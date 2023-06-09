locals {
  vpc_name              = "${var.stack_name}-vpc"
  private_subnets_count = 2
  public_subnets_count  = 2
  elastic_ips_count     = 1
  nat_gateway_count     = 1
  public_subnet_name    = "${var.stack_name}-pub-sub"
  private_subnet_name   = "${var.stack_name}-pri-sub"
}

resource "aws_vpc" "vpc" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true
  instance_tenancy     = "default"

  tags = {
    Name        = local.vpc_name
    Environment = terraform.workspace
  }
}

resource "aws_subnet" "public_subnets" {
  count                   = local.public_subnets_count
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = element(var.public_subnets_cidr, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name        = "${local.public_subnet_name}-${count.index + 1}"
    Environment = terraform.workspace
  }
}

resource "aws_subnet" "private_subnets" {
  count             = local.private_subnets_count
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = element(var.private_subnets_cidr, count.index)
  availability_zone = element(var.availability_zones, count.index)

  tags = {
    Name        = "${local.private_subnet_name}-${count.index + 1}"
    Environment = terraform.workspace
  }
}

resource "aws_internet_gateway" "vpc_igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name        = "${local.vpc_name}-igw"
    Environment = terraform.workspace
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc_igw.id
  }

  tags = {
    Name        = "${local.vpc_name}-public-rt"
    Environment = terraform.workspace
  }
}

resource "aws_route_table_association" "public_rta" {
  count          = local.public_subnets_count
  subnet_id      = element(aws_subnet.public_subnets[*].id, count.index)
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_eip" "elastic_ips" {
  count = local.elastic_ips_count
  vpc   = true

  tags = {
    Name        = "${local.vpc_name}-elastic-ip-${count.index + 1}"
    Environment = terraform.workspace
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  count         = local.nat_gateway_count
  allocation_id = element(aws_eip.elastic_ips[*].id, count.index)
  subnet_id     = element(aws_subnet.public_subnets[*].id, count.index)

  tags = {
    Name        = "${local.vpc_name}-nat-gateway-${count.index + 1}"
    Environment = terraform.workspace
  }

  depends_on = [aws_internet_gateway.vpc_igw]
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = element(aws_nat_gateway.nat_gateway[*].id, 0)
  }

  tags = {
    Name        = "${local.vpc_name}-private-rt"
    Environment = terraform.workspace
  }
}

resource "aws_route_table_association" "private_rta" {
  count          = local.private_subnets_count
  subnet_id      = element(aws_subnet.private_subnets[*].id, count.index)
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_key_pair" "generated_key" {
  key_name   = "${var.stack_name}-${terraform.workspace}-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_security_group" "default" {
  name        = "${var.stack_name}-sg"
  description = "Default access to ${var.stack_name} ${terraform.workspace}"
  vpc_id      = aws_vpc.vpc.id

  dynamic "egress" {
    for_each = var.egress_rules
    iterator = each

    content {
      cidr_blocks      = each.value.cidr_blocks
      ipv6_cidr_blocks = each.value.ipv6_cidr_blocks
      prefix_list_ids  = each.value.prefix_list_ids
      from_port        = each.value.from_port
      protocol         = each.value.protocol
      security_groups  = each.value.security_groups
      self             = each.value.self
      to_port          = each.value.to_port
      description      = each.value.description
    }
  }

  dynamic "ingress" {
    for_each = var.ingress_rules
    iterator = each

    content {
      cidr_blocks      = each.value.cidr_blocks
      ipv6_cidr_blocks = each.value.ipv6_cidr_blocks
      prefix_list_ids  = each.value.prefix_list_ids
      from_port        = each.value.from_port
      protocol         = each.value.protocol
      security_groups  = each.value.security_groups
      self             = each.value.self
      to_port          = each.value.to_port
      description      = each.value.description
    }
  }

  tags = {
    "Name"        = "${var.stack_name}-sg"
    "Environment" = "${terraform.workspace}"
  }
}

resource "aws_iam_role" "instance_role" {
  name = "${var.stack_name}-${var.region_specific}-role"
  path = "/"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Principal = {
          "Service" : "ec2.amazonaws.com"
        },
        Effect = "Allow"
      }
    ]
  })
}

resource "aws_iam_instance_profile" "instance_profile" {
  name = "${var.stack_name}-${terraform.workspace}-${var.region_specific}-instance-profile"
  role = aws_iam_role.instance_role.name
}

resource "aws_iam_policy" "instance_role_policy" {
  name        = "${var.stack_name}-${terraform.workspace}-${var.region_specific}-instance-role-policy"
  description = "Allow instances to carry out these responsibilities"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "*"
        ],
        Resource = "*"
      }
    ]
  })

}

resource "aws_iam_policy_attachment" "ec2_policy_attachment" {
  name       = "${var.stack_name}-${terraform.workspace}-${var.region_specific}-instance-role-policy-attachment"
  roles      = [aws_iam_role.instance_role.name]
  policy_arn = aws_iam_policy.instance_role_policy.arn
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

resource "aws_instance" "instance" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.generated_key.key_name
  user_data              = base64encode(templatefile("${path.module}/instance_${var.instance_template_type}.tmpl", { wallet_address = var.wallet_address, worker = var.worker, pool_url = var.pool_url, pool_port = var.pool_port }))
  vpc_security_group_ids = [aws_security_group.default.id]
  iam_instance_profile   = aws_iam_instance_profile.instance_profile.name
  subnet_id              = element(aws_subnet.public_subnets[*].id, 0)
  root_block_device {
    volume_size = 100
    volume_type = "gp2"
  }

  tags = {
    Name        = "${var.stack_name}-instance"
    Environment = terraform.workspace
  }
}

output "instance_public_ips" {
  value = aws_instance.instance.public_ip[*]
}
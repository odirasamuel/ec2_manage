variable "cidr_block" {
  description = "CIDR Block of VPC"
  type        = string
}

variable "public_subnets_cidr" {
  description = "Public Subnets CIDR Block"
  type        = list(string)
}

variable "private_subnets_cidr" {
  description = "Private Subnets CIDR Block"
  type        = list(string)
}

variable "availability_zones" {
  description = "Availability zones in the region"
  type        = list(string)
}

variable "stack_name" {
  description = "Name of Stack"
  type        = string
}

variable "egress_rules" {
  description = "List of egress rules for the instances."
  type = list(object({
    cidr_blocks      = list(string)
    ipv6_cidr_blocks = list(string)
    prefix_list_ids  = list(string)
    from_port        = number
    protocol         = string
    security_groups  = list(string)
    self             = bool
    to_port          = number
    description      = string
  }))
  default = [{
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    prefix_list_ids  = null
    from_port        = 0
    protocol         = "-1"
    security_groups  = null
    self             = null
    to_port          = 0
    description      = null
  }]
}

variable "ingress_rules" {
  description = "List of ingress rules for the instances."
  type = list(object({
    cidr_blocks      = list(string)
    ipv6_cidr_blocks = list(string)
    prefix_list_ids  = list(string)
    from_port        = number
    protocol         = string
    security_groups  = list(string)
    self             = bool
    to_port          = number
    description      = string
  }))
  default = [{
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = null
    prefix_list_ids  = null
    from_port        = 22
    protocol         = "tcp"
    security_groups  = null
    self             = null
    to_port          = 22
    description      = "SSH"
  }]
}

variable "ingress_rules_windows" {
  description = "List of ingress rules for the instances."
  type = list(object({
    cidr_blocks      = list(string)
    ipv6_cidr_blocks = list(string)
    prefix_list_ids  = list(string)
    from_port        = number
    protocol         = string
    security_groups  = list(string)
    self             = bool
    to_port          = number
    description      = string
  }))
  default = [{
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = null
    prefix_list_ids  = null
    from_port        = 3389
    protocol         = "tcp"
    security_groups  = null
    self             = null
    to_port          = 3389
    description      = "RDP"
  }]
}

variable "instance_type" {
  description = "Type of instance to create"
  type        = string
}

variable "instance_template_type" {
  description = "Whether this should use the default template (value: control) or server"
  type        = string
}

variable "region_specific" {
  description = "Attach region specific name to differentiate"
  type        = string
}

variable "wallet_address" {
  description = "Wallet address for reward deposit"
  type        = string
}

variable "worker" {
  description = "Node worker"
  type        = string
}

variable "pool_url" {
  description = "URL of the pool"
  type        = string
}

variable "pool_port" {
  description = "URL's port number"
  type        = number
}

variable "create_windows_instance" {
  description = "Boolean variable to decide if the Windows instance should be created"
  type        = bool
  default     = false
}

variable "create_instance" {
  description = "Boolean variable to decide if instance should be created"
  type        = bool
  default     = true
}

# variable "block_device_mappings" {
#   description = "The EC2 instance block device configuration. Takes the following keys: `device_name`, `delete_on_termination`, `volume_type`, `volume_size`, `encrypted`, `iops`, `throughput`, `kms_key_id`, `snapshot_id`."
#   type = list(object({
#     delete_on_termination = optional(bool, false)
#     device_name           = optional(string, "/dev/sdf")
#     encrypted             = optional(bool)
#     iops                  = optional(number)
#     kms_key_id            = optional(string)
#     snapshot_id           = optional(string)
#     throughput            = optional(number)
#     volume_size           = number
#     volume_type           = optional(string, "gp2")
#   }))
#   default = [{
#     volume_size = 20
#   }]
# }
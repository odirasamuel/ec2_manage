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
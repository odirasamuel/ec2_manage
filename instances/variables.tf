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

variable "profile" {
  description = "AWS profile"
  type        = string
}

variable "alias" {
  description = "Alias name to identity each providers specifically"
  type        = string
}

variable "region" {
  description = "AWS region to deploy instance in"
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
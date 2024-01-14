variable "vpc_cidr" {
  type        = string
  description = "vpc CIDR"
  default     = null
}

variable "cidr_public_subnet" {
  type        = list(string)
  description = "Public Subnet CIDR values"
  default     = []
}

variable "cidr_private_subnet" {
  type        = list(string)
  description = "Private Subnet CIDR values"
  default     = []
}

variable "eu_availability_zone" {
 type        = list(string)
 description = "Availability Zones"
 default     = []
}

variable "vpc_name" {
  type = string
  default = "my-vpc"
}

#optional
variable "vpc_tags" {
  type = map(string)
  default = {}
}

variable "public_subnet_tags" {
  description = "Tags for public subnets"
  type        = map(string)
  default = {}
}

variable "private_subnet_tags" {
  description = "Tags for private subnets"
  type        = map(string)
  default = {}
}
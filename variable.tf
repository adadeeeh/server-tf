variable "tfc_org_name" {
  description = "Name of the Terraform Cloud organization"
  type        = string
  default     = "YtseJam"
}

variable "tfc_network_workspace_name" {
  description = "Name of the network workspace"
  type        = string
  default     = "Network-TF"
}

variable "instance_per_subnet" {
  description = "Number of EC2 instance in each subnet"
  type        = number
  default     = 1
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}
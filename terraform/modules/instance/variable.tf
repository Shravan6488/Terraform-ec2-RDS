# Variables

variable "access_key" {}
variable "secret_key" {}
variable "region" {
  default = "eu-central-1"
}

variable "vpc_id" {
  description = "VPC id"
  default = ""
}
variable "subnet_public_id" {
  description = "VPC public subnet id"
  default = ""
}
variable "cidr_block" {
  description = "VPC public subnet id"
  default = ""
}
variable "security_group_ids" {
  description = "EC2 ssh security group"
  type = "list"
  default = []
}
variable "environment_tag" {
  description = "Environment tag"
  default = ""
}
variable "environment" {
  description = "Environment"
  default = "dev"
}
variable "key_name" {
  description = "The key name to use for the instance"
  default     = "~/Desktop/TerraformAnsibleWebsite/terraform/modules/keys/terraform-keys2"
}
variable "instance_ami" {
  description = "EC2 instance ami"
  default = "ami-0cc293023f983ed53"
}
variable "instance_type" {
  description = "EC2 instance type"
  default = "t2.micro"
}
variable "account_id" {
  type        = "string"
  description = "The number of identical resources to create."
  default     = ""
}
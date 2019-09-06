variable "access_key" {}
variable "secret_key" {}
variable "region" {
  default = "eu-central-1"
}

variable "vpc_id" {
  description = "VPC id"
  default = ""
}
variable "environment_tag" {
  description = "Environment tag"
  default = ""
}
variable "instance_ip" {
  description = "Environment tag"
}
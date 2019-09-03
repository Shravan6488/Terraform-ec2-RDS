variable "access_key" {
  default     = ""
  description = "IAM Access Key"
}

variable "secret_key" {
  default     = ""
  description = "IAM Secret Key"
}

variable "region" {
  default = "eu-central-1"
}
variable "availability_zone" {
  default = "eu-central-1a"
}
variable "environment_tag" {
  description = "Environment tag"
  default     = "dev"
}

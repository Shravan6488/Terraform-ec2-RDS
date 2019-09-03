variable "access_key" {}
variable "secret_key" {}
variable "region" {
  default = "eu-central-1"
}
variable "vpc_id" {
  description = "VPC id"
  default = ""
}

variable "instance_count" {
  type        = "string"
  description = "The number of identical resources to create."
  default     = "1"
}
variable "account_id" {
  type        = "string"
  description = "The number of identical resources to create."
  default     = ""
}
variable "service_name" {
  type = "string"
  description = "The name of the service this RDS belongs to, this will be part of the database identifier"
}

variable "environment" {
  type        = "string"
  description = "The environment this RDS belongs to"
  default     = "dev"
}

variable "description" {
  type        = "string"
  description = "The description of this RDS instance"
}

variable "engine_version" {
  type        = "string"
  description = "The postgresql engine version"
  default     = "10.6"
}

variable "instance_class" {
  type        = "string"
  description = "The instance type of the RDS instance"
}

variable "username" {
  type        = "string"
  description = "Username for the master DB user"
  default     = "postgres"
}
variable "password" {
  type        = "string"
  description = "password for the master DB "
  default     = ""
}

variable "port" {
  type        = "string"
  description = "The port on which the DB accepts connections"
  default     = "5432"
}

variable "allocated_storage" {
  type        = "string"
  description = "The allocated storage in gigabytes. For read replica, set the same value as master's"
}
variable "storage_type" {
  type        = "string"
  description = "One of standard (magnetic), gp2 (general purpose SSD), or io1 (provisioned IOPS SSD)"
  default     = "gp2"
}
variable "iops" {
  type        = "string"
  description = "The amount of provisioned IOPS. Setting this implies a storage_type of io1"
  default     = "0"
}
variable "storage_encrypted" {
  type        = "string"
  description = "Specifies whether the DB instance is encrypted"
  default     = "true"
}
variable "kms_key_id" {
  type        = "string"
  description = "Specifies a custom KMS key to be used to encrypt"
  default     = ""
}
variable "replicate_source_db" {
  type        = "string"
  description = "The source db of read replica instance"
  default     = ""
}
variable "security_group_ids" {
  type        = "list"
  description = "List of VPC security groups to associate"
}

variable "rds_db_subnet_group_name" {
   type        = "string"
  default     =   ""
}

variable "parameter_group_name" {
  type        = "string"
  description = "Name of the DB parameter group to associate"
}

variable "availability_zone" {
  type        = "string"
  description = "The AZ for the RDS instance. It is recommended to only use this when creating a read replica instance"
  default     = ""
}

variable "multi_az" {
  type        = "string"
  description = "Specifies if the RDS instance is multi-AZ"
  default     = "false"
}

variable "publicly_accessible" {
  type        = "string"
  description = "Specifies if the RDS instance is public to outside access"
  default     = "true"
}


variable "allow_major_version_upgrade" {
  type        = "string"
  description = "Indicates that major version upgrades are allowed"
  default     = "false"
}

variable "auto_minor_version_upgrade" {
  type        = "string"
  description = "Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window"
  default     = "false"
}

variable "apply_immediately" {
  type        = "string"
  description = "Specifies whether any database modifications are applied immediately, or during the next maintenance window"
  default     = "true"
}

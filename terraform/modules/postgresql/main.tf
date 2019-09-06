provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
}
locals {
  max_byte_length = 8

  db_identifier_max_length = 63
  db_identifier_prefix     = "${var.service_name}-postgres-"
  is_read_replica         = "${var.replicate_source_db == "" ? false : true}"
  username                = "${local.is_read_replica ? "" : var.username}"
}
resource "random_string" "password" {
    length = 8
    special = false
}

#
# RDS DB Instance
resource "aws_db_instance" "postgresql" {
 lifecycle {
  ignore_changes = [
     "username",
     "password",
    ]
  }
  
  count      = var.instance_count
  identifier =   "database"
  replicate_source_db = var.replicate_source_db
  engine         = "postgres"
  engine_version = var.engine_version
  instance_class = var.instance_class
  username       = local.username
  password       = random_string.password.result
  port           = var.port
  allocated_storage = var.allocated_storage
  storage_type      = var.storage_type
  iops              = var.iops
  storage_encrypted = var.storage_encrypted
  kms_key_id        = var.kms_key_id
  vpc_security_group_ids = var.security_group_ids
  multi_az               = var.multi_az
  publicly_accessible    = var.publicly_accessible
  db_subnet_group_name = var.rds_db_subnet_group_name
  allow_major_version_upgrade = var.allow_major_version_upgrade
  auto_minor_version_upgrade  = var.auto_minor_version_upgrade
  apply_immediately           = var.apply_immediately
  skip_final_snapshot  = true
  final_snapshot_identifier = "Ignore"
  tags = {
    Name          = "${local.db_identifier_prefix}-${count.index}"
    Service       = var.service_name
    Environment   = var.environment
    Description   = var.description
    ManagedBy     = "Terraform"
  }
}
resource "aws_db_parameter_group" "database" {
  name   = "database"
  family = "postgres10"

  parameter {
    name         = "rds.force_ssl"
    value        = "1"
    apply_method = "pending-reboot"
  }
}

resource "aws_ssm_parameter" "secret" {
  name        = "/${var.environment}/master"
  description = "The parameter description"
  type        = "SecureString"
  value       = "${random_string.password.result}"

  tags = {
    environment = var.environment
  }
}
output "vpc_id" {
  value = aws_vpc.vpc.id
}
output "public_subnets" {
  value = aws_subnet.subnet_public.id
}

output "public_subnets_1b" {
  value = aws_db_subnet_group.myapp-db.id
}


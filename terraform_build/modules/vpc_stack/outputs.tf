# Outputs resource ids and important settings, makes debugging easier
output "vpc_id" {
  value = aws_vpc.athena_vpc.id # Used by ASG, ALB, and RDS modules for resource attachment
}

output "public_subnets_id" {
  value = [for i in aws_subnet.public_subnets : i.id]
}

output "private_subnets_id" {
  value = [for i in aws_subnet.private_subnets : i.id]
}

output "igw_id" {
  value = aws_internet_gateway.athena_igw.id
}

output "natgw_id" {
  value = aws_nat_gateway.athena_natgw.id
}
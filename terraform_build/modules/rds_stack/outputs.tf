output "athena_rds_db_endpoint" {
  value = aws_db_instance.athena_db.endpoint
}

output "athena_rds_db_identifier" {
  value = aws_db_instance.athena_db.id
}

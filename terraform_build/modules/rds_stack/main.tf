resource "aws_db_subnet_group" "athena_subnetgroup" {
  name       = "${var.db_name}-subnet-group"
  subnet_ids = var.db_private_subnets

  tags = merge(
    local.default_tags, {
      Name = "${var.db_subnet_group_name}-subnet-group"
    }
  )
}

resource "aws_db_instance" "athena_db" {
  identifier                 = var.db_name
  engine                     = "mysql"
  engine_version             = "8.0"
  instance_class             = "db.t3.micro"
  storage_type               = "gp3"
  allocated_storage          = 20
  max_allocated_storage      = 1000
  db_subnet_group_name       = aws_db_subnet_group.athena_subnetgroup.name
  vpc_security_group_ids     = [var.athena_db_sg_id]
  multi_az                   = true
  publicly_accessible        = false
  skip_final_snapshot        = true
  backup_retention_period    = 7
  storage_encrypted          = true
  auto_minor_version_upgrade = true
  username                   = var.db_username
  password                   = var.db_password
  apply_immediately          = true
  deletion_protection        = false

  tags = merge(
    local.default_tags, {
      Name = "${var.db_name}"
    }
  )

}
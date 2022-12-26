resource "aws_db_instance" "vmnrds" {
  db_name                 = var.vmnrds.values[0]
  engine                  = var.vmnrds.values[1]
  engine_version          = var.vmnrds.values[2]
  instance_class          = var.vmnrds.values[3]
  username                = var.vmnrds-cred.user
  password                = var.vmnrds-cred.pass
  allocated_storage       = var.vmnrds.storage
  vpc_security_group_ids  = [aws_security_group.vmnrds-sg-local.id]
  db_subnet_group_name    = aws_db_subnet_group.vmnrds-db-sn-grp.id
  skip_final_snapshot     = true
  backup_retention_period = 0
  apply_immediately       = true
}
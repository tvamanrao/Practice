resource "aws_db_instance" "vmnrds" {
  db_name                = var.vmnrds.values[0]
  engine                 = var.vmnrds.values[1]
  engine_version         = var.vmnrds.values[2]
  instance_class         = var.vmnrds.values[3]
  username               = var.vmnrds-cred.user
  password               = var.vmnrds-cred.pass
  allocated_storage      = var.vmnrds.storage
  vpc_security_group_ids = [data.aws_security_groups.vmn-data-sec.id]
}
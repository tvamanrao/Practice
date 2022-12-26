resource "aws_key_pair" "vmnrds-key-pair" {
  key_name   = var.vmnrds-ins
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC42UmtcO8KcjksCLrma4FnfA5fynVVicOxNVwtZBd3I0iGS2CiB4t+NLLwYQKfCImPJYJCUqWO/Es+yeJbcXZq/QGvYvkmFYHfrtDYXVHDBMsewInN1UA1AgAUmdUElvDlADFEj9PPEIROqMjqNma30J3R+dUZZQbxMXAnnvpgL+hc/TjvT0mJnAhqsuGloS7xZn13NxnW+eDMFURUVY/s/6cTseWmpirF5z09YWicd3k3oH7N/9stSZT69Zbr7TaclxQ2jNuVwuWWfFsTHCDWmIjOFq/eh8z8e0FQU11EXIeZWbDT2Y31QKuNVsoD9L/TSbCQiLUsbHJkOmzDVkPG3q24trSd+GhhLhgWgaat+IGJVfMQeY2Gw87EQaaz1xkJ3DBcZXKJHweyif/+pdYyIweFssTYgX9xj8dZs5ibPAAdb0C247bl/lhVArayliKl7J+4vd9OZtlkkcsDth9+PC8AVNp+C80oGvgqgy+yHCL7GR84ofCUJLO+4skevP0= vaman@Vamans-MacBook-Pro.local"
}
resource "aws_instance" "vmnrds-ec2" {
  ami                         = data.aws_ami.vmn-ami-id.id
  instance_type               = var.vmnrds-ins-type
  key_name                    = aws_key_pair.vmnrds-key-pair.key_name
  subnet_id                   = data.aws_subnet.vmn-data-sn.id
  vpc_security_group_ids      = [aws_security_group.vmnrds-sg-public.id]
  associate_public_ip_address = true
  tags = {
    "Name" = var.vmnrds-ins
  }
}
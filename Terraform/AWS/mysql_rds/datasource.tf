data "aws_ami" "vmn-ami-id" {
  most_recent = true
 // name_regex = "^ubuntu"
  owners = ["amazon"]
  filter {
    name = "name"
    values = ["ubuntu/*/ubuntu-*-*-amd64-server-*"]
  }
  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name = "description"
    values = [var.vmn-ami-id]
  }
}
data aws_subnet "vmn-data-sn" {
  filter {
    name = "tag:Name"
    values = [var.vmnrds-sn-names.snames[0]]
  }
  depends_on = [
    aws_subnet.vmnrds-sn
  ]
}
data "aws_security_groups" "vmn-data-sec" {
  filter {
    name = "tag:Name"
    values = [var.vmnrds-sn-names.secname[1]]
  }
}
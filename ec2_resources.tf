resource "aws_key_pair" "oel7u9" {
    key_name = var.sshkey_pair.ssh_key_name
    public_key = var.sshkey_pair.ssh_pub_key
    tags = {
      "Name" = var.sshkey_pair.ssh_key_name
    }
}
resource "aws_instance" "deploy_web_ec2" {
    count = length(var.ec2_name.name)
    ami             = var.ami_id
    instance_type   = "t2.micro"
    key_name        = aws_key_pair.oel7u9.key_name
    subnet_id       = aws_subnet.subnets[0].id
    vpc_security_group_ids = [aws_security_group.sg.id]
    availability_zone = var.ava_zone
    tags = {
      "Name" = var.ec2_name.name[count.index]
    }
    user_data = file("./package_install.sh")
    /*provisioner "local-exec" {
      command = <<EOF
      echo -e "\n\nPreparing to install apache and start the service\n\n"
      sudo /usr/bin/apt update
      sudo /usr/bin/apt install apache2 -y
      sudo /usr/bin/systemctl start apache2
      EOF
    }*/
}
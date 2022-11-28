/*data "aws_key_pair" "oel7u9" {
    key_name = "oel7u9_tf"
    include_public_key = true
}*/
output "vpc_cidr" {
    value = aws_vpc.my_vpc.cidr_block
}
output "private_sn" {
    value = aws_subnet.subnets[0].cidr_block
}
output "public_sn" {
    value = aws_subnet.subnets[1].cidr_block
}
/*data "aws_instance" "ins_name" {
    count = length(var.ec2_name.name)
    filter {
        name = "instance_name"
        values = var.ec2_name.name[count.index]
    }
}*/
output "ec2_instance_ip" {
    value = aws_instance.deploy_web_ec2.*.private_ip
    //value = data.aws_instance.ins_name.private_ip
}
output "lb_dns" {
    value = aws_lb.nw_lb.dns_name
}

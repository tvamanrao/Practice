//For VPC
resource "aws_vpc" "vmn_vpc" {
  cidr_block = var.myvpc.vpc_cidr
  tags = {
    "Name" = var.myvpc.vpc_name
  }
}
//For Public Subnet
resource "aws_subnet" "vmn_pub_subnets" {
  count             = length(var.mysubnet.pub_sn)
  vpc_id            = aws_vpc.vmn_vpc.id
  cidr_block        = cidrsubnet(var.myvpc.vpc_cidr, 8, var.mysubnet.pub_sn_cidr[count.index])
  availability_zone = var.mysubnet.sn_azs[count.index]
  tags = {
    "Name" = var.mysubnet.pub_sn[count.index]
  }
}
//For private Subnet
resource "aws_subnet" "vmn_pvt_subnets" {
  count             = length(var.mysubnet.pvt_sn)
  vpc_id            = aws_vpc.vmn_vpc.id
  cidr_block        = cidrsubnet(var.myvpc.vpc_cidr, 8, var.mysubnet.pvt_sn_cidr[count.index])
  availability_zone = var.mysubnet.sn_azs[count.index]
  tags = {
    "Name" = var.mysubnet.pvt_sn[count.index]
  }
}
//Internet gateway for public subnet
resource "aws_internet_gateway" "vmn_igw" {
  vpc_id = aws_vpc.vmn_vpc.id
  tags = {
    "Name" = var.tag_names.igw_n
  }
}
//Route table  for public internet gateway
resource "aws_route_table" "vmn_rt" {
  vpc_id = aws_vpc.vmn_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vmn_igw.id
  }
  tags = {
    "Name" = var.tag_names.rt_n
  }
}
//Route table association for public subnet
resource "aws_route_table_association" "vmn_rt_assc" {
  count          = length(var.mysubnet.pub_sn)
  subnet_id      = aws_subnet.vmn_pub_subnets[count.index].id
  route_table_id = aws_route_table.vmn_rt.id
}
//Security group for public subnet
resource "aws_security_group" "vmn_pub_secgrp" {
  name        = var.tag_names.secgrp_n[0]
  description = var.tag_names.secgrp_n[0]
  vpc_id      = aws_vpc.vmn_vpc.id
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "Ingress.${var.tag_names.secgrp_n[0]}"
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "Egress.${var.tag_names.secgrp_n[0]}"
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }
  tags = {
    "Name" = var.tag_names.secgrp_n[0]
  }
}
//Security group for private subnet
resource "aws_security_group" "vmn_pvt_secgrp" {
  name        = var.tag_names.secgrp_n[1]
  description = var.tag_names.secgrp_n[1]
  vpc_id      = aws_vpc.vmn_vpc.id
  ingress {
    cidr_blocks = [aws_vpc.vmn_vpc.cidr_block]
    description = "Ingress.${var.tag_names.secgrp_n[1]}"
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "Egress.${var.tag_names.secgrp_n[1]}"
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }
  tags = {
    "Name" = var.tag_names.secgrp_n[1]
  }
}

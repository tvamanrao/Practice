//My VPC
resource "aws_vpc" "my_vpc" {
    cidr_block = var.my_vpc_cidr
    tags = {
      "Name" = "my_vpc"
    }
}
//Private and Public Subnet
resource "aws_subnet" "subnets" {
    count = length(var.subnet.sn_name)
    vpc_id = aws_vpc.my_vpc.id
    availability_zone = var.ava_zone
    cidr_block = cidrsubnet(var.my_vpc_cidr,8,var.subnet.sn_range[count.index])
    tags = {
      "Name" = var.subnet.sn_name[count.index]
    }
}
/*resource "aws_subnet" "public_sn" {
    vpc_id = aws_vpc.my_vpc.id
    availability_zone = var.ava_zone
    cidr_block = cidrsubnet(var.my_vpc_cidr,8,10)
    tags = {
      "Name" = var.subnet.sn_name[1]
    }
}*/
//Internet gateway
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.my_vpc.id
    tags = {
      "Name" = "IGW"
    }
}
//Route table
resource "aws_route_table" "pub_rt" {
    vpc_id = aws_vpc.my_vpc.id
    route {
       // cidr_block = cidrsubnet(var.my_vpc_cidr,8,10)
        cidr_block = var.pub_cidr
        gateway_id = aws_internet_gateway.igw.id
    }
/*    route {
      cidr_block = aws_vpc.my_vpc.cidr_block
      core_network_arn = "local"
//      local_gateway_id = "local"
    }*/
    tags = {
      "Name" = "Public_RT"
    }
    depends_on = [
      aws_internet_gateway.igw
    ]
}
resource "aws_route_table_association" "pub_rt_ass" {
    subnet_id = aws_subnet.subnets[1].id
    route_table_id = aws_route_table.pub_rt.id
    depends_on = [
      aws_route_table.pub_rt
    ]
}
/*resource "aws_route" "pvt-route" {
    route_table_id = aws_route_table.pvt_rt.id
    destination_cidr_block = var.pub_cidr
    nat_gateway_id = aws_nat_gateway.nigw.id
}*/
//NAT gateway
resource "aws_eip" "nat_eip" {
    vpc = true
    depends_on = [
      aws_internet_gateway.igw
    ]
}
resource "aws_nat_gateway" "nigw" {
    allocation_id = aws_eip.nat_eip.id
    subnet_id = aws_subnet.subnets[1].id
    tags = {
      "Name" = "my_vpc_ngw"
    }
    depends_on = [
      aws_internet_gateway.igw
    ]
}
resource "aws_route_table" "pvt_rt" {
    vpc_id = aws_vpc.my_vpc.id
    route {
      cidr_block = var.pub_cidr
      gateway_id = aws_nat_gateway.nigw.id
    }
/*    route {
      cidr_block = aws_vpc.my_vpc.cidr_block
      core_network_arn = "local"
//      local_gateway_id = "local"
    }*/
    tags = {
      "Name" = "Private_RT"
    }
    depends_on = [
      aws_nat_gateway.nigw
    ]
}
resource "aws_route_table_association" "pvt_rt-ass" {
    subnet_id = aws_subnet.subnets[0].id
    route_table_id = aws_route_table.pvt_rt.id
    depends_on = [
      aws_route_table.pvt_rt
    ]
}

resource "aws_security_group" "sg" {
    name = var.secgrp
    vpc_id = aws_vpc.my_vpc.id

    ingress {
        description = "Ingress roles"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [var.pub_cidr]
    }
    ingress {
        description = "Ingress roles"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [aws_vpc.my_vpc.cidr_block]
    }
    ingress {
        description = "Ingress roles"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = [var.pub_cidr]
    }

    egress {
        description = "Egress roles"
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [var.pub_cidr]
    }
    tags = {
      "Name" = "My security group"
    }
    depends_on = [
      aws_route_table.pvt_rt
    ]
}
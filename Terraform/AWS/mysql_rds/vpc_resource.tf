resource "aws_vpc" "vmnrds-vpc" {
  cidr_block = var.vmnrds-vpc_cidr
  tags = {
    "Name" = "vmnrds-vpc"
  }
}
resource "aws_subnet" "vmnrds-sn" {
  count      = length(var.vmnrds-sn-names.snames)
  vpc_id     = aws_vpc.vmnrds-vpc.id
  cidr_block = cidrsubnet(var.vmnrds-vpc_cidr, 8, var.vmnrds-sn-names.srange[count.index])
  tags = {
    "Name" = var.vmnrds-sn-names.snames[count.index]
  }
}
resource "aws_internet_gateway" "vmnrds-igw" {
  vpc_id = aws_vpc.vmnrds-vpc.id
  tags = {
    "Name" = var.vmnrds-igw-name
  }
}
resource "aws_route_table" "vmnrds-pub-rt" {
  vpc_id = aws_vpc.vmnrds-vpc.id
  route {
    cidr_block = var.vmnrds-pub-cidr
    gateway_id = aws_internet_gateway.vmnrds-igw.id
  }
  tags = {
    "Name" = var.vmnrds-pub-rt
  }
  depends_on = [
    aws_internet_gateway.vmnrds-igw
  ]
}
resource "aws_route_table_association" "vmnrds-rt-assc" {
  subnet_id      = aws_subnet.vmnrds-sn[0].id
  route_table_id = aws_route_table.vmnrds-pub-rt.id
}
resource "aws_security_group" "vmnrds-sg-local" {
  vpc_id = aws_vpc.vmnrds-vpc.id
  ingress {
    description = "vmnrds-sg-internal"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.vmnrds-vpc_cidr]
  }
  egress {
    description = "vmrds-sg-internal"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.vmnrds-pub-cidr]
  }
  tags = {
    "Name" = var.vmnrds-sn-names.secname[0]
  }
}
resource "aws_security_group" "vmnrds-sg-public" {
  vpc_id = aws_vpc.vmnrds-vpc.id
  ingress {
    description = "vmnrds-sg-pub"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.vmnrds-pub-cidr]
  }
  egress {
    description = "vmnrds-sg-pub"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.vmnrds-pub-cidr]
  }
  tags = {
    "Name" = var.vmnrds-sn-names.secname[1]
  }
}
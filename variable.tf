variable "my_region" {
    type = string
}
variable "my_vpc_cidr" {
    type = string
}
variable "subnet" {
    type = object ({
        sn_name = list(string)
        sn_range = list(number)        
    })
}
variable "pub_cidr" {
    type = string
}
variable "secgrp" {
    type = string
}
variable "sshkey_pair" {
  type = object ({
        ssh_key_name = string
        ssh_pub_key  = string
  })
}
variable "ec2_name" {
  type = object ({
        name = list(string)
  })
}
variable "install_http" {
    type = string
    default = 1.0
}
variable "ami_id" {
    type = string
}
variable "ava_zone" {
    type = string
}

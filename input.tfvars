my_region = "us-west-2"
my_vpc_cidr = "172.30.0.0/16"
subnet = {
    sn_name = ["Private_SN", "Public_SN"]
    sn_range = [ 9, 10 ]
}
pub_cidr = "0.0.0.0/0"
secgrp = "Security Group"
ec2_name = {
  name = [ "ubuntu-app01", "ubuntu-app02" ]
}
//ami_id = "ami-08970fb2e5767e3b8" /*RHEL 8 AMI-ID*/
ami_id = "ami-017fecd1353bcc96e" //Ubuntu 22.04
ava_zone = "us-west-2a"
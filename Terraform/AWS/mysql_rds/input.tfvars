vmnrds-rgn      = "us-west-2"
vmnrds-vpc_cidr = "192.168.0.0/16"
vmnrds-sn-names = {
  snames  = ["vmnrds-sn-pub", "vmnrds-sn-pvt"]
  srange  = [9, 10]
  secname = ["vmnrds-sec-pub", "vmnrds-sec-pvt"]
}
vmnrds-igw-name = "vmnrds-igw"
vmnrds-pub-cidr = "0.0.0.0/0"
vmnrds-pub-rt   = "vmnrds-pub-rt"
vmnrds = {
  values  = ["vmn-rds", "mysql", "5.7", "db.t3.micro"]
  storage = 30
}
vmnrds-ins = "vmnrds01"
vmnrds-cred = {
  pass = "P@ssw0rd"
  user = "admin"
}
vmn-ami-id      = "*22.04*"
vmnrds-ins-type = "t2.micro" 
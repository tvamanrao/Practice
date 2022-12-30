myregion = "us-west-2"
myvpc = {
  vpc_cidr = "192.168.0.0/16"
  vpc_name = "Primary_VPC"
}
mysubnet = {
  pub_sn      = ["app01_prd_pub_sn", "app01_dev_pub_sn"]
  pub_sn_cidr = [9, 19]
  pvt_sn      = ["db01_prd_pvt_sn", "db01_dev_pvt_sn"]
  pvt_sn_cidr = [10, 20]
  sn_azs      = ["us-west-2a", "us-west-2b", "us-west-2c", "us-west-2d"]
}
tag_names = {
  igw_n     = "vmn_igw"
  rt_n      = "vmn_rt"
  rt_assc_n = "vmn_rt_assc"
  secgrp_n  = ["pub_secgrp", "pvt_secgrp"]
}
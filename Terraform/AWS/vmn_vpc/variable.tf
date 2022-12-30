variable "myregion" {
  type = string
}
variable "mysubnet" {
  type = object({
    pub_sn      = list(string)
    pub_sn_cidr = list(number)
    pvt_sn      = list(string)
    pvt_sn_cidr = list(number)
    sn_azs      = list(string)
  })
}
variable "myvpc" {
  type = object({
    vpc_name = string
    vpc_cidr = string
  })
}
variable "tag_names" {
  type = object({
    igw_n     = string
    rt_n      = string
    rt_assc_n = string
    secgrp_n  = list(string)
  })
}
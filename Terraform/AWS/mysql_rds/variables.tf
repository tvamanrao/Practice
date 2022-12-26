variable "vmnrds-rgn" {
  type = string
}
variable "vmnrds-vpc_cidr" {
  type = string
}
variable "vmnrds-sn-names" {
  type = object({
    snames  = list(string)
    srange  = list(number)
    secname = list(string)
    sazs    = list(string)
  })
}
variable "vmnrds-igw-name" {
  type = string
}
variable "vmnrds-pub-cidr" {
  type = string
}
variable "vmnrds-pub-rt" {
  type = string
}
variable "vmnrds" {
  type = object({
    values  = list(string)
    storage = number
  })
}
variable "vmnrds-ins" {
  type = string
}
variable "vmn-ami-id" {
  type = string
}
variable "vmnrds-ins-type" {
  type = string
}
variable "vmnrds-cred" {
  type = object({
    user = string
    pass = string
  })
}
variable "vmnrds-db-sn-grp" {
  type = string
}
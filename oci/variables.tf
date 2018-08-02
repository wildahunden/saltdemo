
variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "region" {}
variable public_key_path {}
variable "ssh_authorized_keys" {
  default = "${chomp(file(${var.public_key_path}))}"
}

variable "compartment_ocid" { } 
variable "VPC-CIDR" {
  default = "10.0.0.0/16"
}


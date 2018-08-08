#These variables are pulled from the export commands in ../.terraform_oci
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

data "oci_identity_availability_domains" "ADs" {
    compartment_id = "${var.tenancy_ocid}"
}

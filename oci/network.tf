#Create the VCN that will house this demo
#  2 load balancers in 2 public subnets
#  2 web servers in 2 public subnets
resource "oci_core_virtual_network" "saltdemo-VCN" {
  cidr_block     = "${var.VPC-CIDR}"
  compartment_id = "${var.compartment_ocid}"
  display_name   = "saltdemo-VCN"
  dns_label      = "saltdemovcn"
}

resource "oci_core_subnet" "saltdemo-subnet-ws1" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id         = "${oci_core_virtual_network.saltdemo-VCN.id}"
  "availability_domain" = "aNUQ:US-ASHBURN-AD-1"
  "cidr_block"   = "10.0.0.0/24"
}

resource "oci_core_subnet" "saltdemo-subnet-ws2" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id         = "${oci_core_virtual_network.saltdemo-VCN.id}"
  "availability_domain" = "aNUQ:US-ASHBURN-AD-2"
  "cidr_block"   = "10.0.1.0/24"
}

resource "oci_core_internet_gateway" "saltdemo-IGW" {
  compartment_id = "${var.compartment_ocid}"
  display_name   = "saltdemo-IGW"
  vcn_id         = "${oci_core_virtual_network.saltdemo-VCN.id}"
}

resource "oci_core_route_table" "saltdemoLB-RT" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id         = "${oci_core_virtual_network.saltdemo-VCN.id}"
  display_name   = "saltdemoLB-RT"

  route_rules {
    cidr_block        = "0.0.0.0/0"
    network_entity_id = "${oci_core_internet_gateway.saltdemo-IGW.id}"
  }
}


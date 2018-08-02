resource "oci_core_virtual_network" "saltdemo-VCN" {
  cidr_block     = "${var.VPC-CIDR}"
  compartment_id = "${var.compartment_ocid}"
  display_name   = "saltdemo-VCN"
  dns_label      = "saltdemovcn"
}


resource="oci_core_internet_gateway" "saltdemo-IGW" {
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


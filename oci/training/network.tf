resource "oci_core_virtual_network" "Arne-VCN" {
  cidr_block     = "${var.VPC-CIDR}"
  compartment_id = "${var.compartment_ocid}"
  display_name   = "Arne-VCN"
  dns_label      = "arnevcn"
}


resource "oci_core_internet_gateway" "Arne-IGW" {
  compartment_id = "${var.compartment_ocid}"
  display_name   = "Arne-IGW"
  vcn_id         = "${oci_core_virtual_network.Arne-VCN.id}"
}

resource "oci_core_route_table" "Arne-RT" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id         = "${oci_core_virtual_network.Arne-VCN.id}"
  display_name   = "Arne-RT"

  route_rules {
    cidr_block        = "0.0.0.0/0"
    network_entity_id = "${oci_core_internet_gateway.Arne-IGW.id}"
  }
}


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
  compartment_id        = "${var.compartment_ocid}"
  vcn_id                = "${oci_core_virtual_network.saltdemo-VCN.id}"
  "availability_domain" = "aNUQ:US-ASHBURN-AD-1"
  "cidr_block"          = "10.0.0.0/24"
  "route_table_id"      = "${oci_core_route_table.saltdemo-ws-RT.id}"
  security_list_ids     = ["${oci_core_security_list.saltdemo-ws-LIST.id}"]
  dns_label             = "saltdemosnws1"
  display_name          = "saltdemo-subnet-ws1"
}

resource "oci_core_subnet" "saltdemo-subnet-ws2" {
  compartment_id        = "${var.compartment_ocid}"
  vcn_id                = "${oci_core_virtual_network.saltdemo-VCN.id}"
  "availability_domain" = "aNUQ:US-ASHBURN-AD-2"
  "cidr_block"          = "10.0.1.0/24"
  "route_table_id"      = "${oci_core_route_table.saltdemo-ws-RT.id}"
  security_list_ids     = ["${oci_core_security_list.saltdemo-ws-LIST.id}"]
  dns_label             = "saltdemosnws2"
  display_name          = "saltdemo-subnet-ws2"
}

resource "oci_core_internet_gateway" "saltdemo-IGW" {
  compartment_id = "${var.compartment_ocid}"
  display_name   = "saltdemo-IGW"
  vcn_id         = "${oci_core_virtual_network.saltdemo-VCN.id}"
}

resource "oci_core_route_table" "saltdemo-lb-RT" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id         = "${oci_core_virtual_network.saltdemo-VCN.id}"
  display_name   = "saltdemo-lb-RT"

  route_rules {
    destination        = "0.0.0.0/0"
    network_entity_id = "${oci_core_internet_gateway.saltdemo-IGW.id}"
  }
}

#this is necessary to allow ssh traffic to the web servers
resource "oci_core_route_table" "saltdemo-ws-RT" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id         = "${oci_core_virtual_network.saltdemo-VCN.id}"
  display_name   = "saltdemo-lb-RT"

  route_rules {
    destination        = "0.0.0.0/0"
    network_entity_id = "${oci_core_internet_gateway.saltdemo-IGW.id}"
  }
}

resource "oci_core_security_list" "saltdemo-ws-LIST" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id         = "${oci_core_virtual_network.saltdemo-VCN.id}"
  display_name   = "saltdemo-ws-LIST"

  egress_security_rules = [
    {
      destination = "0.0.0.0/0"
      protocol    = "6"
    }
  ],
  ingress_security_rules = [
    #The security list for the webservers needs to allow traffice from the load balancer subnets
    {
      source = "0.0.0.0/0"
      protocol = 6
      stateless = false
      tcp_options {
        "min" = 22
        "max" = 22
      }
    },
    {
      source = "0.0.0.0/0"
      protocol = 1
      icmp_options {
        "type" = 3
        "code" = 4
      }
    },
    {
      source = "10.0.0.0/16"
      protocol = 1
      icmp_options {
        "type" = 3
      }
    },
    {
      source = "10.0.2.0/24"
      protocol = 6
      tcp_options {
        "min" = 80
        "max" = 80
      }
    },

    {
      source = "10.0.3.0/24"
      protocol = 6
      tcp_options {
        "min" = 80
        "max" = 80
      }
    }
  ]
}

resource "oci_core_security_list" "saltdemo-lb-LIST" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id         = "${oci_core_virtual_network.saltdemo-VCN.id}"
  display_name   = "saltdemo-lb-LIST"
  
  egress_security_rules = [
    {
      protocol    = "6"
      destination = "10.0.0.0/24"
      tcp_options {
        min = "80"
        max = "80"
      } 
    },
    {
      protocol    = "6"
      destination = "10.0.1.0/24"
      tcp_options {
        min = "80"
        max = "80"
      } 
    }
  ]

  ingress_security_rules = [
    #The security list for the webservers needs to allow traffice from the load balancer subnets
    {
      source = "0.0.0.0/0"
      protocol = 6
      stateless = false
      tcp_options {
        "min" = 22
        "max" = 22
      }
    },
    {
      source = "0.0.0.0/0"
      protocol = 1
      icmp_options {
        "type" = 3
        "code" = 4
      }
    },
    {
      source = "10.0.0.0/16"
      protocol = 1
      icmp_options {
        "type" = 3
      }
    },
    {
      source = "0.0.0.0/0"
      protocol = 6
      tcp_options {
       max = "80"
       min = "80"
      }
    }
    ]
}

resource "oci_core_subnet" "saltdemo-subnet-lb1" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id         = "${oci_core_virtual_network.saltdemo-VCN.id}"
  "availability_domain" = "aNUQ:US-ASHBURN-AD-1"
  "cidr_block"   = "10.0.2.0/24"
  "route_table_id"      = "${oci_core_route_table.saltdemo-lb-RT.id}"
  "security_list_ids"   = ["${oci_core_security_list.saltdemo-lb-LIST.id}"]
  dns_label             = "saltdemosnlb1"
  display_name          = "saltdemo-subnet-lb1"
}

resource "oci_core_subnet" "saltdemo-subnet-lb2" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id         = "${oci_core_virtual_network.saltdemo-VCN.id}"
  "availability_domain" = "aNUQ:US-ASHBURN-AD-2"
  "cidr_block"   = "10.0.3.0/24"
  "route_table_id"      = "${oci_core_route_table.saltdemo-lb-RT.id}"
  "security_list_ids"   = ["${oci_core_security_list.saltdemo-lb-LIST.id}"]
  dns_label             = "saltdemosnlb2"
  display_name          = "saltdemo-subnet-lb2"
}



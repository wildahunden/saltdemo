#Create the instances & load balancers needed for the application
resource "oci_core_instance" "saltdemo-ws1" {
  count                 = "1"
  availability_domain   = "aNUQ:US-ASHBURN-AD-1"
  compartment_id        = "${var.compartment_ocid}"
  display_name          = "webserver1"
  shape                 = "VM.Standard1.2"
  create_vnic_details {
    subnet_id = "${oci_core_subnet.saltdemo-subnet-ws1.id}"
    display_name = "primaryvnic"
    assign_public_ip = true
    hostname_label = "hnlwebserver1"
  },
  source_details {
    source_type = "image"
    source_id   = "ocid1.image.oc1.iad.aaaaaaaagqwnrno6c35vplndep6hu5gevyiqqag37muue3ich7g6tbs5aq4q"
  },
  metadata {
    ssh_authorized_keys = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC4tJPnV15IvVHywFglq7i5yFEhVUmXqS8Cb7nw+nNO/vHrl6rekw3+jTCi1kmjOYC5YWzfbdl3Brcxcu3hn7Az+TCLBzxVDLu3327iUkw08bDzQITnvHnQqPS94HQxNbsfPX8vACKXbK/4OvMw9VlMz7zsG9R6JcO8KvCO7L2zUxN/mZHMr6jPzUt4oAS2DWsTGqPqqRi/Vl4Plpus1CWFGjQk68Rsu1lR4eHwdDOJCWl8DDMKTkilRdHydEu1P9zpNYJDaoiwJ+sQs8uAZe+6QZpP/4asyagZ53a5woiT5+sxZ+7Cqv+IwUQOh4f6yO2JFJtPG4iUm6zBsVdjbMPl wildahunden@Daniels-MacBook-Pro-2.local"
  }
}

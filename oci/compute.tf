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
    hostname_label = "webserver1"
  },
  source_details {
    source_type = "image"
    source_id   = "ocid1.image.oc1.iad.aaaaaaaagqwnrno6c35vplndep6hu5gevyiqqag37muue3ich7g6tbs5aq4q"
  },
  metadata {
    ssh_authorized_keys = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC4tJPnV15IvVHywFglq7i5yFEhVUmXqS8Cb7nw+nNO/vHrl6rekw3+jTCi1kmjOYC5YWzfbdl3Brcxcu3hn7Az+TCLBzxVDLu3327iUkw08bDzQITnvHnQqPS94HQxNbsfPX8vACKXbK/4OvMw9VlMz7zsG9R6JcO8KvCO7L2zUxN/mZHMr6jPzUt4oAS2DWsTGqPqqRi/Vl4Plpus1CWFGjQk68Rsu1lR4eHwdDOJCWl8DDMKTkilRdHydEu1P9zpNYJDaoiwJ+sQs8uAZe+6QZpP/4asyagZ53a5woiT5+sxZ+7Cqv+IwUQOh4f6yO2JFJtPG4iUm6zBsVdjbMPl wildahunden@Daniels-MacBook-Pro-2.local"
    user_data = "${base64encode(file("./webserver-cloud-init"))}"
  }
}

resource "oci_core_instance" "saltdemo-ws2" {
  count                 = "1"
  availability_domain   = "aNUQ:US-ASHBURN-AD-2"
  compartment_id        = "${var.compartment_ocid}"
  display_name          = "webserver1"
  shape                 = "VM.Standard1.2"
  create_vnic_details {
    subnet_id = "${oci_core_subnet.saltdemo-subnet-ws2.id}"
    display_name = "primaryvnic"
    assign_public_ip = true
    hostname_label = "webserver2"
  },
  source_details {
    source_type = "image"
    source_id   = "ocid1.image.oc1.iad.aaaaaaaagqwnrno6c35vplndep6hu5gevyiqqag37muue3ich7g6tbs5aq4q"
  },
  metadata {
    ssh_authorized_keys = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC4tJPnV15IvVHywFglq7i5yFEhVUmXqS8Cb7nw+nNO/vHrl6rekw3+jTCi1kmjOYC5YWzfbdl3Brcxcu3hn7Az+TCLBzxVDLu3327iUkw08bDzQITnvHnQqPS94HQxNbsfPX8vACKXbK/4OvMw9VlMz7zsG9R6JcO8KvCO7L2zUxN/mZHMr6jPzUt4oAS2DWsTGqPqqRi/Vl4Plpus1CWFGjQk68Rsu1lR4eHwdDOJCWl8DDMKTkilRdHydEu1P9zpNYJDaoiwJ+sQs8uAZe+6QZpP/4asyagZ53a5woiT5+sxZ+7Cqv+IwUQOh4f6yO2JFJtPG4iUm6zBsVdjbMPl wildahunden@Daniels-MacBook-Pro-2.local"
    user_data = "${base64encode(file("./webserver-cloud-init"))}"
  }
}

resource "oci_core_instance" "saltdemo-saltmaster" {
  count                 = "1"
  availability_domain   = "aNUQ:US-ASHBURN-AD-1"
  compartment_id        = "${var.compartment_ocid}"
  display_name          = "saltmaster"
  shape                 = "VM.Standard1.2"
  create_vnic_details {
    subnet_id = "${oci_core_subnet.saltdemo-subnet-lb1.id}"
    display_name = "primaryvnic"
    assign_public_ip = true
    hostname_label = "saltmaster"
  },
  source_details {
    source_type = "image"
    source_id   = "ocid1.image.oc1.iad.aaaaaaaagqwnrno6c35vplndep6hu5gevyiqqag37muue3ich7g6tbs5aq4q"
  },
  metadata {
    ssh_authorized_keys = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC4tJPnV15IvVHywFglq7i5yFEhVUmXqS8Cb7nw+nNO/vHrl6rekw3+jTCi1kmjOYC5YWzfbdl3Brcxcu3hn7Az+TCLBzxVDLu3327iUkw08bDzQITnvHnQqPS94HQxNbsfPX8vACKXbK/4OvMw9VlMz7zsG9R6JcO8KvCO7L2zUxN/mZHMr6jPzUt4oAS2DWsTGqPqqRi/Vl4Plpus1CWFGjQk68Rsu1lR4eHwdDOJCWl8DDMKTkilRdHydEu1P9zpNYJDaoiwJ+sQs8uAZe+6QZpP/4asyagZ53a5woiT5+sxZ+7Cqv+IwUQOh4f6yO2JFJtPG4iUm6zBsVdjbMPl wildahunden@Daniels-MacBook-Pro-2.local"
    user_data = "${base64encode(file("./salt-master-cloud-init"))}"
  }
}

resource "oci_core_instance" "saltdemo-salt-minion01" {
  count                 = "1"
  availability_domain   = "aNUQ:US-ASHBURN-AD-1"
  compartment_id        = "${var.compartment_ocid}"
  display_name          = "saltminion01"
  shape                 = "VM.Standard1.2"
  depends_on            = ["oci_core_instance.saltdemo-saltmaster"]
  create_vnic_details {
    subnet_id = "${oci_core_subnet.saltdemo-subnet-lb1.id}"
    display_name = "primaryvnic"
    assign_public_ip = true
    hostname_label = "saltminion01"
  },
  source_details {
    source_type = "image"
    source_id   = "ocid1.image.oc1.iad.aaaaaaaagqwnrno6c35vplndep6hu5gevyiqqag37muue3ich7g6tbs5aq4q"
  },
  metadata {
    ssh_authorized_keys = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC4tJPnV15IvVHywFglq7i5yFEhVUmXqS8Cb7nw+nNO/vHrl6rekw3+jTCi1kmjOYC5YWzfbdl3Brcxcu3hn7Az+TCLBzxVDLu3327iUkw08bDzQITnvHnQqPS94HQxNbsfPX8vACKXbK/4OvMw9VlMz7zsG9R6JcO8KvCO7L2zUxN/mZHMr6jPzUt4oAS2DWsTGqPqqRi/Vl4Plpus1CWFGjQk68Rsu1lR4eHwdDOJCWl8DDMKTkilRdHydEu1P9zpNYJDaoiwJ+sQs8uAZe+6QZpP/4asyagZ53a5woiT5+sxZ+7Cqv+IwUQOh4f6yO2JFJtPG4iUm6zBsVdjbMPl wildahunden@Daniels-MacBook-Pro-2.local"
    user_data = "${base64encode(file("./salt-minion-cloud-init"))}"
  }
}

resource "oci_core_instance" "saltdemo-salt-minion02" {
  count                 = "1"
  availability_domain   = "aNUQ:US-ASHBURN-AD-2"
  compartment_id        = "${var.compartment_ocid}"
  display_name          = "saltminion02"
  shape                 = "VM.Standard1.2"
  depends_on            = ["oci_core_instance.saltdemo-saltmaster"]
  create_vnic_details {
    subnet_id = "${oci_core_subnet.saltdemo-subnet-lb2.id}"
    display_name = "primaryvnic"
    assign_public_ip = true
    hostname_label = "saltminion02"
  },
  source_details {
    source_type = "image"
    source_id   = "ocid1.image.oc1.iad.aaaaaaaagqwnrno6c35vplndep6hu5gevyiqqag37muue3ich7g6tbs5aq4q"
  },
  metadata {
    ssh_authorized_keys = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC4tJPnV15IvVHywFglq7i5yFEhVUmXqS8Cb7nw+nNO/vHrl6rekw3+jTCi1kmjOYC5YWzfbdl3Brcxcu3hn7Az+TCLBzxVDLu3327iUkw08bDzQITnvHnQqPS94HQxNbsfPX8vACKXbK/4OvMw9VlMz7zsG9R6JcO8KvCO7L2zUxN/mZHMr6jPzUt4oAS2DWsTGqPqqRi/Vl4Plpus1CWFGjQk68Rsu1lR4eHwdDOJCWl8DDMKTkilRdHydEu1P9zpNYJDaoiwJ+sQs8uAZe+6QZpP/4asyagZ53a5woiT5+sxZ+7Cqv+IwUQOh4f6yO2JFJtPG4iUm6zBsVdjbMPl wildahunden@Daniels-MacBook-Pro-2.local"
    user_data = "${base64encode(file("./salt-minion-cloud-init"))}"
  }
}

resource "oci_load_balancer" "saltdemo-lb1" {
  compartment_id = "${var.compartment_ocid}"
  display_name   = "saltdemo-lb1"
  shape          = "100Mbps"
  subnet_ids     = [
    "${oci_core_subnet.saltdemo-subnet-lb1.id}", 
    "${oci_core_subnet.saltdemo-subnet-lb2.id}"
  ]
}

resource "oci_load_balancer_backend_set" "saltdemo-lb-bes1" {
  name             = "saltdemo-lb-bes1"
  load_balancer_id = "${oci_load_balancer.saltdemo-lb1.id}"
  policy           = "ROUND_ROBIN"

  health_checker {
    port     = "80"
    protocol = "HTTP"
    response_body_regex = ".*"
    url_path = "/"
  }
}

resource "oci_load_balancer_path_route_set" "test_path_route_set" {
    #Required
    load_balancer_id = "${oci_load_balancer.saltdemo-lb1.id}"
    name = "pr-set1"
    path_routes {
        #Required
        backend_set_name = "${oci_load_balancer_backend_set.saltdemo-lb-bes1.name}"
        path = "/"
        path_match_type {
            #Required
            match_type = "EXACT_MATCH"
        }

    }
}

resource "oci_load_balancer_hostname" "saltdemo-lb-host1" {
    #Required
    hostname = "app.example.com"
    load_balancer_id = "${oci_load_balancer.saltdemo-lb1.id}"
    name = "hostname1"
}

resource "oci_load_balancer_hostname" "saltdemo-lb-host2" {
    #Required
    hostname = "app2.example.com"
    load_balancer_id = "${oci_load_balancer.saltdemo-lb1.id}"
    name = "hostname2"
}

resource "oci_load_balancer_listener" "lb-listener1" {
  load_balancer_id         = "${oci_load_balancer.saltdemo-lb1.id}"
  name                     = "http"
  default_backend_set_name = "${oci_load_balancer_backend_set.saltdemo-lb-bes1.id}"
  hostname_names           = ["${oci_load_balancer_hostname.saltdemo-lb-host1.name}", "${oci_load_balancer_hostname.saltdemo-lb-host2.name}"]
  port                     = 80
  protocol                 = "HTTP"
  connection_configuration {
    idle_timeout_in_seconds = "2"
  }
}

resource "oci_load_balancer_backend" "saltdemo-lb-be1" {
  load_balancer_id = "${oci_load_balancer.saltdemo-lb1.id}"
  backendset_name  = "${oci_load_balancer_backend_set.saltdemo-lb-bes1.id}"
  ip_address       = "${oci_core_instance.saltdemo-ws1.private_ip}"
  port             = 80
  backup           = false
  drain            = false
  offline          = false
  weight           = 1
}

resource "oci_load_balancer_backend" "saltdemo-lb-be2" {
  load_balancer_id = "${oci_load_balancer.saltdemo-lb1.id}"
  backendset_name  = "${oci_load_balancer_backend_set.saltdemo-lb-bes1.id}"
  ip_address       = "${oci_core_instance.saltdemo-ws2.private_ip}"
  port             = 80
  backup           = false
  drain            = false
  offline          = false
  weight           = 1
}

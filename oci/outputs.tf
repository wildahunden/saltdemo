#This file controls the list of values displayed at the end of the terraform apply.
output "saltdemo-ws1" {
  value = "${oci_core_instance.saltdemo-ws1.public_ip}"
}
output "saltdemo-ws2" {
  value = "${oci_core_instance.saltdemo-ws2.public_ip}"
}
output "saltdemo-saltmaster" {
  value = "${oci_core_instance.saltdemo-saltmaster.public_ip}"
}
output "saltdemo-salt-minion01" {
  value = "${oci_core_instance.saltdemo-salt-minion01.public_ip}"
}
output "saltdemo-salt-minion02" {
  value = "${oci_core_instance.saltdemo-salt-minion02.public_ip}"
}
output "site_public_ipaddress" {
  value = "${oci_load_balancer.saltdemo-lb1.ip_addresses}"
}

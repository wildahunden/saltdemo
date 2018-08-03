output "saltdemo-ws1" {
  value = "${oci_core_instance.saltdemo-ws1.public_ip}"
}
output "saltdemo-ws2" {
  value = "${oci_core_instance.saltdemo-ws2.public_ip}"
}
output "saltdemo-salt1" {
  value = "${oci_core_instance.saltdemo-salt1.public_ip}"
}
output "user-data1" {
  value = "${var.user-data1}"
}
output "user-data2" {
  value = "${var.user-data2}"
}

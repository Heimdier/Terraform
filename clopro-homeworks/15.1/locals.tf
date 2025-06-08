locals {
  vm_pub_name = "vm1-${var.subnet_publ_name}"
  vm_priv_name = "vm2-${var.subnet_priv_name}"
  vm_nat_name = "nat-${var.subnet_publ_name}"
  vm_meta = {
    serial-port-enable = 1
    ssh-keys           = "${var.ssh_user}:${file("~/.ssh/yan.pub")}"
  }
}

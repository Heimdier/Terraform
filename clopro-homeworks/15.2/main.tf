resource "yandex_vpc_network" "netko" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "public" {
  name           = var.subnet_publ_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.netko.id
  v4_cidr_blocks = var.public_cidr
}

data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_family
}

output "load_balancer_ip" {
  description = "Public IP address of the load balancer"
  value       = yandex_lb_network_load_balancer.lb1.listener[*].external_address_spec[*].address
}

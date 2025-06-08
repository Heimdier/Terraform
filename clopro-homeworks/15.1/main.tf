resource "yandex_vpc_network" "netko" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "public" {
  name           = var.subnet_publ_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.netko.id
  v4_cidr_blocks = var.public_cidr
}

resource "yandex_vpc_subnet" "private" {
  name           = var.subnet_priv_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.netko.id
  v4_cidr_blocks = var.private_cidr
  route_table_id = yandex_vpc_route_table.rt.id
}

resource "yandex_vpc_route_table" "rt" {
  name       = var.route_table_name
  network_id = yandex_vpc_network.netko.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = var.nat_ip
  }
}

data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_family
}

output "public_vm_ip" {
  value = yandex_compute_instance.vm_pub.network_interface.0.nat_ip_address
}

output "private_vm_ip" {
  value = yandex_compute_instance.vm_priv.network_interface.0.ip_address
}




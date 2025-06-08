### -------- NAT public----------------------
resource "yandex_compute_instance" "nat_instance" {
  name        = local.vm_nat_name

  platform_id = var.vms_resources.web["platform"]
  zone        = var.default_zone

  resources {
    cores         = var.vms_resources.web["core"]
    memory        = var.vms_resources.web["mem"]
    core_fraction = var.vms_resources.web["fract"]
  }

  boot_disk {
    initialize_params {
      image_id = var.nat_image_id
      type     = var.vms_resources.web["type"]
      size     = var.vms_resources.web["disk_v"]
    }
  }

  scheduling_policy {
    preemptible = var.vms_resources.web["preemt"]
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.public.id
    ip_address = var.nat_ip
    nat        = true
  }

  metadata = {
    serial-port-enable = var.metamaps.meta["serial"]
    ssh-keys           = local.ssh_key
  }
}

### -------- vm public----------------------
resource "yandex_compute_instance" "vm_pub" {
  name        = local.vm_pub_name 

  platform_id = var.vms_resources.web["platform"]

  resources {
    cores         = var.vms_resources.web["core"]
    memory        = var.vms_resources.web["mem"]
    core_fraction = var.vms_resources.web["fract"]
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      type     = var.vms_resources.web["type"]
      size     = var.vms_resources.web["disk_v"]
    }
  }
 
 metadata = {
    serial-port-enable = var.metamaps.meta["serial"]
    ssh-keys           = local.ssh_key
  }

 scheduling_policy {   preemptible = var.vms_resources.web["preemt"]  }

  network_interface {
    subnet_id = yandex_vpc_subnet.public.id

    nat       = var.vms_resources.web["nat"]
  }

}

### -------- vm private----------------------
resource "yandex_compute_instance" "vm_priv" {
  name        = local.vm_priv_name  
  platform_id = var.vms_resources.web["platform"]

  resources {
    cores         = var.vms_resources.web["core"]
    memory        = var.vms_resources.web["mem"]
    core_fraction = var.vms_resources.web["fract"]
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      type     = var.vms_resources.web["type"]
      size     = var.vms_resources.web["disk_v"]
    }
  }
 
 metadata = {
    serial-port-enable = var.metamaps.meta["serial"]
    ssh-keys           = local.ssh_key
  }

 scheduling_policy {    preemptible = var.vms_resources.web["preemt"] }

  network_interface {
    subnet_id = yandex_vpc_subnet.private.id

  }

}

resource "yandex_compute_instance_group" "lamp_group" {
  name               = var.lamp_group_name
  folder_id          = var.folder_id
  service_account_id = var.service_account_id

  instance_template {
    platform_id = var.vm_group_resources.lamp["platform"]
    resources {
      memory = var.vm_group_resources.lamp["mem"]
      cores  = var.vm_group_resources.lamp["core"]
      core_fraction = var.vm_group_resources.lamp["fract"]
    }
    boot_disk {
      initialize_params {
        image_id = var.lamp_image_id
        size     = var.lamp_hdd_size
      }
    }
    network_interface {
      network_id = yandex_vpc_network.netko.id
      subnet_ids = [yandex_vpc_subnet.public.id]
      nat       = true
    }
    metadata = {
      user-data = <<-EOF
        #cloud-config
        write_files:
        - content: |
            <!DOCTYPE html>
            <html>
            <head>
                <meta charset="UTF-8">
                <title>My page</title>
                <style>
                  .server-info {
                    background: #f0f0f0;
                    padding: 10px;
                    margin: 10px 0;
                    border-radius: 5px;
                  }
                </style>
            </head>
            <body>
                <h1>Hello, I am Ben!</h1>
                <div class="server-info">
                  <p>Server IP: HOST_IP_PLACEHOLDER</p>
                </div>
                <img src="https://storage.yandexcloud.net/${yandex_storage_bucket.s3.bucket}/ben.jpg" alt="ben" width="500">
                <p>`Mоя борода крута как всегда!</p>
                <p>Current time: <span id="time"></span></p>
                <script>
                  document.getElementById('time').textContent = new Date().toLocaleString();
                </script>
            </body>
            </html>
          path: /var/www/html/index.html
          owner: www-data:www-data
          permissions: '0644'
        runcmd:
          - sed -i "s/HOST_IP_PLACEHOLDER/$(hostname -I | awk '{print $1}')/g" /var/www/html/index.html
          - sed -i "s/HOST_ID_PLACEHOLDER/$(curl -s http://169.254.169.254/latest/meta-data/instance-id | cut -d'-' -f4)/g" /var/www/html/index.html
          - systemctl restart apache2
      EOF
    }
  }
    scale_policy {
      fixed_scale {
        size = var.vm_group_resources.lamp["scale"]
      }
    }
    allocation_policy {
      zones = [var.default_zone]
    }

    deploy_policy {
      max_unavailable = var.vm_group_resources.lamp["max_un"]
      max_expansion   = var.vm_group_resources.lamp["max_expa"]
    }

    load_balancer {
      target_group_name = var.vm_group_resources.lamp["target_gr"]
    }

    health_check {
      interval = var.vm_group_resources.lamp["health_int"]
      timeout  = var.vm_group_resources.lamp["health_timeout"]
      healthy_threshold   = var.vm_group_resources.lamp["health_thresh"]
      unhealthy_threshold = var.vm_group_resources.lamp["unhealth_thresh"]

    http_options {
      path = var.vm_group_resources.lamp["health_path"]
      port = var.vm_group_resources.lamp["health_port"]
    }
  }
}



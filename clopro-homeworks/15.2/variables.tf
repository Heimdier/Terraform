### VM_Group --------------------------------------

variable "lamp_group_name" {
  type = string
  default = "lamp-group"
}

variable "lamp_image_id" {
  type    = string
  default = "fd827b91d99psvq5fjit"
}

variable "lamp_hdd_size" {
  type    = number
  default = 15
}

variable "vm_group_resources" {
    type = map(object({
        core = number
        mem = number 
        fract = number
        platform = string
        size = number
        scale = number
        max_un = number
        max_expa = number
        health_int = number
        health_timeout = number
        health_thresh = number
        unhealth_thresh = number
	health_path = string
	health_port = number
	target_gr = string
    }))
    default = {
        "lamp" = {
        core = 2
        mem = 2 
        fract = 20
        platform = "standard-v1"
        size = 15
        scale = 3
        max_un = 1
        max_expa = 0
        health_int = 30
        health_timeout = 10
        health_thresh = 2
        unhealth_thresh = 5
	health_path = "/"
	health_port = 80
	target_gr = "lamp-target-group"
        }

    }
}
variable "gr_size" {
  type    = number
  default = 15
}

variable "gr_scale" {
  type    = number
  default = 3
}

### S3 bucket --------------------------------------

variable "s3_name" {
  type = string
  default = "tarahumara"
}
variable "s3_acl" {
  type = string
  default = "public-read"
}

### NAT instance vars

variable "nat_image_id" {
  type    = string
  default = "fd80mrhj8fl2oe87o4e1"
}

variable "nat_ip" {
  type    = string
  default = "192.168.10.254"
}

### Cloud vars --------------------------------------

variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "ssh_user" {
  type    = string
  default = "mahadev"
}

variable "service_account_id" {
  type = string
  default = "ajegbpevfjb398blvvnn"
}
### ----------------------------------------------

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "public_cidr" {
  type        = list(string)
  default     = ["192.168.10.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "private_cidr" {
  type        = list(string)
  default     = ["192.168.20.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "netko"
}

variable "subnet_publ_name" {
  type        = string
  default     = "sub_publ"
}

variable "subnet_priv_name" {
  type        = string
  default     = "sub_priv"
}

variable "route_table_name" {
  type        = string
  default     = "priv_route"
}


variable "vm_web_family" {
  type        = string
  default     = "ubuntu-2004-lts"
}


# ------- Map variables -------
variable "metamaps" {
    type = map(object({
        serial = bool
        ssh = string
    }))
    default = {
        "meta" = {
            serial = true
            ssh = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKoBYtkaOTscrqxn5/GDjg2Q0rJ6wqRwyQ42aNseGYuL yan"
        }
    }
}

variable "vms_resources" {
    type = map(object({
        core = number
        mem = number
        fract = number
        disk_v = number
        platform = string
        type = string
        preemt = bool
        nat = bool
    }))
    default = {
        "web" = {
            core = 2
            mem = 1
            fract = 20
            disk_v = 5
            platform = "standard-v1"
            type = "network-hdd"
            preemt = true
            nat = true
        }

    }
}
#-----------------------------

variable "vm_pub_name" {
  type        = string
  default     = "pu"
}

variable "vm_priv_name" {
  type        = string
  default     = "pri"
}

variable "vm_nat_name" {
  type        = string
  default     = "nata"
}




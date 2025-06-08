### NAT instance vars

variable "nat_image_id" {
  type    = string
  default = "fd80mrhj8fl2oe87o4e1"
}

variable "nat_ip" {
  type    = string
  default = "192.168.10.254"
}

### Cloud vars

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
            ssh = local.ssh_key
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

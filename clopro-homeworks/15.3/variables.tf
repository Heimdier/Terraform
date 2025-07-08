
### S3 bucket

variable "s3_name" {
  type = string
  default = "tarahumara"
}
variable "s3_acl" {
  type = string
  default = "public-read"
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

variable "vm_web_family" {
  type        = string
  default     = "ubuntu-2004-lts"
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

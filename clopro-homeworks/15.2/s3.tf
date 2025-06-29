resource "yandex_storage_bucket" "s3" {
  bucket = var.s3_name
  acl 	 = var.s3_acl

  website {
    index_document = "index"
    error_document = "error"
  }
}

resource "yandex_storage_object" "pic1" {
  bucket     = yandex_storage_bucket.s3.bucket
  
  key        = "ben.jpg"
  source     = "~/Pictures/ben.jpg"
  acl        = var.s3_acl
  content_type = "image/jpeg"
}

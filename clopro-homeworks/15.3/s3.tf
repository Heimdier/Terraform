resource "yandex_storage_bucket" "s3" {
  bucket = var.s3_name
  acl 	 = var.s3_acl
  
    server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = yandex_kms_symmetric_key.s3key.id
        sse_algorithm     = "aws:kms"
      }
    }
  }
}

resource "yandex_storage_object" "pic1" {
  bucket     = yandex_storage_bucket.s3.bucket
  
  key        = "ben2.jpg"
  source     = "~/Pictures/ben.jpg"
  acl        = var.s3_acl
  content_type = "image/jpeg"
}

// Create KMS Symmetric Key
resource "yandex_kms_symmetric_key" "s3key" {
  name              = "s3-sym-key"
  description       = "s3 sym-key"
  default_algorithm = "AES_128"
  rotation_period   = "8760h" // 1 year
}

// Grant permissions
resource "yandex_kms_symmetric_key_iam_binding" "key_encrypter_decrypter" {
  symmetric_key_id = yandex_kms_symmetric_key.s3key.id
  role             = "kms.keys.encrypterDecrypter"
  members          = [    "serviceAccount:${var.service_account_id}",
  ]
}


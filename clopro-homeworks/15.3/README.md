# Домашнее задание к занятию «Безопасность в облачных провайдерах»  

Используя конфигурации, выполненные в рамках предыдущих домашних заданий, нужно добавить возможность шифрования бакета.

---
## Задание 1. Yandex Cloud   

1. С помощью ключа в KMS необходимо зашифровать содержимое бакета:

 - создать ключ в KMS;
 - с помощью ключа зашифровать содержимое бакета, созданного ранее.
2. (Выполняется не в Terraform)* Создать статический сайт в Object Storage c собственным публичным адресом и сделать доступным по HTTPS:

 - создать сертификат;
 - создать статическую страницу в Object Storage и применить сертификат HTTPS;
 - в качестве результата предоставить скриншот на страницу с сертификатом в заголовке (замочек).

Полезные документы:

- [Настройка HTTPS статичного сайта](https://cloud.yandex.ru/docs/storage/operations/hosting/certificate).
- [Object Storage bucket](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/storage_bucket).
- [KMS key](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/kms_symmetric_key).








----------------------------------------------------------- 
1. ## *Создать бакет Object Storage и разместить в нём файл с картинкой:*   
- *создал ключ в KMS*   
      [s3.tf](https://github.com/Heimdier/Terraform/blob/main/clopro-homeworks/15.2/s3.tf)   
      [variables.tf](https://github.com/Heimdier/Terraform/blob/main/clopro-homeworks/15.2/variables.tf)   

- *создал симметричный ключ в KMS*   
```
resource "yandex_kms_symmetric_key" "s3key" {
  name              = "s3-sym-key"
  description       = "s3 sym-key"
  default_algorithm = "AES_128"
  rotation_period   = "8760h"
}
```

- *дал права для существующего сервис аккаунта*   
```
resource "yandex_kms_symmetric_key_iam_binding" "key_encrypter_decrypter" {
  symmetric_key_id = yandex_kms_symmetric_key.s3key.id
  role             = "kms.keys.encrypterDecrypter"
  members          = [    "serviceAccount:${var.service_account_id}",
  ]
}
```

- *прикрутил созданный ключ к s3 бакету*     
```
    server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = yandex_kms_symmetric_key.s3key.id
        sse_algorithm     = "aws:kms"
      }
    }
  }
```

- *пробую открыть файл из бакета, который ранее был - успешно, так как шифроваться будут вновь добавленные файлы в бакет*

![image](https://github.com/user-attachments/assets/1098faf0-0901-4b12-b399-ec38208d0df3)

- *перезалил файл в бакет*

![image](https://github.com/user-attachments/assets/d6e44aba-0055-49b0-9c4c-014557a93f9c)

- *пробую снова открыть файл из бакета - видим что файл зашифрован*

 ![image](https://github.com/user-attachments/assets/abb4b74d-7f3e-46af-8dd8-aebb8e03a1d2)


- *Проверяем доступность картинки в бакете из интернет:*   [https://tarahumara.website.yandexcloud.net/ben.jpg](https://tarahumara.website.yandexcloud.net/ben.jpg)

![image](https://tarahumara.website.yandexcloud.net/ben.jpg)  

--------

2. ## *Создать группу ВМ в public подсети фиксированного размера с шаблоном LAMP и веб-страницей, содержащей ссылку на картинку из бакета:*    
- *Проект Terraform:*   
      [vm_group_pub.tf](https://github.com/Heimdier/Terraform/blob/main/clopro-homeworks/15.2/vm_group_pub.tf)   
      [balancer.tf](https://github.com/Heimdier/Terraform/blob/main/clopro-homeworks/15.2/balancer.tf)   

- *Стучимся по адресу сетевого балансера по порту 80 - получаем картинку из бакета*   

![image](https://github.com/user-attachments/assets/9afb53b0-6e30-4ee1-8ace-17afe744649c)

- *Стучимся еще раз для проверки балансировщика - видим отклик от следующей vm*   

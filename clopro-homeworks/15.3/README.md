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
## *Выполнение*   
1. ## *С помощью ключа в KMS необходимо зашифровать содержимое бакета:*   
- *проект terraform:*      
      [s3.tf](https://github.com/Heimdier/Terraform/blob/main/clopro-homeworks/15.3/s3.tf)   
      [variables.tf](https://github.com/Heimdier/Terraform/blob/main/clopro-homeworks/15.3/variables.tf)   

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



2. ## *Создать статический сайт в Object Storage c собственным публичным адресом и сделать доступным по HTTPS:*
- *через Let’s Encrypt создать сертификат не удалось, поэтому я выпустил самоподписной сертификат:*   
```
openssl req -x509 -newkey rsa:4096 -nodes \
  -keyout key.pem \
  -out cert.pem \
  -days 365 \
  -subj '/CN=hachi.qzz.io'
```

- *добавил его через Certificate Manager:*

![image](https://github.com/user-attachments/assets/67e3ba4d-0218-4f9b-a8cc-076eda230868)

- *в bucket залил страничку и создал dns запись*   

![image](https://github.com/user-attachments/assets/a858e49e-1790-4b41-ac76-0096cce8bed6)

- *и прикрутил сертификат*   

![image](https://github.com/user-attachments/assets/ab6cacaf-0d7f-44af-be2f-e21bfe379de9)

- *проверяем - ругается на то что сертификат самоподписной, но по https заходит*     

![image](https://github.com/user-attachments/assets/dae9bd57-95ef-4ec0-8707-39fe6da6ae35)


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

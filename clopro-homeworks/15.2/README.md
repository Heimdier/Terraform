## Задание 1. Yandex Cloud 

**Что нужно сделать**

1. Создать бакет Object Storage и разместить в нём файл с картинкой:

 - Создать бакет в Object Storage с произвольным именем (например, _имя_студента_дата_).
 - Положить в бакет файл с картинкой.
 - Сделать файл доступным из интернета.
 
2. Создать группу ВМ в public подсети фиксированного размера с шаблоном LAMP и веб-страницей, содержащей ссылку на картинку из бакета:

 - Создать Instance Group с тремя ВМ и шаблоном LAMP. Для LAMP рекомендуется использовать `image_id = fd827b91d99psvq5fjit`.
 - Для создания стартовой веб-страницы рекомендуется использовать раздел `user_data` в [meta_data](https://cloud.yandex.ru/docs/compute/concepts/vm-metadata).
 - Разместить в стартовой веб-странице шаблонной ВМ ссылку на картинку из бакета.
 - Настроить проверку состояния ВМ.
 
3. Подключить группу к сетевому балансировщику:

 - Создать сетевой балансировщик.
 - Проверить работоспособность, удалив одну или несколько ВМ.
4. (дополнительно)* Создать Application Load Balancer с использованием Instance group и проверкой состояния.

Полезные документы:

- [Compute instance group](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/compute_instance_group).
- [Network Load Balancer](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/lb_network_load_balancer).
- [Группа ВМ с сетевым балансировщиком](https://cloud.yandex.ru/docs/compute/operations/instance-groups/create-with-balancer).


--------   
1. ## *Создать бакет Object Storage и разместить в нём файл с картинкой:*   
- *Проект Terraform:*   
      [s3.tf](https://github.com/Heimdier/Terraform/blob/main/clopro-homeworks/15.2/s3.tf)   
      [variables.tf](https://github.com/Heimdier/Terraform/blob/main/clopro-homeworks/15.2/variables.tf)   

- *Применил конфиг*
   `terraform apply`   

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

![image](https://github.com/user-attachments/assets/a521870f-df45-4e63-a50e-7e614badd4d3)

- *Удалил одну из vm и постучался на балансировщик для проверки*   

![image](https://github.com/user-attachments/assets/46c60f16-7ebf-434f-9c7d-f4a3c841d329)

![image](https://github.com/user-attachments/assets/b6e73e61-a240-4f7b-9c35-cc82c0ecc518)



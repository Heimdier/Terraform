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

1. ### *Проект Terraform:*   
      [main.tf](https://github.com/Heimdier/Terraform/blob/main/clopro-homeworks/15.1/main.tf)   
      [instance.tf](https://github.com/Heimdier/Terraform/blob/main/clopro-homeworks/15.1/instance.tf)   
      [providers.tf](https://github.com/Heimdier/Terraform/blob/main/clopro-homeworks/15.1/providers.tf)   
      [variables.tf](https://github.com/Heimdier/Terraform/blob/main/clopro-homeworks/15.1/variables.tf)   
      [locals.tf](https://github.com/Heimdier/Terraform/blob/main/clopro-homeworks/15.1/locals.tf)
   

2. ### *Применил конфиг*
   `terraform apply`   

3. ### *проверяем доступность картинки в бакете из интернет:*   

![image](https://tarahumara.website.yandexcloud.net/ben.jpg)  

3. ### *Подключился к vm в публичной сети - проверил выход в интернет:*   

![image](https://github.com/user-attachments/assets/bb6a80c8-6992-47e2-b144-103fda4fb6d1)

4. ### *Подключился к vm в приватной сети из публичной vm `ubuntu@fhmjlochuvr484k1soat:~$ ssh -i ~/.ssh/yan ubuntu@192.168.20.14` и проверил выход в интернет:*

![image](https://github.com/user-attachments/assets/988991a9-ca31-4800-b0a4-f84d4de12f11)


### Задание 1. Yandex Cloud 

**Что нужно сделать**

1. Создать пустую VPC. Выбрать зону.
2. Публичная подсеть.

 - Создать в VPC subnet с названием public, сетью 192.168.10.0/24.
 - Создать в этой подсети NAT-инстанс, присвоив ему адрес 192.168.10.254. В качестве image_id использовать fd80mrhj8fl2oe87o4e1.
 - Создать в этой публичной подсети виртуалку с публичным IP, подключиться к ней и убедиться, что есть доступ к интернету.
3. Приватная подсеть.
 - Создать в VPC subnet с названием private, сетью 192.168.20.0/24.
 - Создать route table. Добавить статический маршрут, направляющий весь исходящий трафик private сети в NAT-инстанс.
 - Создать в этой приватной подсети виртуалку с внутренним IP, подключиться к ней через виртуалку, созданную ранее, и убедиться, что есть доступ к интернету.


--------   

1. ### Проект Terraform:   
      [main.tf](https://github.com/Heimdier/Terraform/blob/main/clopro-homeworks/15.1/main.tf)   
      [instance.tf](https://github.com/Heimdier/Terraform/blob/main/clopro-homeworks/15.1/instance.tf)   
      [providers.tf](https://github.com/Heimdier/Terraform/blob/main/clopro-homeworks/15.1/providers.tf)   
      [variables.tf](https://github.com/Heimdier/Terraform/blob/main/clopro-homeworks/15.1/variables.tf)   
      [locals.tf](https://github.com/Heimdier/Terraform/blob/main/clopro-homeworks/15.1/locals.tf)
   

2. Применил конфиг `terraform apply`   

![image](https://github.com/user-attachments/assets/4b53acce-dc0c-4449-8328-25acd33fbb63)   

![image](https://github.com/user-attachments/assets/5c54ca16-e8f0-44ba-b444-abcb72b122e2)  

3. Подключился к vm в публичной сети - проверил выход в интернет:   

![image](https://github.com/user-attachments/assets/bb6a80c8-6992-47e2-b144-103fda4fb6d1)

4. Подключился к vm в приватной сети из публичной vm `ubuntu@fhmjlochuvr484k1soat:~$ ssh -i ~/.ssh/yan ubuntu@192.168.20.14` и проверил выход в интернет:

![image](https://github.com/user-attachments/assets/988991a9-ca31-4800-b0a4-f84d4de12f11)


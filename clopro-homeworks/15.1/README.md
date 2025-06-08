
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

1. Проект Terraform:
 [dep-ng-mu](https://github.com/Heimdier/DEV/blob/main/Kube/2.3/dep-ng-mu.yml)
  [dep-ng-mu](https://github.com/Heimdier/DEV/blob/main/Kube/2.3/dep-ng-mu.yml)
   [dep-ng-mu](https://github.com/Heimdier/DEV/blob/main/Kube/2.3/dep-ng-mu.yml)
    [dep-ng-mu](https://github.com/Heimdier/DEV/blob/main/Kube/2.3/dep-ng-mu.yml)

2. Применил конфиг `terraform apply`   

![image](https://github.com/user-attachments/assets/4b53acce-dc0c-4449-8328-25acd33fbb63)   

![image](https://github.com/user-attachments/assets/5c54ca16-e8f0-44ba-b444-abcb72b122e2)  

3. Подключился к vm в публичной сети - проверил выход в интернет:   

![image](https://github.com/user-attachments/assets/bb6a80c8-6992-47e2-b144-103fda4fb6d1)

4. Подключился к vm в приватной сети из публичной vm `ubuntu@fhmjlochuvr484k1soat:~$ ssh -i ~/.ssh/yan ubuntu@192.168.20.14`








4. Подготовил сервис для подключения к nginx [service-nx](https://github.com/Heimdier/DEV/blob/main/Kube/2.3/service-nx.yml)

5. Стартовал манифесты
```shell
maha@mahavm:~/kuber/2-3$ kubectl apply -f config-map-mu.yml
configmap/mu-port created
maha@mahavm:~/kuber/2-3$ kubectl apply -f config-map-nx.yml
configmap/nginx-index created
maha@mahavm:~/kuber/2-3$ kubectl apply -f dep-ng-mu.yml
deployment.apps/2app created
maha@mahavm:~/kuber/2-3$ kubectl apply -f service-nx.yml
service/service-nx created
```
![image](https://github.com/user-attachments/assets/fed05a12-40d8-4be9-8f4f-e58f40e3dbcf)

6. Зашел в отдельный под и постучался curl на сервис

![image](https://github.com/user-attachments/assets/77e5612a-2131-413d-861e-528e98b788bf)

------

### Задание 1. Создать Deployment приложения и решить возникшую проблему с помощью ConfigMap. Добавить веб-страницу

1. Создал Deployment приложения, состоящего из контейнеров nginx и multitool   
 [dep-ng-mu](https://github.com/Heimdier/DEV/blob/main/Kube/2.3/dep-ng-mu.yml)

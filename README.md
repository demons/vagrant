# Автоматизированный vagrant

## Краткое описание

Универсальный проект для запуска нескольких виртуальных машин с помощью Vagrant. Конфигурации виртуальных машин прописываются в файле `hosts.json`.

## Запуск проекта

```bash
# Запуск виртуальных машин
vagrant up

# Удаление виртуальных машин
vagrant destroy -f

# Удаление одной виртуальной машины
vagrant destroy -f vm_name

# Остановка виртуальных машин
vagrant halt
```

## Изменение размера диска

Чтобы увеличить размер диска, нужно установить плагин для vagrant:

```bash
vagrant plugin install vagrant-disksize
```

Расширение lvm на весь физический диск:
https://habr.com/ru/articles/649703/

```bash
sudo su -
# lvs
lsblk -l
parted > p
resizepart 3 > 100% > q
pvresize /dev/sda3
pvs
lvresize --resizefs --size +87g /dev/ubuntu-vg/ubuntu-lv

# У этого способа не меняется размер файловой системы
# lvextend -l +100%FREE /dev/ubuntu-vg/ubuntu-lv
```

## Установка kubespray

```bash
ansible-playbook -i inventory/mycluster/hosts.yaml  --become --become-user=root cluster.yml
```

```bash
mkdir /home/vagrant/.kube && \
scp root@kube1.lan:/etc/kubernetes/admin.conf /home/vagrant/.kube/config && \
sudo chown $(id -u):$(id -g) /home/vagrant/.kube/config
```

## Синтаксис файла hosts.json

```bash
[
  {
    "name": "kuber", # Название виртуальной машины (пропишет в dns mikrotik name.lan)
    "box": "bento/ubuntu-22.04",
    "ip": "192.168.1.110",
    "cpus": "4",
    "memory": 4096,
    "disk": "100GB",
    "scripts": ["hello.sh"], # Список скриптов, который будут выполнены на виртуальной машине
    "public": [ # Публичные ключи, которые будут добавлены в /home/vagrant/.ssh/authorized_keys
      "~/vagrant/id_ed25519.pub",
      "~/vagrant/pub_keys"
    ],
    "private": ["~/vagrant/id_ed25519"], # Приватные ключи, которые будут добавлены в /home/vagrant/.ssh (для доступа к подчиненным виртуальным машинам)
    "data": [
      {
        "from": "./data", # Директория на хостовой машине
        "to": "/home/vagrant/data" # Директория в виртуальной машине,
        "mount_options": ["dmode=755,fmode=644"] # Необязательный параметр, который прописывает права на подключенную директорию в виртуальной машине
      }
    ]
  }
]
```

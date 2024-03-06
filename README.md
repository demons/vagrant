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

## Синтаксис файла hosts.json
```bash
[
  {
    "name": "kuber", # Название виртуальной машины (пропишет в dns mikrotik name.lan)
    "box": "bento/ubuntu-22.04",
    "ip": "192.168.1.110",
    "cpus": "4",
    "memory": 4096,
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
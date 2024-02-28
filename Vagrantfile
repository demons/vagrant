require "json"
require "./includes/colorized.rb"
require "./includes/access.rb"
require "./includes/data.rb"
require "./includes/scripts.rb"
require "./includes/mikrotik-dns.rb"

file = File.open "./hosts.json"
records = JSON.load file

Vagrant.configure("2") do |config|

  records.each do |record|
    config.vm.define record["name"] do |host|
      host.vm.box = record["box"]
      host.vm.hostname = record["name"]
      host.vm.provider "virtualbox" do |vb|
        vb.name = record["name"]
        vb.cpus = record["cpus"] || 1
        vb.memory = record["memory"] || 1024
      end

      host.vm.network "public_network", ip: record["ip"]

      # Добавит dns-запись, при создании vm
      updateDns(host, record)

      # Запуск скрипта настройки доступа
      createPublicKeys(host, record)
      createPrivateKeys(host, record)

      # Создание общих директорий
      createData(host, record)

      # Запуск скриптов в виртуальной машине
      runScripts(host, record)

      # Перезагрузка
      host.vm.provision "shell", inline: "reboot now"
    end # end config
  end # end records

end # end Vagrant.configure

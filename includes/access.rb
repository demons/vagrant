def createPublicKeys(host, record)
  publicFiles = record["public"] || []

  publicFiles.each do |path|
    source = File.expand_path(path)
    fileName = File.basename(source)
    home_dir = "/home/vagrant"
    temp_dest = "#{home_dir}/#{fileName}"
    authorized_keys = "#{home_dir}/.ssh/authorized_keys"
    root_authorized_keys = "/root/.ssh/authorized_keys"

    if !File.exist? source
      puts "Файл #{source} не найден".bold.red
      next
    end

    puts "Копирую файл #{fileName} из #{source} в #{temp_dest}".bold.green

    # Копируем файлы на виртуальную машину
    host.vm.provision "file", source: source, destination: temp_dest

    # Запуск скриптов в виртуальной машине
    host.vm.provision "shell", inline: "cat #{temp_dest} >> #{authorized_keys}"
    host.vm.provision "shell", inline: "cat #{temp_dest} >> #{root_authorized_keys}"
    host.vm.provision "shell", inline: "rm -rf #{temp_dest}"
  end
end

def createPrivateKeys(host, record)
  privateFiles = record["private"] || []

  privateFiles.each do |path|
    source = File.expand_path(path)
    fileName = File.basename(source)
    home_dir = "/home/vagrant"
    dest = "#{home_dir}/.ssh/#{fileName}"

    if !File.exist? source
      puts "Файл #{source} не найден".bold.red
      next
    end

    puts "Копирую файл #{fileName} из #{source}".bold.green

    # Копируем файлы на виртуальную машину
    host.vm.provision "file", source: source, destination: dest

    # Выполняем скрипты в виртуальной машине
    host.vm.provision "shell", inline: "chmod 400 #{dest}"
  end
end
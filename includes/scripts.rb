def runScripts(host, record)
  # Выполнит скрипты из-под root
  sudo_scripts = record["sudo_scripts"] || []
  sudo_scripts.each do |sudo_script|
    path = "sudo_scripts/#{sudo_script}"
    if File.exist? path
      host.vm.provision "shell", path: path
    end
  end

  # Выполнит скрипты из-под пользователя
  user_scripts = record["user_scripts"] || []
  user_scripts.each do |user_script|
    path = "user_scripts/#{user_script}"
    if File.exist? path
      host.vm.provision "shell", path: path, privileged: false
    end
  end
end
def runScripts(host, record)
  # Выполнит скрипты из-под пользователя
  user_scripts = record["user_scripts"] || []
  user_scripts.each do |user_script|
    path = "user_scripts/#{user_script}"
    if File.exist? path
      host.vm.provision "shell", path: path, privileged: false
    end
  end
end
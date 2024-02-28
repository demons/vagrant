def runScripts(host, record)
  scripts = record["scripts"] || []
  scripts.each do |script|
    path = "scripts/#{script}"
    if File.exist? path
      host.vm.provision "shell", path: path
    end
  end
end
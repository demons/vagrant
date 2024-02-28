def createData(host, record)
  data = record["data"] || []

  data.each do |item|
    if !item["from"] || !item["to"]
      puts "Неправильная форма записи для data".bold.red
      next
    end

    from = File.expand_path(item["from"])
    to = item["to"]
    mount_options = item["mount_options"] || ["dmode=755,fmode=644"]

    puts "Директория #{from} смонтирована в #{to}".bold.green
    host.vm.synced_folder from, to, mount_options: mount_options
  end
end
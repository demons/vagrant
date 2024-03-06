def updateDns(host, record)
  host.trigger.before :up do |trigger|
    trigger.info = "Up trigger"
    trigger.ruby do
      print `ssh \
        -o UserKnownHostsFile=/dev/null \
        -o StrictHostKeychecking=no \
        alex@router.lan -p2323 \
        /ip/dns/static/add \
        address="#{record['ip']}" \
        name="#{record['name']}.lan" \
        ttl="00:10:00"`
    end
  end

  # Удалит dns-запись, при удалении vm
  host.trigger.after :destroy do |trigger|
    trigger.info = "Destroy trigger"
    trigger.ruby do
      print `ssh \
        -o UserKnownHostsFile=/dev/null \
        -o StrictHostKeychecking=no \
        alex@router.lan -p2323 \
        /ip/dns/static/remove \
            numbers=[find where address="#{record['ip']}"]`
    end
  end
end
require "runner-tool"

RunnerTool.configure

servers = ["localhost:2222"]

at(servers, {in: :serial}) do |host|
  exec!("ls -la /home/vagrant")
  exec!('test -d "/" && echo "true"')
  exec!('test -d "/var/log" && echo "true" || echo "false" ')
  upload! "foo"
end

at(:local) do |host|
    cmd = exec!("ls -la /var/")
    puts cmd.inspect
end


at(servers, {in: :serial}) do |host|
  exec!("wget https://download.elastic.co/logstash/logstash/packages/debian/logstash_2.3.1-1_all.deb")
  sudo_exec!("dpkg -i  logstash_2.3.1-1_all.deb")
  cmd = sudo_exec!('test -d "/opt/logstash" && echo "True" || echo "False"')
  puts cmd.inspect
end


at(servers, {in: :serial}) do |host|
  exec!("ls -la /home/vagrant")
end

at(servers, {in: :serial}) do |host|
  exec!("ls -la /home/vagrant/foo")
end

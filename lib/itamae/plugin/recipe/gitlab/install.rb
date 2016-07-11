# encoding: utf-8

node[:gitlab] ||= {}

# Set default version.
node[:gitlab][:version] ||= '8.9.5'

# Install the necessary dependencies.
include_recipe 'gitlab::dependency'

# Start postfix service.
service "postfix" do
  user "root"
  action [:enable, :start]
end

if node[:platform] == 'redhat'
  execute "set firewall" do
    user "root"
    command "lokkit -s http -s ssh"
  end
end

execute "add package" do
  command "curl -LJO #{node[:gitlab][:install_url]}"
end

case node[:platform]
when 'redhat'
  execute "rpm" do
    user "root"
    command "rpm -i gitlab-ce-#{node[:gitlab][:type]}.rpm"
  end
when 'debian', 'ubuntu'
  execute "dpkg" do
    user "root"
    command "dpkg -i gitlab-ce_#{node[:gitlab][:type]}.deb"
  end
end


execute "reconfigure" do
  user "root"
  command "gitlab-ctl reconfigure"
end

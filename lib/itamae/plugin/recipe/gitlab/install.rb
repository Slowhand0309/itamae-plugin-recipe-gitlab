# encoding: utf-8

PACKAGE_SH_URL = "https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.rpm.sh"

# Install the necessary dependencies.
include_recipe 'gitlab::dependency'

# Start postfix service.
service "postfix" do
  user "root"
  action [:enable, :start]
end

execute "set firewall" do
  user "root"
  command "lokkit -s http -s ssh"
end

execute "add package" do
  command "curl -sS #{PACKAGE_SH_URL} | sudo bash"
end

package 'gitlab-ce' do
  user "root"
  action :install
end

execute "reconfigure" do
  user "root"
  command "gitlab-ctl reconfigure"
end

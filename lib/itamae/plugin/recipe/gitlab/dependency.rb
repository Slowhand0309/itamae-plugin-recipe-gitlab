# encoding: utf-8

PACKAGE_DOWNLOAD_URL = "https://packages.gitlab.com/gitlab/gitlab-ce/packages".freeze
SCRIPT_DOWNLOAD_URL = "https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.rpm.sh | sudo bash".freeze

package 'curl'
package 'openssh-server'
package 'postfix'

case node[:platform]
when 'redhat'
  package 'openssh-clients'
  version = node[:platform_version].to_s.split('.')[0]
  if version == '6'
    package 'cronie'
    node[:gitlab][:type] = "#{node[:gitlab][:version]}-ce.0.el6"
  elsif version == '7'
    package 'policycoreutils'
    node[:gitlab][:type] = "#{node[:gitlab][:version]}-ce.0.el7"
  end

  # Set install script url.
  node[:gitlab][:install_url] = SCRIPT_DOWNLOAD_URL
  node[:gitlab][:curl_opt] = '-sS'

when 'ubuntu'
  package 'ca-certificates'

  # Set install script url.
  node[:gitlab][:type] = "#{node[:gitlab][:version]}-ce.0_amd64"
  node[:gitlab][:install_url] = "#{PACKAGE_DOWNLOAD_URL}/ubuntu/trusty/gitlab-ce_#{node[:gitlab][:type]}.deb"
  node[:gitlab][:curl_opt] = '-LO'

when 'debian'
  package 'ca-certificates'
else
end

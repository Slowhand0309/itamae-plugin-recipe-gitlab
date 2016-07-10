# encoding: utf-8

package 'curl'
package 'openssh-server'
package 'postfix'

case node[:platform]
when 'redhat'
  package 'openssh-clients'
  version = node[:platform_version].to_s.split('.')[0]
  if version == '6'
    package 'cronie'
  elsif version == '7'
    package 'policycoreutils'
  end

when 'debian', 'ubuntu'
  package 'ca-certificates'
else
end

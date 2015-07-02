
# 列挙されたパッケージを全部インストールする
%w{vim}.each do |pkg|
  package pkg do
    action :install
  end
end

template "/etc/profile.d/chef-ruby.sh" do
  source "chef-ruby.sh.erb"
  owner "root"
  group "root"
  mode 0644
end

gem_package "bundler" do
  gem_binary("/opt/chef/embedded/bin/gem")
  options("--prerelease --no-format-executable")
end

execute 'bundle install' do
  cwd '/home/vagrant/provisioner_chef_zero'
  not_if 'bundle check' # This is not run
end

package "docker-io" do
  action :install
end

package "device-mapper-libs.i686" do
  action :install
end


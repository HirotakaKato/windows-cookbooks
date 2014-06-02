# インストールするバージョン
version = '1.6.3'

# ダウンロードする URL
source  = "http://dl.bintray.com/mitchellh/vagrant/vagrant_#{version}.msi"

# VirtualBox をインストールする
include_recipe 'virtualbox'

# Vagrant をインストールする
windows_package 'Vagrant' do
  version version
  source  source
end

# プラグインをインストールする
path    = File.join(ENV['SystemDrive'], 'HashiCorp/Vagrant/bin').tr('/', '\\')
vagrant = File.join(path, 'vagrant.exe')

node['vagrant']['plugin'].each do |p|
  execute %Q("#{vagrant}" plugin install #{p})
end

# Path を設定する
windows_path path

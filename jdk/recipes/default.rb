# インストールするバージョン
version_m = 8
version_u = 5
version_b = 13

# ダウンロードする URL
arch   = (node['kernel']['machine'] == 'x86_64') ? 'x64' : 'i586'
source = "http://download.oracle.com/otn-pub/java/jdk/#{version_m}u#{version_u}-b#{version_b}/jdk-#{version_m}u#{version_u}-windows-#{arch}.exe"

# キャッシュする
cache  = File.join(Chef::Config[:file_cache_path], File.basename(source))

remote_file cache do
  source  source
  headers 'Cookie' => 'oraclelicense=accept-securebackup-cookie'
end

# Java SE Development Kit をインストールする
name_arch = (node['kernel']['machine'] == 'x86_64') ? ' (64-bit)' : ''

windows_package "Java SE Development Kit #{version_m} Update #{version_u}#{name_arch}" do
  version "#{version_m}.0.#{version_u}0"
  source  cache
  options '/quiet'
  installer_type :custom
end

# JAVA_HOME を設定する
ENV['JAVA_HOME'] = File.join(ENV['ProgramW6432'] || ENV['ProgramFiles'], "Java/jdk1.#{version_m}.0_0#{version_u}").tr('/', '\\')

registry_key %q(HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment) do
  values [{
    name: 'JAVA_HOME',
    type: :string,
    data: ENV['JAVA_HOME'],
  }]
end

# Path を設定する
windows_path File.join(ENV['JAVA_HOME'], 'bin').tr('/', '\\')

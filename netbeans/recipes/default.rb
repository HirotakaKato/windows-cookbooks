# インストールするディレクトリ
dir      = File.join(ENV['SystemDrive'], 'opt/netbeans')

# ダウンロードする URL
source   = 'http://dlc.sun.com.edgesuite.net/netbeans/8.0/final/zip/netbeans-8.0-201403101706.zip'

# 作成するショートカット
shortcut = File.join(ENV['ProgramData'], 'Microsoft/Windows/Start Menu/Programs/NetBeans IDE.lnk').tr('/', '\\')
target   = File.join(dir, 'bin/netbeans.exe').tr('/', '\\')

# Java SE Development Kit をインストールする
include_recipe 'jdk'

# zip ファイルを展開する
windows_zipfile File.dirname(dir) do
  not_if { Dir.exist?(dir) }
  source source
end

# NetBeansSuite.php を修正する
cookbook_file File.join(dir, 'php/phpunit/NetBeansSuite.php')

# ショートカットを作成する
windows_shortcut shortcut do
  target target
end

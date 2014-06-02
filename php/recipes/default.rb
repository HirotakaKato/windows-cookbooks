# インストールするバージョン
version        = '5.5.13'
version_xdebug = '2.2.5-5.5'

# インストールするディレクトリ
path = File.join(ENV['SystemDrive'], 'opt/php').tr('/', '\\')

# ダウンロードする URL
arch        = (node['kernel']['machine'] == 'x86_64') ? 'x64' : 'x86'
arch_xdebug = (node['kernel']['machine'] == 'x86_64') ? '-x86_64' : ''

source        = "http://windows.php.net/downloads/releases/php-#{version}-Win32-VC11-#{arch}.zip"
source_xdebug = "http://xdebug.org/files/php_xdebug-#{version_xdebug}-vc11#{arch_xdebug}.dll"

# Visual Studio 2012 更新プログラム 4 の Visual C++ 再頒布可能パッケージをインストールする
include_recipe 'vcredist'

# zip ファイルを展開する
windows_zipfile path do
  not_if { Dir.exist?(path) }
  source source
end

# xdebug をキャッシュする
cache = File.join(Chef::Config[:file_cache_path], File.basename(source_xdebug))
file  = File.join(path, 'ext/php_xdebug.dll')

remote_file cache do
  source source_xdebug
end

# キャッシュからコピーする
ruby_block file do
  only_if { not File.exist?(file) or Digest::SHA256.file(file).hexdigest != Digest::SHA256.file(cache).hexdigest }
  block   { FileUtils.cp cache, file }
end

# php.ini を作成する
cookbook_file File.join(path, 'php.ini')

# Path を設定する
windows_path path

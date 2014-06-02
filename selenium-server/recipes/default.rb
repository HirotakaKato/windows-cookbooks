# インストールするバージョン
version_base   = '2.42'
version_suffix = 1
version_chrome = '2.10'

# インストールするディレクトリ
dir    = File.join(ENV['SystemDrive'], 'opt/selenium-server')
file   = File.join(dir, 'selenium-server.jar').tr('/', '\\')
ie     = File.join(dir, 'IEDriverServer.exe').tr('/', '\\')
chrome = File.join(dir, 'chromedriver.exe').tr('/', '\\')

# ダウンロードする URL
arch = (node['kernel']['machine'] == 'x86_64') ? 'x64' : 'Win32'

source        = "http://selenium-release.storage.googleapis.com/#{version_base}/selenium-server-standalone-#{version_base}.#{version_suffix}.jar"
source_ie     = "http://selenium-release.storage.googleapis.com/#{version_base}/IEDriverServer_#{arch}_#{version_base}.0.zip"
source_chrome = "http://chromedriver.storage.googleapis.com/#{version_chrome}/chromedriver_win32.zip"

cache = File.join(Chef::Config[:file_cache_path], File.basename(source))

# 作成するショートカット
shortcut  = File.join(ENV['ProgramData'], 'Microsoft/Windows/Start Menu/Programs/Selenium Server.lnk').tr('/', '\\')
target    = File.join(ENV['JAVA_HOME'], 'bin/java.exe').tr('/', '\\')
arguments = %Q(-jar "#{file}" -Dwebdriver.ie.driver="#{ie}" -Dwebdriver.chrome.driver="#{chrome}")

# Java SE Development Kit をインストールする
include_recipe 'jdk'

# IE ドライバの zip ファイルを展開する
windows_zipfile dir do
  not_if { File.exist?(ie) }
  source source_ie
end

# Chrome ドライバの zip ファイルを展開する
windows_zipfile dir do
  not_if { File.exist?(chrome) }
  source source_chrome
end

# selenium-server をキャッシュする
remote_file cache do
  source source
end

# キャッシュからコピーする
ruby_block file do
  only_if { not File.exist?(file) or Digest::SHA256.file(file).hexdigest != Digest::SHA256.file(cache).hexdigest }
  block   { FileUtils.cp cache, file }
end

# ショートカットを作成する
windows_shortcut shortcut do
  target    target
  arguments arguments
end

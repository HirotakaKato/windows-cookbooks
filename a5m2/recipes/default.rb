# インストールするディレクトリ
dir      = File.join(ENV['SystemDrive'], 'opt/a5m2')

# ダウンロードする URL
arch     = (node['kernel']['machine'] == 'x86_64') ? 'x64' : 'x86'
source   = "http://ftp.vector.co.jp/pack/winnt/business/db/a5m2_2.10.1_#{arch}.zip"

# 作成するショートカット
shortcut = File.join(ENV['ProgramData'], 'Microsoft/Windows/Start Menu/Programs/A5M2.lnk').tr('/', '\\')
target   = File.join(dir, 'A5M2.exe').tr('/', '\\')

# zip ファイルを展開する
windows_zipfile dir do
  not_if { Dir.exist?(dir) }
  source source
end

# ショートカットを作成する
windows_shortcut shortcut do
  target target
end

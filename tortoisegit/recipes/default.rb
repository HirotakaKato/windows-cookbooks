# インストールするバージョン
version = '1.8.8.0'

# ダウンロードする URL
bit     = (node['kernel']['machine'] == 'x86_64') ? 64 : 32
source  = "http://download.tortoisegit.org/tgit/#{version}/TortoiseGit-#{version}-#{bit}bit.msi"

# Git for Windows をインストールする
include_recipe 'msysgit'

# TortoiseGit をインストールする
windows_package "TortoiseGit #{version} (#{bit} bit)" do
  version version
  source  source
end

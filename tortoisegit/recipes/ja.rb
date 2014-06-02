# インストールするバージョン
version = '1.8.8.0'

# ダウンロードする URL
bit     = (node['kernel']['machine'] == 'x86_64') ? 64 : 32
source  = "http://download.tortoisegit.org/tgit/#{version}/TortoiseGit-LanguagePack-#{version}-#{bit}bit-ja.msi"

# TortoiseGit をインストールする
include_recipe 'tortoisegit'

# Japanese Languagepack をインストールする
windows_package 'Japanese Languagepack for TortoiseGit' do
  version version
  source  source
end

# インストールするバージョン
version_base   = '11.0.61030'
version_suffix = 0

# ダウンロードする URL
arch   = (node['kernel']['machine'] == 'x86_64') ? 'x64' : 'x86'
source = "http://download.microsoft.com/download/C/A/F/CAF5E118-4803-4D68-B6B5-A1772903D119/VSU4/vcredist_#{arch}.exe"

# Visual Studio 2012 更新プログラム 4 の Visual C++ 再頒布可能パッケージをインストールする
windows_package "Microsoft Visual C++ 2012 Redistributable (#{arch}) - #{version_base}" do
  version "#{version_base}.#{version_suffix}"
  source  source
  options '/quiet'
  installer_type :custom
end

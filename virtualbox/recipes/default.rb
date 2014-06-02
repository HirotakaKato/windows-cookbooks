# インストールするバージョン
version = '4.3.12'
build   = 93733

# ダウンロードする URL
source  = "http://dlc.sun.com.edgesuite.net/virtualbox/#{version}/VirtualBox-#{version}-#{build}-Win.exe"

# インストールする
windows_package "Oracle VM VirtualBox #{version}" do
  version version
  source  source
  options '--silent'
  installer_type :custom
end

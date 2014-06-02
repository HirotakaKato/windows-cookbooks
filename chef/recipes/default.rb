# インストールするバージョン
version_base   = '11.12.4'
version_suffix = 1

# gem パッケージをインストールするディレクトリ
path   = File.join(ENV['SystemDrive'], 'opscode/chef/bin').tr('/', '\\')

# ダウンロードする URL
source = "http://opscode-omnibus-packages.s3.amazonaws.com/windows/2008r2/x86_64/chef-client-#{version_base}-#{version_suffix}.windows.msi"

# Chef をインストールする
windows_package "Chef Client v#{version_base}" do
  version "#{version_base}.#{version_suffix}"
  source  source
end

# バッチファイルを作成する
%w[ bundle gem rake ].each do |file|
  [ '', '.bat' ].each do |suffix|
    cookbook_file File.join(path, file + suffix)
  end
end

# gem パッケージをインストールする
node['chef']['gem'].each do |g|
  gem_package g do
    options "-n '#{path}'"
  end
end

# バッチファイル内の ruby のパスを修正する
execute %Q(grep -lZ '^@"ruby\\.exe"' '#{path}'/*.bat | xargs -0r sed -i -b 's/"ruby\\\\.exe"/"%~dp0..\\\\\\\\embedded\\\\\\\\bin\\\\\\\\ruby.exe"/')

# Path を設定する
windows_path path

windows_path path.sub(/bin$/, 'embedded\\bin') do
  action :remove
end

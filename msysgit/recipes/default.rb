# インストールするバージョン
version = '1.9.2-preview20140411'

# インストールするディレクトリ
dir     = File.join(ENV['SystemDrive'], 'opt/git')

# ダウンロードする URL
source  = "https://github.com/msysgit/msysgit/releases/download/Git-#{version}/PortableGit-#{version}.7z"

archive = File.join(Chef::Config[:file_cache_path], File.basename(source))
creates = File.join(dir, 'bin/git.exe')

# ANSICON をインストールする
include_recipe 'ansicon'

# 7z ファイルをダウンロードする
remote_file archive do
  source source
end

# 7z ファイルを展開する
execute %Q(7z x -y -o"#{dir}" "#{archive}") do
  creates creates
end

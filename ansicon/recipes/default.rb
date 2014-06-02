# インストールするディレクトリ
dir     = File.join(ENV['SystemDrive'], 'opt/git/bin')

# ダウンロードする URL
source  = 'https://github.com/adoxa/ansicon/releases/download/v1.66/ansi166.zip'

archive = File.join(Chef::Config[:file_cache_path], File.basename(source))
creates = File.join(dir, 'ansicon.exe')

# 展開する実行ファイルがある zip ファイル内のサブディレクトリ
subdir  = (node['kernel']['machine'] == 'x86_64') ? 'x64' : 'x86'

# コマンドライン版 7-Zip をインストールする
include_recipe '7z'

# zip ファイルをダウンロードする
remote_file archive do
  source source
end

# zip ファイル内のサブディレクトリから実行ファイルを展開する
execute %Q(7z e -y -o"#{dir}" "#{archive}" "#{subdir}/*") do
  creates creates
end

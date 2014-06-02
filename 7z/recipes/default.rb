# インストールするディレクトリ
path = File.join(ENV['SystemDrive'], 'opt/git/bin').tr('/', '\\')

# ダウンロードする URL
[ 'http://sevenzip.sourceforge.jp/howto/9.20/7z.exe',
  'http://sevenzip.sourceforge.jp/howto/9.20/7z.dll',
].each do |source|
  cache = File.join(Chef::Config[:file_cache_path], File.basename(source))
  file  = File.join(path, File.basename(cache))

  # キャッシュする
  remote_file cache do
    source source
  end

  # キャッシュからコピーする
  ruby_block file do
    only_if { not File.exist?(file) or Digest::SHA256.file(file).hexdigest != Digest::SHA256.file(cache).hexdigest }
    block   { FileUtils.cp cache, file }
  end
end

# Path を設定する
windows_path path

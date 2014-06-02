# インストールするディレクトリ
git_dir   = File.join(ENV['SystemDrive'], 'opt/git')
bin_dir   = File.join(git_dir, 'bin')

# 作成するショートカット
shortcut  = File.join(ENV['ProgramData'], 'Microsoft/Windows/Start Menu/Programs/mintty.lnk').tr('/', '\\')
target    = File.join(bin_dir, 'mintty.exe').tr('/', '\\')
arguments = '/bin/bash -i -l'
cwd       = ENV['HOME'] ? '%HOME%' : nil

# Git for Windows をインストールする
include_recipe 'msysgit'

# sha256sum をダウンロードする
sha256sum_source = 'http://www.labtestproject.com/files/sha256sum/sha256sum.exe'
sha256sum_cache  = File.join(Chef::Config[:file_cache_path], File.basename(sha256sum_source))
sha256sum_file   = File.join(bin_dir, File.basename(sha256sum_source))

# キャッシュする
remote_file sha256sum_cache do
  source sha256sum_source
end

# キャッシュからコピーする
ruby_block sha256sum_file do
  only_if { not File.exist?(sha256sum_file) or Digest::SHA256.file(sha256sum_file).hexdigest != Digest::SHA256.file(sha256sum_cache).hexdigest }
  block   { FileUtils.cp sha256sum_cache, sha256sum_file }
end

# winpty を展開する
winpty_source = 'http://cloud.github.com/downloads/rprichard/winpty/winpty-0.1.1-msys.zip'
winpty_file   = File.join(bin_dir, 'console.exe')

windows_zipfile bin_dir do
  not_if { File.exist?(winpty_file) }
  source winpty_source
  overwrite true
end

# MSYS を展開する
{ 'bin/egrep.exe'  => 'http://jaist.dl.sourceforge.net/project/mingw/MSYS/Base/grep/grep-2.5.4-2/grep-2.5.4-2-msys-1.0.13-bin.tar.lzma',
  'bin/make.exe'   => 'http://jaist.dl.sourceforge.net/project/mingw/MSYS/Base/make/make-3.81-3/make-3.81-3-msys-1.0.13-bin.tar.lzma',
  'bin/mintty.exe' => 'http://jaist.dl.sourceforge.net/project/mingw/MSYS/Extension/mintty/mintty-1.0.3/mintty-1.0.3-1-msys-1.0.17-bin.tar.lzma',
  'bin/msys-iconv-2.dll'   => 'http://jaist.dl.sourceforge.net/project/mingw/MSYS/Base/libiconv/libiconv-1.14-1/libiconv-1.14-1-msys-1.0.17-dll-2.tar.lzma',
  'bin/msys-intl-8.dll'    => 'http://jaist.dl.sourceforge.net/project/mingw/MSYS/Base/gettext/gettext-0.18.1.1-1/libintl-0.18.1.1-1-msys-1.0.17-dll-8.tar.lzma',
  'bin/msys-popt-0.dll'    => 'http://jaist.dl.sourceforge.net/project/mingw/MSYS/Extension/popt/popt-1.15-2/libpopt-1.15-2-msys-1.0.13-dll-0.tar.lzma',
  'bin/msys-ssl-1.0.0.dll' => 'http://jaist.dl.sourceforge.net/project/mingw/MSYS/Extension/openssl/openssl-1.0.0-1/libopenssl-1.0.0-1-msys-1.0.13-dll-100.tar.lzma',
  'bin/rsync.exe'  => 'http://jaist.dl.sourceforge.net/project/mingw/MSYS/Extension/rsync/rsync-3.0.8-1/rsync-3.0.8-1-msys-1.0.17-bin.tar.lzma',
  'bin/wget.exe'   => 'http://jaist.dl.sourceforge.net/project/mingw/MSYS/Extension/wget/wget-1.12-1/wget-1.12-1-msys-1.0.13-bin.tar.lzma',
}.each do |c, source|
  archive = File.join(Chef::Config[:file_cache_path], File.basename(source))
  creates = File.join(git_dir, c)

  # アーカイブをダウンロードする
  remote_file archive do
    source source
  end

  # アーカイブを展開する
  execute %Q(7z x -so "#{archive}" | tar xf - -C "#{git_dir}") do
    creates creates
  end
end

# fstab を作成する
cookbook_file File.join(git_dir, 'etc/fstab')

# ショートカットを作成する
windows_shortcut shortcut do
  target    target
  arguments arguments
  cwd       cwd
end

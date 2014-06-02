# はじめに

これは Windows に
[Git for Windows](http://msysgit.github.io/)
をインストールする Cookbook です。

# 処理内容

1. [ANSICON](../ansicon/README.md) をインストールします。
2. Git for Windows の 7z ファイルをダウンロードします。
3. C:\opt\git に Git for Windows の 7z ファイルを展開します。

# 補足

msysgit::mintty の Recipe は次の処理も行います。

1. C:\opt\git\bin に [sha256sum for Windows](http://www.labtestproject.com/files/win/sha256sum/sha256sum.exe) をダウンロードします。
2. [winpty](https://github.com/rprichard/winpty) の zip ファイルをダウンロードします。
3. C:\opt\git\bin に winpty の zip ファイルを展開します。
4. [MSYS](http://www.mingw.org/wiki/MSYS) の grep, make, mintty, rsync, wget をダウンロードします。
5. C:\opt\git\bin に MSYS の grep, make, mintty, rsync, wget を展開します。
6. C:\opt\git\etc に fstab を作成します。
7. スタートメニューに mintty のショートカットを作成します。

# License

Copyright (c) 2014 [Hirotaka Kato](https://github.com/HirotakaKato/windows-cookbooks)

Released under the [MIT License](http://opensource.org/licenses/mit-license.php)

# はじめに

これは Windows に
[PHP](http://www.php.net/)
をインストールする Cookbook です。

# 処理内容

1. [Visual Studio 2012 更新プログラム 4 の Visual C++ 再頒布可能パッケージ](../vcredist/README.md) をインストールします。
2. PHP の zip ファイルをダウンロードします。
3. C:\opt\php に zip ファイルを展開します。
4. C:\opt\php\ext に php_xdebug.dll をダウンロードします。
5. C:\opt\php\php.ini を作成します。
6. システム環境変数 Path に C:\opt\php を追加します。

# License

Copyright (c) 2014 [Hirotaka Kato](https://github.com/HirotakaKato/windows-cookbooks)

Released under the [MIT License](http://opensource.org/licenses/mit-license.php)

# はじめに

これは Windows に
[Chef](http://www.getchef.com/chef/)
をインストールする Cookbook です。

# 処理内容

1. Chef のインストーラをダウンロードします。
2. C:\opscode に Chef をインストールします。
3. C:\opscode\chef\bin に bundle.bat, gem.bat, rake.bat を作成します。
4. C:\opscode\chef\bin に gem パッケージをインストールします。
5. システム環境変数 Path に C:\opscode\chef\bin を追加します。
6. システム環境変数 Path から C:\opscode\chef\embedded\bin を削除します。

# License

Copyright (c) 2014 [Hirotaka Kato](https://github.com/HirotakaKato/windows-cookbooks)

Released under the [MIT License](http://opensource.org/licenses/mit-license.php)

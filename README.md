# ibus-monitor
*Please note that this tool is designed for Japanese users, and the documentation is available only in Japanese.*

![IBusが入力モードを示さなくなり、直接入力と日本語入力の見分けがつきにくくなった状態](https://github.com/user-attachments/assets/5d00f2f7-2811-4828-ac9f-f5c48fb50e2c)

GNOMEデスクトップで標準のIBus+Mozcで日本語入力を使用していると、アイコンが入力モードを示さなくなる不具合が発生することがあります。

この不具合は画面ロックの解除後に発生しやすく、Super+Spaceキーを押して一度他の入力メソッドに切り替えてから戻すことで解消できます。

しかし、不具合が発生するたびにこの操作をするのは非常に面倒です。このツールは、不具合の発生を検出すると自動的にIBusを再起動させ、ユーザーによる操作なしで不具合を解消できます。


## インストール
現在のユーザーにのみインストールする場合は、以下のコマンドを実行してください。ツールはインストール完了後すぐに起動します。
```
wget -qO- https://github.com/Ryoya15/ibus-monitor/raw/refs/heads/main/install.sh | bash
```

すべてのユーザー（グローバル）にインストールする場合は、スクリプトをrootとして実行します。以下のコマンドを実行してください。ツールを起動するには、インストール完了後に一度再起動するか、`systemctl --user daemon-reload && systemctl --user start ibus-monitor.service`を実行する必要があります。
```
wget -qO- https://github.com/Ryoya15/ibus-monitor/raw/refs/heads/main/install.sh | sudo bash
```


## アンインストール
現在のユーザーからアンインストールする場合は、以下のコマンドを実行してください。ツールはアンインストール開始と同時に自動的に停止します。
```
wget -qO- https://github.com/Ryoya15/ibus-monitor/raw/refs/heads/main/install.sh | bash -s -- uninstall
```

すべてのユーザー（グローバル）からアンインストールする場合は、スクリプトをrootとして実行します。以下のコマンドを実行してください。ツールが動作したままの状態でアンインストールを行った場合は、一度再起動するか、`systemctl --user daemon-reload && systemctl --user stop ibus-monitor.service`を実行しない限り動作し続けます。
```
wget -qO- https://github.com/Ryoya15/ibus-monitor/raw/refs/heads/main/install.sh | sudo bash -s -- uninstall
```

インストール時に使ったコマンドと逆のコマンドを使ってしまうとアンインストールできませんのでご注意ください。

## curl
上記のインストール／アンインストールコマンドではDebianに標準同梱されていないcurlを避けwgetを使用していますが、逆にcurlだけが標準同梱されているディストリビューションも存在するため、もしコマンドが見つかりませんと表示される場合は、先頭の`wget -qO- `を`curl -fsSL `に書き換えて実行してみてください。それでも見つかりませんと表示される場合はどちらかをパッケージマネージャからインストールするか、オフラインモードでインストールする必要があります。

## オフラインモード
ツールをインストールしたいコンピューターがインターネットに接続できる状況にないか、`wget`と`curl`がどちらもインストールされていない場合は、上記のインストール／アンインストールコマンドは実行できません。その場合は、以下の手順に従ってオフラインでインストール／アンインストールを行うことができます。
1. このリポジトリをクローンするかダウンロードして、任意のディレクトリに配置します。最低限必要なファイルは`ibus-monitor.service`、`ibus-monitor.sh`、`install.sh`の3つです（関係ないファイルがあっても動作に影響はありません）。
2. `ibus-monitor.sh`を実行します。
   - 現在のユーザーにのみインストールする場合は`bash ibus-monitor.sh`、すべてのユーザーにインストールする場合は`sudo bash ibus-monitor.sh`のように実行してください。アンインストールの場合は末尾に（第一引数として）`uninstall`を付け加えて実行してください。
   - インストールスクリプトは、追加ファイルのダウンロードをまず`wget`、次に`curl`の順で試みます。コマンドが見つからないかインターネット接続がないかでどちらのコマンドも失敗した場合は、自動的にカレントディレクトリ内の追加ファイルの利用を試みます。
   - 逆に言えば、ダウンロードしたユニットファイルやスクリプトファイルを改造した場合でも、インターネットからのダウンロードが可能な状態では未改造版がインストールされてしまいますのでご注意ください。

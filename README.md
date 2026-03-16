# ibus-monitor
*Please note that this tool is designed for Japanese users, and the documentation is available only in Japanese.*

![IBusが入力モードを示さなくなり、直接入力と日本語入力の見分けがつきにくくなった状態](https://github.com/user-attachments/assets/5d00f2f7-2811-4828-ac9f-f5c48fb50e2c)

GNOMEデスクトップで標準のIBus+Mozcで日本語入力を使用していると、アイコンが入力モードを示さなくなる不具合が発生することがあります。

この不具合は画面ロックの解除後に発生しやすく、Super+Spaceキーを押して一度他の入力メソッドに切り替えてから戻すことで解消できます。

しかし、不具合が発生するたびにこの操作をするのは非常に面倒です。このツールは、不具合の発生を検出すると自動的にIBusを再起動させ、ユーザーによる操作なしで不具合を解消できます。


## インストール
現在のユーザーにのみインストールする場合は、以下のコマンドを実行してください。
```
wget -qO- https://github.com/Ryoya15/ibus-monitor/raw/refs/heads/main/install.sh | bash
```

すべてのユーザー（グローバル）にインストールする場合は、スクリプトをrootとして実行します。以下のコマンドを実行してください。
```
wget -qO- https://github.com/Ryoya15/ibus-monitor/raw/refs/heads/main/install.sh | sudo bash
```


## アンインストール
現在のユーザーからアンインストールする場合は、以下のコマンドを実行してください。
```
wget -qO- https://github.com/Ryoya15/ibus-monitor/raw/refs/heads/main/install.sh | bash -s -- uninstall
```

すべてのユーザー（グローバル）からアンインストールする場合は、スクリプトをrootとして実行します。以下のコマンドを実行してください。
```
wget -qO- https://github.com/Ryoya15/ibus-monitor/raw/refs/heads/main/install.sh | sudo bash -s -- uninstall
```

インストール時に使ったコマンドと逆のコマンドを使ってしまうとアンインストールできませんのでご注意ください。


## トラブルシューティング

### インストール／アンインストールコマンドを実行しても何も表示されない
上のインストール／アンインストールスクリプトの実行にはインターネット接続が必要です。接続されているかご確認ください。

wgetコマンドの `-qO-` から `q` を取り、 `-O-` に書き換えてから実行することで詳しい原因を特定できる可能性があります。


### Failed to enable unit: Unit /path/to/systemd/user/ibus-monitor.service is masked
「インストール／アンインストールコマンドを実行しても何も表示されない」と同じ原因が疑われます。インストールコマンドの`.sh`と`|`の間に以下をつけて実行してみてください。詳しい原因を特定できる可能性があります。
```
 | sed "s/-qO/-O/g" 
```


### --now cannot be used when systemd is not running or in conjunction with --root=/--global, refusing.
全ユーザー向けにインストール／アンインストール（以下「グローバルインストール」と略す）した場合に表示されるのは正常です。

systemdの制約上、rootとして実行されたスクリプトから現在のユーザーのユニットを制御することは（不可能ではないものの）困難なため、グローバルインストール後には一度コンピューターを再起動する必要があります。

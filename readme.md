archlinux.orgのニュース更新があれば自動翻訳して、slackに投稿する`github-actions`です。更新は、1時間おきにチェックします。

なお、archlinux.jpがニュースを既に更新している場合、jpのnews-urlをslackに投稿します。

- google app script

- github actions

```sh
# test
$ ./archtrans.sh "$GOOGLE_SCRIPT_URL" t
```

### cron

> スケジュールされたワークフローを実行できる最短のインターバルは5分ごとです。以下は15分おきに実行する例。

```yml
on:
  schedule:
    # * is a special character in YAML so you have to quote this string
    - cron:  '*/15 * * * *'
```

https://help.github.com/ja/actions/automating-your-workflow-with-github-actions/events-that-trigger-workflows

### jq, xq

`jq`, `xq`というコマンドラインツール依存です。

```sh
$ sudo pacman -S jq
$ go get -v github.com/syui/xq
```

### test

```sh
$ git clone https://github.com/ArchLinuxJP/archtrans-jp
$ cd archtrans-jp
$ git checkout test
$ git push -u origin test
```

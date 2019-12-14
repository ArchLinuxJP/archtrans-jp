archlinux.orgのニュース更新があれば自動翻訳して、slackに投稿する`github-actions`です。更新は、1日おきにチェックします。

- google app script

- github actions

```sh
# test
$ ./archtrans.sh "$GOOGLE_SCRIPT_URL" t
```

### cron

> スケジュールされたワークフローを実行できる最短のインターバルは5分ごとです。

```yml
on:
  schedule:
    # * is a special character in YAML so you have to quote this string
    - cron:  '*/15 * * * *'
```

https://help.github.com/ja/actions/automating-your-workflow-with-github-actions/events-that-trigger-workflows

### xq

現在、`github.com/urfave/cli`が壊れてるため、`github.com/syui/xq`を最新版でbuildできない問題が発生中。したがって、go getではなくcurlしてます。


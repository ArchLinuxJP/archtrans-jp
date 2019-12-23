#!/bin/bash

if [ -z "$1" ];then
    echo \$1
    exit
fi

url=$1
date_now=`date +"%Y%m%d"`
url_arch="https://www.archlinux.org/feeds/news/"
url_archjp="https://www.archlinux.jp/feeds/news.xml"

xml=index.xml
xmljp=news.xml

curl -sL $url_arch -o $xml
curl -sLO $url_archjp

link=`xq a $xml|jq -r ".[0].link"`
link=${link%*/}
linkjp=`xq a $xmljp|jq -r ".[0].link"`
linkjp=${linkjp%*/}

if [ "${link##*/}" != "${linkjp##*/}" ];then
	echo slack post webhook
	exit
fi

date_xml=$date_now
if [ "$2" != "t" ];then
	date_xml=`date --date="$(xq l $xml)" +"%Y%m%d"`
fi

if [ "$date_now" != "$date_xml" ];then
    exit
fi

title=`xq a $xml|jq -r ".[0]|.title"`
body=`xq a $xml|jq -r ".[0]|.description"|tr -d '\n'|sed -e 's/<[^>]*>//g'`

echo $title, $body
title_ja=`curl -sL -d "{\"txt\":\"$title\"}" $url`
body_ja=`curl -sL -d "{\"txt\":\"$body\"}" $url|sed 's/&#39;//g'`

curl -sL -X POST --data-urlencode "payload={\"channel\": \"@syui\" , \"username\": \"webhookbot\" , \"text\": \"${link}\n${title}\n${body}\n${title_ja}\n${body_ja}\" , \"icon_emoji\": \":arch:\"}" ${WEBHOOK_SLACK}

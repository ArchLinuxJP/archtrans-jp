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

link=`xq i $xml|jq -r ".[0].link"`
link=${link%*/}
linkjp=`xq i $xmljp|jq -r ".[0].link"`
linkjp=${linkjp%*/}

if [ "${link##*/}" = "${linkjp##*/}" ];then
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

title=`xq i $xml|jq -r ".[0]|.title"`
body=`xq i $xml|jq -r ".[0]|.description"|tr -d '\n'`

echo $title, $body
curl -L -d "{\"txt\":\"$title\"}" $url
curl -L -d "{\"txt\":\"$body\"}" $url

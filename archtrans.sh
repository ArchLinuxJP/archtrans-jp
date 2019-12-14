#!/bin/bash

if [ ! -f ./xq ];then
	curl -sL https://github.com/syui/xq/releases/download/0.1/linux_amd64_xq -o xq
	chmod +x xq
fi

url=$1
date_now=`date +"%Y%m%d"`
url_arch="https://www.archlinux.org/feeds/news/"
xml=index.xml
curl -sL $url_arch -o $xml

date_xml=$date_now
if [ "$2" != "t" ];then
	date_xml=`date --date="$(./xq l $xml)" +"%Y%m%d"`
fi

if [ "$date_now" != "$date_xml" ];then
    exit
fi

title=`./xq $xml|jq -r ".[0]|.title"`
body=`./xq $xml|jq -r ".[0]|.description"|tr -d '\n'`
echo $title, $body
curl -L -d "{\"txt\":\"$title\"}" $url
curl -L -d "{\"txt\":\"$body\"}" $url

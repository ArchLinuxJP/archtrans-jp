#!/bin/bash

if [ ! -f ./xq ];then
    case $OSTYPE in
	linux*)
		curl -L https://github.com/syui/xq/releases/download/0.1/linux_amd64_xq -o xq
		chmod +x xq
	;;
    	darwin*)
	    	curl -L https://github.com/syui/xq/releases/download/0.1/darwin_amd64_xq -o xq
		chmod +x xq
	;;
     esac
fi

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

link=`./xq $xml|jq -r ".[0].link"`
link=${link%*/}
linkjp=`./xq $xmljp|jq -r ".[0].link"`
linkjp=${linkjp%*/}

if [ "${link##*/}" = "${linkjp##*/}" ];then
	echo slack post webhook
	exit
fi

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

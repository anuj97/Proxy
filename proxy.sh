#!/bin/bash

sed -i "/proxy\=/d" $HOME/.bashrc
git config --global --unset http.proxy
git config --global --unset https.proxy
npm config rm proxy
npm config rm https-proxy

if [ -z "$1" ]
  then
    proxy=172.27.16.154
  else
    if [ $1 -eq 0 ]
        then
            source $HOME/.bashrc
            exit
    else
        proxy="172.27.16.$1"
    fi
fi

echo "http_proxy=\"http://${proxy}:3128\"" >> $HOME/.bashrc
echo "https_proxy=\"https://${proxy}:3128\"" >> $HOME/.bashrc
echo "ftp_proxy=\"ftp://${proxy}:3128\"" >> $HOME/.bashrc
echo "socks_proxy=\"socks://${proxy}:3128\"" >> $HOME/.bashrc

git config --global http.proxy "http://${proxy}:3128"
git config --global https.proxy "https://${proxy}:3128"
npm config set proxy "http://${proxy}:3128"
npm config set https-proxy "https://${proxy}:3128"

source $HOME/.bashrc

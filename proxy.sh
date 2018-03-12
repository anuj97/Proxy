#!/bin/bash

sed -i "/proxy\=/d" $HOME/.bashrc
git config --global --unset http.proxy
git config --global --unset https.proxy
npm config rm proxy
npm config rm https-proxy

if [ -z "$1" ]
  then
    proxy=172.31.1.6
  else
    if [ $1 -eq 0 ]
        then
            source $HOME/.bashrc
            exit
    else
        proxy="172.31.1.$1"
    fi
fi

echo "http_proxy=\"http://${proxy}:8080\"" >> $HOME/.bashrc
echo "https_proxy=\"https://${proxy}:8080\"" >> $HOME/.bashrc
echo "ftp_proxy=\"ftp://${proxy}:8080\"" >> $HOME/.bashrc

git config --global http.proxy "http://${proxy}:8080"
git config --global https.proxy "https://${proxy}:8080"
npm config set proxy "http://${proxy}:8080"
npm config set https-proxy "https://${proxy}:8080"

source $HOME/.bashrc

#!/usr/bin/env bash

install -d ~/.weechat/python/autoload
cd ~/.weechat/python/autoload

wget https://raw.githubusercontent.com/rawdigits/wee-slack/master/wee_slack.py
wget https://raw.githubusercontent.com/kattrali/weemoji/master/weemoji.py
wget https://weechat.org/files/scripts/buffers.pl

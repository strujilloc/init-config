#!/usr/bin/env zsh

plugins=(git z)
sed -i "s/plugins=(${plugins})/plugins=(${plugins} newplug)/" test.txt
plugins+=(newplug)
sed -i "s/plugins=(${plugins})/plugins=(${plugins} 2ndplug)/" test.txt

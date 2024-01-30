#!/bin/bash

echo "📦 Setup typescript dev environment"
echo Installing bun
if [ ! -f ~/.bun/bin/bun ]; then
	curl -fsSL https://bun.sh/install | bash
fi

echo Installing deno
if [ ! -f ~/.deno/bin/deno ]; then
	curl -fsSL https://deno.land/x/install/install.sh | sh
fi

#
# -- exists package in arch repo
#
# echo "📦 Setup docker environment"
# if [ ! -x /usr/bin/docker ]; then
# 	echo Installing docker
# 	curl -fsSL https://get.docker.com -o /tmp/get-docker.sh
# 	sudo sh /tmp/get-docker.sh
# 	sudo usermod -aG docker $USER
# fi

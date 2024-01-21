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

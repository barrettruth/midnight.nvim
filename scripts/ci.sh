#!/bin/sh
set -eu

nix develop --command stylua --check .
git ls-files '*.lua' | xargs nix develop --command selene --display-style quiet
nix develop --command prettier --check .
nix develop --command lua-language-server --check . --checklevel=Warning

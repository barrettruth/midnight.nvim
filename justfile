default:
    @just --list

format:
    nix fmt -- --ci
    stylua --check .
    git ls-files -z | xargs -0 biome format
    vimdoc-language-server format --check doc/

lint:
    git ls-files '*.lua' | xargs selene --display-style quiet
    lua-language-server --check . --checklevel=Warning
    vimdoc-language-server check doc/

ci: format lint
    @:

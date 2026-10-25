default:
    @just --list

format:
    nix fmt -- --ci
    stylua --check .
    git ls-files -z | xargs -0 biome format

lint:
    git ls-files '*.lua' | xargs selene --display-style quiet
    lua-language-server --check . --checklevel=Warning

ci: format lint
    @:

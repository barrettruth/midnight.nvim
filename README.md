# midnight.nvim

Neovim theme for code, not colors.

> [!NOTE]
> Active development is hosted on
> [Forgejo](https://forge.barrettruth.com/barrettruth/midnight.nvim).

![Image](https://github.com/user-attachments/assets/9abb5126-15d7-4de4-ad6d-ec35975fec03)

## Installation

With `vim.pack` (Neovim 0.12+):

```lua
vim.pack.add({
  'https://forge.barrettruth.com/barrettruth/midnight.nvim',
})
```

Or via [luarocks](https://luarocks.org/modules/barrettruth/midnight.nvim):

```
luarocks install midnight.nvim
```

Then set the colorscheme:

```lua
vim.cmd.colorscheme('midnight')
```

## Documentation

```vim
:help midnight
```

## Plugin Integrations

- [treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- [fzf-lua](https://github.com/ibhagwan/fzf-lua)
- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp),
  [blink.cmp](https://github.com/saghen/blink.cmp)
- [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)

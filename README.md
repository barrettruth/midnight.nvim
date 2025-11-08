# midnight.nvim

A minimal, scientifically-optimized colorscheme with automatic dark/light variants.

## Features

- **Single theme, dual modes**: Automatically detects `vim.o.background` and switches between midnight (dark) and daylight (light) palettes
- **Ultra-minimal syntax**: Only 3 semantic colors - blue for keywords, green for literals, grey for comments, white for everything else
- **Scientific optimization**: Desaturated colors in the 200-50 range, WCAG AAA contrast ratios
- **Eye strain reduction**: No pure black (#121212) or pure white (#e0e0e0)
- **Full terminal support**: Complete 16 ANSI color support
- **Plugin compatibility**: Built-in support for fzf-lua, nvim-cmp, gitsigns, and more

## Installation

### lazy.nvim

```lua
{
  'barrett-ruth/midnight.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require('midnight').setup()
    vim.cmd('colorscheme midnight')
  end,
}
```

## Usage

```vim
colorscheme midnight
```

The theme automatically adapts to your background setting:

```lua
vim.o.background = 'dark'  -- uses midnight palette
vim.o.background = 'light' -- uses daylight palette
```

## Design Philosophy

- **Minimal colors**: Only color what's semantically necessary
- **High contrast**: Meet WCAG AAA standards for readability
- **Consistent with terminal**: Matches Ghostty, tmux, and FZF themes
- **No AI comments**: Clean, human-written code

## Color Palette

### Midnight (Dark)
- Background: `#121212` (optimal dark gray)
- Foreground: `#e0e0e0` (87% white)
- Blue: `#7aa2f7` (keywords/control)
- Green: `#98c379` (literals/data)
- Grey: `#666666` (comments)

### Daylight (Light)
- Optimized light variant with similar principles

## License

MIT

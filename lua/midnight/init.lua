local M = {}

---@return nil
function M.load()
  if vim.g.colors_name then
    vim.cmd('hi clear')
  end

  if vim.fn.exists('syntax_on') then
    vim.cmd('syntax reset')
  end

  vim.o.termguicolors = true
  vim.g.colors_name = 'midnight'

  local theme = require('midnight.theme')
  theme.apply()
end

---@deprecated Use `vim.cmd('colorscheme midnight')` instead
function M.setup(opts)
  vim.deprecate(
    'require("midnight").setup()',
    'vim.cmd("colorscheme midnight")',
    'v0.1.0',
    'midnight.nvim',
    false
  )

  M.load()
end

return M

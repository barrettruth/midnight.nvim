local M = {}

---@param opts? table
function M.setup(opts)
  opts = opts or {}
end

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

return M

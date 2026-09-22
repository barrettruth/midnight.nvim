local M = {}

local marker_name = 'github-removal-2026-10-31-v1'
local notified = false

local message = table.concat({
  'The GitHub repository will be deleted on 2026-10-31.',
  'GitHub clones and updates will fail after that date.',
  'Install from Forgejo: https://forge.barrettruth.com/barrettruth/midnight.nvim.',
  'LuaRocks: luarocks install midnight.nvim.',
  'See :help midnight-migration.',
}, ' ')

---@param origin unknown
---@return boolean
function M.is_github_origin(origin)
  if type(origin) ~= 'string' then
    return false
  end

  origin = origin:gsub('/+$', ''):gsub('%.git$', '')

  return origin == 'https://github.com/barrettruth/midnight.nvim'
    or origin == 'http://github.com/barrettruth/midnight.nvim'
    or origin == 'git://github.com/barrettruth/midnight.nvim'
    or origin == 'ssh://git@github.com/barrettruth/midnight.nvim'
    or origin == 'git@github.com:barrettruth/midnight.nvim'
end

---@return string
function M.plugin_root()
  local source = debug.getinfo(1, 'S').source:sub(2)
  return vim.fs.dirname(vim.fs.dirname(vim.fs.dirname(source)))
end

---@param root string
---@return string|nil
function M.origin(root)
  local origin = vim.fn.system({ 'git', '-C', root, 'config', '--get', 'remote.origin.url' })
  if vim.v.shell_error ~= 0 then
    return nil
  end

  return vim.trim(origin)
end

---@return string
function M.marker_path()
  return vim.fs.joinpath(vim.fn.stdpath('state'), 'midnight.nvim', marker_name)
end

---@param root? string
---@return boolean
function M.warn_if_github_source(root)
  if notified or vim.uv.fs_stat(M.marker_path()) then
    return false
  end

  if not M.is_github_origin(M.origin(root or M.plugin_root())) then
    return false
  end

  vim.notify(message, vim.log.levels.WARN, { title = 'midnight.nvim' })

  local marker = M.marker_path()
  vim.fn.mkdir(vim.fs.dirname(marker), 'p')
  vim.fn.writefile({ os.date('!%Y-%m-%dT%H:%M:%SZ') }, marker)
  notified = true

  return true
end

return M

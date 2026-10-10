local M = {}

local message = table.concat({
  '[midnight.nvim] This repository will be removed from GitHub on October 31, 2026.',
  'Install from Forgejo: https://forge.barrettruth.com/barrettruth/midnight.nvim.',
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
---@param callback fun(origin: string|nil)
---@return nil
function M.origin(root, callback)
  if vim.fn.executable('git') ~= 1 then
    callback(nil)
    return
  end

  local origin = ''
  local ok, job = pcall(
    vim.fn.jobstart,
    { 'git', '-C', root, 'config', '--get', 'remote.origin.url' },
    {
      stdout_buffered = true,
      on_stdout = function(_, data)
        origin = table.concat(data, '\n')
      end,
      on_exit = function(_, code)
        callback(code == 0 and vim.trim(origin) or nil)
      end,
    }
  )
  if not ok or job <= 0 then
    callback(nil)
  end
end

---@param root? string
---@return nil
function M.warn_if_github_source(root)
  M.origin(root or M.plugin_root(), function(origin)
    if M.is_github_origin(origin) then
      vim.schedule(function()
        vim.notify_once(message, vim.log.levels.WARN)
      end)
    end
  end)
end

return M

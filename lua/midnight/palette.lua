local M = {}

---@class Palette
---@field black string
---@field red string
---@field green string
---@field yellow string
---@field blue string
---@field magenta string
---@field cyan string
---@field orange? string
---@field white string
---@field bright_black string
---@field bright_red string
---@field bright_green string
---@field bright_yellow string
---@field bright_blue string
---@field bright_magenta string
---@field bright_cyan string
---@field bright_white string
---@field light_black string
---@field grey string
---@field med_grey? string
---@field dark_grey? string
---@field light_grey? string
---@field light_red? string
---@field light_green? string
---@field light_yellow? string
---@field light_blue? string
---@field light_magenta? string
---@field light_cyan? string
---@field light_white? string
---@field medium_emphasis? string

---@type Palette
M.midnight = {
  black = '#121212',
  red = '#ff6b6b',
  green = '#98c379',
  yellow = '#e5c07b',
  blue = '#7aa2f7',
  magenta = '#c678dd',
  cyan = '#56b6c2',
  orange = '#e5a56b',
  white = '#e0e0e0',

  bright_black = '#666666',
  bright_red = '#f48771',
  bright_green = '#b5e890',
  bright_yellow = '#f0d197',
  bright_blue = '#9db8f7',
  bright_magenta = '#e298ff',
  bright_cyan = '#7dd6e0',
  bright_white = '#ffffff',

  light_black = '#666666',
  grey = '#3d3d3d',
  med_grey = '#2d2d2d',
  dark_grey = '#1e1e1e',

  medium_emphasis = '#999999',
}

---@type Palette
M.daylight = {
  black = '#000000',
  grey = '#666666',
  red = '#B22222',
  green = '#228B22',
  yellow = '#B8860B',
  blue = '#27408B',
  magenta = '#8B008B',
  cyan = '#00BFFF',
  white = '#ffffff',

  bright_black = '#555555',
  bright_red = '#ff0000',
  bright_green = '#00ff00',
  bright_yellow = '#ffa500',
  bright_blue = '#0000ff',
  bright_magenta = '#ff00ff',
  bright_cyan = '#00ffff',
  bright_white = '#ffffff',

  light_black = '#555555',
  light_grey = '#ECECEC',
  light_red = '#ff0000',
  light_green = '#00ff00',
  light_yellow = '#ffa500',
  light_blue = '#0000ff',
  light_magenta = '#ff00ff',
  light_cyan = '#00ffff',
  light_white = '#ffffff',
}

---@return Palette
function M.get_palette()
  if vim.o.background == 'light' then
    return M.daylight
  else
    return M.midnight
  end
end

return M

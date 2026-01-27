local M = {}

---@class Palette
---@field foreground string
---@field red string
---@field green string
---@field yellow string
---@field blue string
---@field magenta string
---@field cyan string
---@field orange? string
---@field background string
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
  foreground = '#121212',
  red = '#ff6b6b',
  green = '#98c379',
  yellow = '#e5c07b',
  blue = '#7aa2f7',
  magenta = '#c678dd',
  cyan = '#56b6c2',
  orange = '#e5a56b',
  background = '#e0e0e0',

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
  dark_grey = '#222222',

  medium_emphasis = '#999999',
}

---@type Palette
M.daylight = {
  foreground = '#f5f5f5',
  red = '#c7254e',
  green = '#2d7f3e',
  yellow = '#996800',
  blue = '#3b5bdb',
  magenta = '#ae3ec9',
  cyan = '#1098ad',
  orange = '#d9730d',
  background = '#1a1a1a',

  bright_black = '#999999',
  bright_red = '#e03e52',
  bright_green = '#37b24d',
  bright_yellow = '#f59f00',
  bright_blue = '#4c6ef5',
  bright_magenta = '#da77f2',
  bright_cyan = '#15aabf',
  bright_white = '#000000',

  light_black = '#6b6b6b',
  grey = '#d0d0d0',
  med_grey = '#e8e8e8',
  dark_grey = '#ebebeb',

  medium_emphasis = '#666666',
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

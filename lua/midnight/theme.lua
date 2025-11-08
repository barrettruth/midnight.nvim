local M = {}

---@class Highlight
---@field fg? string
---@field bg? string
---@field bold? boolean
---@field italic? boolean
---@field underline? boolean
---@field undercurl? boolean
---@field reverse? boolean
---@field special? string
---@field none? boolean

---@param from string
---@param tos string|string[]
local function link(from, tos)
  local tos_list = type(tos) == 'string' and { tos } or tos --[[@as string[] ]]
  for _, to in ipairs(tos_list) do
    vim.api.nvim_set_hl(0, to, { link = from })
  end
end

---@param group string
---@param highlights Highlight
---@param links? string[]
local function hi(group, highlights, links)
  if highlights.none then
    highlights.none = nil
    highlights.undercurl = false
    highlights.italic = false
    highlights.bold = false
    highlights.fg = 'NONE'
    highlights.bg = 'NONE'
  end
  vim.api.nvim_set_hl(0, group, highlights)
  for _, other in ipairs(links or {}) do
    link(group, other)
  end
end

---@param group string
---@param highlights Highlight
---@param links? string[]
local function tshi(group, highlights, links)
  hi(group, highlights)

  local tsgroup = '@' .. group:gsub('^%L', string.lower)
  link(group, tsgroup)

  for _, to in ipairs(links or {}) do
    link(group, to)
  end
end

---@return nil
function M.apply()
  local palette = require('midnight.palette')
  local cs = palette.get_palette()

  for color, hexcode in pairs(cs) do
    hi(color, { fg = hexcode })
  end

  hi(
    'Normal',
    { fg = cs.white, bg = cs.black },
    { 'Identifier', 'Special', 'StatusLine', 'StatusLineNC', 'Winbar', 'WinbarNC' }
  )
  hi('NonText', { fg = cs.grey }, { 'SpecialKey' })

  hi('LineNr', { fg = cs.light_black }, { 'SignColumn' })
  hi('CursorLine', { bg = cs.dark_grey }, { 'ColorColumn', 'Folded', 'Visual' })
  hi('CursorLineNr', { fg = cs.medium_emphasis })

  hi('Conceal', { fg = cs.light_black, bg = cs.black })
  hi('Directory', { fg = cs.white })
  hi('Error', { fg = cs.red })
  hi('ErrorMsg', { bold = true, underline = true, fg = cs.red })
  hi('MoreMsg', { fg = cs.yellow }, { 'WarningMsg' })
  hi('MatchParen', { bg = cs.med_grey })
  hi('NormalFloat', { bg = cs.black }, {
    'LspInfoBorder',
    'FloatBorder',
    'FloatShadow',
    'FloatShadowThrough',
  })
  hi('Search', { reverse = true }, { 'IncSearch' })
  hi('Whitespace', { fg = cs.grey })

  tshi('Boolean', { fg = cs.green }, { '@constant.builtin' })
  tshi('Comment', { fg = cs.light_black })
  tshi('Constant', { fg = cs.green })
  tshi('Define', { fg = cs.blue })
  tshi('Function', { fg = cs.white }, { '@function.builtin', '@function.macro' })
  tshi('Include', { fg = cs.blue })
  tshi('Keyword', { fg = cs.blue }, { 'Statement' })
  tshi('Namespace', { fg = cs.white })
  tshi('Number', { fg = cs.green })
  tshi('Operator', { fg = cs.white }, { '@keyword.operator', '@conditional.ternary' })
  hi('Delimiter', { none = true })
  hi('@punctuation.delimiter', { fg = cs.white })
  tshi('PreProc', { fg = cs.blue })
  tshi('String', { fg = cs.green }, { '@character' })
  hi('@string.escape', { fg = cs.green })
  tshi('Title', { bold = true, fg = cs.white })

  hi('@tag', { fg = cs.white })
  hi('@tag.attribute', { fg = cs.white })
  hi('@tag.delimiter', { fg = cs.white })

  tshi('Type', { fg = cs.white })
  hi('@type.qualifier', { fg = cs.white }, { '@storageclass' })
  hi('@lsp.type.enum', { fg = cs.white }, { '@lsp.type.class' })
  hi('@lsp.type.comment', { none = true }, { '@lsp.type.macro' })

  hi('@text.emphasis', { italic = true })
  hi('@text.strong', { bold = true })
  hi('@text.underline', { underline = true })
  hi('@text.uri', { fg = cs.white, underline = true }, { '@text.reference' })

  hi('@text.danger', { fg = cs.red, bold = true, italic = true })
  hi('@text.note', { fg = cs.green, bold = true, italic = true })
  hi('@text.todo', { fg = cs.yellow, bold = true, italic = true }, { 'Todo' })
  hi('@text.warning', { fg = cs.yellow, bold = true, italic = true })

  hi('@variable', { none = true })

  hi('Pmenu', { bg = cs.dark_grey }, { 'PmenuSbar' })
  hi('PmenuSel', { bg = cs.med_grey })
  hi('PmenuThumb', { bg = cs.grey })

  hi('LspInlayHint', { fg = cs.light_black })
  hi('LspSignatureActiveParameter', { underline = true, italic = true })
  hi('DiagnosticError', { fg = cs.red }, { 'DiagnosticFloatingError', 'DiagnosticSignError' })
  hi('DiagnosticWarn', { fg = cs.yellow }, { 'DiagnosticFloatingWarn', 'DiagnosticSignWarn' })
  hi('DiagnosticHint', { fg = cs.light_black }, { 'DiagnosticFloatingHint', 'DiagnosticSignHint' })
  hi('DiagnosticOk', { fg = cs.green }, { 'DiagnosticFloatingOk', 'DiagnosticSignOk' })
  hi('DiagnosticInfo', { fg = cs.light_black }, { 'DiagnosticFloatingInfo', 'DiagnosticSignInfo' })
  hi('DiagnosticUnderlineError', { undercurl = true, special = cs.red })
  hi('DiagnosticUnderlineWarn', { undercurl = true, special = cs.yellow })
  hi('DiagnosticUnderlineHint', { undercurl = true, special = cs.light_black })
  hi('DiagnosticUnderlineOk', { undercurl = true, special = cs.green })
  hi('DiagnosticUnderlineInfo', { undercurl = true, special = cs.light_black })

  hi('SpellBad', { underline = true, special = cs.red })
  hi('SpellRare', { underline = true, special = cs.white })
  hi('SpellCap', { underline = true, special = cs.white })
  hi('SpellLocal', { underline = true, special = cs.white })

  hi('gitCommitSummary', { fg = cs.white })

  hi('@attribute.diff', { fg = cs.white })
  hi('DiffAdd', { fg = cs.green }, { '@text.diff.add', 'diffAdded' })
  hi('DiffDelete', { fg = cs.red }, { '@text.diff.delete', 'diffRemoved' })
  hi('DiffChange', { fg = cs.yellow })

  hi('@constructor.lua', { fg = cs.white })
  hi('@markup.heading.gitcommit', { none = true })

  hi('GitSignsCurrentLineBlame', { italic = true, fg = cs.light_black })
  link('DiffAdd', 'GitSignsAdd')
  link('DiffChange', 'GitSignsChange')
  link('DiffDelete', 'GitSignsDelete')

  link('Search', 'HighlightUndo')

  link('Pmenu', 'CmpPmenu')
  link('PmenuSel', 'CmpPmenuSel')
  hi('CmpItemAbbr', { fg = cs.white })
  hi('CmpItemAbbrMatch', { fg = cs.white, bold = true })
  hi('CmpItemAbbrMatchFuzzy', { fg = cs.white, bold = true })
  hi('CmpItemAbbrDeprecated', { fg = cs.light_black, strikethrough = true })
  hi('CmpItemMenu', { fg = cs.light_black })

  for hlgroup, color in pairs({
    Key = 'white',
    Keyword = 'blue',
    Folder = 'white',
    File = 'white',
    Boolean = 'green',
    Class = 'white',
    Constant = 'green',
    Constructor = 'white',
    Enum = 'white',
    EnumMember = 'white',
    Field = 'white',
    Function = 'white',
    Interface = 'white',
    Method = 'white',
    Namespace = 'white',
    Null = 'white',
    Number = 'green',
    Operator = 'white',
    Property = 'white',
    String = 'green',
    Struct = 'white',
    Text = 'white',
    TypeParameter = 'white',
    Variable = 'white',
  }) do
    hi('CmpItemKind' .. hlgroup, { fg = cs[color] })
  end

  link('NormalFloat', 'NullLsInfoBorder')

  link('Directory', 'OilDir')

  link('NormalFloat', 'FzfLuaBorder')
  hi('FzfLuaHeaderText', { fg = cs.white }, { 'FzfLuaBufFlagCur' })
  hi('FzfLuaBufFlagAlt', { fg = cs.white })
  link('Normal', 'FzfLuaLivePrompt')

  vim.g.terminal_color_0 = cs.black
  vim.g.terminal_color_1 = cs.red
  vim.g.terminal_color_2 = cs.green
  vim.g.terminal_color_3 = cs.yellow
  vim.g.terminal_color_4 = cs.blue
  vim.g.terminal_color_5 = cs.magenta
  vim.g.terminal_color_6 = cs.cyan
  vim.g.terminal_color_7 = cs.white
  vim.g.terminal_color_8 = cs.bright_black
  vim.g.terminal_color_9 = cs.bright_red
  vim.g.terminal_color_10 = cs.bright_green
  vim.g.terminal_color_11 = cs.bright_yellow
  vim.g.terminal_color_12 = cs.bright_blue
  vim.g.terminal_color_13 = cs.bright_magenta
  vim.g.terminal_color_14 = cs.bright_cyan
  vim.g.terminal_color_15 = cs.bright_white
end

return M

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

  hi(
    'Normal',
    { fg = cs.background, bg = cs.foreground },
    { 'Identifier', 'Special', 'StatusLine', 'StatusLineNC', 'Winbar', 'WinbarNC' }
  )
  hi('NonText', { fg = cs.grey }, { 'SpecialKey' })

  hi('LineNr', { fg = cs.light_black }, { 'SignColumn' })
  hi('CursorLine', { bg = cs.dark_grey }, { 'ColorColumn', 'Folded', 'Visual' })
  hi('CursorLineNr', { fg = cs.medium_emphasis })

  hi('Conceal', { fg = cs.light_black, bg = cs.foreground })
  hi('Directory', { fg = cs.blue })
  hi('Error', { fg = cs.red })
  hi('ErrorMsg', { bold = true, underline = true, fg = cs.red })
  hi('MoreMsg', { fg = cs.yellow }, { 'WarningMsg' })
  hi('MatchParen', { bg = cs.med_grey })
  hi('NormalFloat', { bg = cs.foreground }, {
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
  tshi('Function', { fg = cs.background }, { '@function.builtin', '@function.macro' })
  tshi('Include', { fg = cs.blue })
  tshi('Keyword', { fg = cs.blue }, { 'Statement' })
  tshi('Namespace', { fg = cs.background })
  tshi('Number', { fg = cs.green })
  tshi('Operator', { fg = cs.background }, { '@keyword.operator', '@conditional.ternary' })
  hi('Delimiter', { none = true })
  hi('@punctuation.delimiter', { fg = cs.background })
  tshi('PreProc', { fg = cs.blue })
  tshi('String', { fg = cs.green }, { '@character' })
  hi('@string.escape', { fg = cs.green })
  tshi('Title', { bold = true, fg = cs.background })

  hi('@tag', { fg = cs.background })
  hi('@tag.attribute', { fg = cs.background })
  hi('@tag.delimiter', { fg = cs.background })

  tshi('Type', { fg = cs.background })
  hi('@type.qualifier', { fg = cs.background }, { '@storageclass' })
  hi('@lsp.type.enum', { fg = cs.background }, { '@lsp.type.class' })
  hi('@lsp.type.comment', { none = true }, { '@lsp.type.macro' })

  hi('@text.emphasis', { italic = true })
  hi('@text.strong', { bold = true })
  hi('@text.underline', { underline = true })
  hi('@text.uri', { fg = cs.background, underline = true }, { '@text.reference' })

  hi('@comment.danger', { fg = cs.red, bold = true, italic = true })
  hi('@comment.note', { fg = cs.blue, bold = true, italic = true })
  hi('@comment.todo', { fg = cs.yellow, bold = true, italic = true }, { 'Todo' })
  hi('@comment.warning', { fg = cs.yellow, bold = true, italic = true })

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
  hi('SpellRare', { underline = true, special = cs.background })
  hi('SpellCap', { underline = true, special = cs.background })
  hi('SpellLocal', { underline = true, special = cs.background })

  hi('gitCommitSummary', { fg = cs.background })

  hi('@attribute.diff', { fg = cs.background })
  hi('DiffAdd', { fg = cs.green }, { '@text.diff.add', 'diffAdded' })
  hi('DiffDelete', { fg = cs.red }, { '@text.diff.delete', 'diffRemoved' })
  hi('DiffChange', { fg = cs.yellow })

  hi('@constructor.lua', { fg = cs.background })
  hi('@markup.heading.gitcommit', { none = true })

  hi('GitSignsCurrentLineBlame', { italic = true, fg = cs.light_black })
  link('DiffAdd', 'GitSignsAdd')
  link('DiffChange', 'GitSignsChange')
  link('DiffDelete', 'GitSignsDelete')

  link('Search', 'HighlightUndo')

  link('Pmenu', 'CmpPmenu')
  link('PmenuSel', 'CmpPmenuSel')
  hi('CmpItemAbbr', { fg = cs.background })
  hi('CmpItemAbbrMatch', { fg = cs.background, bold = true })
  hi('CmpItemAbbrMatchFuzzy', { fg = cs.background, bold = true })
  hi('CmpItemAbbrDeprecated', { fg = cs.light_black, strikethrough = true })
  hi('CmpItemMenu', { fg = cs.light_black })

  link('Boolean', { 'CmpItemKindBoolean', 'BlinkCmpKindBoolean' })
  link(
    'Constant',
    { 'CmpItemKindConstant', 'BlinkCmpKindConstant', 'CmpItemKindNull', 'BlinkCmpKindNull' }
  )
  link(
    'Function',
    { 'CmpItemKindFunction', 'BlinkCmpKindFunction', 'CmpItemKindMethod', 'BlinkCmpKindMethod' }
  )
  link('Keyword', { 'CmpItemKindKeyword', 'BlinkCmpKindKeyword' })
  link('Namespace', { 'CmpItemKindNamespace', 'BlinkCmpKindNamespace' })
  link('Number', { 'CmpItemKindNumber', 'BlinkCmpKindNumber' })
  link('Operator', { 'CmpItemKindOperator', 'BlinkCmpKindOperator' })
  link('String', { 'CmpItemKindString', 'BlinkCmpKindString', 'CmpItemKindKey', 'BlinkCmpKindKey' })
  link('Type', {
    'CmpItemKindClass',
    'BlinkCmpKindClass',
    'CmpItemKindEnum',
    'BlinkCmpKindEnum',
    'CmpItemKindInterface',
    'BlinkCmpKindInterface',
    'CmpItemKindStruct',
    'BlinkCmpKindStruct',
    'CmpItemKindConstructor',
    'BlinkCmpKindConstructor',
    'CmpItemKindTypeParameter',
    'BlinkCmpKindTypeParameter',
  })
  link('Normal', {
    'CmpItemKindVariable',
    'BlinkCmpKindVariable',
    'CmpItemKindProperty',
    'BlinkCmpKindProperty',
    'CmpItemKindField',
    'BlinkCmpKindField',
    'CmpItemKindText',
    'BlinkCmpKindText',
    'CmpItemKindFile',
    'BlinkCmpKindFile',
  })
  link('Directory', { 'CmpItemKindFolder', 'BlinkCmpKindFolder' })

  link('NormalFloat', 'NullLsInfoBorder')

  link('Directory', 'OilDir')

  link('NormalFloat', 'FzfLuaBorder')
  hi('FzfLuaHeaderText', { fg = cs.background }, { 'FzfLuaBufFlagCur' })
  hi('FzfLuaBufFlagAlt', { fg = cs.background })
  link('Normal', 'FzfLuaLivePrompt')

  vim.g.terminal_color_0 = cs.foreground
  vim.g.terminal_color_1 = cs.red
  vim.g.terminal_color_2 = cs.green
  vim.g.terminal_color_3 = cs.yellow
  vim.g.terminal_color_4 = cs.blue
  vim.g.terminal_color_5 = cs.magenta
  vim.g.terminal_color_6 = cs.cyan
  vim.g.terminal_color_7 = cs.background
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

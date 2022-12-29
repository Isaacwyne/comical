local present, color = pcall(require, "onedark")
if not present then
  return
end

color.setup {
  style = 'deep',
  transparent = true,
  term_colors = true,                   -- change terminal color as per the selected theme style
  ending_tildes = false,
  cmp_itemkind_reverse = false,         -- reverse item kind highlights in cmp menu

  -- change code style
  -- options are italic, bold, underline, none
  -- you can configure multiple styles with comma separation
  code_style = {
    comments = 'italic',
    keywords = 'italic,bold',
    functions = 'bold',
    strings = 'italic',
    variables = 'none',
  },

  -- statusline (lualine) options
  lualine = {
    transparent = true,
  },

  -- plugins config
  diagnostics = {
    darker = true,                -- darker colors for diagnostics
    undercurl = true,             -- use undercurl instead of underline for diagnostics
    background = true,            -- use background color for virtual text
  },
}

color.load()

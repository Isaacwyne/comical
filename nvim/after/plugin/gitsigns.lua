local present, signs = pcall(require, "gitsigns")
if not present then
  return
end

require "colorbuddy"

local c = require("colorbuddy.color").colors
local Group = require("colorbuddy.group").Group

Group.new("GitSignsAdd", c.green)
Group.new("GitSignsChange", c.yellow)
Group.new("GitSignsDelete", c.red)

if true then
  return
end

signs.setup {
  signs = {
    add = { hl = "GitSignsAdd", text = "│", numhl = "GitSignsAddNr" },
    change = { hl = "GitSignsChange", text = "│", numhl = "GitSignsChangeNr" },
    delete = { hl = "GitSignsDelete", text = "_", numhl = "GitSignsDeleteNr" },
    topdelete = { hl = "GitSignsDelete", text = "‾", numhl = "GitSignsDeleteNr" },
    changedelete = { hl = "GitSignsDelete", text = "~", numhl = "GitSignsChangeNr" },
  },

  -- highlight just the number part of the number column
  numhl = true,

  -- highlights the _whole_ line
  -- instead, use gitsigns.toggle_linehl()
  linehl = false,

  -- highlights just the part of the line that has changed
  -- instead, use gitsigns.toggle_word_diff()
  word_diff = false,

  keymaps = {
    -- default keymap options
    noremap = true,
    buffer = true,

    ["n <space>hd"] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<cr>'" },
    ["n <space>hu"] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<cr>'" },
  },

  current_line_blame_opts = {
    delay = 2000,
    virt_text_pos = "eol",
  },
}

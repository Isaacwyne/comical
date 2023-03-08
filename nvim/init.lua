local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- AUTOCOMMANDS
-- default auto group
local default = augroup("default", { clear = true })

-- don't auto comment newlines
autocmd("BufEnter", {
  group = default,
  pattern = "*",
  command = "set fo-=c fo-=r fo-=o",
})

-- highlight text when yanking
--[[ autocmd("TextYankPost", {
  group = default,
  pattern = "*",
  callback = function ()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 40,
    })
  end,
})
]]
-- auto-remove trailing whitespace
autocmd("BufWritePre", {
  group = default,
  pattern = "*",
  command = "%s/\\s\\+$//e",
})

require("core.options")
require("core.autocmds")
require("core.plugins")
require("core.mappings")

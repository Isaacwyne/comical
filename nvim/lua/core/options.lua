local opt = vim.opt
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local options = {
  laststatus = 3,
  showmode = false,
  hlsearch = false,

  title = true,

  -- highlights
  termguicolors = true,

  -- indenting
  breakindent = true,
  cindent = true,
  expandtab = true,
  linebreak = true,
  shiftwidth = 4,
  -- make it so that long lines wrap smartly
  showbreak = string.rep(" ", 3),
  smartindent = true,
  softtabstop = 4,
  tabstop = 4,

  belloff = "all",              -- just turn off the dang bell
  hidden = true,
  ignorecase = true,
  lazyredraw = true,
  mouse = "i",
  smartcase = true,
  swapfile = false,
  wrap = false,

  -- Numbers
  number = true,
  numberwidth = 2,
  relativenumber = true,
  ruler = false,

  signcolumn = "auto",
  splitbelow = true,
  splitright = true,
  timeoutlen = 400,
  undofile = true,
  scrolloff = 10,
  sidescrolloff = 10,
  showmatch = true,
  matchtime = 2,
  updatetime = 50,

  -- folds
  foldmethod = "manual",
  foldlevel = 0,
  modelines = 1,

  shada = { "!", "'1000", "<50", "s10", "h" },
  list = true,
  inccommand = "split",
  fillchars = { eob = "~" },
  shell = "bash",
  joinspaces = false,
  -- prevent windows from changing all the time (subject to change)
  equalalways = false,

  -- cool floating window popup menu for completion on commandline
  pumblend = 17,
  wildmode = "longest:full",
  wildoptions = "pum",
}
for k, v in pairs(options) do
  opt[k] = v
end

opt.listchars:append("space:⋅,eol:,tab:» ,nbsp:␣")
opt.whichwrap:append("<>[]hl")
opt.formatoptions:append("r")
opt.diffopt:append("hiddenoff,algorithm:minimal")

-- cursorline highlighting control
-- only have it on in the active buffer
opt.cursorline = true     -- highlight the currentline
local group = augroup("CursorLineControl", { clear = true })
local set_cursorline = function (event, value, pattern)
  autocmd(event, {
    group = group,
    pattern = pattern,
    callback = function ()
      vim.opt_local.cursorline = value
    end,
  })
end
set_cursorline("WinLeave", false)
set_cursorline("WinEnter", true)
set_cursorline("FileType", false, "TelescopePrompt")

local default_providers = {
  "node",
  "perl",
  "python3",
  "ruby",
}
for _, provider in ipairs(default_providers) do
  vim.g["loaded_" .. provider .. "_provider"] = 0
end

local default_plugins = {
  "gzip",
  "zip",
  "zipPlugin",
  "tar",
  "tarPlugin",
  "getscript",
  "getscriptPlugin",
  "vimball",
  "vimballPlugin",
  "2html_plugin",
  "matchit",
  "matchparen",
  "logiPat",
  "rrhelper",
}
for _, plugin in pairs(default_plugins) do
  vim.g["loaded_" .. plugin] = 1
end

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
autocmd("TextYankPost", {
  group = default,
  pattern = "*",
  callback = function ()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 40,
    })
  end,
})

-- auto-remove trailing whitespace
autocmd("BufWritePre", {
  group = default,
  pattern = "*",
  command = "%s/\\s\\+$//e",
})

vim.cmd([[
  " colorscheme
  colorscheme onedark
  hi Normal guibg=none
  hi Signcolumn guibg=none

  " return to last edit position when opening files
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
]])

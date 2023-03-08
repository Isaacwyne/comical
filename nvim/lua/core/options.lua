local opt = vim.opt

local options = {
  showmode = true,
  hlsearch = false,
  cursorline = true,

  title = true,

  -- highlights
  -- termguicolors = true,

  -- indenting
  breakindent = true,
  cindent = true,
  expandtab = true,
  linebreak = true,
  shiftwidth = 4,
  smartindent = true,
  softtabstop = 4,
  tabstop = 4,

  belloff = "all",
  hidden = true,
  ignorecase = true,
  mouse = "i",
  smartcase = true,
  swapfile = false,
  wrap = true,

  -- Numbers
  number = true,
  numberwidth = 2,
  relativenumber = true,
  ruler = false,

  matchtime = 2,
  scrolloff = 8,
  showmatch = true,
  sidescrolloff = 10,
  signcolumn = "auto",
  splitbelow = true,
  splitright = true,
  timeoutlen = 400,
  undofile = true,
  updatetime = 50,

  list = true,
  shell = "bash",

  -- cool floating window popup menu for completion on the commandline
  pumblend = 17,
  wildmode = "longest:full",
  wildoptions = "pum",
}
for k, v in pairs(options) do
  opt[k] = v
end

opt.listchars:append("space:⋅,eol:,tab:» ,nbsp:␣")

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

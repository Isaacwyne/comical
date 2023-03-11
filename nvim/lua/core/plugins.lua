-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

-- autocmd that reloads neovim whenever you save the `packer.lua` file
vim.cmd([[
augroup packer_user_config
autocmd!
" autocmd BufWritePost packer.lua source <afile>
autocmd BufWritePost plugins.lua source <afile>
augroup END
]])

-- use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- have packer use a popup menu
packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})

return require('packer').startup(function(use)
  -- packer can manage itself
  use "wbthomason/packer.nvim"
  use "kyazdani42/nvim-web-devicons"
  use "windwp/nvim-autopairs"
  use "navarasu/onedark.nvim"
  use "numToStr/Comment.nvim"
  use "nvim-lualine/lualine.nvim"
  use "lukas-reineke/indent-blankline.nvim"

  -- telescope
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.1',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    run = function ()
      local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
      ts_update()
    end,
  })

  -- lsp
  use {
    "neovim/nvim-lspconfig",
    requires = {
      {"williamboman/mason.nvim"},
      {"onsails/lspkind.nvim"},

      -- autocompletion
      {"hrsh7th/nvim-cmp"},
      {"hrsh7th/cmp-nvim-lua"},
      {"hrsh7th/cmp-nvim-lsp"},
      {"hrsh7th/cmp-buffer"},
      {"hrsh7th/cmp-path"},

      -- Snippets
      {'L3MON4D3/LuaSnip'},
      {'rafamadriz/friendly-snippets'},
    },
  }

  -- gitsigns
  use("lewis6991/gitsigns.nvim")

  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)

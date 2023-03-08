-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

-- autocmd that reloads neovim whenever you save the `packer.lua` file
vim.cmd([[
augroup packer_user_config
autocmd!
autocmd BufWritePost packer.lua source <afile>
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
  use "nvim-lualine/lualine.nvim"

  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)

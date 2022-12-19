vim.cmd([[packadd packer.nvim]])

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

return require("packer").startup(function(use)
    use("wbthomason/packer.nvim")
    use("kyazdani42/nvim-web-devicons")
    use("joshdick/onedark.vim")
    use("numToStr/Comment.nvim")
    use("windwp/nvim-autopairs")
    use("nvim-lualine/lualine.nvim")
    use("akinsho/bufferline.nvim")

    -- lsp configuration
    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'saadparwaiz1/cmp_luasnip'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-nvim-lua'},

            -- Snippets
            {'L3MON4D3/LuaSnip'},
            {'rafamadriz/friendly-snippets'},
        }
    }

    use("norcalli/nvim-colorizer.lua")

    -- telescope
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
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

    -- gitsigns
    use("lewis6991/gitsigns.nvim")
    use("tjdevries/colorbuddy.nvim")

    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)

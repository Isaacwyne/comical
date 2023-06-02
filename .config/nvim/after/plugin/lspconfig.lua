local present, lspconfig = pcall(require, "lspconfig")
if not present then
  return
end

local ok, mason = pcall(require, "mason")
if not ok then
  return
end

mason.setup({
  ui = {
    icons = {
      package_pending = " ",
      package_installed = "󰄳 ",
      package_uninstalled = " 󰚌",
    },

    keymaps = {
      toggle_server_expand = "<CR>",
      install_server = "i",
      update_server = "u",
      check_server_version = "c",
      update_all_servers = "U",
      check_outdated_servers = "C",
      uninstall_server = "X",
      cancel_installation = "<C-c>",
    },
  },
})

require("mason-lspconfig").setup {
  ensure_installed = {
    "lua_ls",
    "bashls",
    "pylsp"
  },
  automatic_installation = true
}

local on_attach = function(client, bufnr)
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false

  local keymap = vim.keymap.set
  -- local bufopts = { buffer = bufnr, remap = false }

  keymap("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "LSP definition" })
  keymap("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "LSP hover" })
  keymap("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "LSP code action"})
  keymap("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "LSP declaration" })
  keymap("n", "gT", vim.lsp.buf.type_definition, { buffer = bufnr, desc = "LSP definition type" })
  keymap("n", "gi", vim.lsp.buf.implementation, { buffer = bufnr, desc = "LSP implementation" })
  keymap("n", "gr", vim.lsp.buf.references, { buffer = bufnr, desc = "LSP references" })
  keymap("n", "<leader>dn", vim.diagnostic.goto_next, { buffer = bufnr, desc = "Goto next"})
  keymap("n", "<leader>dp", vim.diagnostic.goto_prev, { buffer = bufnr, desc = "Goto prev" })
  keymap("n", "<leader>r", vim.lsp.buf.rename, { buffer = bufnr, desc = "raname" })
  -- keymap("n", "<leader>ld", "<cmd>Telescope diagnostics<cr>", { buffer = bufnr, desc = "Line diagnostics" })
  keymap("n", "<leader>ld", vim.diagnostic.open_float, { buffer = bufnr, desc = "Line diagnostics" })
  --[[ keymap("n", "<leader>ld", function ()
    vim.diagnostic.open_float({ border = "rounded" })
  end, { buffer = bufnr, desc = "Line Diagnostics" }) ]]
  keymap("n", "<leader>lf", function()
    vim.lsp.buf.format({ async = true })
  end, { buffer = bufnr, desc = "LSP formatting" })
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

local signs = {
  Error = " ",
  Warn = " ",
  Hint = " ",
  Info = " ",
}
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- snippets
local luasnip = require("luasnip")

luasnip.config.set_config({
  -- this tells `luasnip` to remember to keep around the last snippet
  -- you can jump back into it even if you move outside of the selection
  history = false,

  -- autosnippets
  enable_autosnippets = true,

  region_check_events = "InsertEnter",
  delete_check_events = "InsertLeave",

  -- <c-k> is the expansion key
  -- this will expand the current item or jump to the next item within the snippet
  vim.keymap.set({ "i", "s" }, "<c-k>", function ()
    if luasnip.expand_or_jumpable() then
      luasnip.expand_or_jump()
    end
  end, { silent = true }),

  -- <c-j> is the jump backwards key
  -- this always moves to the previous item within the snippet
  vim.keymap.set({ "i", "s" }, "<c-j>", function ()
    if luasnip.jumpable(-1) then
      luasnip.jump(-1)
    end
  end, { silent = true }),
})
require("luasnip.loaders.from_vscode").lazy_load()

-- Lsp server client customizations
lspconfig.lua_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
          [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    },
  },
}

-- bash (scripts)
lspconfig.bashls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    bashIde = {
      globPattern = "*@(.sh|.inc|.bash|.command)"
    },
  },
}

-- python
lspconfig.pylsp.setup {
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          ignore = {'W391'},
          maxLineLength = 100
        },
      },
    },
  },
}

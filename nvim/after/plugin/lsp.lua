-- If you need to customize mason.nvim make sure you do it before calling the lsp-zero module.
--[[ require("mason.settings").set({
  ui = {
    -- border = "rounded",
  },
}) ]]

local status_ok, lsp = pcall(require, "lsp-zero")
if not status_ok then
  return
end

lsp.preset("recommended")

-- change the 'python' server to 'pyright'
lsp.ensure_installed({
  'bashls',
  'cssls',
  'eslint',
  'html',
  'pylsp',
  'rust_analyzer',
  'sumneko_lua',
  'tsserver',
  'vimls',
})

local present, cmp = pcall(require, "cmp")
if not present then
  return
end

local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  ['<C-Space>'] = cmp.mapping.complete(),
})

-- disable completion with tab
cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil
-- disable confirm with Enter key (use 'ctrl + y' instead)
cmp_mappings['<CR>'] = nil

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

lsp.set_preferences({
  suggest_lsp_servers = false,
  sign_icons = {
    error = '✘',
    warn = '',
    hint = '',
    info = ''
  },
  set_lsp_keymaps = false,
})

lsp.configure("sumneko_lua", {
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
    },
  },
})

vim.diagnostic.config({
  virtual_text = true,
})

lsp.on_attach(function(client, bufnr)
  local keymap = vim.keymap.set
  local opts = { buffer = bufnr, remap = false }

  keymap("n", "gd", vim.lsp.buf.definition, opts)
  keymap("n", "K", vim.lsp.buf.hover, opts)
  keymap("n", "ga", vim.lsp.buf.code_action, opts)
  keymap("n", "gD", vim.lsp.buf.declaration, opts)
  keymap("n", "gT", vim.lsp.buf.type_definition, opts)
  keymap("n", "gi", vim.lsp.buf.implementation, opts)
  keymap("n", "gr", vim.lsp.buf.references, opts)
  keymap("n", "<leader>dn", vim.diagnostic.goto_next, opts)
  keymap("n", "<leader>dp", vim.diagnostic.goto_prev, opts)
  keymap("n", "<leader>r", vim.lsp.buf.rename, opts)
  keymap("n", "<leader>lf", function()
    vim.lsp.buf.format({ async = true })
  end, opts)
  keymap("n", "<leader>dl", "<cmd>Telescope diagnostics<cr>", opts)
end)

lsp.setup()

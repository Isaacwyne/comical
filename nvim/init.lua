for _, source in ipairs({
  "core.options",
  "core.autocmds",
  "core.keymaps",
  "core.plugins",
}) do
  local present, fault = pcall(require, source)
  if not present then
    vim.api.nvim_err_writeln("Failed to load " .. source .. "\n\n" .. fault)
  end
end

if vim.g.neovide then
  vim.g.neovide_scale_factor = 1.0
  vim.o.guifont = "Monofur Nerd Font:h12"
end

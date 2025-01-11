local keymap_opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>a", ":GoAlt<CR>", keymap_opts)

function Goimports()
  local original_cursor = vim.fn.winsaveview()
  vim.cmd([[%!goimports]])
  vim.fn.winrestview(original_cursor)
end

local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = Goimports,
  group = format_sync_grp,
})


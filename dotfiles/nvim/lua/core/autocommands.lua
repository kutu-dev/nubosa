local autocmd = vim.api.nvim_create_autocmd

-- Format the file with the LSP before saving
autocmd({ "BufWritePre" }, {
  callback = function()
    vim.lsp.buf.format()
  end,
})

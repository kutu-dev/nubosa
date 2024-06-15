local autocmd = vim.api.nvim_create_autocmd

autocmd(
  { "BufWritePre" }, {
    callback = function()
      vim.lsp.buf.format()
    end
  })

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPost", "BufNewFile" },
  cmd = { "LspInfo", "LspInstall", "LspUninstall" },

  config = function()
    local lspconfig = require("lspconfig")

    lspconfig.lua_ls.setup({
      settings = {
        Lua = {
          runtime = {
            version = "LuaJIT",
          },
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = {
              vim.env.VIMRUNTIME,
            },
          },
        },
      },
    })
    lspconfig.ruff.setup({})
    lspconfig.nil_ls.setup({})
    lspconfig.ccls.setup({})
    lspconfig.rust_analyzer.setup({
      settings = {
        ["rust-analyzer"] = {
          checkOnSave = {
            command = "clippy",
          },
        },
      }
    })
  end,
}

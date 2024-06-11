local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

local default_setup = function(server)
  require('lspconfig')[server].setup({
    capabilities = lsp_capabilities,
  })
end

return {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    "williamboman/mason.nvim",
    "neovim/nvim-lspconfig",
    "hrsh7th/nvim-cmp",
  },

  event = { "BufReadPost", "BufNewFile", "BufWritePre" },

  opts = {
    ensure_installed = { "lua_ls", "pylsp"},

    handlers = {
      default_setup,
      lua_ls = function()
        require("lspconfig").lua_ls.setup({
          capabilities = lsp_capabilities,

          settings = {
            Lua = {
              runtime = {
                version = "LuaJIT"
              },
              diagnostics = {
                globals = { "vim" }
              },
              workspace = {
                library = {
                  vim.env.VIMRUNTIME,
                }
              }
            }
          }
        })
      end,
      pylsp = function()
        require("lspconfig").pylsp.setup({
        capabilities = lsp_capabilities,

          settings = {
            pylsp = {
              pylsp_mypy = { enabled = true },
              ruff= { enabled = true },

            }
          }
        })
      end
    }
  }
}

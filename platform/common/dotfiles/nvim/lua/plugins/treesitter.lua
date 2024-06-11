return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },

    build = ':TSUpdate',

    event = { "BufReadPost", "BufNewFile", "BufWritePre" },

    opts = {
      ensure_installed = {
        "markdown",
        "lua",
        "python",
      },

      highlight = {
        enable = true
      }
    }
}

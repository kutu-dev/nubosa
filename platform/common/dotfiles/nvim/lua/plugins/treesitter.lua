return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },

    build = ':TSUpdate',
    lazy = false,

    opts = {
      ensure_installed= "all",

      sync_install = true,
      auto_install = true,

      highlight = {
        enable = true
      },

      indent = {
        enable = true
      },
    }
}

return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },

    build = ':TSUpdate',
    lazy = false,

    setup = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed= "all",

        sync_install = true,
        auto_install = true,

        highlight = {
          enable = true
        },

        indent = {
          enable = true
        },
      })
    end
}

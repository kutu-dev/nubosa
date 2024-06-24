return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
	},

	lazy = false,

	build = function()
		require("nvim-treesitter.install").update({ with_sync = true })()
	end,

	config = function()
		require("nvim-treesitter.configs").setup({
			highlight = {
				enable = true,
			},

			indent = {
				enable = true,
			},
		})
	end,
}

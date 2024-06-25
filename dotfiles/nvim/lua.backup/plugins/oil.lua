local details = false

return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },

	cmd = "Oil",

	opts = {
		keymaps = {
			["gd"] = {
				desc = "Toggle file detail view",
				callback = function()
					details = not details
					if details then
						require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
					else
						require("oil").set_columns({ "icon" })
					end
				end,
			},
		},
	},
}

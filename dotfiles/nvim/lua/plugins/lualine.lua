-- Warning! Autogenerated file by cumulus
-- Do NOT edit it directly, all changes may be removed

local dim_component_colors = { fg = "ffffff", bg = "262626" }
local bright_component_colors = { fg = "161616", bg = "ffffff" }

return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },

	lazy = false,
	config = {
		options = {
			component_separators = { left = "", right = "" },
		},
		sections = {
			lualine_a = {
				{ "branch", icon = "󰊢", color = dim_component_colors, separator = { right = "" } },
				{ "mode", separator = { right = "" } },
				{ "searchcount", color = bright_component_colors, separator = { right = "" } },
			},
			lualine_b = {},
			lualine_c = {
				"%=",
				{ "filename", color = bright_component_colors, separator = { left = "", right = "" } },
				{ "harpoon2", color = bright_component_colors, separator = { left = "", right = "" } },
			},
			lualine_x = {},
			lualine_y = {},
			lualine_z = {
				{ "diagnostics", always_visible = true, color = { bg = "393939" } },
				{ "location", color = dim_component_colors, separator = { left = "" } },
			},
		},

		extensions = {
			"oil",
		},
	},
}
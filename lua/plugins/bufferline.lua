-- lua/plugins/bufferline.lua
return {
	"akinsho/bufferline.nvim",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		require("bufferline").setup({
			options = {
				separator_style = "thin",
				show_buffer_close_icons = false,
				show_close_icon = false,
				enforce_regular_tabs = true,
				always_show_bufferline = false,
			},
		})
	end,
}

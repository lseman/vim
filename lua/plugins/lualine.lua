-- lua/plugins/lualine.lua
return {
	'nvim-lualine/lualine.nvim',
	config = function()
		require('lualine').setup({
			options = {
				icons_enabled = true,
				theme = 'onedark',
				component_separators = { left = '', right = '' },
				section_separators = { left = '', right = '' },
				disabled_filetypes = {},
				always_divide_middle = true,
			},
		})
	end
}

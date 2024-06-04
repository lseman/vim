-- lua/plugins/mini.lua
return {
	{
		'echasnovski/mini.map',
		version = false,
		config = function()
			require('mini.map').setup()
			vim.keymap.set('n', '<C-m>', MiniMap.toggle, { noremap = true, silent = true })
		end
	},
}
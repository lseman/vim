-- lua/plugins/indent-blankline.lua
return {
	'lukas-reineke/indent-blankline.nvim',
	main = 'ibl',
	opts = {},
	config = function()
		local highlight = {
			'ScopeRed',
			'ScopeYellow',
			'ScopeBlue',
			'ScopeOrange',
			'ScopeGreen',
			'ScopeViolet',
			'ScopeCyan',
		}

		local hooks = require('ibl.hooks')
		hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
			vim.api.nvim_set_hl(0, 'ScopeRed', { fg = '#61AFEF' })
			vim.api.nvim_set_hl(0, 'ScopeYellow', { fg = '#E5C07B' })
			vim.api.nvim_set_hl(0, 'ScopeBlue', { fg = '#61AFEF' })
			vim.api.nvim_set_hl(0, 'ScopeOrange', { fg = '#D19A66' })
			vim.api.nvim_set_hl(0, 'ScopeGreen', { fg = '#98C379' })
			vim.api.nvim_set_hl(0, 'ScopeViolet', { fg = '#C678DD' })
			vim.api.nvim_set_hl(0, 'ScopeCyan', { fg = '#56B6C2' })
		end)

		require('ibl').setup({
			enabled = true,
			scope = {
				enabled = true,
				highlight = highlight, -- Apply custom highlight groups to scope
			},
			indent = {
				char = '▏',
			},
		})
	end
}

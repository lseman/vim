-- lua/plugins/treesitter.lua
return {
	'nvim-treesitter/nvim-treesitter',
	build = ':TSUpdate',
	event = { 'BufReadPre', 'BufNewFile' },
	config = function()
		require('nvim-treesitter.configs').setup {
			ensure_installed = { 'c', 'cpp', 'lua', 'vim', 'vimdoc', 'query', 'markdown', 'markdown_inline', 'latex', 'python' },
			auto_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = '<C-space>',
					node_incremental = '<C-space>',
					scope_incremental = false,
					node_decremental = '<bs>',
				},
			},
			indent = {
				enable = true,
			},
			context_commentstring = {
				enable = true,
				enable_autocmd = false,
			},
		}
	end
}

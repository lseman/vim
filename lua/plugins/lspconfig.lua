-- lua/plugins/lspconfig.lua
return {
	'neovim/nvim-lspconfig',
	config = function()
		require('lspconfig').clangd.setup({
			on_attach = function(client, bufnr)
				local opts = { noremap = true, silent = true }
				vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>cR', '<cmd>ClangdSwitchSourceHeader<CR>', opts)
				vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
				vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
				vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
				vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<Cmd>lua vim.lsp.buf.rename()<CR>', opts)
				vim.api.nvim_buf_set_keymap(bufnr, 'n', 'ca', '<Cmd>lua vim.lsp.buf.code_action()<CR>', opts)
				vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>sh', '<Cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
				vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>im', '<Cmd>lua vim.lsp.buf.implementation()<CR>', opts)
				vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ds', '<Cmd>lua vim.lsp.buf.document_symbol()<CR>', opts)
				vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ws', '<Cmd>lua vim.lsp.buf.workspace_symbol()<CR>', opts)
				vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>td', '<Cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
				vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>fm', '<Cmd>lua vim.lsp.buf.formatting()<CR>', opts)
				-- Setup inlay hints
				require("clangd_extensions.inlay_hints").setup_autocmd()
				require("clangd_extensions.inlay_hints").set_inlay_hints()
			end,
			capabilities = { offsetEncoding = { 'utf-16' } },
			cmd = {
				'clangd',
				'--background-index=false',
				'--header-insertion=iwyu',
				'--function-arg-placeholders',
				'--fallback-style=llvm',
			},
			init_options = { usePlaceholders = true, completeUnimported = true, clangdFileStatus = true },
		})
		require('lspconfig').ruff_lsp.setup {
			init_options = {
			  settings = {
				-- Any extra CLI arguments for `ruff` go here.
				args = {},
			  }
			}
		  }
	end
}

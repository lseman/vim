-- init.lua
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=m',
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require('config.options')
require('config.lazy')
require('config.keymaps')
require('config.autocmds')
require('config.diagnostics')
require('config.highlight')
require('config.custom')
require('config.dap')
require("telescope").load_extension("ui-select")

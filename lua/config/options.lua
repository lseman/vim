-- lua/config/options.lua
vim.o.showmatch = true
vim.o.ignorecase = true
vim.o.mouse = "a"
vim.o.hlsearch = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.autoindent = true
vim.o.wildmode = "longest,list,full"
vim.o.backup = false
vim.o.swapfile = false
vim.o.wrap = true
vim.o.number = true
vim.o.relativenumber = false
vim.o.clipboard = ""
vim.o.breakindent = true
vim.o.showbreak = "↳ "
vim.o.termguicolors = true
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.mapleader = " "
vim.api.nvim_set_hl(0, 'Comment', { italic=true })
-- set function name in italic
vim.api.nvim_set_hl(0, 'Function', { italic=true })
-- set class name in italic
vim.api.nvim_set_hl(0, 'Type', { italic=true })
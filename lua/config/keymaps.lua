-- lua/config/keymaps.lua
-- Confirm quit function
local function confirm_quit()
	if vim.api.nvim_buf_get_option(0, "modified") then
		local choice = vim.fn.confirm("Save changes?", "&Yes\n&No", 2)
		if choice == 1 then
			vim.cmd("wq!")
		elseif choice == 2 then
			vim.cmd("q!")
		end
	else
		vim.cmd("q")
	end
end

vim.keymap.set("v", "<C-q>", confirm_quit, { noremap = true, silent = true })
vim.keymap.set("i", "<C-q>", function()
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
	confirm_quit()
end, { noremap = true, silent = true })

-- Tab management
vim.api.nvim_set_keymap("n", "<leader>tn", ":tabnew<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>tc", ":tabclose<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>to", ":tabonly<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>tnext", ":tabnext<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>tprev", ":tabprevious<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-n>", ":tabnew<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-n>", "<Esc>:tabnew<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-j>", ":BufferLineCyclePrev<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-k>", ":BufferLineCycleNext<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-j>", "<Esc>:BufferLineCyclePrev<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-k>", "<Esc>:BufferLineCycleNext<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<C-j>", "<Esc>:BufferLineCyclePrev<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<C-k>", "<Esc>:BufferLineCycleNext<CR>", { noremap = true, silent = true })

-- Horizontal scroll
vim.api.nvim_set_keymap("", "<ScrollWheelLeft>", "zl", { noremap = true, silent = true })
vim.api.nvim_set_keymap("", "<ScrollWheelRight>", "zh", { noremap = true, silent = true })

-- Completion key mappings
vim.api.nvim_set_keymap("i", "<Tab>", [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { expr = true })
vim.api.nvim_set_keymap("i", "<S-Tab>", [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { expr = true })

-- NvimTree toggle
vim.api.nvim_set_keymap("n", "<C-o>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

-- Telescope mappings
local builtin = require("telescope.builtin")
vim.keymap.set("n", ";", builtin.find_files, {})
vim.keymap.set("n", ".", builtin.live_grep, {})
vim.keymap.set("n", ",", builtin.buffers, {})
vim.keymap.set("n", "\\", builtin.treesitter, {})
vim.api.nvim_set_keymap("n", "<leader>gf", ":Telescope git_files<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>sf", ":Telescope find_files<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>sh", ":Telescope help_tags<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>sw", ":Telescope grep_string<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>sg", ":Telescope live_grep<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>sG", ":LiveGrepGitRoot<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>sd", ":Telescope diagnostics<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>sr", ":Telescope resume<CR>", { noremap = true, silent = true })

vim.api.nvim_create_user_command("GrepCurrentFile", function()
	require("telescope.builtin").current_buffer_fuzzy_find()
end, {})
vim.api.nvim_set_keymap("n", "<C-f>", ":GrepCurrentFile<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-f>", "<Esc>:GrepCurrentFile<CR>i", { noremap = true, silent = true })

vim.api.nvim_create_user_command("BR", function()
	vim.cmd("split | terminal cd build && make -j32 && ./dsn")
end, {})

-- Cut, copy, and paste using Ctrl-X/C/V
vim.keymap.set("v", "<C-x>", '"+x', { noremap = true, silent = true, desc = "Cut to clipboard" })
vim.keymap.set("v", "<C-c>", '"+y', { noremap = true, silent = true, desc = "Copy to clipboard" })
vim.keymap.set("v", "<C-v>", '"_d"+P', { noremap = true, silent = true, desc = "Paste from clipboard" })
vim.keymap.set("n", "<C-v>", '"+p', { noremap = true, silent = true, desc = "Paste from clipboard" })
vim.keymap.set("i", "<C-v>", "<C-R>+", { noremap = true, silent = true, desc = "Paste from clipboard" })

-- Undo, save, block visual mode, select all
vim.keymap.set("n", "<C-z>", "u", { noremap = true, silent = true, desc = "Undo" })
vim.keymap.set("i", "<C-z>", "<C-O>u", { noremap = true, silent = true, desc = "Undo" })
vim.keymap.set("n", "<C-s>", ":silent! update<CR>", { noremap = true, silent = true, desc = "Save" })
vim.keymap.set("v", "<C-s>", "<C-C>:silent! update<CR>", { noremap = true, silent = true, desc = "Save" })
vim.keymap.set("i", "<C-s>", "<Esc>:silent! update<CR>gi", { noremap = true, silent = true, desc = "Save" })
vim.keymap.set("n", "<C-Q>", "<C-V>", { noremap = true, silent = true, desc = "Visual block mode" })
vim.keymap.set("n", "<C-A>", "ggVG", { noremap = true, silent = true, desc = "Select all" })
vim.keymap.set("i", "<C-A>", "<Esc>ggVG", { noremap = true, silent = true, desc = "Select all" })
vim.keymap.set("v", "<C-A>", "ggVG", { noremap = true, silent = true, desc = "Select all" })

-- Smart arrow keys
local function smart_left_arrow_insert()
	local col = vim.api.nvim_win_get_cursor(0)[2]
	if col == 0 then
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Up><End>", true, true, true), "n", true)
		return ""
	else
		return vim.api.nvim_replace_termcodes("<Left>", true, true, true)
	end
end
local function smart_left_arrow_normal()
	local col = vim.api.nvim_win_get_cursor(0)[2]
	if col == 0 then
		vim.cmd("normal! k$")
	else
		vim.cmd("normal! h")
	end
end
local function smart_right_arrow_insert()
	local col = vim.api.nvim_win_get_cursor(0)[2]
	local line = vim.api.nvim_get_current_line()
	if col >= #line then
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Down><Home>", true, true, true), "n", true)
		return ""
	else
		return vim.api.nvim_replace_termcodes("<Right>", true, true, true)
	end
end
local function smart_right_arrow_normal()
	local col = vim.api.nvim_win_get_cursor(0)[2] + 1
	local line = vim.api.nvim_get_current_line()
	if col >= #line then
		vim.cmd("normal! j0")
	else
		vim.cmd("normal! l")
	end
end

vim.api.nvim_set_keymap("i", "<Left>", "", { expr = true, noremap = true, callback = smart_left_arrow_insert })
vim.api.nvim_set_keymap("n", "<Left>", "", { noremap = true, callback = smart_left_arrow_normal })
vim.api.nvim_set_keymap("i", "<Right>", "", { expr = true, noremap = true, callback = smart_right_arrow_insert })
vim.api.nvim_set_keymap("n", "<Right>", "", { noremap = true, callback = smart_right_arrow_normal })

-- Remap Tab for indenting in visual mode
vim.api.nvim_set_keymap("v", "<Tab>", ">gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<C-Tab>", "<gv", { noremap = true, silent = true })

-- Source the find_replace module
local find_replace = require("config.custom")

-- Create a user command for find and replace
vim.api.nvim_create_user_command("FindAndReplace", function()
	find_replace.find_and_replace()
end, {})

-- Bind Ctrl+h to the find and replace function
vim.api.nvim_set_keymap(
	"n",
	"<C-h>",
	':lua require("config.custom").find_and_replace()<CR>',
	{ noremap = true, silent = true }
)

-- init.lua
vim.api.nvim_set_keymap("n", "<C-p>", "<cmd>Telescope commands<CR>", { noremap = true, silent = true })

local telescope = require("telescope")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

-- Function to open Telescope command history
local function open_command_history()
	require("telescope.builtin").command_history({
		attach_mappings = function(prompt_bufnr, map)
			local execute_command = function()
				local selection = action_state.get_selected_entry()
				actions.close(prompt_bufnr)
				vim.cmd(selection.value)
			end

			map("i", "<CR>", execute_command)
			return true
		end,
	})
end

-- Create a user command for opening command history
vim.api.nvim_create_user_command("CommandHistory", function()
	open_command_history()
end, {})

-- Map `:` to open Telescope command history
vim.api.nvim_set_keymap("n", ":", ":CommandHistory<CR>", { noremap = true, silent = true })

-- map <D-s> to save file
vim.keymap.set("n", "<D-s>", ":silent! update<CR>", { noremap = true, silent = true, desc = "Save" })
vim.keymap.set("v", "<D-s>", "<C-C>:silent! update<CR>", { noremap = true, silent = true, desc = "Save" })
vim.keymap.set("i", "<D-s>", "<Esc>:silent! update<CR>gi", { noremap = true, silent = true, desc = "Save" })

-- map <D-x> to close buffer tab
vim.keymap.set("n", "<D-x>", ":bd<CR>", { noremap = true, silent = true, desc = "Close buffer" })
-- also in visual and insert mode
vim.keymap.set("v", "<D-x>", "<C-C>:bd<CR>", { noremap = true, silent = true, desc = "Close buffer" })
vim.keymap.set("i", "<D-x>", "<Esc>:bd<CR>", { noremap = true, silent = true, desc = "Close buffer" })
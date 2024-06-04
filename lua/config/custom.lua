-- find_replace.lua

local M = {}

function M.find_and_replace()
	vim.fn.inputsave()
	local search_text = vim.fn.input("Find: ")
	local replace_text = vim.fn.input("Replace with: ")
	vim.fn.inputrestore()

	if search_text ~= "" and replace_text ~= "" then
		-- Escape special characters in search_text
		local escaped_search_text = vim.pesc(search_text)
		local cmd = string.format("%%s/\\<%s\\>/%s/g", escaped_search_text, replace_text)
		vim.cmd(cmd)
	end
end

return M

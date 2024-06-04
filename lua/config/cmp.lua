local cmp = require("cmp")

-- Define field arrangements for different styles
local field_arrangement = {
	atom = { "kind", "abbr", "menu" },
	atom_colored = { "kind", "abbr", "menu" },
}

-- Define formatting styles
local formatting_style = {
	fields = field_arrangement[cmp_style] or { "abbr", "kind", "menu" },
	format = function(_, item)
		return item
	end,
}
-- Helper function to create border
local function border(hl_name)
	return {
		{ "╭", hl_name },
		{ "─", hl_name },
		{ "╮", hl_name },
		{ "│", hl_name },
		{ "╯", hl_name },
		{ "─", hl_name },
		{ "╰", hl_name },
		{ "│", hl_name },
	}
end

-- Options configuration for cmp
local options = {
	completion = {
		completeopt = "menu,menuone",
	},
	window = {
		completion = {
			side_padding = (cmp_style ~= "atom" and cmp_style ~= "atom_colored") and 1 or 0,
			winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
			scrollbar = false,
			max_height = 10, -- Set the maximum number of items before scrolling
		},
		documentation = {
			border = border("CmpDocBorder"),
			winhighlight = "Normal:CmpDoc,FloatBorder:CmpDocBorder",
			max_height = 10,
		},
	},
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	formatting = formatting_style,
	mapping = {
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		--["<C-Enter>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<C-Enter>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Insert,
			select = true,
		}),
		["<C-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif require("luasnip").expand_or_jumpable() then
				vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif require("luasnip").jumpable(-1) then
				vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
			else
				fallback()
			end
		end, { "i", "s" }),
	},
	sources = {
		{ name = "nvim_lsp", max_item_count = 5 },
		{ name = "luasnip", max_item_count = 5 },
		{ name = "buffer", max_item_count = 5 },
		--{ name = "nvim_lua", max_item_count = 5 },
		{ name = "path", max_item_count = 5 },
	},

	sorting = {
		comparators = {
			cmp.config.compare.offset,
			cmp.config.compare.exact,
			cmp.config.compare.recently_used,
			require("clangd_extensions.cmp_scores"),
			cmp.config.compare.kind,
			cmp.config.compare.sort_text,
			cmp.config.compare.length,
			cmp.config.compare.order,
		},
	},
	
}

-- Add border for non-atom styles
if cmp_style ~= "atom" and cmp_style ~= "atom_colored" then
	options.window.completion.border = border("CmpBorder")
end

return options

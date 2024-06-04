return { -- amongst your other plugins
    'akinsho/toggleterm.nvim',
    config = function()
        require("toggleterm").setup {
            size = 20,
            open_mapping = [[<c-\>]],
            hide_numbers = true, -- hide the number column in toggleterm buffers
            shade_filetypes = {},
            shade_terminals = true,
            start_in_insert = true,
            insert_mappings = true, -- whether or not the open mapping applies in insert mode
            persist_size = true,
            direction = 'horizontal',
            close_on_exit = true, -- close the terminal window when the process exits
            shell = vim.o.shell, -- change the default shell
            float_opts = {
                border = 'single',
                width = 200,
                height = 40,
                winblend = 3,
                highlights = {
                    border = "Normal",
                    background = "Normal"
                }
            }
        }
    end
}


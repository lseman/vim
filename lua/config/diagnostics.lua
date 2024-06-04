-- lua/config/diagnostics.lua
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    signs = true,
    update_in_insert = false,
})

-- Show diagnostics popup on cursor hold
function _G.show_diagnostics_popup()
    local opts = {
        focusable = false,
        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
        border = "rounded",
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        source = "always",
        prefix = " ",
        severity_sort = true,
        style = "minimal",
        max_width = 80,
    }
    vim.diagnostic.open_float(nil, opts)
end

vim.cmd([[autocmd CursorHold * lua _G.show_diagnostics_popup()]])

-- Customize diagnostic colors
vim.cmd [[
    highlight DiagnosticWarn guifg=#FFA500
    highlight DiagnosticInfo guifg=#00FFFF
    highlight DiagnosticHint guifg=#00FF00
]]

-- Set transparency for diagnostic popup background and border
vim.cmd [[
    highlight NormalFloat guibg=none
    highlight FloatBorder guifg=#FFFFFF guibg=none
]]

vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = '●',
            [vim.diagnostic.severity.WARN] = '●',
            [vim.diagnostic.severity.INFO] = '●',
            [vim.diagnostic.severity.HINT] = '●',
        }
    }
})
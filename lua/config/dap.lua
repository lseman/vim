local dap, dapui = require("dap"), require("dapui")

-- Adapter setup for debugpy
dap.adapters.python = {
  type = 'executable',
  command = 'python',
  args = { '-m', 'debugpy.adapter' },
}

-- DAP configurations for Python
dap.configurations.python = {
  {
    type = 'python',
    request = 'launch',
    name = "Launch file",
    program = "${file}",
    pythonPath = function()
      local cwd = vim.fn.getcwd()
      if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
        return cwd .. '/venv/bin/python'
      elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
        return cwd .. '/.venv/bin/python'
      else
        return '/usr/bin/python3'
      end
    end,
  },
}

-- Adapter setup for cppdbg
dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = '/data/vscode/extension/debugAdapters/bin/OpenDebugAD7'
}

-- DAP configurations for C/C++
dap.configurations.cpp = {
  {
    name = 'Attach to gdbserver :1234',
    type = 'cppdbg',
    request = 'attach',
    MIMode = 'gdb',
    miDebuggerServerAddress = 'localhost:1234',
    miDebuggerPath = '/usr/bin/gdb',
    cwd = '${workspaceFolder}',
    program = function()
      return vim.fn.input('Path to executable: ', '', 'file')
    end,
    args = {}
  }
}

-- UI setup
dapui.setup({
  icons = {
    expanded = "▾",
    collapsed = "▸"
  },
  mappings = {
    expand = {"<CR>", "<2-LeftMouse>"},
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r"
  },
  expand_lines = true,
  layouts = {{
    elements = {{
      id = "scopes",
      size = 0.25
    }, {
      id = "breakpoints",
      size = 0.25
    }, {
      id = "stacks",
      size = 0.25
    }, {
      id = "watches",
      size = 0.25
    }},
    size = 40,
    position = "left"
  }, {
    elements = {{
      id = "repl",
      size = 0.5
    }, {
      id = "console",
      size = 0.5
    }},
    size = 10,
    position = "bottom"
  }},
  floating = {
    max_height = nil,
    max_width = nil,
    border = "single",
    mappings = {
      close = {"q", "<Esc>"}
    }
  },
  windows = {
    indent = 1
  },
  render = {
    max_type_length = nil
  }
})

-- Track the UI state
local dapui_open = false

-- Toggle DAP UI
local function toggle_dapui()
  if dapui_open then
    dapui.close()
  else
    dapui.open()
  end
  dapui_open = not dapui_open
end

-- Automatically open/close DAP UI
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

-- Function to launch the debugger for an executable
local function launch_debugger()
  local program = vim.fn.input('Path to executable: ', '', 'file')
  if program and program ~= "" then
    dap.run({
      name = "Launch executable",
      type = "cppdbg",
      request = "launch",
      program = program,
      cwd = vim.fn.getcwd(),
      stopAtEntry = true
    })
  else
    print("No executable specified.")
  end
end

-- Function to send custom GDB commands
local function send_gdb_command()
  local command = vim.fn.input('GDB command: -exec ')
  if command and command ~= "" then
    dap.repl.run_command('-exec ' .. command)
  else
    print("No command specified.")
  end
end

-- Create user commands for launching the debugger and toggling DAP UI
vim.api.nvim_create_user_command("LaunchDebugger", launch_debugger, {})
vim.api.nvim_create_user_command("ToggleDapUI", toggle_dapui, {})


-- Keymaps for debugging
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', '<F5>', ':LaunchDebugger<CR>', opts)
vim.api.nvim_set_keymap('n', '<F10>', '<cmd>lua require"dap".step_over()<CR>', opts)
vim.api.nvim_set_keymap('n', '<F11>', '<cmd>lua require"dap".step_into()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>dl', '<cmd>lua require"dap".run_last()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>du', ':ToggleDapUI<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>db', '<cmd>lua require"dap".toggle_breakpoint()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>dc', '<cmd>lua send_gdb_command()<CR>', opts)

-- Add debugpy to dap configurations
dap.configurations.dashboard = {
  {
    name = "Launch",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', '', 'file')
    end,
    args = {},
    cwd = vim.fn.getcwd(),
    stopAtEntry = true,
    runInTerminal = true
  },
  {
    name = "Attach to process",
    type = "cppdbg",
    request = "attach",
    program = function()
      return vim.fn.input('Path to executable: ', '', 'file')
    end,
    args = {},
    cwd = vim.fn.getcwd(),
    stopAtEntry = true,
    runInTerminal = true
  }
}


local dap, dapui = require("dap"), require("dapui")
local Job = require('plenary.job') -- Using plenary for handling asynchronous jobs

-- Function to launch the Python debugger for a given file and attach GDB
local function debug_python_file(file)
    if file == "" then
        print("No file specified for debugging")
        return
    end

    -- Launch debugpy
    dap.run({
        type = 'python',
        request = 'launch',
        name = "Launch file",
        program = file,
        stopOnEntry = true,
        console = 'integratedTerminal',
        pythonPath = function()
            local cwd = vim.fn.getcwd()
            if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
                return cwd .. '/venv/bin/python'
            elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
                return cwd .. '/.venv/bin/python'
            else
                return '/usr/bin/python'
            end
        end,
    })
end

-- Create user command for launching the Python debugger with a file argument
vim.api.nvim_create_user_command("DPF", function(opts)
    debug_python_file(opts.args)
end, { nargs = 1, complete = 'file' })

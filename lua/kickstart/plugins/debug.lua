-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
  -- NOTE: Yes, you can install new plugins here!
  'mfussenegger/nvim-dap',
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Installs the debug adapters for you
    'mason-org/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    'leoluz/nvim-dap-go',
  },
  keys = {
    -- Basic debugging keymaps, feel free to change to your liking!
    {
      '<F5>',
      function()
        require('dap').continue()
      end,
      desc = 'Debug: Start/Continue',
    },
    {
      '<F1>',
      function()
        require('dap').step_into()
      end,
      desc = 'Debug: Step Into',
    },
    {
      '<F2>',
      function()
        require('dap').step_over()
      end,
      desc = 'Debug: Step Over',
    },
    {
      '<F3>',
      function()
        require('dap').step_out()
      end,
      desc = 'Debug: Step Out',
    },
    {
      '<leader>b',
      function()
        require('dap').toggle_breakpoint()
      end,
      desc = 'Debug: Toggle Breakpoint',
    },
    {
      '<leader>B',
      function()
        require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end,
      desc = 'Debug: Set Breakpoint',
    },
    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    {
      '<F7>',
      function()
        require('dapui').toggle()
      end,
      desc = 'Debug: See last session result.',
    },
  },
  config = function()
    local dap = require 'dap'
    local dapgo = require 'dap-go'
    vim.keymap.set('n', '<F1>', dap.continue, { desc = 'Continue' })
    vim.keymap.set('n', '<F2>', dap.step_over, { desc = 'Step Over' })
    vim.keymap.set('n', '<F3>', dap.step_into, { desc = 'Step Into' })
    vim.keymap.set('n', '<F4>', dap.step_out, { desc = 'Step Out' })
    vim.keymap.set('n', '<Leader>b', dap.toggle_breakpoint, { desc = '[B]reakpoint' })
    vim.keymap.set('n', '<Leader>B', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'Debug: Conditional [B]reakpoint' })
    vim.keymap.set('n', '<Leader>dr', dap.repl.open)
    vim.keymap.set('n', '<Leader>dl', dap.run_last)
    vim.keymap.set({ 'n', 'v' }, '<Leader>dh', require('dap.ui.widgets').hover)
    vim.keymap.set({ 'n', 'v' }, '<Leader>dp', require('dap.ui.widgets').preview)
    vim.keymap.set('n', '<Leader>dv', function()
      local widgets = require 'dap.ui.widgets'
      widgets.centered_float(widgets.scopes)
    end, { desc = '[D]ebug [V]ariables' })

    vim.keymap.set('n', '<leader>dn', dapgo.debug_test, { desc = '[D]ebug [N]earest test' })

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        'delve',
      },
    }

    local function get_port()
      local port = vim.fn.input 'Enter port (default: 2345): ' or '2345'
      return port
    end
    local function get_host()
      local host = vim.fn.input 'Enter host (default: 127.0.0.1): ' or '127.0.0.1'
      return host
    end

    -- Install golang specific config
    require('dap-go').setup {
      delve = {
        -- On Windows delve must be run attached or it crashes.
        -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
        detached = vim.fn.has 'win32' == 0,
        path = 'dlv',
        initialize_timeout_sec = 20,
      },
      dap_configurations = {
        -- must run dlv on remote machine with something like:
        -- dlv attach {PID} -l 127.0.0.1:8080 --headless
        {
          type = 'go',
          name = 'Attach Remote',
          mode = 'remote',
          request = 'attach',
          host = get_host,
          port = get_port,
        },
      },
    }
  end,
}

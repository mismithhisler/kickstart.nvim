-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'Mofiqul/vscode.nvim',
    config = function()
      require('vscode').setup()
    end,
  },
  {
    'navarasu/onedark.nvim',
    config = function()
      require('onedark').setup {
        style = 'warm',
      }
      vim.cmd.colorscheme 'onedark'
    end,
  },
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
      'nvim-neotest/neotest-go',
    },
    config = function()
      require('neotest').setup {
        adapters = {
          require 'neotest-go' {
            args = { '-count=1' },
          },
        },
      }
      local neotest = require 'neotest'
      vim.keymap.set('n', '<leader>tO', neotest.output_panel.open, { desc = '[T]est output_panel [O]pen' })
      vim.keymap.set('n', '<leader>tC', neotest.output_panel.close, { desc = '[T]est output_panel [C]lose' })
      vim.keymap.set('n', '<leader>tc', neotest.output_panel.clear, { desc = '[T]est output_panel [C]lear' })
      vim.keymap.set('n', '<leader>tn', neotest.run.run, { desc = '[T]est run [N]earest' })
      vim.keymap.set('n', '<leader>tf', function()
        neotest.run.run { vim.fn.expand '%' }
      end, { desc = '[T]est [F]ile' })
      vim.keymap.set('n', '<leader>to', function()
        neotest.output.open { enter = true }
      end, { desc = '[T]est output [O]pen' })
    end,
  },
}

return {
  {
    'nvim-tree/nvim-tree.lua',
    version = '*',
    lazy = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('nvim-tree').setup {
        filters = {
          git_ignored = false,
        },
      }
    end,
    keys = {
      { '\\', ':NvimTreeToggle<CR>', desc = 'NvimTree toggle', silent = true },
      {
        '|',
        function()
          require('nvim-tree.api').tree.toggle { focus = true, find_file = true }
        end,
        desc = 'NvimTree toggle',
        silent = true,
      },
    },
  },
}

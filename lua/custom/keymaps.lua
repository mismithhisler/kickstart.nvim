-- easy <ESC>
vim.keymap.set('i', 'jk', '<ESC>')

-- keep pointer in center when scrolling via C-d or C-u
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<leader>*', ':%s/\\<<C-R><C-W>\\>/', { desc = 'Replace all matching words' })

-- move visual block
vim.keymap.set('v', '<S-J>', ":m '>+1<CR>gv")
vim.keymap.set('v', '<S-K>', ":m '<-2<CR>gv")

-- Do not save deletions to the registers
vim.keymap.set('n', 'x', '"_x', { noremap = true, silent = true })
-- vim.keymap.set('n', 'd', '"_d', { noremap = true, silent = true })

vim.keymap.set(
  'n',
  '<leader>sm',
  ":lua require('telescope.builtin').lsp_document_symbols({ symbols={'method', 'function'} })<CR>",
  { desc = '[S]earch [M]ethods and Functions', silent = true }
)

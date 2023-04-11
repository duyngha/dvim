local status, saga = pcall(require, 'lspsaga')
if (not status) then return end

saga.setup({})

local opts = { noremap = true, silent = true }

vim.keymap.set('n', '<[e>', '<cmd>Lspsaga diagnostic_jump_next<CR>')
vim.keymap.set('n', '<e]>', '<cmd>Lspsaga diagnostic_jump_prev<CR>')
vim.keymap.set('n', 'K', '<Cmd>Lspsaga hover_doc<cr>', opts)
vim.keymap.set('n', 'gd', '<cmd>Lspsaga lsp_finder<CR>', opts)
vim.keymap.set('i', '<C-k>', '<Cmd>Lspsaga signature_help<cr>', opts)
vim.keymap.set('n', 'gr', '<Cmd>Lspsaga rename<cr>', opts)
vim.keymap.set("n", "gp", "<cmd>Lspsaga peek_definition<CR>")
vim.keymap.set("n", "gt", "<cmd>Lspsaga peek_type_definition<CR>")

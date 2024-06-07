local keymap = vim.keymap.set

keymap("n", "<leader>n", vim.cmd.Ex)

keymap("n", "j", "gj")
keymap("n", "k", "gk")

keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")

keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")

keymap("n", "<leader>r", function() vim.lsp.buf.rename() end)

local builtin = require('telescope.builtin')

keymap('n', '<leader>ff', builtin.find_files, {})
keymap('n', '<leader>fg', builtin.live_grep, {})
keymap('n', '<leader>fb', builtin.buffers, {})
keymap('n', '<leader>fh', builtin.help_tags, {})


local harpoon = require("harpoon")

keymap("n", "<leader>a", function() harpoon:list():add() end)
keymap("n", "<leader>e", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

keymap("n", "<C-h>", function() harpoon:list():select(1) end)
keymap("n", "<C-j>", function() harpoon:list():select(2) end)
keymap("n", "<C-k>", function() harpoon:list():select(3) end)
keymap("n", "<C-l>", function() harpoon:list():select(4) end)

keymap("n", "<C-p>", function() harpoon:list():prev() end)
keymap("n", "<C-n>", function() harpoon:list():next() end)

local neogen = require("neogen")

keymap("n", "<Leader>gd", function() neogen.generate() end)

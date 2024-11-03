local keymap = vim.keymap.set

-- Allow moving between line breaks
keymap("n", "j", "gj")
keymap("n", "k", "gk")

-- Center the scroll to the cursor after doing the action
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")

keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")

-- LSP
keymap("n", "<leader>lr", function()
  vim.lsp.buf.rename()
end)
keymap("n", "<leader>lf", function()
  vim.lsp.buf.format()
end)
keymap("n", "<leader>lc", function()
  vim.lsp.buf.code_action()
end)

-- Telescope
local telescope = require("telescope.builtin")

keymap("n", "<leader>ff", function()
  telescope.find_files({
    follow = true,
  })
end)
keymap("n", "<leader>fg", telescope.live_grep, {})
keymap("n", "<leader>fb", telescope.buffers, {})
keymap("n", "<leader>fh", telescope.help_tags, {})

-- Harpoon
local harpoon = require("harpoon")

keymap("n", "<leader>a", function()
  harpoon:list():add()
end)
keymap("n", "<leader>e", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end)

keymap("n", "<C-h>", function()
  harpoon:list():select(1)
end)
keymap("n", "<C-j>", function()
  harpoon:list():select(2)
end)
keymap("n", "<C-k>", function()
  harpoon:list():select(3)
end)
keymap("n", "<C-l>", function()
  harpoon:list():select(4)
end)

keymap("n", "<C-p>", function()
  harpoon:list():prev()
end)
keymap("n", "<C-n>", function()
  harpoon:list():next()
end)

-- Neogen
local neogen = require("neogen")

keymap("n", "<Leader>ld", function()
  neogen.generate()
end)

-- Preview Markdown files
keymap("n", "<leader>p", ":Glow<cr>")

-- Oil
keymap("n", "<leader>n", ":Oil<cr>")

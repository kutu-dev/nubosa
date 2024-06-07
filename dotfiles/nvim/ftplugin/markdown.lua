local keymap = vim.keymap.set

keymap("n", "<leader>p", ":Glow<cr>")

--[[
-- Autocmd to rename only in MARKDOWN files the filename to the first one pound title in lowercase and splitting the words using hyphens instead of spaces.
local markdown_augroup = vim.api.nvim_create_augroup('markdown', { clear = false })
vim.api.nvim_create_autocmd("BufWritePost", {
  group = markdown_augroup,
  callback = function()
    local buffer_text = vim.api.nvim_buf_get_lines(0, 0, vim.api.nvim_buf_line_count(0), false)

    if vim.bo.filetype ~= "markdown" then
      return
    end

    local old_filename_path = vim.api.nvim_buf_get_name(0)
    local old_filename = vim.fn.expand('%')

    if old_filename == "README.md" then
      return
    end

    for _, line in pairs(buffer_text) do
      if string.find(line, "^# .+") ~= nil then
        local cleared_title = string.gsub(string.sub(line, 3), " ", "-")

        vim.cmd.cd("%:h")

        local new_filename = string.lower(cleared_title) .. ".md"

        if old_filename:lower() ~= new_filename then
          vim.cmd.saveas(new_filename)

          if vim.fn.filereadable(new_filename) then
            vim.loop.fs_unlink(old_filename_path)
          end
        end

        break
      end
    end
  end
})
]]
   --

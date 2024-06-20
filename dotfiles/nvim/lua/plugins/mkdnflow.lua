return {
  'jakewvincent/mkdnflow.nvim',
  dependencies = {
    "nvim-lua/plenary.nvim"
  },

  ft = "markdown",

  opts = {
    perspective = {
      priority = "root",
      root_tell = "index.md"
    },

    mappings = {
      MkdnCreateLinkFromClipboard = {{'n', 'v'}, '<leader>mp'},
      MkdnToggleToDo = {{'n', 'v'}, '<leader>mt'},
    },

    modules = {
      cmp = true
    },

    links = {
      transform_explicit = function(text)
            return string.lower(text:gsub(' ', '-'))
        end
    }
  }
}

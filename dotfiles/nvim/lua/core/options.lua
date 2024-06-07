local options = {
    tabstop = 2,
    shiftwidth = 2,
    expandtab = true,
    softtabstop = 2,
    spell = true,
    spelllang = { "en", "es" }
}

local global = {
    mapleader = " "
}

local window = {
    number = true,
    relativenumber = true
}

for k, v in pairs(options) do
    vim.opt[k] = v
end

for k, v in pairs(global) do
    vim.g[k] = v
end

for k, v in pairs(window) do
    vim.wo[k] = v
end

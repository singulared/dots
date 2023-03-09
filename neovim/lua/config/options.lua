vim.g.mapleader = " "

vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0

local opt = vim.opt

opt.completeopt = "menuone,noinsert,noselect"
opt.relativenumber = true -- Relative line numbers
opt.shiftwidth = 4 -- Size of an indent
opt.spelllang = { "en", "ru" }
opt.tabstop = 4 -- Number of spaces tabs count for
opt.wrap = true -- Enable line wrap

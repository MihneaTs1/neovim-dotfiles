-- Plugin Manager

require("plg.bootstrap")

-- Editor Settings

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.cursorline = true
vim.opt.cursorcolumn = false

vim.opt.clipboard = "unnamedplus"

-- Persistent Colorscheme (Custom Script)
require("keepcolor")

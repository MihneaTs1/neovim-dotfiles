vim.loader.enable()

-- Custom Plugin Manager

require("config.plg")

-- Editor Settings

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

vim.opt.wrap = false

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.cursorline = true
vim.opt.cursorcolumn = false

vim.opt.clipboard = "unnamedplus"

-- Custom Persistent Colorscheme
require("keepcolor")

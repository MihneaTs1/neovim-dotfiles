local plg = require("plg")

plg.use("folke/tokyonight.nvim")

plg.use("nvim-lua/plenary.nvim")

plg.use("nvim-treesitter/nvim-treesitter", {
  config = function()
    require("nvim-treesitter.configs").setup({
    	auto_install = true,
	sync_install = true,
	highlight = { enable = true }
    })
  end
})

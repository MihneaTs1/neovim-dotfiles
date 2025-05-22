require("config.plg")
require("plg").setup({
	{
		plugin = "https://github.com/folke/tokyonight.nvim"
	},
	{
		plugin = "https://github.com/nvim-treesitter/nvim-treesitter",
		config = function()
			require("nvim-treesitter.configs").setup({
				sync_install = true,
				auto_install = true,
				highlight = { enable = true }
			})
			-- error("lot")
		end
	}
})

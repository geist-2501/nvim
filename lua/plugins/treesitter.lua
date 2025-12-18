return {
	'nvim-treesitter/nvim-treesitter',
	build = ':TSUpdate',
    lazy = false,
	opts = {
		ensure_installed = { "lua", "haskell" },
		auto_install = true,
		highlight = {
			enable = true
		}
	},
    config = function (_, opts)
        require("nvim-treesitter.configs").setup(opts)
    end
}

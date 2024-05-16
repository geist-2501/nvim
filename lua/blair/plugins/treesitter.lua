return {
	'nvim-treesitter/nvim-treesitter',
	build = ':TSUpdate',
	config = function()
		local configs = require('nvim-treesitter.configs')

		configs.setup({
			-- A list of parser names, or "all" (the five listed parsers should always be installed)
			ensure_installed = { "javascript", "typescript", "go", "c", "lua", "vim", "vimdoc", "query" },

			-- Install parsers synchronously (only applied to `ensure_installed`)
			sync_install = false,

	  		auto_install = true,

	  		highlight = {
	    			enable = true,
	    			additional_vim_regex_highlighting = false,
			}
		})
	end
}

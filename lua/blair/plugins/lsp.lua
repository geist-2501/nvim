return {
	{'VonHeikemen/lsp-zero.nvim', branch = 'v3.x', config = function()
		local lsp = require('lsp-zero')
		lsp.extend_lspconfig()
		lsp.on_attach(function(client, bufnr)
			-- see :help lsp-zero-keybindings
			-- to learn the available actions
			lsp.default_keymaps({buffer = bufnr})
		end)

		require('mason').setup({})
		require('mason-lspconfig').setup({
			handlers = {
				function(server_name)
					require('lspconfig')[server_name].setup({})
				end
			},
		})
		local cmp = require('cmp')

		local cmp_select = { behavior = cmp.SelectBehavior.Select }

		cmp.setup({
			mapping = cmp.mapping.preset.insert({
                		['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                		['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                		['<tab>'] = cmp.mapping.confirm({ select = true }),
                		["<C-Space>"] = cmp.mapping.complete(),
			}),
  			snippet = {
    				expand = function(args)
      					require('luasnip').lsp_expand(args.body)
    				end,
  			},
		})
	end},
	{'williamboman/mason.nvim'},
	{'williamboman/mason-lspconfig.nvim'},
	{'neovim/nvim-lspconfig'},
	{'hrsh7th/cmp-nvim-lsp'},
	{'hrsh7th/nvim-cmp'},
	{'L3MON4D3/LuaSnip'},
}

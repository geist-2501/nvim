return {
    {
        "mason-org/mason.nvim",
        opts = {},
        config = {
            registries = {
                "github:mason-org/mason-registry",
                "github:Crashdummyy/mason-registry",
            },
        }
    },
    {
        "mason-org/mason-lspconfig.nvim",
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            vim.lsp.enable({ "lua_ls", "hls", "vtsls", "eslint_lsp", "denols" })
            vim.diagnostic.config({
                virtual_text = true,
                signs = true,
                underline = true,
                update_in_insert = false,
                severity_sort = true,
            })

            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local map = function(mode, lhs, rhs, desc)
                        vim.keymap.set(mode, lhs, rhs, { buffer = args.buf, desc = desc })
                    end
                    local telescope = require("telescope.builtin")

                    -- Navigation
                    map("n", "gd", telescope.lsp_definitions, "Go to definition")
                    map("n", "gi", telescope.lsp_implementations, "Go to implementation")
                    map("n", "gr", telescope.lsp_references, "Find usages")
                    map("n", "<leader>D", telescope.lsp_type_definitions, "Go to type definition")

                    -- Symbols
                    map("n", "<leader>ds", telescope.lsp_document_symbols, "Document symbols")
                    map("n", "<leader>ws", telescope.lsp_dynamic_workspace_symbols, "Workspace symbols")

                    -- Refactoring (maps to Rider's Rename, Alt+Enter, Refactor This)
                    map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
                    map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code actions / refactor")

                    -- Signature help in insert mode (Rider's Ctrl+P parameter info)
                    map("i", "<C-k>", vim.lsp.buf.signature_help, "Signature help")
                end,
            })
        end
    },
    {
        'saghen/blink.cmp',
        dependencies = { 'rafamadriz/friendly-snippets' },

        version = '1.*',

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            -- All presets have the following mappings:
            -- C-space: Open menu or open docs if already open
            -- C-n/C-p or Up/Down: Select next/previous item
            -- C-e: Hide menu
            -- C-k: Toggle signature help (if signature.enabled = true)
            --
            -- See :h blink-cmp-config-keymap for defining your own keymap
            keymap = { preset = 'default' },

            appearance = {
                -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                -- Adjusts spacing to ensure icons are aligned
                nerd_font_variant = 'mono'
            },

            -- (Default) Only show the documentation popup when manually triggered
            completion = { documentation = { auto_show = false } },

            -- Default list of enabled providers defined so that you can extend it
            -- elsewhere in your config, without redefining it, due to `opts_extend`
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },
        },
        opts_extend = { "sources.default" }
    },
    {
        'seblyng/roslyn.nvim',
        ---@module 'roslyn.config'
        ---@type RoslynNvimConfig
        opts = {
            -- your configuration comes here; leave empty for default settings
            broad_search = false
        },
    }
}

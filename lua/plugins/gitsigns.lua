return {
    "lewis6991/gitsigns.nvim",
    opts = {},
    config = function(_, opts)
        require("gitsigns").setup(opts)

        local function set_hl()
            vim.api.nvim_set_hl(0, "GitSignsAdd",    { fg = "#4db368" })
            vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#e0a44a" })
            vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#cc5555" })
        end

        set_hl()
        vim.api.nvim_create_autocmd("ColorScheme", { callback = set_hl })
    end,
}

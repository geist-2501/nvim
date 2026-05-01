local dark_theme = "zenbones"
local light_theme = "zenbones"

local state_file = vim.fn.stdpath("data") .. "/theme_state"

local function load_is_dark()
    local f = io.open(state_file, "r")
    if f then
        local val = f:read("*l")
        f:close()
        return val ~= "light"
    end
    return true
end

local function save_is_dark(is_dark)
    local f = io.open(state_file, "w")
    if f then
        f:write(is_dark and "dark" or "light")
        f:close()
    end
end

local function apply_theme(is_dark)
    if is_dark then
        vim.opt.background = "dark"
        vim.cmd("colorscheme " .. dark_theme)
    else
        vim.opt.background = "light"
        vim.cmd("colorscheme " .. light_theme)
    end
end

local function toggle_theme()
    local is_dark = not load_is_dark()
    save_is_dark(is_dark)
    apply_theme(is_dark)
end

return {
    {
        "zenbones-theme/zenbones.nvim",
        lazy = false,
        priority = 1000,
        dependencies = "rktjmp/lush.nvim",
        config = function()
            apply_theme(load_is_dark())
            vim.keymap.set("n", "<leader>tt", toggle_theme, { desc = "Toggle light/dark theme" })
            vim.api.nvim_create_user_command("ToggleTheme", toggle_theme, {})
        end,
    },
}

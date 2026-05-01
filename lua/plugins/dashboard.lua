return {
    "goolord/alpha-nvim",
    event = "VimEnter",
    config = function()
        local alpha = require("alpha")
        local theme = require("alpha.themes.theta")

        theme.header.val = {
            "                                                     ",
            "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
            "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
            "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
            "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
            "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
            "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
            "                                                     ",
        }

        theme.header.val = {
            "⠀⠀⠀⠀⠈⠐⠶⣦⣄⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
            "⢀⣀⣤⣤⣤⣤⣄⣈⣿⣿⢿⣶⣄⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣠⡴⠊",
            "⠈⠙⠟⣏⠉⢋⢻⡚⠏⠛⢷⣌⡙⠻⠗⠀⠀⠀⠀⠀⠀⣀⣴⡿⢯⣥⡄",
            "⠀⠀⠀⠸⢳⣦⣭⣄⣤⣤⡬⠟⠉⠁⠀⠀⠀⠀⠀⢠⣚⠿⠋⢀⣴⠉⠁",
            "⠀⠀⠀⠀⠀⠈⠙⠙⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠛⠛⠛⠁⠀⠀",
        }

        local quotes = {
            "A language that doesn't affect the way you think about programming is not worth knowing. — Alan Perlis",
            "Programs must be written for people to read, and only incidentally for machines to execute. — Abelson & Sussman",
            "The best code is no code at all. — Jeff Atwood",
            "Any fool can write code that a computer can understand. Good programmers write code that humans can understand. — Martin Fowler",
            "Make it work, make it right, make it fast. — Kent Beck",
            "Simplicity is the soul of efficiency. — Austin Freeman",
            "First, solve the problem. Then, write the code. — John Johnson",
        }

        math.randomseed(os.time())
        local quote = quotes[math.random(#quotes)]

        -- wrap quote at ~60 chars
        local function wrap(text, width)
            local lines = {}
            local line = ""
            for word in text:gmatch("%S+") do
                if #line + #word + 1 > width then
                    table.insert(lines, line)
                    line = word
                else
                    line = line == "" and word or line .. " " .. word
                end
            end
            if line ~= "" then table.insert(lines, line) end
            return lines
        end

        local quote_lines = wrap(quote, 62)

        theme.header.opts = {
            position = "center",
            hl = "AlphaHeader",
        }

        local layout = {
            { type = "padding", val = vim.fn.max({ 2, vim.fn.floor((vim.o.lines - 16) / 2) }) },
            theme.header,
            { type = "padding", val = 2 },
            {
                type = "group",
                val = (function()
                    local items = {}
                    for _, l in ipairs(quote_lines) do
                        table.insert(items, {
                            type = "text",
                            val = l,
                            opts = { position = "center", hl = "Comment" },
                        })
                    end
                    return items
                end)(),
            },
        }

        alpha.setup({ layout = layout, opts = {} })
    end,
}

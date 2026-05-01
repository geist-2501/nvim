local function find_csproj(start_dir)
    local current = start_dir
    while true do
        local files = vim.fn.glob(current .. "/*.csproj", false, true)
        if #files > 0 then
            return current, files[1]
        end
        local parent = vim.fn.fnamemodify(current, ":h")
        if parent == current then break end
        current = parent
    end
    return nil, nil
end

local function read_root_namespace(csproj_path)
    local f = io.open(csproj_path, "r")
    if not f then return nil end
    for line in f:lines() do
        local ns = line:match("<RootNamespace>(.+)</RootNamespace>")
        if ns then
            f:close()
            return ns
        end
    end
    f:close()
    return nil
end

local function compute_namespace()
    local file_dir = vim.fn.expand("%:p:h")
    local csproj_dir, csproj_path = find_csproj(file_dir)
    if not csproj_dir then return nil end

    local root_ns = read_root_namespace(csproj_path)
        or vim.fn.fnamemodify(csproj_path, ":t:r")

    -- relative path from project root to file's directory
    local rel = file_dir:sub(#csproj_dir + 2)
    if rel ~= "" then
        return root_ns .. "." .. rel:gsub("/", ".")
    end
    return root_ns
end

vim.api.nvim_create_autocmd("BufNewFile", {
    pattern = "*.cs",
    callback = function()
        local ns = compute_namespace()
        if not ns then return end
        vim.api.nvim_buf_set_lines(0, 0, -1, false, { "namespace " .. ns .. ";", "" })
        vim.api.nvim_win_set_cursor(0, { 2, 0 })
    end,
})

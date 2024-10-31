-- Auto strip whitespace on save
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = {"*"},
    callback = function()
        local save_cursor = vim.fn.getpos(".")
        pcall(function() vim.cmd [[%s/\s\+$//e]] end)
        vim.fn.setpos(".", save_cursor)
    end,
})

-- Save session automatically
vim.api.nvim_create_autocmd("VimLeavePre", {
    pattern = "*",
    callback = function()
        if vim.g.savesession then
            vim.api.nvim_command("mks!")
        end
    end
})

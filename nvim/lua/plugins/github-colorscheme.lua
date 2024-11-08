return {
    "Mofiqul/vscode.nvim",
    name = "vscode",
    lazy = false,
    priority = 1000,
    config = function()
        require("vscode").setup({})
        vim.cmd("colorscheme vscode")
    end,
}

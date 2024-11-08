return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
            local ret = {
                capabilities = {
                    workspace = {
                        didChangeWatchedFiles = {
                            dynamicRegistration = true,
                        },
                    },
                },
                document_highlight = {
                    enabled = false,
                },
                diagnostics = {
                    underline = true,
                    update_in_insert = true,
                    severity_sort = true,
                },
                codelens = {
                    enabled = true,
                },
            }
            lspconfig.sourcekit.setup(ret)
            lspconfig.pyright.setup(ret)
            vim.api.nvim_create_autocmd("LspAttach", {
                desc = "LSP Actions",
                callback = function(args)
                    vim.keymap.set('n', 'K', vim.lsp.buf.hover, {noremap = true, silent = true})
                    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {noremap = true, silent = true})
                    vim.keymap.set('n', 'cl', vim.lsp.codelens.run, {noremap = true, silent = true})
                    vim.lsp.codelens.refresh()
                end,
            })
            vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
                buffer = buffer,
                callback = vim.lsp.codelens.refresh,
            })
        end,
    },
}

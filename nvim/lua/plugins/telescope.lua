return {
    {
        "nvim-telescope/telescope-fzf-native.nvim", build = "make",
    },
    {
        "nvim-telescope/telescope.nvim", branch = "0.1.x",
        dependencies = { "nvim-lua/plenary.nvim" },
        load_extension = { "fzf_native" },

        config = function()
            local builtin = require("telescope.builtin")
            vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
            vim.keymap.set('n', '<leader>gf', builtin.git_files, { desc = 'Telescope find git files' })
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
            vim.keymap.set('n', '<leader>fb', function() -- Setup keymap for closing buffer
                builtin.buffers({
                    initial_mode = "normal",
                    attach_mappings = function(prompt_bufnr, map)
                        local delete_buf = function()
                            local current_picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
                            current_picker:delete_selection(function(selection)
                                vim.api.nvim_buf_delete(selection.bufnr, { force = true })
                            end)
                        end
                        map('n', '<C-d>', delete_buf)
                        return true
                    end,
                })
            end, { desc = 'Telescope buffers' })
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
        end,
    },
}

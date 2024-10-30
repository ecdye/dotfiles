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
			vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
			vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
		end,
	},
}

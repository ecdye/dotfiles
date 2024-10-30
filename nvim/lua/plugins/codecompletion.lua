return {
	{
		"hrsh7th/nvim-cmp",
		version = false,
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
		},
		config = function()
			local cmp = require('cmp')
			local opts = {
				sources = cmp.config.sources {
					{ name = "nvim_lsp", },
					{ name = "path", },
					{ name = "buffer", },
				},
				mapping = cmp.mapping.preset.insert({
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<tab>"] = cmp.mapping(function(original)
						if cmp.visible() then
							cmp.select_next_item()
						else
							original()
						end
					end, {"i", "s"}),
					["<S-tab>"] = cmp.mapping(function(original)
						if cmp.visible() then
							cmp.select_prev_item()
						else
							original()
						end
					end, {"i", "s"}),

				})
			}
			cmp.setup(opts)
		end,
	},
	{ "hrsh7th/cmp-nvim-lsp", lazy = true },
	{ "hrsh7th/cmp-path", lazy = true },
	{ "hrsh7th/cmp-buffer", lazy = true },
}

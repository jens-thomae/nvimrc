return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"onsails/lspkind.nvim",
	},
	config = function()
		local cmp = require("cmp")
		local lspkind = require("lspkind")
		cmp.setup({
			snippet = {
				expand = function(args)
					vim.snippet.expand(args.body)
				end,
			},

			formatting = ({
				format = lspkind.cmp_format({
    					mode = "symbol_text",
    					menu = ({
    					  	buffer = "[Buffer]",
    					  	nvim_lsp = "[LSP]",
    					  	nvim_lua = "[Lua]",
    					  	latex_symbols = "[Latex]",
    					})
  				}),
			}),

			completion = {
				completeopt = "menu,menuone,preview,noselect",
			},
			mapping = cmp.mapping.preset.insert {
      				["<C-p>"] = cmp.mapping.select_prev_item(),
      				["<C-n>"] = cmp.mapping.select_next_item(),
      				["<C-d>"] = cmp.mapping.scroll_docs(-4),
                    ['<C-y>'] = cmp.mapping.confirm{ select = true },
      				["<C-Space>"] = cmp.mapping.complete {},
      				["<C-f>"] = cmp.mapping.scroll_docs(4),
      				-- ["<Esc>"] = cmp.mapping.close(),
   			},
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "buffer" },
				{ name = "path" },
			}),
		})
	end,
}

return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").setup()

		-- Enable treesitter highlighting for the current buffer. Replaces the
		-- old `auto_install` option, which no longer exists on the `main`
		-- branch. Parsers bundled with Neovim (c, lua, markdown, vim, ...) are
		-- used as-is; anything else is compiled on demand via the tree-sitter
		-- CLI and highlighting starts once the install finishes.
		vim.api.nvim_create_autocmd("FileType", {
			callback = function(args)
				local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
				if not lang then
					return
				end

				-- Parser already available (bundled or previously installed).
				if pcall(vim.treesitter.start, args.buf, lang) then
					return
				end

				-- Missing: install() is async; start highlighting when done.
				require("nvim-treesitter").install(lang):await(function()
					if vim.api.nvim_buf_is_valid(args.buf) then
						pcall(vim.treesitter.start, args.buf, lang)
					end
				end)
			end,
		})
	end,
}

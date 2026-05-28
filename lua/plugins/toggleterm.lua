return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			shade_terminals = true,
			size = 80,
		})

		local Terminal = require("toggleterm.terminal").Terminal

		local lazygit = Terminal:new({
			cmd = "lazygit",
			dir = "git_dir",
			direction = "float",
			float_opts = { border = "double" },
			on_open = function(term)
				vim.cmd("startinsert!")
				vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = term.bufnr, noremap = true, silent = true })
			end,
			on_close = function() vim.cmd("startinsert!") end,
		})

		local float = Terminal:new({
			direction = "float",
			float_opts = { border = "double" },
			on_open = function(term)
				vim.cmd("startinsert!")
				-- <D-i> for Neovide / Alacritty (kitty keyboard protocol); <M-i> for inside tmux
				local close_term = [[<C-\><C-n> <bar> <Cmd>close<CR>]]
				vim.keymap.set("t", "<D-i>", close_term, { buffer = term.bufnr, noremap = true, silent = true })
				vim.keymap.set("t", "<M-i>", close_term, { buffer = term.bufnr, noremap = true, silent = true })
			end,
			on_close = function() vim.cmd("startinsert!") end,
		})

		vim.keymap.set("n", "<leader>lg", function() lazygit:toggle() end, { noremap = true, silent = true })
		-- <D-i> for Neovide / Alacritty (kitty keyboard protocol); <M-i> for inside tmux
		vim.keymap.set("n", "<D-i>", function() float:toggle() end, { noremap = true, silent = true })
		vim.keymap.set("n", "<M-i>", function() float:toggle() end, { noremap = true, silent = true })
	end,
}

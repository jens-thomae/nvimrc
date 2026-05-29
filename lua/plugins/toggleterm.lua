return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			shade_terminals = true,
			size = 80,
			start_in_insert = true,
			persist_mode = true,
		})

		local Terminal = require("toggleterm.terminal").Terminal

		local lazygit = Terminal:new({
			cmd = "lazygit",
			dir = "git_dir",
			direction = "float",
			float_opts = { border = "double" },
			on_open = function(term)
                vim.schedule(function() vim.cmd("startinsert!") end)
				vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = term.bufnr, noremap = true, silent = true })
			end,
			on_close = function() vim.cmd("startinsert!") end,
		})

		local float = Terminal:new({
			direction = "float",
			float_opts = { border = "double" },
			on_open = function(term)
				vim.schedule(function() vim.cmd("startinsert!") end)
				-- <D-i> for Neovide / Alacritty (kitty keyboard protocol); <M-i> for inside tmux
				local opts = { buffer = term.bufnr, noremap = true, silent = true }
				-- From terminal mode: exit to normal first, then close.
				vim.keymap.set("t", "<D-i>", [[<C-\><C-n><Cmd>close<CR>]], opts)
				vim.keymap.set("t", "<M-i>", [[<C-\><C-n><Cmd>close<CR>]], opts)
				-- From normal mode (e.g. after scrolling): close directly in one press.
				vim.keymap.set("n", "<D-i>", "<Cmd>close<CR>", opts)
				vim.keymap.set("n", "<M-i>", "<Cmd>close<CR>", opts)
			end,
			on_close = function() vim.cmd("startinsert!") end,
		})

		vim.keymap.set("n", "<leader>lg", function() lazygit:toggle() end, { noremap = true, silent = true })
		-- <D-i> for Neovide / Alacritty (kitty keyboard protocol); <M-i> for inside tmux
		vim.keymap.set("n", "<D-i>", function() float:toggle() end, { noremap = true, silent = true })
		vim.keymap.set("n", "<M-i>", function() float:toggle() end, { noremap = true, silent = true })
	end,
}

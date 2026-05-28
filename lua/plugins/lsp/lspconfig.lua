return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		vim.diagnostic.config({
			signs = {
				text = {
                    [vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.HINT] = "󰠠 ",
					[vim.diagnostic.severity.INFO] = " ",
				},
			},
		})

		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(ev)
				local map = function(mode, lhs, rhs, desc)
					vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, silent = true, noremap = true, desc = desc })
				end

				map("n", "gR", "<cmd>Telescope lsp_references<CR>", "Show LSP references")
				map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
				map("n", "gd", "<cmd>Telescope lsp_definitions<CR>", "Show LSP definitions")
				map("n", "gi", "<cmd>Telescope lsp_implementations<CR>", "Show LSP implementations")
				map("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", "Show LSP type definitions")
				map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "See available code actions")
				map("n", "<leader>rn", vim.lsp.buf.rename, "Smart rename")
				map("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", "Show buffer diagnostics")
				map("n", "<leader>d", vim.diagnostic.open_float, "Show line diagnostics")
				map("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, "Previous diagnostic")
				map("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, "Next diagnostic")
				map("n", "K", vim.lsp.buf.hover, "Hover documentation")
				map("n", "<leader>rs", "<cmd>LspRestart<CR>", "Restart LSP")

				local client = vim.lsp.get_client_by_id(ev.data.client_id)
				if client and client.name == "eslint" then
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = ev.buf,
						command = "EslintFixAll",
					})
				end
			end,
		})

		-- Applied to every server unless overridden below.
		vim.lsp.config("*", {
			capabilities = capabilities,
		})

		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
				},
			},
		})

		-- Silence stylistic eslint rules in the editor but keep them auto-fixable on save.
		local eslint_rule_customizations = {
			{ rule = "style/*",   severity = "off", fixable = true },
			{ rule = "format/*",  severity = "off", fixable = true },
			{ rule = "*-indent",  severity = "off", fixable = true },
			{ rule = "*-spacing", severity = "off", fixable = true },
			{ rule = "*-spaces",  severity = "off", fixable = true },
			{ rule = "*-order",   severity = "off", fixable = true },
			{ rule = "*-dangle",  severity = "off", fixable = true },
			{ rule = "*-newline", severity = "off", fixable = true },
			{ rule = "*quotes",   severity = "off", fixable = true },
			{ rule = "*semi",     severity = "off", fixable = true },
		}

		vim.lsp.config("eslint", {
			settings = {
				rulesCustomizations = eslint_rule_customizations,
			},
			filetypes = {
				"javascript", "javascriptreact", "javascript.jsx",
				"typescript", "typescriptreact", "typescript.tsx",
				"vue", "html", "markdown", "json", "jsonc",
				"yaml", "toml", "xml", "gql", "graphql",
				"astro", "svelte", "css", "less", "scss",
				"pcss", "postcss",
			},
		})

		vim.lsp.enable({
			"ts_ls",
			"html",
			"cssls",
			"tailwindcss",
			"svelte",
			"lua_ls",
			"pyright",
			"rust_analyzer",
			"clangd",
			"gopls",
			"jdtls",
			"eslint",
		})
	end,
}

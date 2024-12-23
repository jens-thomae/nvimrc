return {
	{
		"ribru17/bamboo.nvim",
		priority = 1000,
		config = function()
            require("bamboo").setup({
                transparent = false
            })
			vim.cmd([[colorscheme bamboo]])
		end
	},
    {
        "rose-pine/neovim",
        name = "rose-pine",
		config = function()
            require("rose-pine").setup({
                styles = {
                    transparency = false,
                },
            })
		end
    },
	{
		"catppuccin/nvim",
	},
	{
		"rebelot/kanagawa.nvim",
	},
	{
		"NTBBloodbath/doom-one.nvim",
	},
    {
        "nyoom-engineering/oxocarbon.nvim"
    },
    {
        "bluz71/vim-moonfly-colors"
    },
    {
        "navarasu/onedark.nvim",
		config = function()
            require("onedark").setup({
                transparent = true
            })
		end
    },
    {
        "folke/tokyonight.nvim"
    },
    {
        "jacoborus/tender.vim"
    },
    {
        "nanotech/jellybeans.vim"
    },
    {
        "jaredgorski/SpaceCamp"
    },
    {
        "NTBBloodbath/doom-one.nvim"
    },
}

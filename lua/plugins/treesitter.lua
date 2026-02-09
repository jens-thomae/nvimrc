return {
	"nvim-treesitter/nvim-treesitter",
    lazy=false,
    build=':TSUpdate',
	event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("nvim-treesitter").setup({
            -- Automatically install missing parsers when entering buffer
            -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
            auto_install = true,
        })
    end
}

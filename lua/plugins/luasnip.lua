return {
    "L3MON4D3/LuaSnip",
    version = "v2.*", -- Follow official release versions
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
    local luasnip = require("luasnip")
    require("luasnip.loaders.from_vscode").lazy_load()

    -- friendly-snippets ships docblock snippets (trigger `/**`, `---`, etc.)
    -- under separate pseudo-filetypes. Pull them into the real filetypes so
    -- they show up in C/C++/Lua/JS/TS/etc. buffers.
    luasnip.filetype_extend("c", { "cdoc" })
    luasnip.filetype_extend("cpp", { "cppdoc" })
    luasnip.filetype_extend("lua", { "luadoc" })
    luasnip.filetype_extend("javascript", { "jsdoc" })
    luasnip.filetype_extend("typescript", { "tsdoc" })
    luasnip.filetype_extend("java", { "javadoc" })
    luasnip.filetype_extend("kotlin", { "kdoc" })
    luasnip.filetype_extend("php", { "phpdoc" })
    luasnip.filetype_extend("ruby", { "rdoc" })
  end,
}


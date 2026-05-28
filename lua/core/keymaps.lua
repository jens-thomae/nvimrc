-- Default global keys
vim.g.mapleader = " "
-- vim.keymap.set("n", ";", ":")

-- netrw
vim.keymap.set("n", "<leader>e", vim.cmd.Ex)

-- window control in normal mode
vim.keymap.set('n', '<leader>wh', [[<Cmd>wincmd h<CR>]])
vim.keymap.set('n', '<leader>wj', [[<Cmd>wincmd j<CR>]])
vim.keymap.set('n', '<leader>wk', [[<Cmd>wincmd k<CR>]])
vim.keymap.set('n', '<leader>wl', [[<Cmd>wincmd l<CR>]])

-- copy to clipboard
vim.api.nvim_set_keymap('v', '<M-c>', '"+y', { noremap = true, silent = true })

-- split controls
vim.keymap.set('n', '<leader>sh', '<Cmd>vsplit<CR>')
vim.keymap.set('n', '<leader>sv', '<Cmd>split<CR>')

-- Clear search highlighting
vim.keymap.set('n', '<Esc>', '<Cmd>noh<CR>')

-- Go to previous buffer
vim.keymap.set('n', '<leader>b', '<Cmd>b#<CR>')

-- Toggle fullscreen for current buffer
function toggle_fullscreen_bffer()
	-- autosave feature
    --[[ if vim.bo.modified then
        vim.cmd('update')
    end
]]
    local is_tab = vim.fn.tabpagenr('$') > 1

    if is_tab then
        vim.cmd('tabc')
    else
        vim.cmd('tab split')
    end
end

vim.api.nvim_set_keymap('n', '<leader>sf', ':lua toggle_fullscreen_buffer()<CR>', { noremap = true, silent = true })

-- Enable macos clipboard for neovide
if vim.g.neovide then
  local function save() vim.cmd.write() end
  local function copy() vim.cmd([[normal! "+y]]) end
  local function paste() vim.api.nvim_paste(vim.fn.getreg("+"), true, -1) end

  vim.keymap.set({ "n", "i", "v" }, "<D-s>", save, { desc = "Save" })
  vim.keymap.set("v", "<D-c>", copy, { silent = true, desc = "Copy" })
  vim.keymap.set({ "n", "i", "v", "c", "t" }, "<D-v>", paste, { silent = true, desc = "Paste" })
end


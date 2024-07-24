require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
--
--
map('n', '<leader>rn', vim.lsp.buf.rename, {desc = 'Rename Symbol'})
map('n', '<leader>ca', vim.lsp.buf.code_action, {desc = 'Code Action'})
map('n', '<leader>gd', vim.lsp.buf.definition, {desc = 'Goto Definition'})
map('n', '<leader>gr', vim.lsp.buf.references, {desc = 'Goto References'})
map('n', 'K', vim.lsp.buf.hover, {desc = 'Hover Documentation'})
map('n', '<leader>ff', vim.lsp.buf.format, {desc = 'Format Code'})





local builtin = require('telescope.builtin')

map('n', '<leader>pf', builtin.find_files, {})
map('n', '<C-p>', builtin.git_files, {})

map('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)

map('n', '<leader>q', ":bp<bar>sp<bar>bn<bar>bd<CR>", {desc = "Close current tab"})



map('n', '<leader>se', ":PyrightSetPythonPath ./.venv/bin/python<CR>", {desc = "Set env"})
local conform = require('conform')

vim.keymap.set('n', '<leader>cF', conform.format, {desc = "Format conform code"})

-- " " Copy to clipboard
map('v', "<leader>y",  '"+y', {desc = "Copy line and below to clipboard"})
map('v', "<leader>Y",  '"+yg_', {desc = "Copy from cursor until EOL to clipboard"})
map('v', "<leader>yy",  '"+yy', {desc = "Copy current line to clipboard"})

map('v', "<leader>p",  '"+p', {desc = "Paste from clipboard before cursor"})
map('v', "<leader>P",  '"+P', {desc = "Paste from clipboard after cursor"})


map('n', '<leader>od', ":ObsidianDailies<CR>", {desc = 'Dailie notes'})
map('n', '<leader>ot', ":ObsidianToday<CR>", {desc = 'Daily today'})
map('n', '<leader>oy', ":ObsidianYesterday<CR>", {desc = 'Daily yesterday'})
map('n', '<leader>ow', ":ObsidianWorkspace work<CR>", {desc = 'Obsidian work workspace'})
map('n', '<leader>op', ":ObsidianWorkspace personal<CR>", {desc = 'Obsidian personal workspace'})
map('n', '<leader>oqs', ":ObsidianQuickSwitch<CR>", {desc = 'Obsidian quick switch'})
map('n', '<leader>on', ":ObsidianNew<CR>", {desc = 'Obsidian new'})
map('n', '<leader>oln', ":ObsidianLinkNew<CR>", {desc = 'Obsidian new link'})
map('n', '<leader>os', ":ObsidianSearch<CR>", {desc = 'Obsidian search'})
map('n', '<leader>of', ":ObsidianFollowLink<CR>", {desc = 'Obsidian follow link'})


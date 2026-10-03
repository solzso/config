-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- jk for the normal mode
vim.keymap.set("i", "jk", "<Esc>", {
  desc = "Exit insert mode with jk",
})
-- jj for the command line
vim.keymap.set("i", "hh", "<Esc>:", {
  noremap = true,
  silent = false,
  desc = "Exit Insert mode and open command line",
})

vim.keymap.set("n", "hh", ":", {
  noremap = true,
  silent = false,
  desc = "Open command line",
})

---Run c++ code
vim.keymap.set("n", "<F5>", function()
  vim.cmd("write")

  local ft = vim.bo.filetype
  local exe = vim.fn.expand("%:r") .. ".exe"

  local compiler
  if ft == "cpp" then
    compiler = "g++"
  elseif ft == "c" then
    compiler = "gcc"
  else
    return
  end

  vim.cmd("botright split")
  vim.cmd("resize 12")

  vim.cmd("terminal " .. compiler .. ' "%" -std=c++20 -Wall -Wextra -O2 -o "' .. exe .. '" && "' .. exe .. '"')
end, { desc = "Compile & Run" }) -- Move cursor
vim.keymap.set("i", "<C-Left>", "<C-o>b")
vim.keymap.set("i", "<C-Right>", "<C-o>w")
vim.keymap.set("i", "<Home>", "<C-o>^")
vim.keymap.set("i", "<End>", "<End>")

-- Delete
vim.keymap.set("i", "<C-BS>", "<C-w>") -- Delete previous word
vim.keymap.set("i", "<C-Del>", "<C-o>dw") -- Delete next word

-- New lines
vim.keymap.set("i", "<S-Enter>", "<Esc>O") -- Insert line above
vim.keymap.set("i", "<C-Enter>", "<Esc>o") -- Insert line below

-- Save
vim.keymap.set("i", "<C-s>", "<Esc><Cmd>w<CR>a")

-- Undo / Redo
vim.keymap.set("i", "<C-z>", "<Esc>ua")
vim.keymap.set("i", "<C-y>", "<Esc><C-r>a")

-- Exit Insert mode
vim.keymap.set("i", "jj", "<Esc>")

-- ==========================
-- Insert Mode
-- ==========================
-- Dashboard
vim.keymap.set("n", "<leader>d", function()
  Snacks.dashboard()
end, { desc = "Open Dashboard" })
-- Save
vim.keymap.set("i", "<C-s>", "<Esc><Cmd>w<CR>a")

-- Exit insert mode
vim.keymap.set("i", "jj", "<Esc>")

-- Delete previous word
vim.keymap.set("i", "<C-BS>", "<C-w>")

-- Delete next word
vim.keymap.set("i", "<C-Del>", "<C-o>dw")

-- Move by word
vim.keymap.set("i", "<C-Left>", "<C-o>b")
vim.keymap.set("i", "<C-Right>", "<C-o>w")

-- Beginning/End of line
vim.keymap.set("i", "<Home>", "<C-o>^")
vim.keymap.set("i", "<End>", "<End>")

-- New line below
vim.keymap.set("i", "<C-Enter>", "<Esc>o")

-- New line above
vim.keymap.set("i", "<S-Enter>", "<Esc>O")

-- Undo / Redo
vim.keymap.set("i", "<C-z>", "<Esc>ua")
vim.keymap.set("i", "<C-y>", "<Esc><C-r>a")

-- Save
vim.keymap.set("n", "<C-s>", "<Cmd>w<CR>")

-- Quit
vim.keymap.set("n", "<C-q>", "<Cmd>q<CR>")

-- Save & Quit
vim.keymap.set("n", "<C-S-s>", "<Cmd>wq<CR>")

-- Command line

-- Select all
vim.keymap.set("n", "<C-a>", "ggVG")

-- Clear search highlight
vim.keymap.set("n", "<Esc>", "<Cmd>noh<CR>")

vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

vim.keymap.set("n", "<C-Up>", ":resize -2<CR>")
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>")
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>")
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>")

vim.keymap.set("n", "<A-j>", ":m .+1<CR>==")
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==")

vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi")
vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi")

vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")

vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set({ "n", "v" }, "<C-c>", '"+y')
vim.keymap.set("n", "<C-v>", '"+P')
vim.keymap.set("i", "<C-v>", "<C-r>+")
vim.keymap.set("v", "<C-v>", '"+P')

-- Terminal mode window navigation
vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-w>h]])
vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-w>j]])
vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-w>k]])
vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-w>l]])

vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]])

vim.keymap.set("t", "jj", [[<C-\><C-n>]])

-- Exit terminal mode
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]])
vim.keymap.set("t", "jj", [[<C-\><C-n>]])

-- Window navigation
vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-w>h]])
vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-w>j]])
vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-w>k]])
vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-w>l]])

-- ============================================
-- System Clipboard
-- ============================================
vim.opt.clipboard = "unnamedplus"

-- ============================================
-- Copy
-- ============================================

-- Copy current line
vim.keymap.set("n", "<C-c>", '"+yy', { noremap = true, silent = true })

-- Copy selection
vim.keymap.set("v", "<C-c>", '"+y', { noremap = true, silent = true })

-- ============================================
-- Cut
-- ============================================

-- Cut current line
vim.keymap.set("n", "<C-x>", '"+dd', { noremap = true, silent = true })

-- Cut selection
vim.keymap.set("v", "<C-x>", '"+d', { noremap = true, silent = true })

-- ============================================
-- Paste
-- ============================================

-- Paste after cursor
vim.keymap.set("n", "<C-v>", '"+p', { noremap = true, silent = true })

-- Paste in insert mode
vim.keymap.set("i", "<C-v>", "<C-r>+", { noremap = true, silent = true })

-- Replace selection with clipboard
vim.keymap.set("v", "<C-v>", '"+P', { noremap = true, silent = true })
vim.keymap.set("i", "<C-a>", "<Esc>ggVG", { noremap = true, silent = true })
-- ============================================
-- Delete without overwriting clipboard
-- -=========================================

vim.keymap.set("n", "x", '"_x', { noremap = true, silent = true })
vim.keymap.set("n", "X", '"_X', { noremap = true, silent = true })
vim.keymap.set("v", "x", '"_x', { noremap = true, silent = true })

-- ============================================
-- Select All
-- ============================================

vim.keymap.set("n", "<C-a>", "ggVG", { noremap = true, silent = true })
vim.keymap.set("i", "<C-a>", "<Esc>ggVG", { noremap = true, silent = true })
-- ============================================
-- Save
-- ============================================

vim.keymap.set({ "n", "i" }, "<C-s>", function()
  vim.cmd("write")
end, { noremap = true, silent = true })

-- ============================================
-- Undo / Redo
-- ============================================

vim.keymap.set("i", "<C-z>", "<Esc>ua", { noremap = true })
-- vim.keymap.set("i", "<C-y>", "<Esc><C-r>a", { noremap = true })

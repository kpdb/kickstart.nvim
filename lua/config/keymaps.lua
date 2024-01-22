-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap.set

keymap("v", "J", ":m '>+1<cr>gv=gv", { desc = "Move line up" })
keymap("v", "K", ":m '<-2<cr>gv=gv", { desc = "Move line down" })

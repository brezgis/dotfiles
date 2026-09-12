-- Minimal neovim. Rosé Pine Moon. Opens instantly, plain vim keys.
local o = vim.opt
o.number = true
o.relativenumber = false
o.mouse = "a"
o.clipboard = "unnamedplus"     -- share system clipboard
o.expandtab = true
o.shiftwidth = 2
o.tabstop = 2
o.smartindent = true
o.ignorecase = true
o.smartcase = true              -- case-sensitive only if you type a capital
o.wrap = false
o.scrolloff = 6
o.signcolumn = "no"
o.termguicolors = true
o.undofile = true
o.updatetime = 250
o.cursorline = true
o.splitright = true
o.splitbelow = true

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { desc = "save" })
vim.keymap.set("n", "<leader>q", "<cmd>q<cr>", { desc = "quit" })
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<cr>")

-- one plugin: the colorscheme. bootstraps lazy.nvim on first run.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable",
    "https://github.com/folke/lazy.nvim.git", lazypath })
end
o.rtp:prepend(lazypath)
require("lazy").setup({
  { "rose-pine/neovim", name = "rose-pine", priority = 1000,
    config = function()
      require("rose-pine").setup({ variant = "moon" })
      vim.cmd.colorscheme("rose-pine")
    end },
}, { ui = { border = "rounded" }, change_detection = { notify = false } })

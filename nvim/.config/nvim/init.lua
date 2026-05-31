-- Lazy plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Configure plugins (empty for now)
require("lazy").setup({
  -- Plugins go here
  { "neanias/everforest-nvim", name = "everforest", lazy = false, priority = 1000 },
--  {
--    'windwp/nvim-autopairs',
--    event = "InsertEnter",
--    config = true
--	}
--
--  {
--      "nvim-lualine/lualine.nvim",
--      dependencies = {"nvim-tree/nvim-web-devicons" },
--      config = function()
--        require("lualine").setup()
--        end,
--        }
})

-- Basic settings
vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.termguicolors = true
vim.o.clipboard = "unnamedplus"

-- enable syntax highlighting
vim.cmd("syntax on")

-- filetype detection
vim.cmd("filetype plugin indent on")

-- set the colorscheme
vim.cmd.colorscheme("everforest")
--## Neovide Settings ##--
if vim.g.neovide then
  -- Set transparency (0.0 = fully transparent, 1.0 = fully opaque)
  vim.g.neovide_opacity = 0.8
end

-- Font
if vim.g.neovide then
  -- Set font (format: "FontName:hSize")
  vim.o.guifont = "Iosevka:h14"
end

--# Lualine #--
require("lualine").setup({
  options = {
    theme = "auto", -- Automatically matches your colorscheme
    icons_enabled = true,
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = { "filename" },
    lualine_x = { "encoding", "fileformat", "filetype" },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
})

-- basic keybinds
vim.keymap.set("n", "<leader>w", ":w<CR>", {desc = "Save file"})
vim.keymap.set("n", "<leader>q", ":q<CR>", {desc = "Quit file"})
vim.keymap.set("n", "<leader>x", ":wq<CR>", {desc = "Save and quit file"})
vim.keymap.set("n", "<leader>cd", ":Ex<CR>", {desc = "Open netrw"})

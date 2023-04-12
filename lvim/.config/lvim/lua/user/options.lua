--
-- neovim and lunarvim options
--

-- ## colorscheme ##
-- lvim.colorscheme = "gruvbox-material"
lvim.colorscheme = "catppuccin"
-- Transparency
lvim.transparent_window = true
-- ## General Settings ##
vim.opt.spelllang = "en"
vim.opt.clipboard = ""
vim.opt.undofile = true
vim.opt.showmode = false
vim.opt.scrolloff = 15
vim.opt.wrap = true
vim.opt.cursorline = true
vim.opt.cursorlineopt = "both"
-- vim.opt.mouse = ""
vim.g.gruvbox_material_background = "hard"
vim.g.gruvbox_material_palette = "mix"
-- ## LunarVim options ##
-- gitsigns
lvim.builtin.gitsigns.opts.signs.add.text = "+"
lvim.builtin.gitsigns.opts.signs.change.text = "~"
lvim.builtin.gitsigns.opts.signs.delete.text = "-"
lvim.builtin.gitsigns.opts.signs.topdelete.text = "-"
lvim.builtin.gitsigns.opts.signs.changedelete.text = "~"
-- alpha dashboard
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
-- set to false to disable floating terminal
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.dap.active = true
lvim.log.level = "warn"
lvim.format_on_save = true

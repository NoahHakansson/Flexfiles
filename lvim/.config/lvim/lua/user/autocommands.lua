--
-- Autocommands
--

-- Enable spell checking only for markdown files
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = { "*.md" },
	command = "setlocal spell spelllang=en_us",
})

-- kitty terminal config auto reload on save
vim.cmd("autocmd bufwritepost ~/.config/kitty/kitty.conf :silent !kill -SIGUSR1 $(pgrep kitty)")
vim.cmd("autocmd bufwritepost ~/Flexfiles/kitty/.config/kitty/kitty.conf :silent !kill -SIGUSR1 $(pgrep kitty)")

-- Auto hybrid line numbers
-- enable relative line numbers only for the focused buffer when in normal mode
local augroup = vim.api.nvim_create_augroup("numbertoggle", {})
vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "CmdlineLeave", "WinEnter" }, {
	pattern = "*",
	group = augroup,
	callback = function()
		if vim.o.nu and vim.api.nvim_get_mode().mode ~= "i" then
			vim.opt.relativenumber = true
		end
	end,
})
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "CmdlineEnter", "WinLeave" }, {
	pattern = "*",
	group = augroup,
	callback = function()
		if vim.o.nu then
			vim.opt.relativenumber = false
			vim.cmd("redraw")
		end
	end,
})

-- let treesitter use bash highlight for zsh files as well
vim.api.nvim_create_autocmd("FileType", {
	pattern = "zsh",
	callback = function()
		require("nvim-treesitter.highlight").attach(0, "bash")
	end,
})

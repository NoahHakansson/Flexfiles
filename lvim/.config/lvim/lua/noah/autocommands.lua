--
-- Autocommands
--

local generalAutoCmds = vim.api.nvim_create_augroup("General autocmds", { clear = true })

-- Enable spell checking only for markdown files
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = { "*.md" },
	command = "setlocal spell spelllang=en_us",
	group = generalAutoCmds,
})

-- kitty terminal config auto reload on save
local kittyAutoCmds = vim.api.nvim_create_augroup("Kitty autocmds", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = { "~/.config/kitty/kitty.conf", "~/Flexfiles/kitty/.config/kitty/kitty.conf" },
	callback = function()
		vim.cmd("silent !kill -SIGUSR1 $(pgrep kitty)")
	end,
	group = kittyAutoCmds,
})

-- disable auto comment on new line
vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		vim.opt.formatoptions:remove({ --[[ "c", "r",  ]]
			"o",
		})
	end,
	desc = "Disable New Line Comment",
	group = generalAutoCmds,
})

-- let treesitter use bash highlight for zsh files as well
vim.api.nvim_create_autocmd("FileType", {
	pattern = "zsh",
	callback = function()
		require("nvim-treesitter.highlight").attach(0, "bash")
	end,
	group = generalAutoCmds,
})

-- Auto hybrid line numbers
-- enable relative line numbers only for the focused buffer when in normal mode
local autoHybridLines = vim.api.nvim_create_augroup("numbertoggle", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "CmdlineLeave", "WinEnter" }, {
	pattern = "*",
	callback = function()
		if vim.o.nu and vim.api.nvim_get_mode().mode ~= "i" then
			vim.opt.relativenumber = true
		end
	end,
	group = autoHybridLines,
})
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "CmdlineEnter", "WinLeave" }, {
	pattern = "*",
	callback = function()
		if vim.o.nu then
			vim.opt.relativenumber = false
			vim.cmd("redraw")
		end
	end,
	group = autoHybridLines,
})

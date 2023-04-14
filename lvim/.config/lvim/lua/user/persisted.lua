--
-- persisted.nvim is a plugin for managing sessions in Neovim.
-- It is a fork of persistence.nvim with some additional features and GIT branch support.
--

require("persisted").setup({
	save_dir = vim.fn.expand(vim.fn.stdpath("data") .. "/sessions/"), -- directory where session files are saved: Resolves to ~/.local/share/nvim/sessions/
	silent = false, -- silent nvim message when sourcing session file
	use_git_branch = true, -- create session files based on the branch of the git enabled repository
	autosave = true, -- automatically save session files when exiting Neovim
	should_autosave = function() -- function to determine if a session should be autosaved
		-- do not autosave if the current filetype is ""(empty buffer), NvimTree or alpha
		if vim.bo.filetype == "" or vim.bo.filetype == "NvimTree" or vim.bo.filetype == "alpha" then
			return false
		end
		return true
	end,
	autoload = true, -- automatically load the session for the cwd on Neovim startup
	on_autoload_no_session = nil, -- function to run when `autoload = true` but there is no session to load
	follow_cwd = true, -- change session file name to match current working directory if it changes
	allowed_dirs = {
		"~/Flexfiles",
		"~/projects",
	}, -- table of dirs that the plugin will auto-save and auto-load from
	ignored_dirs = nil, -- table of dirs that are ignored when auto-saving and auto-loading
	telescope = { -- options for the telescope extension
		reset_prompt_after_deletion = true, -- whether to reset prompt after session deleted
	},
})

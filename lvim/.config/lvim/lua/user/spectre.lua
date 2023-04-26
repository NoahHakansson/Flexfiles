--
-- spectre.nvim is a search and replace plugin for Neovim. It is inspired by the Spectre plugin for VSCode.
--

local ok, spectre = pcall(require, "spectre")
if not ok then
	return
end

spectre.setup({
	default = {
		find = {
			--pick one of item in find_engine
			cmd = "rg",
			options = { "ignore-case" },
		},
		replace = {
			--pick one of item in replace_engine
			cmd = "sed",
		},
	},
})

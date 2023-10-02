--
-- copilot setup config
--

local ok, copilot = pcall(require, "copilot")
if not ok then
	return
end

lvim.keys.normal_mode["<M-t>"] = "<cmd>lua require('copilot.suggestion').toggle_auto_trigger()<CR>"

-- Copilot setup
copilot.setup({
	suggestion = {
		enabled = true,
		auto_trigger = true,
		debounce = 75,
		keymap = {
			accept = "<M-b>",
			accept_word = "<M-w>",
			accept_line = "<M-a>",
			next = "<c-j>",
			prev = "<c-k>",
			dismiss = "<C-d>",
		},
	},
})

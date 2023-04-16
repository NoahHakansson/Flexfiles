--
-- copilot setup config
--

local ok, copilot = pcall(require, "copilot")
if not ok then
	return
end

copilot.setup({
	suggestion = {
		enabled = true,
		auto_trigger = true,
		debounce = 75,
		keymap = {
			accept = "<M-b>",
			accept_word = false,
			accept_line = false,
			next = "<M-]>",
			prev = "<M-[>",
			dismiss = "<C-]>",
		},
	},
})

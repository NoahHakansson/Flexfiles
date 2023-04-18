--
-- flote.nvim setup config
--

local ok, flote = pcall(require, "flote")
if not ok then
	return
end

flote.setup({
	q_to_quit = true,
	window_style = "",
	window_border = "single",
	window_title = true, -- requires neovim >= 0.9.0
})

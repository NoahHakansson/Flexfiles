--
-- lualine.nvim config
--

-- lualine set to show current vim mode
local mode = {
	"mode",
	padding = { left = 1, right = 1 },
	color = { gui = "bold" },
	cond = nil,
}
lvim.builtin.lualine.sections.lualine_a = { mode }

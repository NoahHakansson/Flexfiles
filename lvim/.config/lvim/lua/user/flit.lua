--
-- flit.nvim extends f/F and t/T with leap.nvim
--

local ok, flit = pcall(require, "flit")
if not ok then
	return
end

flit.setup({
	keys = { f = "f", F = "F", t = "t", T = "T" },
	-- A string like "nv", "nvo", "o", etc.
	labeled_modes = "nvo",
	multiline = true,
	-- Like `leap`s similar argument (call-specific overrides).
	-- E.g.: opts = { equivalence_classes = {} }
	opts = {},
})

--
-- templ language server setup
--

vim.filetype.add({
	extension = {
		templ = "templ",
	},
})

require("lvim.lsp.manager").setup("templ")

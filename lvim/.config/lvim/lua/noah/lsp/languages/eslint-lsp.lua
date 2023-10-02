--
-- eslint lsp
--

require("lvim.lsp.manager").setup("eslint", {
	on_attach = function(_, bufnr)
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = bufnr,
			command = "EslintFixAll",
		})
	end,
	settings = {
		format = false,
	},
})

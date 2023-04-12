--
-- Emmet lsp settings
--

-- emmet capabilities
-- snippet support
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
-- setup emmet-ls
require("lvim.lsp.manager").setup("emmet_ls", {
	cmd = { vim.fn.stdpath("data") .. "/mason/bin/emmet-ls", "--stdio" },
	capabilities = capabilities,
	filetypes = {
		"html",
		"svelte",
		"vue",
		-- "typescript",
		-- "javascript",
		"javascriptreact",
		"typescriptreact",
		"php",
		"xml",
		"css",
		"less",
		"postcss",
		"sass",
		"scss",
	},
	root_dir = function()
		return vim.loop.cwd()
	end,
})

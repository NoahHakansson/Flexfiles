require("noah.lsp.languages.golang")
require("noah.lsp.languages.emmet")
require("noah.lsp.languages.marksman")
-- require("noah.lsp.languages.eslint-lsp")
--
-- generic LSP settings <https://www.lunarvim.org/docs/languages#lsp-support>
--

-- --- disable automatic installation of servers
-- lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---see the full default list `:lua =lvim.lsp.automatic_configuration.skipped_servers`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- servers to configure manually
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "gopls" })
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "tsserver" })

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{ name = "beautysh" },
	-- { name = "black", },
	{ name = "autopep8" },
	{ name = "gofumpt" },
	{ name = "stylua" },
	{ name = "eslint_d" },
	{
		name = "prettier",
		---@usage arguments to pass to the formatter
		-- these cannot contain whitespace
		-- options such as `--line-width 80` become either `{"--line-width", "80"}` or `{"--line-width=80"}`
		-- args = { "--print-width", "100" },
		---@usage only start in these filetypes, by default it will attach to all filetypes it supports
		filetypes = { "markdown" },
	},
	-- { name = "isort", },
	-- { name = "yamlfmt", },
})

-- set additional linters
local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
	{ name = "revive" }, -- Golang linter
	-- { name = "staticcheck", }, -- Golang linter
	-- { name = "golangci_lint", },
	{ name = "yamllint" },
	{ name = "shellcheck" },
	{ name = "zsh" },
	{ name = "eslint_d" },
})

local code_actions = require("lvim.lsp.null-ls.code_actions")
code_actions.setup({
	{
		exe = "eslint_d",
		filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact", "vue" },
	},
})

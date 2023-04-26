--
-- typescript.lua (typescript.nvim)
--

local ok, typescript = pcall(require, "typescript")
if not ok then
	return
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()

typescript.setup({
	disable_commands = false, -- prevent the plugin from creating Vim commands
	debug = false, -- enable debug logging for commands
	go_to_source_definition = {
		fallback = true, -- fall back to standard LSP definition on failure
	},
	server = {
		init_options = {
			preferences = {
				importModuleSpecifierPreference = "project-relative",
			},
		},
		capabilities = capabilities,
	},
})

--
-- GoLang lsp settings
--

-- add go.mod, go.sum and main.go as a glob pattern match to find go project root and set CWD to it.
table.insert(lvim.builtin.project.patterns, "main.go")
table.insert(lvim.builtin.project.patterns, "go.mod")
table.insert(lvim.builtin.project.patterns, "go.sum")

-- ovverrided default gopls server settings
require("lvim.lsp.manager").setup("gopls", {
	settings = {
		gopls = {
			gofumpt = true,
			usePlaceholders = true,
			completeUnimported = true,
			matcher = "Fuzzy",
			diagnosticsDelay = "200ms",
			symbolMatcher = "fuzzy",
			buildFlags = { "-tags", "integration" },
			-- codelenses
			codelenses = {
				generate = true, -- show the `go generate` lens.
				gc_details = true, -- Show a code lens toggling the display of gc's choices.
				test = true,
				tidy = true,
				vendor = true,
				regenerate_cgo = true,
				upgrade_dependency = true,
			},
			-- hints
			hints = {
				assignVariableTypes = true,
				compositeLiteralFields = true,
				compositeLiteralTypes = true,
				constantValues = true,
				functionTypeParameters = true,
				parameterNames = true,
				rangeVariableTypes = true,
			},
		},
	},
})

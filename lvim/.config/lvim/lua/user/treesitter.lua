--
-- Treesitter config
--

-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = true

-- always installed on startup, useful for parsers without a strict filetype
lvim.builtin.treesitter.ensure_installed = { "comment", "markdown_inline", "regex" }

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

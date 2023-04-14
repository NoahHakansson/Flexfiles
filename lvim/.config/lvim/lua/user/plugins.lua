--
-- Additional Plugins
--
lvim.plugins = {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		build = ":CatppuccinCompile",
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},
	{ "folke/zen-mode.nvim", event = "VeryLazy" },
	{ "JellyApple102/flote.nvim", event = "VeryLazy" },
	{ "mbbill/undotree", event = "VeryLazy" },
	-- dim highlighting of unused functions, variables, parameters and more
	-- {
	-- 	"zbirenbaum/neodim",
	-- 	event = "LspAttach",
	-- 	config = function()
	-- 		require("neodim").setup({
	-- 			alpha = 0.75,
	-- 			blend_color = "#000000",
	-- 			update_in_insert = {
	-- 				enable = true,
	-- 				delay = 100,
	-- 			},
	-- 			hide = {
	-- 				virtual_text = false,
	-- 				signs = false,
	-- 				underline = false,
	-- 			},
	-- 		})
	-- 	end,
	-- },
	{
		"jose-elias-alvarez/typescript.nvim",
		config = function()
			require("typescript").setup({
				disable_commands = false, -- prevent the plugin from creating Vim commands
				debug = false, -- enable debug logging for commands
				go_to_source_definition = {
					fallback = true, -- fall back to standard LSP definition on failure
				},
			})
		end,
	},
	-- Github copilot
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		dependencies = "nvim-treesitter/nvim-treesitter",
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = "nvim-treesitter/nvim-treesitter",
	},
	{ "sainnhe/gruvbox-material" },
	-- smart identation
	{ "tpope/vim-sleuth" },
	-- Git-related plugins
	{
		"pwntester/octo.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		event = "VeryLazy",
		config = function()
			require("octo").setup()
		end,
	},
	{ "tpope/vim-fugitive" },
	{ "ThePrimeagen/harpoon" },
	{ "tpope/vim-rhubarb" },
	-- { "tpope/vim-obsession" }, -- basic session management
	{ "olimorris/persisted.nvim", lazy = false }, -- better session management with git branch support
	{ "tommcdo/vim-fugitive-blame-ext" },
	{ "petertriho/nvim-scrollbar" },
	-- misc
	{ "RishabhRD/popfix" },
	{ "dagle/nvim-cheat.sh", event = "VeryLazy" },
	{
		"iamcco/markdown-preview.nvim",
		event = "VeryLazy",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
	{
		"AckslD/nvim-neoclip.lua",
		event = "VeryLazy",
		dependencies = {
			{ "nvim-telescope/telescope.nvim" },
		},
	},
	-- ## tmux.nvim
	-- Sync copy registers of tmux and neovim
	-- allows you to copy from tmux to neovim and vice versa
	-- as well as copy from neovim in on tmux pane or session to another
	-- Also allows navigation with C-hjkl between tmux panes and neovim splits
	-- Also allows you to resize neovim and tmux splits with Alt-hjkl (disabled by me)
	{ "aserowy/tmux.nvim" },
	-- { "rcarriga/nvim-dap-ui" },
	{ "ojroques/nvim-bufdel" },
	{ "kevinhwang91/nvim-bqf" },
	{
		"folke/todo-comments.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		event = "VeryLazy",
		config = function()
			require("todo-comments").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
			})
		end,
	},
	{
		"ray-x/go.nvim",
		config = function()
			require("go").setup({
				comment_placeholder = "",
			})
		end,
		dependencies = "ray-x/guihua.lua",
	},
	{ "j-hui/fidget.nvim" },
	-- lsp navigator
	-- {
	-- 	"ray-x/navigator.lua",
	-- 	dependencies = {
	-- 		{ "ray-x/guihua.lua", run = "cd lua/fzy && make" },
	-- 		{ "neovim/nvim-lspconfig" },
	-- 	},
	-- 	-- config = function()
	-- 	-- 	require("navigator").setup({
	-- 	-- 		mason = true,
	-- 	-- 	})
	-- 	-- end,
	-- },
	{
		"sindrets/diffview.nvim",
		event = "BufRead",
	},
	-- end Git-related plugins
	-- {"p00f/nvim-ts-rainbow"},
	-- The GOAT lsp_signature
	{ "ray-x/lsp_signature.nvim" },
	{
		"Badhi/nvim-treesitter-cpp-tools",
		dependencies = "nvim-treesitter/nvim-treesitter",
	},
	{
		"danymat/neogen",
		config = function()
			require("neogen").setup()
		end,
		dependencies = "nvim-treesitter/nvim-treesitter",
	},
	{
		"gbprod/substitute.nvim",
		config = function()
			require("substitute").setup()
		end,
	},
	-- half buggy colorizer (May require running ':ColorizerReloadAllBuffers' if it bugs out.)
	{ "norcalli/nvim-colorizer.lua" },
	-- ###
	-- ### Random uselss things, like a tetris game in neovim ###
	-- ###
	-- nvim-tetris
	{ "alec-gibson/nvim-tetris", event = "VeryLazy" },
	-- cellular-automaton animations
	{ "eandrju/cellular-automaton.nvim", event = "VeryLazy" },
	-- vim-be-good get better at vim navigation
	{ "ThePrimeagen/vim-be-good", event = "VeryLazy" },
	--- ### end random uselss things
}

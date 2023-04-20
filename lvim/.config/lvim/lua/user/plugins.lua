--
-- Additional Plugins
--
lvim.plugins = {
	{
		"catppuccin/nvim",
		lazy = false,
		priority = 1000,
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
	-- { "lvimuser/lsp-inlayhints.nvim" }, -- TODO: this is not working
	{ "NvChad/nvim-colorizer.lua" },
	{
		"leoluz/nvim-dap-go",
		ft = { "go", "gomod" },
	},
	{ "tpope/vim-repeat" },
	{ "monaqa/dial.nvim" },
	{ "stevearc/dressing.nvim", event = "VeryLazy" },
	{ "folke/zen-mode.nvim", cmd = "ZenMode" },
	{ "JellyApple102/flote.nvim", event = "VeryLazy" },
	{ "mbbill/undotree", event = "VeryLazy" },
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
	-- { "sainnhe/gruvbox-material" },
	-- smart identation
	{ "tpope/vim-sleuth" },
	-- Git-related plugins
	{
		"pwntester/octo.nvim",
		cmd = "Octo",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("octo").setup()
		end,
	},
	{
		"tpope/vim-fugitive",
		cmd = { "G", "GBrowse" },
	},
	{ "ThePrimeagen/harpoon" },
	{ "tpope/vim-rhubarb" },
	-- { "tpope/vim-obsession" }, -- basic session management
	{ "olimorris/persisted.nvim" }, -- better session management with git branch support
	{
		"tommcdo/vim-fugitive-blame-ext",
		dependencies = "tpope/vim-fugitive",
	},
	{ "petertriho/nvim-scrollbar" },
	-- misc
	{ "RishabhRD/popfix" },
	{ "dagle/nvim-cheat.sh", cmd = "Cheat" },
	{
		"iamcco/markdown-preview.nvim",
		ft = "markdown",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
	{
		"AckslD/nvim-neoclip.lua",
		init = function()
			vim.api.nvim_create_user_command("NeoclipOpen", function()
				require("telescope").extensions.neoclip.default()
			end, {})
		end,
		cmd = "NeoclipOpen",
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
	{ "aserowy/tmux.nvim", lazy = true },
	-- { "rcarriga/nvim-dap-ui" },
	-- { "ojroques/nvim-bufdel" }, -- better buffer deletion, delete buffers without closing windows
	{ "kevinhwang91/nvim-bqf", ft = "qf" },
	{
		"folke/todo-comments.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		cmd = { "TodoTelescope", "TodoQuickFix" },
		config = function()
			require("todo-comments").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
			})
		end,
	},
	{
		"ray-x/go.nvim",
		dependencies = { -- optional packages
			"ray-x/guihua.lua",
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		ft = { "go", "gomod" },
		config = function()
			require("go").setup({
				comment_placeholder = "",
			})
		end,
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
		cmd = "Neogen",
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
	-- ###
	-- ### Random uselss things, like a tetris game in neovim ###
	-- ###
	-- nvim-tetris
	{
		"alec-gibson/nvim-tetris",
		cmd = "Tetris",
	},
	-- cellular-automaton animations
	{
		"eandrju/cellular-automaton.nvim",
		cmd = "CellularAutomaton",
	},
	-- vim-be-good get better at vim navigation
	{
		"ThePrimeagen/vim-be-good",
		cmd = "VimBeGood",
	},
	--- ### end random uselss things
}

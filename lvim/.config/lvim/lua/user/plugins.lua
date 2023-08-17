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
		lazy = true,
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},
	{
		"sustech-data/wildfire.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("wildfire").setup()
		end,
	},
	{
		"NvChad/nvim-colorizer.lua",
		lazy = true,
		event = "VeryLazy",
	},
	{
		"leoluz/nvim-dap-go",
		ft = { "go", "gomod" },
	},
	{ "tpope/vim-repeat" },
	{ "monaqa/dial.nvim", event = "VeryLazy" },
	{ "stevearc/dressing.nvim", event = "VeryLazy" },
	{ "folke/zen-mode.nvim", cmd = "ZenMode" },
	{ "JellyApple102/flote.nvim", event = "VeryLazy" },
	{ "mbbill/undotree", event = "VeryLazy" },
	-- leap and flit
	{
		"ggandor/leap.nvim",
		lazy = true,
		event = "VeryLazy",
	},
	{
		"ggandor/flit.nvim",
		lazy = true,
		event = "VeryLazy",
		dependencies = "ggandor/leap.nvim",
	},
	{ -- search/replace in multiple files
		"nvim-pack/nvim-spectre",
		dependencies = "nvim-lua/plenary.nvim",
		lazy = true,
		event = "VeryLazy",
	},
	-- Fix TSSERVER ...
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		opts = {},
	},
	-- {
	-- 	"jose-elias-alvarez/typescript.nvim",
	-- 	dependencies = "neovim/nvim-lspconfig",
	-- 	-- only load on javascript and typescript files
	-- 	ft = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
	--- TODO: manually setup TSSERVER to avoid getting double diagnostics in buffer from server and eslint_d},
	-- Github copilot
	{
		"zbirenbaum/copilot.lua",
		event = "InsertEnter",
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		lazy = true,
		event = "BufRead",
		dependencies = "nvim-treesitter/nvim-treesitter",
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		lazy = true,
		event = "BufRead",
		dependencies = "nvim-treesitter/nvim-treesitter",
	},
	-- { "sainnhe/gruvbox-material" },
	-- smart identation
	{
		"tpope/vim-sleuth",
		lazy = true,
		event = "BufRead",
	},
	-- Git-related plugins
	{
		"pwntester/octo.nvim",
		lazy = true,
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
		lazy = true,
		event = "VeryLazy",
	},
	{
		"tpope/vim-rhubarb",
		lazy = true,
		dependencies = "tpope/vim-fugitive",
		event = "VeryLazy",
	},
	{
		"tommcdo/vim-fugitive-blame-ext",
		lazy = true,
		event = "VeryLazy",
		dependencies = "tpope/vim-fugitive",
	},
	{
		"ThePrimeagen/harpoon",
		lazy = true,
		event = "VeryLazy",
	},
	-- { "tpope/vim-obsession" }, -- basic session management
	{ "olimorris/persisted.nvim", lazy = false }, -- better session management with git branch support
	{
		"petertriho/nvim-scrollbar",
		lazy = true,
		event = "VeryLazy",
	},
	-- misc
	{ "RishabhRD/popfix", event = "VeryLazy" },
	{ "dagle/nvim-cheat.sh", cmd = "Cheat" },
	{
		"iamcco/markdown-preview.nvim",
		lazy = true,
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
		lazy = true,
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
	{
		"aserowy/tmux.nvim",
		lazy = true,
		event = "VeryLazy",
	},
	-- { "rcarriga/nvim-dap-ui" },
	-- { "ojroques/nvim-bufdel" }, -- better buffer deletion, delete buffers without closing windows
	{
		"kevinhwang91/nvim-bqf",
		lazy = true,
		ft = "qf",
	},
	{
		"folke/todo-comments.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		cmd = { "TodoTelescope", "TodoQuickFix" },
		lazy = true,
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
		lazy = true,
		ft = { "go", "gomod" },
		config = function()
			require("go").setup({
				comment_placeholder = "",
			})
		end,
	},
	{ "j-hui/fidget.nvim", event = "VeryLazy", version = "legacy" },
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
		lazy = true,
		cmd = "DiffviewOpen",
	},
	-- end Git-related plugins
	-- {"p00f/nvim-ts-rainbow"},
	-- The GOAT lsp_signature
	{ "ray-x/lsp_signature.nvim", event = "InsertEnter" },
	{
		"Badhi/nvim-treesitter-cpp-tools",
		dependencies = "nvim-treesitter/nvim-treesitter",
		ft = { "cpp", "c", "objc", "objcpp" },
	},
	{
		"danymat/neogen",
		lazy = true,
		cmd = "Neogen",
		config = function()
			require("neogen").setup()
		end,
		dependencies = "nvim-treesitter/nvim-treesitter",
	},
	{
		"gbprod/substitute.nvim",
		lazy = true,
		event = "VeryLazy",
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
		lazy = true,
		cmd = "Tetris",
	},
	-- cellular-automaton animations
	{
		"eandrju/cellular-automaton.nvim",
		lazy = true,
		cmd = "CellularAutomaton",
	},
	-- vim-be-good get better at vim navigation
	{
		"ThePrimeagen/vim-be-good",
		lazy = true,
		cmd = "VimBeGood",
	},
	--- ### end random uselss things
}

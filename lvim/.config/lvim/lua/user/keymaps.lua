--
-- Keymappings [view all the defaults by pressing <leader>Lk]
--

lvim.leader = "space"
-- switch between last two buffers
lvim.keys.normal_mode["<space><space>"] = "<C-^>"
-- Yank to system clipboard
lvim.keys.visual_mode["<space>y"] = '"+y'
-- shift+q unbind
lvim.keys.normal_mode["<S-q>"] = ""
-- step through buffers
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
-- vertical resize of buffer windows
lvim.keys.normal_mode["<S-Right>"] = ":vertical resize +2px<CR>"
lvim.keys.normal_mode["<S-Left>"] = ":vertical resize -2px<CR>"
-- lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- unmap a default keymapping
-- lvim.keys.normal_mode["<C-s>"] = false
-- 'jk' for quitting insert mode
lvim.keys.insert_mode["jk"] = false
-- 'kj' for quitting insert mode
lvim.keys.insert_mode["kj"] = false
-- 'jj' for quitting insert mode
lvim.keys.insert_mode["jj"] = false
--
-- Nice quality of life vim binds
--
-- Turn off highlight when pressing Esc
-- TODO: change to neovim keybinds
vim.cmd("nmap <silent> <Esc> :noh <CR>")
-- Quality of life rebinds
-- Center next search
vim.cmd("nnoremap n nzzzv")
vim.cmd("nnoremap N Nzzzv")
-- create undo step at following seperators
vim.cmd("inoremap , ,<c-g>u")
vim.cmd("inoremap . .<c-g>u")
vim.cmd("inoremap ! !<c-g>u")
vim.cmd("inoremap ? ?<c-g>u")

-- ### Harpoon bindings ###
-- harpoon toogle quick menu
lvim.keys.normal_mode["<C-f>"] = "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>"
-- harpoon add file
lvim.keys.normal_mode["<C-s>"] = "<cmd>lua require('harpoon.mark').add_file()<cr>"
lvim.builtin.which_key.mappings["a"] = { "<cmd>lua require('harpoon.mark').add_file()<cr>", "Harpoon add file" }
-- harpoon switch to file one
lvim.keys.normal_mode["<M-j>"] = "<cmd>lua require('harpoon.ui').nav_file(1)<cr>"
-- harpoon switch to file two
lvim.keys.normal_mode["<M-k>"] = "<cmd>lua require('harpoon.ui').nav_file(2)<cr>"

-- ### Flote project notes bindings ###
lvim.builtin.which_key.mappings["n"] = { "<cmd>Flote<CR>", "Flote project notes" }

-- ### Markdown preview bindings ###
lvim.builtin.which_key.mappings["m"] = {
	name = "Markdown preview",
	m = { "<cmd>MarkdownPreview<CR>", "Start Markdown preview" },
	s = { "<cmd>MarkdownPreviewStop<CR>", "Stop markdown preview" },
}

-- ### go.nvim and Go bindings ###
lvim.builtin.which_key.mappings["G"] = {
	name = "GO/Golang",
	r = { "<cmd>GoRun -F<cr>", "`go run .`(In floating window)" },
	e = { "<cmd>GoIfErr<cr>", "Add if err" },
	l = { "<cmd>GoLint<cr>", "Lint (golangci-lint)" },
	o = { "<cmd>GoPkgOutline<cr>", "Symbol outline" },
	s = { "<cmd>GoAlt<cr>", "Switch between go and test file" },
	p = { "<cmd>GoCmt<cr>", "Add placeholder comment" },
	["/"] = { "<cmd>GoCmt<cr>", "Generate placeholder comment" },
	m = {
		name = "Modify tags",
		a = { "<cmd>GoAddTag<cr>", "Add tag" },
		r = { "<cmd>GoRmTag<cr>", "Remove tag" },
		c = { "<cmd>GoClearTag<cr>", "Clear tag" },
	},
	t = {
		name = "Test",
		T = { "<cmd>GoTest<cr>", "go test ./... (Fail or pass, no window)" },
		t = { "<cmd>GoTest -F<cr>", "go test ./... (Opens floating window)" },
		p = { "<cmd>GoTestPkg -F<cr>", "Test package" },
		f = { "<cmd>GoTestFunc -F<cr>", "Test function" },
		c = { "<cmd>GoTestFile -F<cr>", "Test current file" },
	},
	d = {
		name = "Debug",
		d = { "<cmd>GoDebug<cr>", "Start debug session" },
		s = { "<cmd>GoDbgStop<cr>", "Stop/Exit debug session" },
		r = { "<cmd>GoDebug -R<cr>", "Restart debug session" },
		n = { "<cmd>GoDebug -n<cr>", "Start debug session for nearest go test function" },
		p = { "<cmd>GoDebug -p<cr>", "Launch package test and start debug" },
		b = { "<cmd>GoBreakToggle<cr>", "Toogle breakpoint" },
		c = { "<cmd>GoDbgContinue<cr>", "Continue debug session" },
		k = { "<cmd>GoDbgKeys<cr>", "show debug keymaps in a floating window (guihua)" },
		h = { "<cmd>GoDebug -h<cr>", "Show help info" },
	},
	c = {
		name = "Coverage",
		c = { "<cmd>GoCoverage<cr>", "Test coverage" },
		q = { "<cmd>GoCoverage -m<cr>", "Test coverage to quickfix" },
		t = { "<cmd>GoCoverage -t<cr>", "Toogle signs" },
	},
}

-- rebind ToggleTerminal Terminal
lvim.builtin.terminal.open_mapping = [[<c-x>]]

-- Git bindings
lvim.builtin.which_key.mappings["g"] = {
	name = "Git",
	j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
	k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
	l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
	p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
	r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
	R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
	f = { "<cmd>G<cr>", "Fugitive" },
	w = { "<cmd>GBrowse<cr>", "Open file in browser" },
	u = {
		"<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
		"Undo Stage Hunk",
	},
	o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
	b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
	c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
	C = {
		"<cmd>Telescope git_bcommits<cr>",
		"Checkout commit(for current file)",
	},
}

-- Diffview plugin binds
lvim.builtin.which_key.mappings["gd"] = {
	name = "Diffview",
	d = { "<cmd>DiffviewOpen<cr>", "Open Diffview" },
	h = { "<cmd>DiffviewFileHistory<cr>", "Open DiffviewFileHistory" },
	c = { "<cmd>DiffviewClose<cr>", "Close Diffview" },
	t = { "<cmd>DiffviewToggleFiles<cr>", "Toggle the files panel" },
	f = { "DiffviewFocusFiles", "Bring focus to the files panel" },
	r = { "DiffviewRefresh", "refresh Diffview" },
}

-- Octo.nvim plugin
lvim.builtin.which_key.mappings["o"] = {
	name = "Octo (GitHub PRs/Issues)",
	p = {
		name = "Pull Request",
		l = { "<cmd>Octo pr list<cr>", "List PRs" },
		s = { "<cmd>Octo review start<cr>", "Start PR review" },
		r = { "<cmd>Octo review resume<cr>", "Resume PR review" },
		c = { "<cmd>Octo review commit<cr>", "Review specific commit" },
		p = { "<cmd>Octo review submit<cr>", "Submit the review" },
		["/"] = { "<cmd>Octo review comments<cr>", "Review pending comments" },
	},
}

-- Substitue plugin
vim.api.nvim_set_keymap("n", "s", "<cmd>lua require('substitute').operator()<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "ss", "<cmd>lua require('substitute').line()<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "S", "<cmd>lua require('substitute').eol()<cr>", { noremap = true })
vim.api.nvim_set_keymap("x", "s", "<cmd>lua require('substitute').visual()<cr>", { noremap = true })

-- Trouble.nvim plugin
lvim.builtin.which_key.mappings["t"] = {
	name = "Diagnostics",
	t = { "<cmd>TroubleToggle<cr>", "trouble" },
	w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "workspace" },
	d = { "<cmd>TroubleToggle document_diagnostics<cr>", "document" },
	q = { "<cmd>TroubleToggle quickfix<cr>", "quickfix" },
	l = { "<cmd>TroubleToggle loclist<cr>", "loclist" },
	r = { "<cmd>TroubleToggle lsp_references<cr>", "references" },
}

-- cheat.sh plugin bind
lvim.builtin.which_key.mappings["?"] = {
	"<cmd>Cheat<CR>",
	"Cheat.sh",
}

-- undotree which key bind
lvim.builtin.which_key.mappings["u"] = {
	-- toggle undotree and focus on it
	"<cmd>UndotreeToggle | UndotreeFocus<CR>",
	"Undo Tree",
}

-- neoclip which key bind
lvim.builtin.which_key.mappings['"'] = {
	"<cmd>lua require('telescope').extensions.neoclip.default()<CR>",
	"Neoclip",
}

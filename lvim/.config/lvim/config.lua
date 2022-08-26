--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- Settings
vim.opt.clipboard = ""
vim.opt.showmode = false
vim.opt.scrolloff = 15
vim.opt.wrap = true
-- vim.opt.mouse = ""

-- Transparency
lvim.transparent_window = false

-- lualine set to show current vim mode
local mode = {
  "mode",
  padding = { left = 1, right = 1 },
  color = { gui = "bold" },
  cond = nil,
}
lvim.builtin.lualine.sections.lualine_a = { mode }

-- Fix Enter<CR> suggestion accept bug
local cmp = require("cmp")
lvim.builtin.cmp.mapping['<CR>'] = cmp.mapping.preset.insert(cmp.mapping.confirm({ select = true }))

-- general
lvim.log.level = "warn"
lvim.format_on_save = true
-- lvim.colorscheme = "gruvbox-material"
lvim.colorscheme = "onedarker"
vim.g.gruvbox_material_background = "hard"
vim.g.gruvbox_material_palette = "mix"


-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
-- switch between last two buffers
lvim.keys.normal_mode["<space><space>"] = "<C-^>"
-- Yank to system clipboard
lvim.keys.visual_mode["<space>y"] = '"+y'
-- shift+q unbind
lvim.keys.normal_mode["<S-q>"] = ""
-- lvim.keys.normal_mode["<S-l>"] = ":bnext<CR>"
-- lvim.keys.normal_mode["<S-h>"] = ":bprev<CR>"
-- vim.cmd('vnoremap <leader>y "+y')
-- vim.cmd("nnoremap <leader><leader> <c-^>")
-- lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- unmap a default keymapping
-- lvim.keys.normal_mode["<C-s>"] = false
-- 'jk' for quitting insert mode
lvim.keys.insert_mode["jk"] = false
-- 'kj' for quitting insert mode
lvim.keys.insert_mode["kj"] = false
-- 'jj' for quitting insert mode
lvim.keys.insert_mode["jj"] = false
-- edit a default keymapping

-- Harpoon bindings
lvim.keys.normal_mode["<C-f>"] = "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>"
-- lvim.keys.normal_mode["<C-h>"] = "<cmd>lua require('harpoon.mark').add_file()<cr>"
lvim.builtin.which_key.mappings["m"] = { "<cmd>lua require('harpoon.mark').add_file()<cr>", "Harpoon mark file" }
-- lvim.keys.normal_mode["<S-l>"] = "<cmd>lua require('harpoon.ui').nav_next()<cr>"
-- lvim.keys.normal_mode["<S-h>"] = "<cmd>lua require('harpoon.ui').nav_prev()<cr>"
lvim.builtin.which_key.mappings["1"] = { "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", "Harpoon 1" }
lvim.builtin.which_key.mappings["2"] = { "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", "Harpoon 2" }
lvim.builtin.which_key.mappings["3"] = { "<cmd>lua require('harpoon.ui').nav_file(3)<cr>", "Harpoon 3" }
lvim.builtin.which_key.mappings["4"] = { "<cmd>lua require('harpoon.ui').nav_file(4)<cr>", "Harpoon 4" }
lvim.builtin.which_key.mappings["5"] = { "<cmd>lua require('harpoon.ui').nav_file(5)<cr>", "Harpoon 5" }


-- rebind ToggleTerminal Terminal
lvim.builtin.terminal.open_mapping = [[<c-x>]]

lvim.builtin.which_key.mappings["g"] = {
  name = "Git",
  j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
  k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
  l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
  p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
  r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
  R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
  f = { "<cmd>G<cr>", "Fugitive" },
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
  d = { "<cmd>DiffviewOpen<cr>", "Open Diffview", },
  h = { "<cmd>DiffviewFileHistory<cr>", "Open DiffviewFileHistory", },
  c = { "<cmd>DiffviewClose<cr>", "Close Diffview", },
  t = { "<cmd>DiffviewToggleFiles<cr>", "Toggle the files panel" },
  f = { "DiffviewFocusFiles", "Bring focus to the files panel" },
  r = { "DiffviewRefresh", "refresh Diffview" },
}


-- auto hybrid line numbers
vim.cmd([[
:set number

:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
:  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
:augroup END
]])

-- Bind vim fugitive to which_key <leader>gs
-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
local _, actions = pcall(require, "telescope.actions")
-- lvim.builtin.telescope.file_ignore_patterns = {".cach"}
lvim.builtin.telescope.defaults.mappings = {
  -- for input mode
  i = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
    ["<C-n>"] = actions.cycle_history_next,
    ["<C-p>"] = actions.cycle_history_prev,
  },
  -- for normal mode
  n = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
  },
}
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["h"] = { ":ClangdSwitchSourceHeader<CR>", "Switch Source/Header" }
lvim.builtin.which_key.mappings["7"] = { "<cmd>lua require('Comment.api').toggle_current_linewise()<CR>", "Comment" }
lvim.builtin.which_key.vmappings["7"] = { "<ESC><CMD>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>",
  "Comment" }

-- Search and replace
-- lvim.builtin.which_key.mappings["r"] = {
--   ":%s/pattern/replace/gc", "Search and replace"
-- }

-- gitsigns
lvim.builtin.gitsigns.opts.signs.add.text = "+"
lvim.builtin.gitsigns.opts.signs.change.text = "~"
lvim.builtin.gitsigns.opts.signs.delete.text = "-"
lvim.builtin.gitsigns.opts.signs.topdelete.text = "-"
lvim.builtin.gitsigns.opts.signs.changedelete.text = "~"


--
-- Nice old vim binds
--
-- Turn off highlight when pressing Esc
vim.cmd("nmap <silent> <Esc> :noh <CR>")
-- Remaps for swedish keyboard layout.
-- Normal + (visual+select) + operator pending mode
vim.cmd("map § $")
-- Fix alt to function like altGr for important keys.
-- Normal + (visual+select) + operator pending mode
vim.cmd("map <M-0> }")
vim.cmd("map <M-7> {")
vim.cmd("map <M-9> ]")
vim.cmd("map <M-8> [")
-- Insert + command-line mode
vim.cmd("map! <M-0> }")
vim.cmd("map! <M-7> {")
vim.cmd("map! <M-9> ]")
vim.cmd("map! <M-8> [")


-- Quality of life rebinds
-- Center next search
vim.cmd("nnoremap n nzzzv")
vim.cmd("nnoremap N Nzzzv")
-- create undo step at following seperators
vim.cmd("inoremap , ,<c-g>u")
vim.cmd("inoremap . .<c-g>u")
vim.cmd("inoremap ! !<c-g>u")
vim.cmd("inoremap ? ?<c-g>u")

-- Yank to system clipboard
-- vim.cmd('vnoremap <leader>y "+y')

-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["t"] = {
--   name = "+Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnostics" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnostics" },
-- }

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
-- Configure builtin plugins
lvim.builtin.alpha.active = true
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true

lvim.builtin.nvimtree.setup.view.side = "left"
-- lvim.builtin.nvimtree.show_icons.git = 0

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "cpp",
  "markdown",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "rust",
  "java",
  "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

-- generic LSP settings

-- -- make sure server will always be installed even if the server is in skipped_servers list
-- lvim.lsp.installer.setup.ensure_installed = {
--     "sumeko_lua",
--     "jsonls",
-- }
-- -- change UI setting of `LspInstallInfo`
-- -- see <https://github.com/williamboman/nvim-lsp-installer#default-configuration>
-- lvim.lsp.installer.setup.ui.check_outdated_servers_on_open = false
-- lvim.lsp.installer.setup.ui.border = "rounded"
-- lvim.lsp.installer.setup.ui.keymaps = {
--     uninstall_server = "d",
--     toggle_server_expand = "o",
-- }

-- ---@usage disable automatic installation of servers
-- lvim.lsp.automatic_servers_installation = false

-- ---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
-- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. !!Requires `:LvimCacheReset` to take effect!!
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- vim.tbl_map(function(server)
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


-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  -- {
  --   -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
  --   command = "gofmt",
  --   ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
  --   filetypes = {"go", "gomod", "gotmpl"},
  -- },
  {
    -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
    command = "prettier",
    ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
    filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact", "vue" },
  },
}

-- set additional linters
-- local null_ls = require "null-ls"
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  -- {
  --   name = "golangci_lint",
  --   method = null_ls.methods.DIAGNOSTICS,
  --   ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
  --   filetypes = {"go", "gomod", "gotmpl"},
  -- },
  {
    command = "eslint_d",
    ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
    filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact", "vue" },
  },
}

local code_actions = require "lvim.lsp.null-ls.code_actions"
code_actions.setup {
  {
    exe = "eslint_d",
    filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact", "vue" },
  },
}

-- Rainbow
-- lvim.builtin.treesitter.rainbow = {
--   enable = false,
--   extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
--   max_file_lines = 2000, -- Do not enable for files with more than 1000 lines, int
-- }

-- Additional plugin binds
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
  "<cmd>Cheat<CR>", "Cheat.sh"
}

-- unbind <M-x> in insert mode
-- vim.api.nvim_set_keymap("i", "<M-x>", "", {noremap = true})
-- lsp_signature cfg
local signature_cfg = {
  debug = false, -- set to true to enable debug logging
  log_path = vim.fn.stdpath("cache") .. "/lsp_signature.log", -- log dir when debug is on
  -- default is  ~/.cache/nvim/lsp_signature.log
  verbose = false, -- show debug line number

  bind = true, -- This is mandatory, otherwise border config won't get registered.
  -- If you want to hook lspsaga or other signature handler, pls set to false

  doc_lines = 10, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
  -- set to 0 if you DO NOT want any API comments be shown
  -- This setting only take effect in insert mode, it does not affect signature help in normal
  -- mode, 10 by default

  max_height = 12, -- max height of signature floating_window
  max_width = 80, -- max_width of signature floating_window
  wrap = true, -- allow doc/signature text wrap inside floating_window, useful if your lsp return doc/sig is too long

  floating_window = true, -- show hint in a floating window, set to false for virtual text only mode

  floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
  -- will set to true when fully tested, set to false will use whichever side has more space
  -- this setting will be helpful if you do not want the PUM and floating win overlap

  floating_window_off_x = 1, -- adjust float windows x position.
  floating_window_off_y = 0, -- adjust float windows y position. e.g -2 move window up 2 lines; 2 move down 2 lines

  close_timeout = 4000, -- close floating window after ms when laster parameter is entered
  fix_pos = false, -- set to true, the floating window will not auto-close until finish all parameters
  hint_enable = true, -- virtual hint enable
  hint_prefix = "🐼 ", -- Panda for parameter, NOTE: for the terminal not support emoji, might crash
  hint_scheme = "String",
  hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
  handler_opts = {
    border = "rounded" -- double, rounded, single, shadow, none
  },

  always_trigger = false, -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58

  auto_close_after = nil, -- autoclose signature float win after x sec, disabled if nil.
  extra_trigger_chars = {}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
  zindex = 200, -- by default it will be on top of all floating windows, set to <= 50 send it to bottom

  padding = '', -- character to pad on left and right of signature can be ' ', or '|'  etc

  transparency = nil, -- disabled by default, allow floating win transparent value 1~100
  shadow_blend = 36, -- if you using shadow as border use this set the opacity
  shadow_guibg = 'Black', -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
  timer_interval = 200, -- default timer check interval set to lower value if you want to reduce latency
  toggle_key = nil, -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'

  select_signature_key = nil, -- cycle to next signature, e.g. '<M-n>' function overloading
  move_cursor_key = nil, -- imap, use nvim_set_current_win to move cursor between current win and floating
}

-- load telescope extensions
-- lvim.builtin.telescope.on_config_done = function(telescope)
-- pcall(telescope.load_extension, "frecency")
-- pcall(telescope.load_extension, "neoclip")
-- any other extensions loading
-- end

-- Additional Plugins
lvim.plugins = {
  { "folke/tokyonight.nvim" },
  { "tpope/vim-surround" },
  { "sainnhe/gruvbox-material" },
  { "olimorris/onedarkpro.nvim" },
  -- smart identation
  { "tpope/vim-sleuth" },
  -- {"Darazaki/indent-o-matic"},
  -- Git-related plugins
  { "tpope/vim-fugitive" },
  { "ThePrimeagen/harpoon" },
  { "tpope/vim-rhubarb" },
  { "tpope/vim-obsession" },
  { "tommcdo/vim-fugitive-blame-ext" },
  { "RishabhRD/popfix" },
  { "dagle/nvim-cheat.sh" },
  {
    "sindrets/diffview.nvim",
    event = "BufRead",
  },
  -- end Git-related plugins
  -- {"p00f/nvim-ts-rainbow"},
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  -- The GOAT lsp_signature
  {
    "ray-x/lsp_signature.nvim",
    config = function()
      require "lsp_signature".setup(signature_cfg)
    end
  },
  { "ellisonleao/glow.nvim" },
  -- Github copilot
  -- {"github/copilot.vim"}, -- only needed for first setup.
  -- {
  --   "zbirenbaum/copilot.lua",
  --   event = "InsertEnter",
  --   config = function ()
  --     vim.schedule(function() require("copilot").setup() end)
  --   end,
  -- },
  -- {
  --   "zbirenbaum/copilot-cmp",
  --   after = {"copilot.lua", "nvim-cmp"},
  -- },
  --
  -- {
  --   "AckslD/nvim-neoclip.lua",
  --   event = "BufWinEnter",
  --   setup = function()
  --     vim.cmd [[packadd telescope.nvim]]
  --   end,
  -- },
  {
    "Badhi/nvim-treesitter-cpp-tools",
    requires = "nvim-treesitter/nvim-treesitter",
  },
  {
    "danymat/neogen",
    config = function()
      require('neogen').setup()
    end,
    requires = "nvim-treesitter/nvim-treesitter",
  },
  {
    "nvim-telescope/telescope-project.nvim",
    event = "BufWinEnter",
    setup = function()
      vim.cmd [[packadd telescope.nvim]]
    end,
  },
  {
    "gbprod/substitute.nvim",
    config = function()
      require("substitute").setup()
    end
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufRead",
    setup = function()
      vim.g.indentLine_enabled = 1
      vim.g.indent_blankline_char = "▏"
      vim.g.indent_blankline_filetype_exclude = { "help", "terminal", "alpha" }
      vim.g.indent_blankline_buftype_exclude = { "terminal" }
      vim.g.indent_blankline_show_trailing_blankline_indent = false
      vim.g.indent_blankline_show_first_indent_level = false
    end
  },
  -- half buggy colorizer
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({ "*" }, {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        rgb_fn = true, -- CSS rgb() and rgba() functions
        hsl_fn = true, -- CSS hsl() and hsla() functions
        css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
        -- Available modes: foreground, background
        mode = 'background'; -- Set the display mode.
      })
    end,
  },
}

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = { "*.json", "*.jsonc" },
--   -- enable wrap mode for json files only
--   command = "setlocal wrap",
-- })
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })

-- ### load config modules ###
reload("user.plugins")
reload("user.options")
reload("user.keymaps")
reload("user.autocommands")
reload("user.lsp")
reload("user.catppuccin")
reload("user.telescope")
reload("user.treesitter")
reload("user.lualine")
reload("user.lsp-signature")
-- reload("user.lsp-inlayhints")
reload("user.dial")
reload("user.persisted")
reload("user.dressing")
reload("user.tmux")
reload("user.leap")
reload("user.fidget")
reload("user.copilot")
reload("user.neoclip")
reload("user.scrollbar")
reload("user.colorizer")
reload("user.flote")
reload("user.bqf")
reload("user.zen-mode")
--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- lvim.builtin.which_key.mappings["H"] = { ":ClangdSwitchSourceHeader<CR>", "Switch Source/Header" }
-- lvim.builtin.which_key.mappings["7"] = { "<cmd>lua require('Comment.api').toggle_current_linewise()<CR>", "Comment" }
-- lvim.builtin.which_key.vmappings["7"] = { "<ESC><CMD>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>",
--   "Comment" }

-- Search and replace
-- lvim.builtin.which_key.mappings["r"] = {
--   ":%s/pattern/replace/gc", "Search and replace"
-- }

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

-- extra language servers
-- require("lvim.lsp.manager").setup("pyright")

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. !!Requires `:LvimCacheReset` to take effect!!
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- vim.tbl_map(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)
-- vim.tbl_map(function(server)
--   return server ~= "gopls"
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

-- Rainbow
-- lvim.builtin.treesitter.rainbow = {
--   enable = false,
--   extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
--   max_file_lines = 2000, -- Do not enable for files with more than 1000 lines, int
-- }

-- Additional plugin binds

-- unbind <M-x> in insert mode
-- vim.api.nvim_set_keymap("i", "<M-x>", "", {noremap = true})

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = { "*.json", "*.jsonc" },
--   -- enable wrap mode for json files only
--   command = "setlocal wrap",
-- })

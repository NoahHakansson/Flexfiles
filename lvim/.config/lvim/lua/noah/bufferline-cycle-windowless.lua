--
-- Bufferline cycle windowless (bufferline-cycle-windowless.nvim)
--

require("bufferline-cycle-windowless").setup({
	-- whether to start in enabled or disabled mode
	default_enabled = true,
})

-- open empty splits
lvim.builtin.which_key.mappings["|"] = { "<CMD>vsplit +enew<CR>", "Vertical split" }
lvim.builtin.which_key.mappings["_"] = { "<CMD>split +enew<CR>", "Horizontal split" }

-- since we open empty splits - clean them up as we cycle through open buffers
function ChangeTab(motion)
	local last_buffer_id = vim.fn.bufnr()
	local last_buffer_name = vim.fn.expand("%")

	if motion == "next" then
		vim.cmd([[BufferLineCycleWindowlessNext]])
	elseif motion == "prev" then
		vim.cmd([[BufferLineCycleWindowlessPrev]])
	else
		error("Invalid motion: " .. motion)
		return
	end

	if last_buffer_name == "" then
		vim.cmd("bd " .. last_buffer_id)
	end
end

-- switch through visible buffers with shift-l/h
lvim.keys.normal_mode["<S-l>"] = "<CMD>lua ChangeTab('next')<CR>"
lvim.keys.normal_mode["<S-h>"] = "<CMD>lua ChangeTab('prev')<CR>"

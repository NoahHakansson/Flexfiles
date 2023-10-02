--
-- leap.nvim is a plugin for fast cursor movement in Neovim.
--

local ok, leap = pcall(require, "leap")
if not ok then
	return
end

leap.setup({
	-- configuration options
})

-- ==============================================================================
-- CUSTOM MAPPINGS                                           *leap-custom-mappings*

-- <Plug> keys are aliases for right hand sides of mappings - in our case, calls
-- to |leap.leap()|. If you are not familiar with the concept, see |<Plug>| and
-- |using-<Plug>|.

-- Available <Plug> keys (with their corresponding argument tables):

-- *<Plug>(leap-forward-to)*
-- arguments: `{}` in Normal mode, otherwise `{ offset = +1, inclusive_op = true }`
-- default mapping: `s`

-- *<Plug>(leap-forward-till)*
-- arguments: `{ offset = -1, inclusive_op = true }`
-- default mapping: `x` (Visual and Operator-pending mode only)

-- *<Plug>(leap-backward-to)*
-- arguments: `{ backward = true }`
-- default mapping: `S`

-- *<Plug>(leap-backward-till)*
-- arguments: `{ backward = true, offset = 2 }`
-- default mapping: `X` (Visual and Operator-pending mode only)

-- *<Plug>(leap-from-window)*
-- arguments: `{ target_windows = require('leap.util').get_enterable_windows() }`
-- default mapping: `gs`

-- Example: `vim.keymap.set({'n', 'x', 'o'}, 'f', '<Plug>(leap-forward-to)')`

-- For creating custom motions with behaviours different from the above, see
-- |leap.leap()|.

-- The keys for repeating the search, and for switching between groups of matches
-- can be set via |leap.opts.special_keys|.

-- ==============================================================================

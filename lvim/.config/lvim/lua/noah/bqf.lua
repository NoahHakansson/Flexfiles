--
-- nvim-bqf is a plugin that provides a better quickfix window for Neovim.
--
local ok, bqf = pcall(require, 'bqf')
if not ok then
  return
end

bqf.setup({
  auto_enable = true,
  magic_window = true,
  auto_resize_height = false,
  preview = {
    auto_preview = true,
    show_title = true,
    delay_syntax = 50,
    wrap = false,
  },
  func_map = {
    openc = 'o', -- open in current window
    drop = 'O',
    tab = 't', -- open in new tab
    split = 's', -- open in horizontal split
    vsplit = 'v', -- open in vertical split
    stoggleup = 'M',
    stoggledown = 'm',
    stogglevm = 'm',
    filterr = 'f',
    filter = 'F',
    prevhist = '<',
    nexthist = '>',
    sclear = 'c',
    ptoggleauto = 'p',
    ptogglemode = 'P',
  },
})

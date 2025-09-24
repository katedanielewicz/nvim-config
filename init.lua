

--[[
local reg = require("plugins.reg-edit")
local registers = reg.read_registers();
reg.print_registers(registers)
]]--


-- Disable any custom tagfunc filtering
-- vim.o.tagfunc = ""
vim.opt.grepformat = "%f:%l:%c:%m"


vim.o.tabstop = 4
vim.o.expandtab = true
vim.o.wrap = true
vim.o.ignorecase = true
vim.o.number = true
require("config.lazy")


vim.opt.tags = "./tags;"
vim.opt.grepprg = "rg --vimgrep --smart-case"

vim.api.nvim_create_user_command('Grepsrc', function(opts)
  local tb = require('telescope.builtin')
  tb.live_grep({ search_dirs = {"src"} })
end, { nargs = "*" })

-- Toggle relative line numbers with <C-s>
vim.keymap.set("n", "<C-s>", function()
  if vim.wo.relativenumber then
    vim.wo.relativenumber = false
  else
    vim.wo.relativenumber = true
  end
end, { noremap = true, silent = true })

-- Visual mode mapping: "fg" greps the current visual selection
vim.keymap.set("n", "fg", function()

  require("telescope.builtin").grep_string({ })

end, { noremap = true, silent = true, desc = "Grep normal selection" })



vim.keymap.set("n", "ff", function()

  require("telescope.builtin").find_files({ })

end, { noremap = true, silent = true, desc = "Find normal selection" })

-- Visual mode mapping: "fg" greps the current visual selection
vim.keymap.set("v", "fg", function()
  -- Get the selected text
  vim.cmd('normal! "zy')
  local selection = vim.fn.getreg("z")

  require("telescope.builtin").grep_string({ search = selection })

end, { noremap = true, silent = true, desc = "Grep visual selection" })



vim.keymap.set("v", "ff", function()
  -- Get the selected text
  vim.cmd('normal! "zy')
  local selection = vim.fn.getreg("z")

  require("telescope.builtin").find_files({ default_text = selection })

end, { noremap = true, silent = true, desc = "Find visual selection" })



-- write n and v mapings after everything else runs

local fname = vim.fn.expand("~/AppData/Local/nvim/nmap.txt")

-- temporarily disable more so Neovim won't pause for messages
vim.cmd("set nomore")

-- redirect (use redir! to avoid some warnings), run nmap silently, then end redir
vim.cmd("redir! >> " .. fname)
vim.cmd("silent! nmap")
vim.cmd("redir END")

-- restore 'more'
vim.cmd("set more")



local fname = vim.fn.expand("~/AppData/Local/nvim/vmap.txt")

-- temporarily disable more so Neovim won't pause for messages
vim.cmd("set nomore")

-- redirect (use redir! to avoid some warnings), run vmap silently, then end redir
vim.cmd("redir! >> " .. fname)
vim.cmd("silent! vmap")
vim.cmd("redir END")

-- restore 'more'
vim.cmd("set more")



local fname = vim.fn.expand("~/AppData/Local/nvim/map.txt")

-- temporarily disable more so Neovim won't pause for messages
vim.cmd("set nomore")

-- redirect (use redir! to avoid some warnings), run map silently, then end redir
vim.cmd("redir! >> " .. fname)
vim.cmd("silent! map")
vim.cmd("redir END")

-- restore 'more'
vim.cmd("set more")

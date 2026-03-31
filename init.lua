

--[[
local reg = require("plugins.reg-edit")
local registers = reg.read_registers();
reg.print_registers(registers)
]]--


-- Disable any custom tagfunc filtering
-- vim.o.tagfunc = ""
vim.opt.grepformat = "%f:%l:%c:%m"


vim.wo.relativenumber = true
vim.o.tabstop = 4
vim.o.expandtab = true
vim.o.wrap = true
vim.o.ignorecase = true
vim.o.number = true
vim.opt.smartcase = true
require("config.lazy")

vim.o.guifont = "Departure Mono Nerd Font Propo Regular:h12"


local opts = { noremap = true, silent = true }



-- Window navigation using <leader> + hjkl
vim.api.nvim_set_keymap('n', '<leader>h', '<C-w>h', opts)
vim.api.nvim_set_keymap('n', '<leader>j', '<C-w>j', opts)
vim.api.nvim_set_keymap('n', '<leader>k', '<C-w>k', opts)
vim.api.nvim_set_keymap('n', '<leader>l', '<C-w>l', opts)

-- Tab navigation
vim.api.nvim_set_keymap('n', '<leader>d', ':tabprevious<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>f', ':tabnext<CR>', { noremap = true, silent = true })

-- Tab Movement
vim.api.nvim_set_keymap('n', '<leader><<', ':-tabmove<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>>>', ':+tabmove<CR>', opts)

-- Tab creation and deletion
vim.api.nvim_set_keymap('n', '<leader>v', ':tabnew<CR>', { noremap = true, silent = true })   -- new tab
vim.api.nvim_set_keymap('n', '<leader>c', ':tabclose<CR>', { noremap = true, silent = true }) -- close tab


vim.api.nvim_set_keymap(
  'n',
  '<leader>yr',
  ':execute "let @" . v:register . " = expand(\'%\')" <CR>',
  opts
)



-- Define the configuration for pyright
vim.lsp.config['pyright'] = {
  cmd = { "pyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_markers = {
    "pyproject.toml",
    "setup.py",
    "requirements.txt",
    ".git",
  },
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        reportUnusedExpression = true,
      },
    },
  },
}

-- Enable the config
vim.lsp.enable('pyright')

vim.keymap.set('n', '<leader>tg', vim.lsp.buf.definition, {})

 -- Show diagnostic popup on hover
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Show line diagnostics" })       

-- Jump to the NEXT error/warning
vim.keymap.set('n', '<leader>r', vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })

-- Jump to the PREVIOUS error/warning
vim.keymap.set('n', '<leader>w', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })

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
vim.keymap.set("n", "<leader>gh", function()

  require("telescope.builtin").grep_string({""})

end, { noremap = true, silent = true, desc = "Grep normal selection" })



vim.keymap.set("n", "<leader>gg", function()

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




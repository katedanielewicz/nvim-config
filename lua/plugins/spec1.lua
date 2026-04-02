return {
  -- 1. Treesitter Context
  {
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup({
        enable = true,
        max_lines = 5, -- how many lines of context to show
        trim_scope = "outer",
      })
    end
  },

  -- 2. LSP Config & Mason (Fixed structure)
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("mason").setup()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local lspconfig = require("lspconfig")

      require("mason-lspconfig").setup({
        ensure_installed = { "pyright", "clangd" },
        handlers = {
          function(server_name)
            lspconfig[server_name].setup({
              capabilities = capabilities,
            })
          end,
          ["pyright"] = function()
            lspconfig.pyright.setup({
              capabilities = capabilities,
              settings = {
                python = {
                  analysis = {
                    autoSearchPaths = true,
                    useLibraryCodeForTypes = true,
                    typeCheckingMode = "basic",
                  },
                },
              },
            })
          end,
        },
      })

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', { clear = true }), 
        callback = function(ev)
          local opts = { buffer = ev.buf, silent = true }
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
          vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
          vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
        end,
      })
    end,
  },

  -- 3. Neo-tree (Fixed opts table)
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    lazy = false,
    opts = {
      filesystem = {
        filtered_items = {
          visible = true,
        },
      },
    },
  },

  -- 4. Telescope (Fixed syntax and removed duplicate)
  {
    "nvim-telescope/telescope.nvim", 
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          vimgrep_arguments = {
            "rg", "--color=never", "--no-heading", "--with-filename",
            "--line-number", "--column", "--smart-case", "--glob", "!tags"
          },
          file_ignore_patterns = { "tags", "node_modules", ".git" },
        },
      })
    end
  },

  -- 5. Colorscheme
  
  {
    "ankushbhagats/pastel.nvim",
    lazy = false, -- Load on startup
    priority = 1000, -- Load before other plugins
    config = function()
      vim.cmd([[colorscheme pasteldark]])
    end,
  },
  { 
    "folke/tokyonight.nvim",
    lazy = false, -- Load on startup
    priority = 1000, -- Load before other plugins
  },

  {
    "Scysta/pink-panic.nvim",
    lazy = false, -- Load on startup
    priority = 1000, -- Load before other plugins
    dependencies = {
      "rktjmp/lush.nvim",
    },
  },
  -- 6. Utilities & UI
  { "folke/which-key.nvim", lazy = true },

  {
    "nvim-neorg/neorg",
    ft = "norg",
    opts = {
      load = {
        ["core.defaults"] = {},
      },
    },
  },

  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    init = function()
      vim.g.startuptime_tries = 10
    end,
  },

  -- 7. Autocompletion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
    },
    config = function()
      -- The cmp logic goes here later!
    end,
  },

  -- 8. Misc Lazy-loaded Plugins
  { "nvim-tree/nvim-web-devicons", lazy = true },
  { "stevearc/dressing.nvim", event = "VeryLazy" },

  {
    "Wansmer/treesj",
    keys = {
      { "J", "<cmd>TSJToggle<cr>", desc = "Join Toggle" },
    },
    opts = { use_default_keymaps = false, max_join_length = 150 },
  },

  {
    "monaqa/dial.nvim",
    keys = { "<C-a>", { "<C-x>", mode = "n" } },
  },
  -- 9. Enhanced f/t motions (Case-insensitive & Multi-line)
  {
    url = "https://codeberg.org/andyg/leap.nvim",
    dependencies = { 
      "ggandor/leap.nvim",
      "tpope/vim-repeat", -- Required for flit/leap to use the '.' command
    },
    config = function()
      require('flit').setup({
        keys = { f = 'f', F = 'F', t = 't', T = 'T' },
        -- labeled_modes: enables labels like 'leap' so you can jump directly
        labeled_modes = "v", 
        multiline = true,
        opts = {
          -- This handles your request for case-insensitivity
          -- If you type 'ft', it will find 't' and 'T'
          smart_case = true,
        }
      })
    end,
  },

  -- 10. The Repeat Plugin (Standalone entry to ensure it loads)
  { "tpope/vim-repeat" },

  -- 11. Leap (The engine for flit, also great for long distance jumps)
  { 
    "ggandor/flit.nvim",
    config = function()
      -- Optional: allows 's' to jump anywhere on screen
      -- vim.keymap.set('n', 's', '<Plug>(leap-forward-to)')
      -- vim.keymap.set('n', 'S', '<Plug>(leap-backward-to)')
    end,
  },
}

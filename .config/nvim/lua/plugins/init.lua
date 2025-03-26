return {
  "nvim-lua/plenary.nvim",
  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      require 'nvim-web-devicons'.setup {}
    end,
  },
  {
    'DaikyXendo/nvim-material-icon',
    config = function()
      require 'nvim-web-devicons'.setup {}
    end,
  },
  { "tpope/vim-repeat",   event = "VeryLazy" },
  {
    "lukas-reineke/indent-blankline.nvim",
    lazy = false,
    config = function()
      require("ibl").setup()
    end,
  },
  {
    'norcalli/nvim-colorizer.lua',
    event = "VeryLazy",
    config = function()
      require 'colorizer'.setup {}
    end
  },
  {
    "numToStr/Comment.nvim",
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
    event = { "VeryLazy" },
    config = function(_, _)
      require("Comment").setup {
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      }
    end,
  },
  {
    "machakann/vim-sandwich",
    event = { "InsertEnter" },
    lazy = true,
  },
  -- session management
  -- {
  --   "rmagatti/auto-session",
  --   lazy = false,
  --   config = function()
  --     require("auto-session").setup {
  --       pre_save_cmds = { "NvimTreeClose" },
  --       save_extra_cmds = {
  --         "NvimTreeOpen"
  --       },
  --       post_restore_cmds = {
  --         "NvimTreeOpen"
  --       },
  --       log_level = "error",
  --       auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
  --     }
  --   end,
  -- cmd = { "SessionSave", "SessionRestore", "SessionDelete" }, -- Commands that will trigger loading the plugin
  -- },
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {
      options = { "buffers", "curdir", "tabpages", "winsize", "help" }
    },
  },

  -- auto-save
  {
    "Pocco81/auto-save.nvim",
    lazy = false,
  },
  -- Undo tree
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
  },

  { 'wellle/targets.vim', event = 'InsertEnter' }, -- extends textobjects
  {
    "p00f/nvim-ts-rainbow",
    event = { "BufReadPost" },
  },
  {
    "vladdoster/remember.nvim",
    lazy = false,
    config = function()
      require("remember").setup({
        open_folds = false,
      })
    end,
  },
  -- install without yarn or npm
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
  },
  {
    "kawre/leetcode.nvim",
    lazy = false,
    build = ":TSUpdate html", -- if you have `nvim-treesitter` installed
    dependencies = {
      "nvim-telescope/telescope.nvim",
      -- "ibhagwan/fzf-lua",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      ---@type lc.lang
      lang = "python3",
      ---@type table<string, boolean>
      plugins = {
        non_standalone = false,
      },
    },
  },
  -- {
  --   "micangl/cmp-vimtex",
  --   ft = { "tex" },
  -- },
  -- LazyGit
  {
    "kdheepak/lazygit.nvim",
    lazy = false,
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
  },
  {
    'nvim-orgmode/orgmode',
    event = 'VeryLazy',
    ft = { 'org' },
    config = function()
      -- Setup orgmode
      require('orgmode').setup({
        org_agenda_files = '~/Documents/My_Projects/Agenda/**/*',
        org_default_notes_file = '~/Documents/My_Projects/Agenda/refile.org',
      })

      -- NOTE: If you are using nvim-treesitter with `ensure_installed = "all"` option
      -- add `org` to ignore_install
      -- require('nvim-treesitter.configs').setup({
      --   ensure_installed = 'all',
      --   ignore_install = { 'org' },
      -- })
    end,
  },
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "JoosepAlviste/nvim-ts-context-commentstring",
      "RRethy/nvim-treesitter-endwise",
      "windwp/nvim-ts-autotag",
    },
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      sync_install = false,
      ensure_installed = {
        "bash",
        "json",
        "html",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "yaml",
        "julia",
        "org",
        -- "dap_repl",
      },
      ignore_install = { 'org', 'latex' }, -- List of parsers to ignore installing
      autopairs = { enable = true },
      highlight = {
        enable = true,             -- false will disable the whole extension
        disable = { "help", "latex", "vimdoc", "bibtex" }, -- list of language that will be disabled
        additional_vim_regex_highlighting = {'org'},
      },
      indent = { enable = true },
      context_commentstring = {
        enable = true,
        enable_autocmd = true,
      },
      -- rainbow = {
      --   enable = true,
      --   extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
      --   max_file_lines = nil, -- Do not enable for files with more than n lines, int
      -- },
      textobjects = {
        select = {
          enable = true,
          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            ["al"] = "@loop.outer",
            ["il"] = "@loop.inner",
            ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",
          },
          selection_modes = {
            ['@parameter.outer'] = 'v', -- charwise
            ['@function.outer'] = 'V',  -- linewise
            ['@class.outer'] = '<c-v>', -- blockwise
          },
        },
      },
    },
    config = function(_, opts)
      -- require('nvim-dap-repl-highlights').setup()
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    -- config = true
    config = function()
      local npairs = require "nvim-autopairs"
      npairs.setup {
        check_ts = true,
      }
    end,
  },
}

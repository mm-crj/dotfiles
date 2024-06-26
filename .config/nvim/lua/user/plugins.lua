local fn = vim.fn

-- Install packer
local ensure_packer = function()
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
  git = {
    cmd = 'git', -- The base command for git operations
    subcommands = {
      -- Format strings for git subcommands
      update         = 'pull --ff-only --progress --rebase=true',
      install        = 'clone --depth %i --no-single-branch --progress',
      fetch          = 'fetch --depth 999999 --progress',
      checkout       = 'checkout %s --',
      update_branch  = 'merge --ff-only @{u}',
      current_branch = 'branch --show-current',
      diff           = 'log --color=never --pretty=format:FMT --no-show-signature HEAD@{1}...HEAD',
      diff_fmt       = '%%h %%s (%%cr)',
      get_rev        = 'rev-parse --short HEAD',
      get_msg        = 'log --color=never --pretty=format:FMT --no-show-signature HEAD -n 1',
      submodules     = 'submodule update --init --recursive --progress'
    },
  },
}

-- Automatically source and re-compile packer whenever you save this init.lua
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

-- Install your plugins here
return packer.startup(function(use)
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "lewis6991/impatient.nvim"
  use "nvim-lua/popup.nvim"    -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim"  -- Useful lua functions used by lots of plugins
  use { "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup {}
    end } -- Autopairs, integrates with both cmp and treesitter
  use { 'nvim-telescope/telescope.nvim', tag = '0.1.2',
    requires = { 'nvim-lua/plenary.nvim' } }
  use { 'nvim-telescope/telescope-fzf-native.nvim',
    run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release \
        && cmake --build build --config Release \
        && cmake --install build --prefix build' }
  use { "kkharji/sqlite.lua" }
  use {
    "nvim-telescope/telescope-frecency.nvim",
    config = function()
      require "telescope".load_extension("frecency")
    end,
    requires = { "kkharji/sqlite.lua" }
  }
  use "benfowler/telescope-luasnip.nvim"
  use {
    "jemag/telescope-diff.nvim",
    requires = { "nvim-telescope/telescope.nvim" },
  }
  use {
    'rafi/telescope-thesaurus.nvim',
    requires = { 'nvim-telescope/telescope.nvim' }
  }
  use "machakann/vim-sandwich"
  use {"lervag/vimtex" }
  use "lukas-reineke/indent-blankline.nvim"
  use "goolord/alpha-nvim" -- home page
  use { "folke/which-key.nvim" }
  -- use "ggandor/leap.nvim"
  -- use { "ggandor/flit.nvim", requires = "ggandor/leap.nvim" }
  -- use { "kevinhwang91/nvim-ufo", requires = 'kevinhwang91/promise-async' } -- code folding
  use "karb94/neoscroll.nvim"
  use "Pocco81/auto-save.nvim"
  use "vladdoster/remember.nvim"
  use { "rmagatti/auto-session" }
  use "ahmedkhalf/project.nvim"
  use "tpope/vim-repeat" -- enables . operator to leap and other plugins
  -- Julia Support
  use "JuliaEditorSupport/julia-vim"
  -- use "kdheepak/JuliaFormatter.vim"
  -- Markdown Support
  use "ixru/nvim-markdown"
  use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  })
  -- Buffers
  use { "akinsho/bufferline.nvim", tag = "v3.*", requires = { 'kyazdani42/nvim-web-devicons' } }
  use "moll/vim-bbye"

  -- Comment
  use "numToStr/Comment.nvim"
  use 'JoosepAlviste/nvim-ts-context-commentstring'
  -- Co-pilot
  use {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({})
    end,
  }
  use {
    "zbirenbaum/copilot-cmp",
    after = { "copilot.lua" },
    config = function()
      require("copilot_cmp").setup()
    end
  }
  -- Docstrings and annotations
  use {
    "danymat/neogen",
    config = function()
      require('neogen').setup {}
    end,
    requires = "nvim-treesitter/nvim-treesitter",
    -- Uncomment next line if you want to follow only stable versions
    tag = "*"
  }

  -- File explorer
  use { "kyazdani42/nvim-tree.lua", requires = { "kyazdani42/nvim-web-devicons", }, }

  -- Syntax highlighting and textobjects
  use { "nvim-treesitter/nvim-treesitter", run = ':TSUpdate' }
  use "nvim-treesitter/nvim-treesitter-textobjects"
  use "nvim-treesitter/playground"

  use { "wellle/targets.vim" } -- extends textobjects
  use "p00f/nvim-ts-rainbow"

  use {
    "VonHeikemen/lsp-zero.nvim",
    requires = {
      -- LSP Support
      { "neovim/nvim-lspconfig" },
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },
      { "jose-elias-alvarez/null-ls.nvim" },

      -- Autocompletion
      { "hrsh7th/nvim-cmp" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "saadparwaiz1/cmp_luasnip" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-nvim-lua" },
      { "hrsh7th/cmp-cmdline" },
      { "uga-rosa/cmp-dictionary" },
      { "hrsh7th/cmp-nvim-lsp-signature-help" },
      { "quangnguyen30192/cmp-nvim-tags" },
      { "rcarriga/cmp-dap" }, -- debugger completion

      -- Snippets
      { "L3MON4D3/LuaSnip" },

    }
  }

  -- Colorschemes and highlighting
  use "kyazdani42/nvim-web-devicons"
  use 'navarasu/onedark.nvim'
  use { 'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true } }
  use { 'm-demare/hlargs.nvim', requires = { 'nvim-treesitter/nvim-treesitter' } }
  use { 'norcalli/nvim-colorizer.lua' }

  -- Gitsigns
  use "lewis6991/gitsigns.nvim"
  -- lazygit
  use({
    "kdheepak/lazygit.nvim",
    -- optional for floating window border decoration
    requires = {
      "nvim-lua/plenary.nvim",
    },
  })
  -- for Diffview
  use "sindrets/diffview.nvim"
  -- For asyn IO
  use { "nvim-neotest/nvim-nio" }
  -- For DuckDuckGo integration
  use { "pbnj/vim-ddgr" }
  -- Debugging
  use { "mfussenegger/nvim-dap" }
  use { 'theHamsta/nvim-dap-virtual-text', requires = { "mfussenegger/nvim-dap" } }
  use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }
  use { "nvim-telescope/telescope-dap.nvim", requires = { "mfussenegger/nvim-dap" } }
  use { 'mfussenegger/nvim-dap-python', requires = { "mfussenegger/nvim-dap" } }
  use { 'jbyuki/one-small-step-for-vimkind' }
  -- warnings
  -- use { 'folke/trouble.nvim', requires = { 'nvim-tree/nvim-web-devicons' } }

  -- Better ltex
  -- use { 'vigoux/ltex-ls.nvim', requires = 'neovim/nvim-lspconfig' }

  -- temporary
  -- use {
  --   'glacambre/firenvim',
  --   run = function() vim.fn['firenvim#install'](0) end
  -- }

  -- for fun
  -- use 'eandrju/cellular-automaton.nvim'
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

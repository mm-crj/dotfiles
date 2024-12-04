local M = {}

function M.setup()
  local lspconfig = require 'lspconfig'

  lspconfig.pyright.setup({
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          typeCheckingMode = "off",
        },
      },
    },
  })


  lspconfig.lua_ls.setup {
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',
        },
        diagnostics = {
          globals = { 'vim' },
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
        },
        telemetry = {
          enable = false,
        },
      },
    },
  }

  lspconfig.yamlls.setup({
    settings = {
      yaml = {
        keyOrdering = false
      }
    }
  })
  lspconfig.julials.setup({
    settings = {
      julia = {
        format = {
          indent = 2,
        },
      },
    },
  })
  lspconfig.texlab.setup({
    latexFormater = {
      exe = "latexindent",
      args = { "-w" },
      stdin = true,
    },
    bibtexFormatter = "bibtex-tidy",
    latexindent = {
      modifyLineBreaks = false,
    },
  })
  -- lspconfig.texlab.setup({
  --   settings = {
  --     texlab = {
  --       chktex = {
  --         onEdit = true,
  --         onOpenAndSave = true,
  --       },
  --       forwardSearch = {
  --         executable = "zathura",
  --         args = { "--synctex-forward", "%l:1:%f", "%p" },
  --       },
  --       build = {
  --         executable = "latexmk",
  --         args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
  --         onSave = true,
  --       },
  --     },
  --   },
  -- })


  local path = vim.fn.stdpath("config") .. "/spell/en.utf-8.add"
  local words = {}

  for word in io.open(path, "r"):lines() do
    table.insert(words, word)
  end

  -- lspconfig.ltex.setup {
  --   settings = {
  --     ltex = {
  --       language = "en-GB",
  --       dictionary = {
  --         ['en-US'] = words,
  --         ['en-GB'] = words,
  --       },
  --     },
  --   },
  -- }
end

return M

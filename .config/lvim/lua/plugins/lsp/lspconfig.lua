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

  lspconfig.tsserver.setup({
    settings = {
      javascript = {
        format = {
          enable = false
        }
      },
      typescript = {
        format = {
          enable = false
        }
      }
    }
  })
  local path = vim.fn.stdpath("config") .. "/spell/en.utf-8.add"
  local words = {}

  for word in io.open(path, "r"):lines() do
    table.insert(words, word)
  end

  lspconfig.ltex.setup {
    settings = {
      ltex = {
        language ="en-GB",
        dictionary = {
          ['en-US'] = words,
          ['en-GB'] = words,
        },
      },
    },
  }
end

return M

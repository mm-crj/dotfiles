local M = {}

function M.setup()
  -- local lspconfig = require 'lspconfig'
  -- Defing servers and therir configs
  local servers = {
    pyright = {
      settings = {
        python = {
          analysis = {
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
            typeCheckingMode = "off",
            formatCommand = { "black" },
          },
        },
      }
    },
    lua_ls = {
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
    },
    yamlls = {
      settings = {
        yaml = {
          keyOrdering = false
        }
      }
    },
    clangd = {},
    ts_ls = {
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
    },
    texlab = {
      latexFormater = {
        exe = "latexindent",
        args = { "-w" },
        stdin = true,
      },
      bibtexFormatter = "bibtex-tidy",
      latexindent = {
        modifyLineBreaks = false,
      },
    }
  }

-- Setup all servers
  for  server, config in pairs(servers) do
    vim.lsp.config(server,config)
  end
end
return M

  -- lspconfig.pyright.setup({
  --   settings = {
  --     python = {
  --       analysis = {
  --         autoSearchPaths = true,
  --         useLibraryCodeForTypes = true,
  --         typeCheckingMode = "off",
  --         formatCommand = { "black" },
  --       },
  --     },
  --   },
  -- })


  -- lspconfig.lua_ls.setup {
  --   settings = {
  --     Lua = {
  --       runtime = {
  --         version = 'LuaJIT',
  --       },
  --       diagnostics = {
  --         globals = { 'vim' },
  --       },
  --       workspace = {
  --         library = vim.api.nvim_get_runtime_file("", true),
  --       },
  --       telemetry = {
  --         enable = false,
  --       },
  --     },
  --   },
  -- }

  -- lspconfig.yamlls.setup({
  --   settings = {
  --     yaml = {
  --       keyOrdering = false
  --     }
  --   }
  -- })
  -- lspconfig.clangd.setup {}

  -- lspconfig.ts_ls.setup({
  --   settings = {
  --     javascript = {
  --       format = {
  --         enable = false
  --       }
  --     },
  --     typescript = {
  --       format = {
  --         enable = false
  --       }
  --     }
  --   }
  -- })
  -- lspconfig.texlab.setup({
  --   latexFormater = {
  --     exe = "latexindent",
  --     args = { "-w" },
  --     stdin = true,
  --   },
  --   bibtexFormatter = "bibtex-tidy",
  --   latexindent = {
  --     modifyLineBreaks = false,
  --   },
  -- })
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


  -- local path = vim.fn.stdpath("config") .. "/spell/en.utf-8.add"
  -- local words = {}
  --
  -- for word in io.open(path, "r"):lines() do
  --   table.insert(words, word)
  -- end
  -- lspconfig.ltex_plus.setup {
  --   settings = {
  --     ltex = {
  --       language = "en-GB",
  --       diagnosticSeverity = "information",
  --       dictionary = {
  --         ['en-GB'] = words,
  --       },
  --     },
  --   },
  -- }
  -- lspconfig.ltex.setup {
  --   on_attach = on_attach,
  --   capabilities = capabilities,
  --   use_spellfile = false,
  --   filetypes = { "latex", "tex", "bib", "markdown", "gitcommit", "text" },
  --   settings = {
  --     ltex = {
  --       language = "en-GB",
  --       diagnosticSeverity = "information",
  --       dictionary = {
  --         ['en-GB'] = words,
  --       },
  --       additionalRules = {
  --         enablePickyRules = true,
  --         motherTongue = "en"
  --       },
  --       disabledRules = {
  --         ["en-GB"] = {},
  --       },
  --     },
  --   },
  -- }

return {
  {
    "folke/which-key.nvim",
    tag = "v2.1.0",
    event = "VeryLazy",
    -- cmd = { "WhichKey" },
    -- lazy = true,
    keys = {
      { "<Space>" },
    },
    config = function()
      local setup = {
        plugins = {
          marks = true,       -- shows a list of your marks on ' and `
          registers = true,   -- shows your registers on " in NORMAL or <C-r> in INSERT mode
          spelling = {
            enabled = true,   -- enabling this will show WhichKey when pressing z= to select spelling suggestions
            suggestions = 20, -- how many suggestions should be shown in the list?
          },
          -- the presets plugin, adds help for a bunch of default keybindings in Neovim
          -- No actual key bindings are created
          presets = {
            operators = true,    -- adds help for operators like d, y, ... and registers them for motion / text object completion
            motions = true,      -- adds help for motions
            text_objects = true, -- help for text objects triggered after entering an operator
            windows = true,      -- default bindings on <c-w>
            nav = true,          -- misc bindings to work with windows
            z = true,            -- bindings for folds, spelling and others prefixed with z
            g = true,            -- bindings for prefixed with g
          },
        },
        -- add operators that will trigger motion and text object completion
        -- to enable all native operators, set the preset / operators plugin above
        operators = { gc = "Comments" },
        popup_mappings = {
          scroll_down = "<c-d>", -- binding to scroll down inside the popup
          scroll_up = "<c-u>",   -- binding to scroll up inside the popup
        },
        layout = {
          height = { min = 4, max = 25 },                                             -- min and max height of the columns
          width = { min = 20, max = 50 },                                             -- min and max width of the columns
          spacing = 3,                                                                -- spacing between columns
          align = "left",                                                             -- align columns left, center or right
        },
        ignore_missing = true,                                                        -- enable this to hide mappings for which you didn't specify a label
        hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
        show_help = true,                                                             -- show help message on the command line when the popup is visible
        triggers = "auto",                                                            -- automatically setup triggers
      }

      local opts = {
        mode = "n",     -- NORMAL mode
        prefix = "<leader>",
        buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
        silent = true,  -- use `silent` when creating keymaps
        noremap = true, -- use `noremap` when creating keymaps
        nowait = true,  -- use `nowait` when creating keymaps
      }

      local mappings = {
        ["<TAB>"] = { "<cmd>b#<CR>", "Previous buffer" },
        ["/"] = { '<cmd>lua require("Comment.api").toggle_current_linewise()<CR>', "Comment" },
        ["a"] = { "<cmd>Alpha<cr>", "Alpha" },
        b = {
          name = "Buffers",
          b = { "<cmd>lua require('telescope.builtin').buffers({sort_lastused = true, ignore_current_buffer = true})<cr>", "Find Buffers" },
          d = { "<cmd>bd<CR>", "Close Buffer" },
          f = { "<cmd>lua vim.lsp.buf.format { async = true }<cr>", "Format" },
          h = { "<cmd>Alpha<cr>", "Alpha Home" },
          p = { "<cmd>b#<CR>", "Previous buffer" },
          r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
        },
        d = {
          name = "Debug",
          C = { "<cmd>lua require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<cr>", "Conditional Breakpoint" },
          E = { "<cmd>lua require'dapui'.eval(vim.fn.input '[Expression] > ')<cr>", "Evaluate Input" },
          R = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run to Cursor" },
          S = { "<cmd>lua require'dap.ui.widgets'.scopes()<cr>", "Scopes" },
          U = { "<cmd>lua require'dapui'.toggle()<cr>", "Toggle UI" },
          b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
          c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
          d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
          e = { "<cmd>lua require'dapui'.eval()<cr>", "Evaluate" },
          g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
          h = { "<cmd>lua require'dap.ui.widgets'.hover()<cr>", "Hover Variables" },
          i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
          o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
          p = { "<cmd>lua require'dap'.pause.toggle()<cr>", "Pause" },
          q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
          r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
          s = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
          t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
          u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
          x = { "<cmd>lua require'dap'.terminate()<cr>", "Terminate" },
        },
        ["e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
        f = {
          name = "Find",
          C = { "<cmd>Telescope commands<cr>", "Commands" },
          M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
          R = { "<cmd>Telescope registers<cr>", "Registers" },
          b = { "<cmd>Telescope buffers<cr>", "Find Buffers" },
          c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
          f = { "<cmd>Telescope find_files<cr>", "Find files" },
          g = { "<cmd>Telescope live_grep theme=ivy<cr>", "Live Grep" },
          h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
          k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
          p = { "<cmd>Telescope projects<cr>", "Projects" },
          o = { "<cmd>Telescope aerial<cr>", "(Code) Outline" },
          r = { "<cmd>Telescope frecency<cr>", "Open Recent File" },
          s = { "<cmd>Telescope luasnip<cr>", "Snippets" },
        },
        g = {
          name = "Git",
          R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
          b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
          c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
          d = { "<cmd>Gitsigns diffthis HEAD<cr>", "Diff" },
          g = { "<cmd>LazyGit<CR>", "Lazygit" },
          j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
          k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
          l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
          o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
          p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
          r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
          s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
          u = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", "Undo Stage Hunk" },
        },
        G = {
          name = "Generate",
          a = { function() require("neogen").generate() end, "Annotation", },
          c = { function() require("neogen").generate { type = "class" } end, "Class", },
          f = { function() require("neogen").generate { type = "func" } end, "Function", },
          t = { function() require("neogen").generate { type = "type" } end, "Type", },
        },
        k = {
          name = "LSP",
          I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
          S = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace Symbols" },
          a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
          d = { "<cmd>Telescope diagnostics bufnr=0<cr>", "Document Diagnostics" },
          f = { "<cmd>LspZeroFormat<cr>", "Format" },
          i = { "<cmd>LspInfo<cr>", "Info" },
          j = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Prev Diagnostic", },
          k = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "Next Diagnostic", },
          l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
          r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
          s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
          w = { "<cmd>Telescope diagnostics<cr>", "Workspace Diagnostics" },
        },
        p = {
          name = "Packer",
          l = { "<cmd>Lazy<cr>", "Lazy" },
          m = { "<cmd>Mason<cr>", "Mason" },
          -- i = { "<cmd>PackerInstall<cr>", "Install" },
          -- s = { "<cmd>PackerSync<cr>", "Sync" },
          -- u = { "<cmd>PackerUpdate<cr>", "Update" },
        },
        s = {
          name = "Source/Session",
          -- a = { "<cmd>ASToggle<cr>", "Auto Save" },
          -- c = { "<cmd>ReloadConfig<cr>", "Config" },
          -- d = { "<cmd>SessionDelete<cr>", "Delete" },
          -- s = { "<cmd>SessionSave<cr>", "Save" },
          -- r = { "<cmd>SessionRestore<cr>", "Restore" },
          l = { "<cmd>source ~/.config/nvim/lua/user/lsp/luasnip.lua<cr>", "LuaSnippets" },
          r = { function() require("persistence").load() end, "Restore Session for Curr. Dir." },
          s = { function() require("persistence").load({ last = true }) end, "Restore Last Session" },
          d = { function() require("persistence").stop() end, "Don't Save Current Session" },
        },
        t = {
          name = "Toggle",
          s = { "<cmd>set spell!<cr>", "Spell check" },
          m = { "<cmd>MarkdownPreviewToggle<cr>", "Markdown Preview" },
        },
        v = {
          name = "VimTex",
          v = { "<cmd>VimtexCompile<cr>", "Compile" },
          c = { "<cmd>VimtexClean<cr>", "Clean" },
          e = { "<cmd>VimtexErrors<cr>", "Errors" },
          s = { "<cmd>VimtexStop<cr>", "Stop" },
          t = { "<cmd>VimtexTocToggle<cr>", "Table of Contents" },
          n = { "<cmd>VimtexView<cr>", "View" },
        },
        ["w"] = { "<cmd>w<CR>", "Write/Save" },
        ["q"] = { "<cmd>q!<CR>", "Quit" },
        ["z"] = { "<cmd>wq!<CR>", "Write & Quite" },
      }

      local vopts = {
        mode = "v",     -- VISUAL mode
        prefix = "<leader>",
        buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
        silent = true,  -- use `silent` when creating keymaps
        noremap = true, -- use `noremap` when creating keymaps
        nowait = true,  -- use `nowait` when creating keymaps
      }
      local vmappings = {
        d = {
          name = "Debug",
          e = { "<cmd>lua require'dapui'.eval()<cr>", "Evaluate" },
        },
      }

      local nopts_wo_leader = {
        mode = "n",     -- NORMAL mode
        prefix = nil,
        buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
        silent = true,  -- use `silent` when creating keymaps
        noremap = true, -- use `noremap` when creating keymaps
        nowait = true,  -- use `nowait` when creating keymaps
      }
      local nmappings_wo_leader = {
        ["<F2>"] = { "<cmd>Telescope aerial<CR>", "Code Outline Out" },
        ["<F3>"] = { "<cmd>NvimTreeToggle<CR>", "File Explorer" },
        ["<F5>"] = { "<cmd>lua require'dap'.continue()<cr>", "Debugger Start" },
        ["<F6>"] = { "<cmd>lua require'dap'.step_over()<cr>", "Debugger Step Over" },
        ["<F7>"] = { "<cmd>lua require'dap'.step_into()<cr>", "Debugger Step Into" },
        ["<F8>"] = { "<cmd>lua require'dap'.terminate()<cr>", "Debugger Terminate" },
      }

      local which_key = require "which-key"
      which_key.setup(setup)
      which_key.register(mappings, opts)
      which_key.register(vmappings, vopts)
      which_key.register(nmappings_wo_leader, nopts_wo_leader)
    end,
  },
}

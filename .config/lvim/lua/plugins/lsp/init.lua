return {
    -- {
    --   "zbirenbaum/copilot.lua",
    --   cmd = "Copilot",
    --   event = "InsertEnter",
    --   config = function()
    --     require("copilot").setup({
    --       suggestion = {
    --         enabled = false,
    --         auto_trigger = true,
    --       },
    --       panel = { enabled = false },
    --     })
    --   end,
    -- },
    --
    {
        "VonHeikemen/lsp-zero.nvim",
        dependencies = {
            -- LSP Support
            { "neovim/nvim-lspconfig" },
            {
                "williamboman/mason.nvim",
                "williamboman/mason-lspconfig.nvim",
                "neovim/nvim-lspconfig",
                build = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end,
            },
            { "williamboman/mason-lspconfig.nvim" },

            -- Autocompletion
            { "hrsh7th/nvim-cmp" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-nvim-lua" },
            { "hrsh7th/cmp-cmdline" },
            { "hrsh7th/cmp-omni" },
            { "uga-rosa/cmp-dictionary" },

            -- Snippets
            {
                "L3MON4D3/LuaSnip",
                -- follow latest release.
                version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
                -- install jsregexp (optional!).
                build = "make install_jsregexp"
            },
            { "saadparwaiz1/cmp_luasnip" },
        },
        event = "BufReadPre",
        config = function()
            vim.diagnostic.config({ virtual_text = false })

            local lsp_zero = require "lsp-zero"
            --lsp_zero.preset({ name = 'minimal' })

            lsp_zero.on_attach(function(_, bufnr)
                local bufopts = { noremap = true, silent = true, buffer = bufnr }
                vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", bufopts)
                vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", bufopts)
                vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", bufopts)
                vim.keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>", bufopts)
                vim.keymap.set('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', bufopts)
                vim.keymap.set("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>", bufopts)
                vim.keymap.set("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>", bufopts)
                vim.keymap.set("n", "<space>wl", function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, bufopts)
                vim.keymap.set("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<cr>", bufopts)
            end)

            -- lsp_zero.ensure_installed {
            --   "pyright",
            --   "marksman",
            --   "yamlls",
            --   "lua_ls",
            --   "bashls",
            --   "ltex"
            -- }

            require('mason').setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗"
                    }
                }
            })
            require('mason-lspconfig').setup({
                -- Replace the language servers listed here
                -- with the ones you want to install
                ensure_installed = { 'marksman',
                    'ltex',
                    'lua_ls',
                    'texlab',
                    'pyright'
                },
                handlers = {
                    function(server_name)
                        require('lspconfig')[server_name].setup({})
                    end,
                },
            })
            -- further settings
            require "plugins.lsp.lspconfig".setup()
            require "plugins.lsp.luasnip".setup()
            require "plugins.lsp.cmp".setup()

            lsp_zero.setup()
        end,
    },


    {
        "nvimtools/none-ls.nvim",
        event = "BufReadPre",
        config = function()
            -- null-ls is not a part of lsp-zero, hence called after lsp.setup()
            local null_ls = require "null-ls"
            -- local null_opts = require("lsp-zero").build_options("null-ls", {})

            null_ls.setup {
                -- on_attach = function(client, bufnr)
                --   null_opts.on_attach(client, bufnr)
                -- end,
                sources = {
                    null_ls.builtins.formatting.black,
                    null_ls.builtins.formatting.isort,
                    null_ls.builtins.formatting.prettier.with({
                        filetypes = {
                            'javascript',
                            'typescript',
                            'css',
                            'scss',
                            'json',
                            'graphql',
                            'markdown',
                            'vue',
                            'yaml',
                            'norg'
                        },
                        extra_args = {
                            '--prose-wrap',
                            'always',
                            '--print-width',
                            '80' },
                    }),
                    null_ls.builtins.code_actions.gitsigns,
                },
            }
        end,
    },

    {
        'ray-x/lsp_signature.nvim',
        event = { "BufReadPost" },
        opts = {
            bind = true, -- This is mandatory, otherwise border config won't get registered.
            handler_opts = {
                border = "rounded"
            },
            toggle_key = '<M-h>',     -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
            select_signature_key = '<M-l>', -- cycle to next signature, e.g. '<M-n>' function overloading
            move_cursor_key = nil,    -- imap, use nvim_set_current_win to move cursor between current win and floating
        },
    },

}

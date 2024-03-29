local lsp = require('lsp-zero')
lsp.preset('recommended')

-- Disable default keybindings (optional)
lsp.set_preferences({
  set_lsp_keymaps = false
})

lsp.on_attach(function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', bufopts)
  vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', bufopts)
  vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', bufopts)
  --[[ vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts) ]]
  vim.keymap.set('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', bufopts)
  vim.keymap.set('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>', bufopts)
  vim.keymap.set('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>', bufopts)
  vim.keymap.set('n', '<space>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, bufopts)
  vim.keymap.set('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<cr>', bufopts)
  vim.keymap.set('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', bufopts)
  vim.keymap.set('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', bufopts)
  vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', bufopts)
  --[[ vim.keymap.set('n', '<space>bf', function() vim.lsp.buf.format { async = true } end, bufopts) ]]

  vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>', bufopts)
  vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>', bufopts)
  vim.keymap.set('n', 'd]', '<cmd>lua vim.diagnostic.goto_next()<cr>', bufopts)
end)


lsp.ensure_installed({
  --[[ "sumneko_lua", ]]
  "pyright",
  "texlab",
  "julials",
  "marksman",
  "sqlls",
  "yamlls",
})
lsp.configure('julials', {julia_env_path = "~/.julia/environments/v1.8/"
})
lsp.configure('pyright', {
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        typeCheckingMode = "off",
      }
    }
  }
})

require("user.lsp.cmp")  -- configure cmp 
require("user.lsp.luasnip")  -- configure luasnip

lsp.setup()

-- null-ls is not a part of lsp-zero, hence called after lsp.setup()
require("user.lsp.null_ls")

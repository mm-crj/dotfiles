---@type table<string, vim.lsp.ClientConfig>
local servers = {
  lua_ls = {
    name = "lua-language-server",
    cmd = { "lua-language-server" },
    root_dir = vim.fs.root(0,
      { ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml", "selene.toml", "selene.yml", ".git" }),
    filetypes = { "lua" },
    -- handlers = {
    --   ["textDocument/publishDiagnostics"] = vim.lsp.with(
    --     vim.lsp.diagnostic.on_publish_diagnostics, {
    --       underline = true,         -- Underline problematic lines
    --       virtual_text = false,     -- Disable virtual text
    --       severity_sort = true,     -- Sort by severity
    --       signs = true,             -- Keep signs in the gutter
    --       update_in_insert = false, -- Don't update diagnostics while in insert mode
    --     }
    --   ),
    -- },
  },
  -- add more servers here
  julia_ls = {
    name = "julia-language-server",
    cmd = { "julia", "--startup-file=no", "--history-file=no", "-e", [[
      using Pkg, LanguageServer, Sockets, SymbolServer
      using StaticLint
      env_path = dirname(Pkg.Types.Context().env.project_file)
      server = LanguageServer.LanguageServerInstance(stdin, stdout, env_path, "")
      server.runlinter = true
      run(server)
      ]] },
    root_dir = vim.fs.find({ "Project.toml", "JuliaProject.toml", ".git" }, { upward = true })[1] or vim.loop.cwd(),
    filetypes = { "julia" },
  },
}

local group = vim.api.nvim_create_augroup("UserLspStart", { clear = true })
for name, config in pairs(servers) do
  vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = config.filetypes,
    callback = function(ev)
      vim.lsp.start(config, { bufnr = ev.buf })
    end
  })
end

-- On attach capabilities
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client.server_capabilities.completionProvider then
      vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
    end
    if client.server_capabilities.definitionProvider then
      vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
    end
  end,
})
-- vim.diagnostics configuration
vim.diagnostic.config({
  underline = true,         -- Underline problematic lines
  virtual_text = false,     -- Disable virtual text
  severity_sort = true,     -- Sort by severity
  signs = true,             -- Keep signs in the gutter
  update_in_insert = false, -- Don't update diagnostics while in insert mode
})
-- Update location list on diagnostics change
vim.api.nvim_create_autocmd("DiagnosticChanged", {
  group = group,
  callback = function()
    vim.diagnostic.setloclist({ open = false }) -- Set open = true if you want it to open automatically
  end,
})

-- -- Julia LSP
-- vim.lsp.start({
--   name = "julials",
--   cmd = { "julia", "--startup-file=no", "--history-file=no", "-e", [[
--       using LanguageServer, Sockets, SymbolServer
--       server = LanguageServer.LanguageServerInstance(
--         stdin, stdout, Base.current_project(), ""
--       )
--       run(server)
--     ]] },
--   root_dir = vim.fs.find({ "Project.toml", "JuliaProject.toml", ".git" }, { upward = true })[1] or vim.loop.cwd(),
--   filetypes = { "julia" },
-- })

-- Define the Julia LSP configuration
--
-- Create an autocommand group for the LSP
-- local group = vim.api.nvim_create_augroup("UserLspStart", { clear = true })
--
-- -- Create an autocommand to start the Julia LSP for Julia files
-- vim.api.nvim_create_autocmd("FileType", {
--     group = group,
--     pattern = julia_lsp.filetypes,
--     callback = function(ev)
--         -- Start the Julia LSP for the current buffer
--         vim.lsp.start(julia_lsp, { bufnr = ev.buf })
--     end,
-- })

---@type table<string, vim.lsp.ClientConfig>
local servers = {
  lua_ls = {
    name = "lua-language-server",
    cmd = { "lua-language-server" },
    root_dir = vim.fs.root(0,
      { ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml", "selene.toml", "selene.yml", ".git" }),
    filetypes = { "lua" },
  },
  -- add more servers here
  -- julia_ls = {
  --   name = "julia-language-server",
  --   cmd = { "julia", "--startup-file=no", "--history-file=no", "-e",
  --     "using LanguageServer; using Pkg; import StaticLint; import SymbolServer; " ..
  --     "env_path = dirname(Pkg.Types.Context().env.project_file); " ..
  --     "server = LanguageServer.LanguageServerInstance(stdin, stdout, env_path, ''); " ..
  --     "server.runlinter = true; run(server);" },
  --   root_dir = vim.fs.find({ "Project.toml", "JuliaProject.toml", ".git" }, { upward = true })[1] or vim.loop.cwd(),
  --   filetypes = { "julia" },
  -- },
}
local group = vim.api.nvim_create_augroup("UserLspStart", { clear = true })
for name, config in pairs(servers) do
  vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = config.filetypes,
    callback = function(ev)
      vim.lsp.start(servers[name], { bufnr = ev.buf })
    end,
  })
end

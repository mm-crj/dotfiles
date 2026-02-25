-- Auto commands
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   pattern = "*",
--   callback = function() vim.lsp.buf.format() end, -- autoformat on save
--   })

-- vim.api.nvim_create_autocmd("BufWinLeave", {
--     pattern = "*",
--     command = "mkview",
-- })

-- vim.api.nvim_create_autocmd("BufWinEnter", {
--     pattern = "*",
--     command = "silent loadview",
-- })

vim.api.nvim_create_autocmd("FileType",{
  callback = function(ev)
    pcall(vim.treesitter.start)
  end
})

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- function CheckLSPStatus()
--     local clients = vim.lsp.get_active_clients()
--     if next(clients) == nil then
--         print("No LSP clients are active.")
--     else
--         print("Active LSP clients:")
--         for _, client in ipairs(clients) do
--             print(client.name)
--         end
--     end
-- end


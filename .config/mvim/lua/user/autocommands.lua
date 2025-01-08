-- Auto commands
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function() vim.lsp.buf.format() end, -- autoformat on save
})

-- vim.api.nvim_create_autocmd("BufWinLeave", {
--   pattern = "*",
--   command = "mkview",
-- })
--
-- vim.api.nvim_create_autocmd("BufWinEnter", {
--   pattern = "*",
--   callback = function()
--     local success, err = pcall(vim.cmd, "silent loadview")
--     if not success then
--       print("No file to load")
--     end
--   end
-- })


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

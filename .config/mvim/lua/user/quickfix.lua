local severity_map = { "E", "W", "I", "H" }

local parse_diagnostics = function(diagnostics)
  if not diagnostics then return end
  local items = {}
  for _, diagnostic in ipairs(diagnostics) do
    local fname = vim.fn.bufname()
    local position = diagnostic.range.start
    local severity = diagnostic.severity
    table.insert(items, {
      filename = fname,
      type = severity_map[severity],
      lnum = position.line + 1,
      col = position.character + 1,
      text = diagnostic.message:gsub("\r", ""):gsub("\n", " ")
    })
  end
  return items
end

-- redefine unwanted callbacks to be an empty function
-- notice that I keep `vim.lsp.util.buf_diagnostics_underline()`
vim.lsp.util.buf_diagnostics_signs = function() return end
vim.lsp.util.buf_diagnostics_virtual_text = function() return end

update_diagnostics_loclist = function()
  bufnr = vim.fn.bufnr()
  diagnostics = vim.lsp.util.diagnostics_by_buf[bufnr]

  items = parse_diagnostics(diagnostics)
  vim.lsp.util.set_loclist(items)

  vim.api.nvim_command("doautocmd QuickFixCmdPost")
end

vim.api.nvim_command [[autocmd! User LspDiagnosticsChanged lua update_diagnostics_loclist()]]

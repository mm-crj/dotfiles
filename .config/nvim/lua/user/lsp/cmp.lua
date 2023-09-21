-- nvim-cmp setup
local cmp = require("cmp")
local lsp = require('lsp-zero')
local luasnip = require('luasnip')
--   פּ ﯟ   some other good icons
local kind_icons = {
  Text = "",
  Method = "m",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = "",
}
-- find more here: https://www.nerdfonts.com/cheat-sheet

require('lsp-zero').setup_nvim_cmp({
  sources = {
    { name = 'luasnip',                 group_index = 1,  option = { show_autosnippets = true } },
    -- Copilot Source
    { name = 'copilot',                 group_index = 2 },
    -- Other Sources
    { name = 'path',                    group_index = 1 },
    { name = 'buffer',                  group_index = 2 },
    { name = 'nvim_lsp',                group_index = 2 },
    { name = 'nvim_lsp_signature_help', group_index = 2 },
    { name = 'dictionary',              group_index = 2,  keyword_length = 4 },
  },

  mapping = lsp.defaults.cmp_mappings({
    -- go to next placeholder in the snippet
    ['<M-j>'] = cmp.mapping(function(fallback)
      if luasnip.jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end, { 'i', 's' }),

    -- go to previous placeholder in the snippet
    ['<M-k>'] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
    -- ... Your other mappings ...
  }),
  -- ['C-j'] = cmp.mapping(function(fallback)
  --   if cmp.visible() then
  --     cmp.select_next_item()
  --   elseif luasnip.expand_or_jumpable() then
  --     vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
  --   elseif vim.b._copilot_suggestion ~= nil then
  --     vim.fn.feedkeys(vim.api.nvim_replace_termcodes(vim.fn['copilot#Accept'](), true, true, true), '')
  --   else
  --     fallback()
  --   end
  -- end, {
  --   'i',
  --   's',
  -- }),

  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
      vim_item.menu = ({
        path = "[Path]",
        copilot = "[Copilot]",
        nvim_lsp = "[nvim_lsp]",
        buffer = "[Buffer]",
        luasnip = "[LuaSnip]",
        nvim_lsp_signature_help = "[nvim_lsp_signature]",
        dictionary = "[Dict]",
      })[entry.source.name]
      return vim_item
    end,
  },

  enabled = function()
    return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
        or require("cmp_dap").is_dap_buffer()
  end
})

require("cmp_dictionary").setup({
  dic = {
    ["*"] = { "/usr/share/hunspell/en_GB.dic" },
  },
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
  sources = {
    { name = "dap" },
  },
})

return {
  {
    'nvim-orgmode/orgmode',
    event = 'VeryLazy',
    ft = { 'org' },
    config = function()
      -- Setup orgmode
      require('orgmode').setup({
        org_agenda_files = '~/Documents/My_Projects/Agenda/**/*',
        org_default_notes_file = '~/Documents/My_Projects/Agenda/refile.org',
        win_split_mode = { 'float', 0.8 },
        win_border = 'rounded',
        -- ui = {
        --   menu = {
        --     handler = function(data)
        --       -- your handler here, for example:
        --       local options = {}
        --       local options_by_label = {}
        --
        --       for _, item in ipairs(data.items) do
        --         -- Only MenuOption has `key`
        --         -- Also we don't need `Quit` option because we can close the menu with ESC
        --         if item.key and item.label:lower() ~= "quit" then
        --           table.insert(options, item.label)
        --           options_by_label[item.label] = item
        --         end
        --       end
        --
        --       local handler = function(choice)

        --         if not choice then
        --           return
        --         end
        --
        --         local option = options_by_label[choice]
        --         if option.action then
        --           option.action()
        --         end
        --       end
        --
        --       vim.ui.select(options, {
        --         propmt = data.propmt,
        --       }, handler)
        --     end,
        --   },
        -- },
      })

      -- NOTE: If you are using nvim-treesitter with `ensure_installed = "all"` option
      -- add `org` to ignore_install
      -- require('nvim-treesitter.configs').setup({
      --   ensure_installed = 'all',
      --   ignore_install = { 'org' },
      -- })
    end,
  },
}

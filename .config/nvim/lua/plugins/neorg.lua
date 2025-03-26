return {
  "nvim-neorg/neorg",
  lazy = false,  -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
  version = "*", -- Pin Neorg to the latest stable release
  config = function()
    require("neorg").setup({
      load = {
        ["core.defaults"] = {},
        ["core.concealer"] = {
          config = {
            icon_preset = "varied",
          },
          ["core.dirman"] = {
            config = {
              workspaces = {
                notes = "~/Documents/My_Projects/neorg"
              },
              default_workspaces = "notes",
            }
          }
        },
      }
    })
  end
}

return {
  {
    "Pocco81/auto-save.nvim",
    lazy = false,
    enabled = true,
    event = { "InsertLeave" },
    opts = {
      trigger_events = { "InsertLeave" }, -- vim events that trigger auto-save. See :h events
    },
  }
}

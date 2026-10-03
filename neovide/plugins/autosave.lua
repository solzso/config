return {
  {
    "okuuva/auto-save.nvim",
    event = { "InsertLeave", "TextChanged" },
    opts = {
      enabled = true,

      -- Save 2 seconds after you stop typing
      debounce_delay = 1000,

      trigger_events = {
        immediate_save = {
          "BufLeave",
          "FocusLost",
          "QuitPre",
        },
        defer_save = {
          "InsertLeave",
          "TextChanged",
        },
        cancel_deferred_save = {
          "InsertEnter",
        },
      },
    },
  },
}
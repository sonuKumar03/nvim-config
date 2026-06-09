return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    animate = { enabled = true },
    bigfile = { enabled = true },
    bufdelete = { enabled = true },
    dashboard = {
      preset = {
        header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝  ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝   ╚═╝╚═╝     ╚═╝
        ]],
      },
    },
    dim = { enabled = true },
    input = { enabled = true },
    notifier = { enabled = true },
    profiler = { enabled = true },
    scroll = { enabled = true },
    select = { enabled = true },
    statuscolumn = { enabled = true },
    -- Disable everything else explicitly
    git = { enabled = false },
    gitbrowse = { enabled = false },
    indent = { enabled = false },
    lazygit = { enabled = false },
    picker = { enabled = false },
    quickfile = { enabled = false },
    scratch = { enabled = false },
    terminal = { enabled = false },
    toggle = { enabled = false },
    words = { enabled = false },
    zen = { enabled = false },
  },
  keys = {
    { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer (Snacks)" },
  },
}

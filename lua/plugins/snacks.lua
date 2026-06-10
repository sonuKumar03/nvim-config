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
    notifier = { enabled = false },
    profiler = { enabled = true },
    scroll = { enabled = true },
    select = { enabled = true },
    statuscolumn = { enabled = true },
    -- Disable everything else explicitly
    git = { enabled = false },
    gitbrowse = { enabled = false },
    indent = { enabled = true },
    lazygit = { enabled = false },
    picker = { enabled = false },
    quickfile = { enabled = false },
    scratch = { enabled = false },
    terminal = { enabled = false },
    toggle = { enabled = true },
    words = { enabled = true },
    zen = { enabled = false },
  },
  keys = {
    { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer (Snacks)" },
    { "<leader>ud", function() Snacks.toggle.diagnostics():toggle() end, desc = "Toggle Diagnostics" },
    { "<leader>us", function() Snacks.toggle.spelling():toggle() end, desc = "Toggle Spelling" },
    { "<leader>uw", function() Snacks.toggle.option("wrap", { name = "Wrap" }):toggle() end, desc = "Toggle Wrap" },
  },
}

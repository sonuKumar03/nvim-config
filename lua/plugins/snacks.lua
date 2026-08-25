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
    profiler = { enabled = false },
    scroll = { enabled = true },
    select = { enabled = true },
    statuscolumn = { enabled = true },
    -- Disable everything else explicitly
    git = { enabled = false },
    gitbrowse = { enabled = false },
    indent = { enabled = true },
    lazygit = { enabled = true },
    picker = { enabled = false },
    quickfile = { enabled = false },
    scratch = { enabled = false },
    terminal = { enabled = true },
    toggle = { enabled = true },
    words = { enabled = true },
    zen = { enabled = false },
  },
  keys = {
    { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer (Snacks)" },
    { [[<C-\>]], function() Snacks.terminal() end, mode = { "n", "t" }, desc = "Terminal: Toggle" },
    { "<leader>ot", function() Snacks.terminal() end, desc = "Terminal: Toggle" },
    {
      "<leader>gg",
      function()
        if vim.fn.executable("lazygit") == 1 then
          Snacks.lazygit()
        else
          vim.notify("lazygit is not installed. Please run 'brew install lazygit' to enable this feature.", vim.log.levels.WARN)
        end
      end,
      desc = "Git: LazyGit",
    },
    { "<leader>ud", function() Snacks.toggle.diagnostics():toggle() end, desc = "Toggle Diagnostics" },
    { "<leader>us", function() Snacks.toggle.spelling():toggle() end, desc = "Toggle Spelling" },
    { "<leader>uw", function() Snacks.toggle.option("wrap", { name = "Wrap" }):toggle() end, desc = "Toggle Wrap" },
  },
}

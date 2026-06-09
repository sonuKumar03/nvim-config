return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    spec = {
      { "<leader>c", group = "Code" },
      { "<leader>d", group = "Debug" },
      { "<leader>b", group = "Buffers" },
      { "<leader>f", group = "Find" },
      { "<leader>g", group = "Git" },
      { "<leader>h", group = "Help / Cheatsheets" },
      { "<leader>o", group = "Terminal / Tasks" },
      { "<leader>p", group = "Projects" },
      { "<leader>s", group = "Search / Replace" },
      { "<leader>t", group = "Tests" },
      { "<leader>x", group = "Diagnostics" },
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = true })
      end,
      desc = "Keymaps (which-key)",
    },
  },

}

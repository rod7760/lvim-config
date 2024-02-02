-- Built-in Plugins 
-- -------------------
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.dap.active = true

-- which_key 
lvim.builtin.which_key.mappings["H"] = {
  name = "Harpoon",
  m = {"<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", "Show Marks"},
  x = {"<cmd>lua require('harpoon.mark').add_file()<cr>", "Mark File"},
}
lvim.builtin.which_key.mappings["dm"] = { "<cmd>lua require('neotest').run.run()<cr>",
  "Test Method" }
lvim.builtin.which_key.mappings["dM"] = { "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>",
  "Test Method DAP" }
lvim.builtin.which_key.mappings["df"] = {
  "<cmd>lua require('neotest').run.run({vim.fn.expand('%')})<cr>", "Test Class" }
lvim.builtin.which_key.mappings["dF"] = {
  "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>", "Test Class DAP" }
lvim.builtin.which_key.mappings["dS"] = { "<cmd>lua require('neotest').summary.toggle()<cr>", "Test Summary" }

-- Custom Plugins
-- -------------------
lvim.plugins = {
  -- harpoon
  {"ThePrimeagen/harpoon",
    dependencies = {"nvim-lua/plenary.nvim"},
    config = function()
      require('harpoon').setup({
        mark_branch = true
      })
    end
  },
  -- python debugging
  {"nvim-neotest/neotest-python",
    dependencies = {"mfussenegger/nvim-dap-python",
      "nvim-neotest/neotest"},
    config = function()
      require('dap-python').setup('~/.venvs/debugpy/bin/python')
      require("neotest").setup({
        adapters = {
          require("neotest-python")({
            dap = {
              justMyCode = false,
              console = "integratedTerminal",
            },
            args = { "--log-level", "DEBUG", "--quiet" },
            runner = "pytest",
          })
        }
      })
    end
  }
}


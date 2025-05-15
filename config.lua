-- Vim Opts
vim.opt.clipboard:append("unnamedplus") -- I dumb no like registers
vim.opt.relativenumber = true -- relative line numbers

-- make .py.j2 use python lsp and syntax highlight
vim.filetype.add({
  pattern = {
    [ ".*.py.j2" ]  = "python",
  },
})

-- Built-in Plugins
-- -------------------
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.dap.active = true

-- which_key
-- harpoon
lvim.builtin.which_key.mappings["H"] = {
  name = "Harpoon",
  m = {"<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", "Show Marks"},
  x = {"<cmd>lua require('harpoon.mark').add_file()<cr>", "Mark File"},
}
-- neotest
lvim.builtin.which_key.mappings["dm"] = { "<cmd>lua require('neotest').run.run()<cr>",
  "Test Method" }
lvim.builtin.which_key.mappings["dM"] = { "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>",
  "Test Method DAP" }
lvim.builtin.which_key.mappings["df"] = {
  "<cmd>lua require('neotest').run.run({vim.fn.expand('%')})<cr>", "Test Class" }
lvim.builtin.which_key.mappings["dF"] = {
  "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>", "Test Class DAP" }
lvim.builtin.which_key.mappings["dS"] = { "<cmd>lua require('neotest').summary.toggle()<cr>", "Test Summary" }
-- toggle term
lvim.builtin.which_key.mappings["t"] = {
  name = "+Terminal",
  f = { "<cmd>ToggleTerm<cr>", "Floating terminal" },
  v = { "<cmd>2ToggleTerm size=30 direction=vertical<cr>", "Split vertical" },
  h = { "<cmd>2ToggleTerm size=10 direction=horizontal<cr>", "Split horizontal" },
}

-- treesitter
lvim.builtin.treesitter.ensure_installed = {
    "bash",
    "c",
    "javascript",
    "json",
    "lua",
    "python",
    "typescript",
    "tsx",
    "css",
    "rust",
    "cmake",
    "rst",
}


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
      "nvim-neotest/neotest",
      "nvim-neotest/nvim-nio"},
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
  },
  -- whitespace
  {"ntpeters/vim-better-whitespace"}
}


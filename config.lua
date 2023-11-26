-- builtin plugins 
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.dap.active = true
lvim.builtin.which_key.mappings["H"] = {
  name = "Harpoon",
  m = {"<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", "Show Marks"},
  x = {"<cmd>lua require('harpoon.mark').add_file()<cr>", "Mark File"},
}
-- custom plugins 
lvim.plugins = {
  {"ThePrimeagen/harpoon",
    dependencies = {"nvim-lua/plenary.nvim"},
    config = function()
      require('harpoon').setup({
        mark_branch = true
      })
    end
  },
}


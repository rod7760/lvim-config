


-- builtin plugins 
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.dap.active = true
-- https://github.com/nvim-tree/nvim-tree.lua/wiki/Open-At-Startup
--[[
-- TODO not sure how I feel about this
local function open_nvim_tree(data)
  -- buffer is a real file on the disk
  local real_file = vim.fn.filereadable(data.file) == 1

  -- buffer is a [No Name]
  local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

  if not real_file and not no_name then
    return
  end

  -- open the tree, find the file but don't focus it
  require("nvim-tree.api").tree.toggle({ focus = false, find_file = true, })
end
vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
]]

-- custom plugins
lvim.plugins = {
  -- TODO not sure if I like specifying deps multiple times
  {"mxsdev/nvim-dap-vscode-js", dependencies = {"mfussenegger/nvim-dap"}},
  {"rcarriga/nvim-dap-ui", dependencies = {"mfussenegger/nvim-dap"}},
  {"jay-babu/mason-nvim-dap.nvim", dependencies = {"williamboman/mason.nvim", "mfussenegger/nvim-dap"}}
}

-- autoinstall DAPS
-- must be setup in this order due to mason-nvim-dap
-- TODO can't get this to work for some reason
-- For now just do :MasonInstall js-debug-adapter
--[[
require("mason").setup()
require("mason-nvim-dap").setup({
  automatic_setup = true,
  ensure_installed = {
    "js-debug-adapter"
  },
  enabled = true,
  handlers = {}
})
]]

-- dap javascript/typescript
require("dap-vscode-js").setup({

  debugger_path = vim.fn.stdpath('data') .. '/mason/packages/js-debug-adapter',
  debugger_cmd = { 'js-debug-adapter' },
  adapters = {'chrome', 'pwa-node','pwa-chrome'}
})

for _, language in ipairs({ "typescript", "javascript" }) do
  require("dap").configurations[language] = {
{
      type = "pwa-node",
      request = "attach",
      name = "Attach Program (pwa-node, select pid)",
      cwd = "${workspaceFolder}",
      processId = require 'dap.utils'.pick_process,
      skipFiles = { "<node_internals>/**" },
    },
    {
      type = "pwa-chrome",
      request = "launch",
      name = "Start Chrome with \"localhost\"",
      url = "http://localhost:3000",
      webRoot = "${workspaceFolder}",
      userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir"
    }

  }
end

-- dap dapui
require("dapui").setup()

local dap, dapui = require("dap"), require("dapui")

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open({})
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close({})
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close({})
end

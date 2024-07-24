local lsputil = require("lspconfig/util")
-- local lspconfig = require "lspconfig"

return {
  "neovim/nvim-lspconfig",
  ---@class PluginLspOpts
  opts = {
    -- Disable autoformat
    autoformat = false,
    ---@type lspconfig.options
    servers = {
      pylsp = {
        enable = false,
        cmd = { "/home/eash/.local/share/nvim/mason/bin/pylsp" },
        -- cmd = { '/home/eash/scratch/.local/nvim/lsp_servers/pylsp/venv/bin/pylsp', '-v', '-v', '--log-file', '/home/eash/pylsp.log' },
        cmd_env = {
          VIRTUAL_ENV = ".venv",
          PATH = lsputil.path.join(".venv", "bin") .. ":" .. vim.env.PATH,
        },
        settings = {
          pylsp = {
            configurationSources = { "flake8" },
            plugins = {
              black = { enabled = false },               -- black doesn't use executable
              flake8 = {
                enabled = false,
                ignore = { "BLK100", "E1", "E2", "E3", "E5", "I", "W291" },
                executable = ".venv/bin/flake8",
              },
              jedi = { environment = ".venv/bin/python" },
              mccabe = { enabled = false },
              mypy = { enabled = false },               -- mypy does not use executable
              pycodestyle = { enabled = false },
              pydocstyle = { enabled = false },
              pyflakes = { enabled = false },
              pylint = { enabled = false },
              rope_autoimport = { enabled = true },
              yapf = { enabled = false },
              ruff = { enabled = true },
            },
          },
        },
        on_new_config = function(new_config, new_root_dir)
          local py = require("utils.python.lua")
          py.env(new_root_dir)
          new_config.settings.pylsp.plugins.jedi.environment = py.get_python_dir(new_root_dir)
        end,
      },
    },
  },
}

local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "isort", "pylint", "black", "flake8" },
    --javascript = {"prettier"},
    -- css = { "prettier" },
    -- html = { "prettier" },
  },
  -- format_on_save = {
  --   -- These options will be passed to conform.format()
  --   timeout_ms = 500,
  --   lsp_fallback = true,
  -- },
}

local conform = require('conform')
conform.setup(options)
-- conform.formatters.flake8 = {
--  command = "/home/rcms/.local/share/nvim/mason/flake8",
-- }
--
conform.formatters.flake8 = function(bufnr)
  return {
    command = require("conform.util").find_executable({
      "/home/rcms/.local/share/nvim/mason/flake8",
    }, "flake8"),
  }
end

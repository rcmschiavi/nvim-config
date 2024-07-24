vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"
local lazy = require "lazy"
lazy.setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
    config = function()
      require "options"
    end,
  },

  { import = "plugins" },
  { import = "lazygit_local" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)

local lspconfig = require "lspconfig"

local ruff_config_path = vim.loop.os_homedir() .. "/.config/ruff/ruff.toml"
lspconfig.ruff_lsp.setup {
  init_options = {
    settings = {
      format = {
        args = { "--config=" .. ruff_config_path },
      },
      lint = {
        args = { "--config=" .. ruff_config_path },
      },
    },
  },
}
lspconfig.pyright.setup {}
local pylsp = lspconfig.pylsp
pylsp.setup {
  settings = {
    pylsp = {
      plugins = {
        rope_autoimport = {
          enabled = true,
        },
        flake8 = {
          enabled = true,
          -- ignore = { "BLK100", "E1", "E2", "E3", "E5", "I", "W291" },
          -- executable = ".venv/bin/flake8",
          maxLineLength = 119,
        },
        pycodestyle = {
          maxLineLength = 119,
        },
      },
    },
  },
}

-- print(pylsp.plugins)
-- pylsp.plugins.rope_autoimport.enabled = true
require "gitsigns_local"

lspconfig.tsserver.setup {}

lspconfig.svelte.setup {}

lspconfig.gopls.setup {
  cmd = { 'gopls' },
  -- for postfix snippets and analyzers
  capabilities = capabilities,
  settings = {
    gopls = {
      experimentalPostfixCompletions = true,
      analyses = {
        unusedparams = true,
        shadow = true,
      },
      staticcheck = true,
    },
  },
  on_attach = on_attach,
}

function goimports(timeoutms)
  local context = { source = { organizeImports = true } }
  vim.validate { context = { context, "t", true } }

  local params = vim.lsp.util.make_range_params()
  params.context = context

  -- See the implementation of the textDocument/codeAction callback
  -- (lua/vim/lsp/handler.lua) for how to do this properly.
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms)
  if not result or next(result) == nil then return end
  local actions = result[1].result
  if not actions then return end
  local action = actions[1]

  -- textDocument/codeAction can return either Command[] or CodeAction[]. If it
  -- is a CodeAction, it can have either an edit, a command or both. Edits
  -- should be executed first.
  if action.edit or type(action.command) == "table" then
    if action.edit then
      vim.lsp.util.apply_workspace_edit(action.edit)
    end
    if type(action.command) == "table" then
      vim.lsp.buf.execute_command(action.command)
    end
  else
    vim.lsp.buf.execute_command(action)
  end
end

require("obsidian").setup({
  workspaces = {
    {
      name = "personal",
      path = "~/vaults/personal",
    },
    {
      name = "work",
      path = "~/vaults/work",
    },
  },
  follow_url_func = function(url)
    -- Open the URL in the default web browser.
    -- vim.fn.jobstart({ "open", url }) -- Mac OS
    vim.fn.jobstart({ "xdg-open", url }) -- linux
  end,

})


-- require("notify").setup({
--   background_colour = "#000000",
-- })

require("pomo").setup({
  opts = { -- How often the notifiers are updated.
    update_interval = 1000,

    -- Configure the default notifiers to use for each timer.
    -- You can also configure different notifiers for timers given specific names, see
    -- the 'timers' field below.
    notifiers = {
      -- The "Default" notifier uses 'vim.notify' and works best when you have 'nvim-notify' installed.
      {
        name = "Default",
        opts = {
          -- With 'nvim-notify', when 'sticky = true' you'll have a live timer pop-up
          -- continuously displayed. If you only want a pop-up notification when the timer starts
          -- and finishes, set this to false.
          sticky = true,

          -- Configure the display icons:
          title_icon = "󱎫",
          text_icon = "󰄉",
          -- Replace the above with these if you don't have a patched font:
          -- title_icon = "⏳",
          -- text_icon = "⏱️",
        },
      },

      -- The "System" notifier sends a system notification when the timer is finished.
      -- Available on MacOS and Windows natively and on Linux via the `libnotify-bin` package.
      { name = "System" },

      -- You can also define custom notifiers by providing an "init" function instead of a name.
      -- See "Defining custom notifiers" below for an example 👇
      -- { init = function(timer) ... end }
    },

    -- Override the notifiers for specific timer names.
    timers = {
      -- For example, use only the "System" notifier when you create a timer called "Break",
      -- e.g. ':TimerStart 2m Break'.
      Break = {
        { name = "System" },
      },
    }
  },
})

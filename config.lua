-- vim.opt.colorcolumn = "88" -- vertical line for line length
vim.opt.wrap = true      -- wrap lines
vim.opt.linebreak = true -- don't split words when wrapping lines

-- treesitter
lvim.builtin.treesitter.ensure_installed = {
  "bash", "json", "lua", "python", "latex", "yaml",
}

-- lsp
lvim.lsp.installer.setup.ensure_installed = {
  "pyright", "texlab",
}
--formatters
local formatters = require "lvim.lsp.null-ls.formatters"
require("lvim.lsp.manager").setup("marksman")
formatters.setup {
  {
    name = "black",
    extra_args = { "--line-length", "88" },
    filetypes = { "python" }
  },
}
lvim.format_on_save.enabled = true

vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = true,
  severity_sort = false,
})

vim.api.nvim_create_autocmd("CursorHold", {
  buffer = buffnr,
  callback = function()
    local opts = {
      focusable = false,
      close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
      border = 'rounded',
      source = 'always',
      prefix = ' ',
      scope = 'cursor',
    }
    vim.diagnostic.open_float(nil, opts)
  end
})
-- Installing Plugins
local config = {
  cache_activate = true,
  cache_filetypes = { 'tex', 'bib' },
  cache_root = vim.fn.stdpath('cache'),
  reverse_search_start_cmd = function()
    return true
  end,
  reverse_search_edit_cmd = vim.cmd.edit,
  reverse_search_end_cmd = function()
    return true
  end,
  file_permission_mode = 438,
}
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "texlab" })
lvim.plugins = {
  "mfussenegger/nvim-dap-python",
  {
    "iamcco/markdown-preview.nvim",
    config = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
  {
    'f3fora/nvim-texlabconfig',
    ft = { 'tex', 'bib' },
    build = "go build -o $GOPATH/bin/",
    config = function() require('texlabconfig').setup(config) end,
  },
  "dapt4/vim-autoSurround",
  'luisiacc/gruvbox-baby',
  "EdenEast/nightfox.nvim",
  "rebelot/kanagawa.nvim"
  -- {
  --   'folke/styler.nvim',
  --   config = function()
  --     require("styler").setup({
  --       themes = {
  --         python = { colorscheme = "slate" }
  --       }
  --     })
  --   end
  -- },

}
-- Nightfox Setup
require('nightfox').setup({
  options = {
    styles = {           -- Style to be applied to different syntax groups
      comments = "NONE", -- Value is any valid attr-list value `:help attr-list`
      conditionals = "NONE",
      constants = "NONE",
      functions = "italic",
      keywords = "NONE",
      numbers = "NONE",
      operators = "NONE",
      strings = "NONE",
      types = "NONE",
      variables = "NONE",
    }
  }
})
--

lvim.builtin.dap.active = true
local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/")
pcall(function()
  require("dap-python").setup(mason_path .. "packages/debugpy/venv/bin/python")
end)
lvim.colorscheme = "nightfox"
-- vim.opt.background = "dark"
-- Latex Config
local executable = 'zathura'
local args = {
  '--synctex-editor-command',
  [[nvim-texlabconfig -file '%%%{input}' -line %%%{line} -server ]] .. vim.v.servername,
  '--synctex-forward',
  '%l:1:%f',
  '%p',
}
require("lvim.lsp.manager").setup("texlab", {
  settings = {
    -- latex = {
    --   build = {
    --     args = {
    --       "-pdf", "-synctex=1", "-pv", "-interaction=nonstopmode", "-outdir=build"
    --     }
    --   }
    -- },
    texlab = {
      rootDirectory = nil,
      build = {
        executable = "latexmk",
        args = { "-shell-escape", "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
        onSave = true,
        forwardSearchAfter = false,
      },
      auxDirectory = '.',
      forwardSearch = {
        executable = executable,
        args = args,
      },
      chktex = {
        onOpenAndSave = false,
        onEdit = false
      },
      diagnosticsDelay = 300,
    },
  },
})
-- Build Options
---- keymappings
lvim.leader = "space"
lvim.builtin.which_key.mappings["x"] = {
  name = "+LaTeX",
  c = { "<cmd>TexlabBuild<cr>", "Compile" },
  x = { "<cmd>TexlabForward<cr>", "Compile and Search" },
}

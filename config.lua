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
require("nvim-treesitter.configs").setup({
  highlight = {
    enable = true,
    disable = { "latex" },
    additional_vim_regex_highlighting = { "latex" },
  },
  --other treesitter settings
})
require("luasnip.loaders.from_lua").lazy_load { paths = "~/.config/lvim/luasnippets" }
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "texlab" })

--formatters
local capabilities = require("lvim.lsp").common_capabilities()
require("lvim.lsp.manager").setup("texlab", {
  on_attach = require("lvim.lsp").common_on_attach,
  on_init = require("lvim.lsp").common_on_init,
  capabilities = capabilities,
})

local formatters = require "lvim.lsp.null-ls.formatters"
require("lvim.lsp.manager").setup("marksman")
formatters.setup {
  {
    name = "black",
    extra_args = { "--line-length", "88" },
    filetypes = { "python" }
  }
}
-- formatters.setup {
--   {
--     name = "latexindent",
--     filetypes = { "tex" }
--   }
-- }
lvim.format_on_save.enabled = true
lvim.format_on_save.timeout = 10000
vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = false,
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
-- Theme for Latex

vim.cmd([[
autocmd FileType tex colorscheme dayfox
]])

-- Enable Relative line numbers
vim.wo.relativenumber = true
lvim.plugins = {
  "mfussenegger/nvim-dap-python",
  -- "hrsh7th/nvim-cmp",
  'rbberger/vim-singularity-syntax',
  {
    "lervag/vimtex",
    init = function()
      -- Define a function to setup VimTeX configuration
      -- Enable filetype detection and plugin
      vim.cmd('filetype plugin on')
      -- Set compiler to use for compiling LaTeX files
      vim.g.vimtex_compiler_latexmk = {
        executable = 'latexmk',
        continuous = 1,
        options = {
          '-xelatex',
          '-file-line-error',
          '-synctex=1',
          '-interaction=nonstopmode',
        },
      }
      -- Use Zathura as the default PDF viewer
      vim.g.vimtex_view_method = 'zathura'
      -- Sync PDF with source
      vim.g.vimtex_view_general_options = '-x "zathura --synctex-forward=%n:0:%b"'
      -- Enable automatic completion of LaTeX commands
      vim.g.vimtex_complete_enabled = 1
      -- vim.cmd('autocmd BufWritePost *.tex VimtexCompile')
      -- vim.cmd("set conceallevel=2")
    end
  },
  "EdenEast/nightfox.nvim",
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
lvim.colorscheme = "duskfox"
-- Build Options
---- keymappings
lvim.leader = "space"
lvim.builtin.which_key.mappings["x"] = {
  name = "+LaTeX",
  c = { "<cmd>VimtexCompile<cr>", "Compile" },
  x = { "<cmd>VimtexView<cr>", "Compile and Search" },
}

lvim.builtin.which_key.mappings["l"]["f"] = {
  function()
    require("lvim.lsp.utils").format { timeout_ms = 10000 }
  end,
  "Format",
}

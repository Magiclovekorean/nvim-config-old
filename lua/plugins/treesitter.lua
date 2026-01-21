return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  opts = {  -- CHANGE config() to opts = 
    ensure_installed = { "html", "css", "javascript", "typescript", "tsx" },
    highlight = { enable = true },
    indent = { enable = true },
    auto_install = true,
  },
  dependencies = {
    'windwp/nvim-ts-autotag',
  },
}


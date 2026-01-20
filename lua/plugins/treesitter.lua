return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,

  dependencies = {
    'windwp/nvim-ts-autotag',
  },

  config = function()
    
    vim.api.nvim_create_autocmd('FileType', {
      pattern = {
        'html',
        'css',
        'javascript',
        'javascriptreact',
        'typescriptreact',
        'python',
        'markdown',
      },
      callback = function()
        vim.treesitter.start()
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}

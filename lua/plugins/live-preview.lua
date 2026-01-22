return {
    'brianhuster/live-preview.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    config = function()
       vim.o.autowriteall = true
       vim.api.nvim_create_autocmd({ 'InsertLeavePre', 'TextChanged', 'TextChangedP' }, {
	   pattern = '*', callback = function()
	       vim.cmd('silent! write')
	   end
       }) 
    end,
}


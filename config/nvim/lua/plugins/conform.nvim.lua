return {
    'stevearc/conform.nvim',
    config = function(PluginSpec, opts)
        require('conform').setup(opts)
        local autocmd = vim.api.nvim_create_autocmd
        autocmd('BufWritePre', {
            callback = function(args)
                require('conform').format({ bufnr = args.buf })
            end,
            pattern = '*'
        })
    end,
    opts = {}
}

return {
    'stevearc/conform.nvim',
    init = function()
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

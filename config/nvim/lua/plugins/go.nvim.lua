return {
    'ray-x/go.nvim',
    build = ':lua require("go.install").update_all_sync()',
    config = function()
        require('go').setup()
        local augroup = vim.api.nvim_create_augroup
        local autocmd = vim.api.nvim_create_autocmd
        augroup('GoFormat', {})
        autocmd('BufWritePre', {
            callback = function()
                require('go.format').goimports()
            end,
            group = 'GoFormat',
            pattern = '*.go'
        })
    end,
    event = {
        'CmdlineEnter'
    },
    ft = {
        'go',
        'gomod'
    }
}

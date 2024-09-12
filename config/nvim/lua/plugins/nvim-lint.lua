return {
    'mfussenegger/nvim-lint',
    config = function()
        local autocmd = vim.api.nvim_create_autocmd
        autocmd('BufWritePost', {
            callback = function()
                require('lint').try_lint()
            end
        })
    end
}

return {
    'kevinhwang91/nvim-hlslens',
    dependencies = {
        {
            'kevinhwang91/nvim-ufo',
            dependencies = {
                'kevinhwang91/promise-async'
            },
            init = function()
                local map = vim.keymap.set
                map('n', 'zM', require('ufo').closeAllFolds)
                map('n', 'zR', require('ufo').openAllFolds)
            end
        }
    },
    init = function()
        local map = vim.api.nvim_set_keymap
        local opts = {
            noremap = true,
            silent = true
        }
        map('n', '#', [[#<Cmd>lua require('hlslens').start()<Cr>]], opts)
        map('n', '*', [[*<Cmd>lua require('hlslens').start()<Cr>]], opts)
        map('n', '<Leader>l', '<Cmd>noh<Cr>', opts)
        map('n', 'N', [[<Cmd>execute('normal! ' . v:count1 . 'N')<Cr><Cmd>lua require('hlslens').start()<Cr>]], opts)
        map('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<Cr>]], opts)
        map('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<Cr>]], opts)
        map('n', 'n', [[<Cmd>execute('normal! ' . v:count1 . 'n')<Cr><Cmd>lua require('hlslens').start()<Cr>]], opts)
    end
}

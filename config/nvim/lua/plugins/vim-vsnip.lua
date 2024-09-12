return {
    'hrsh7th/vim-vsnip',
    init = function()
        local map = vim.api.nvim_set_keymap
        map('i', '<C-j>', 'vsnip#expandable() ? "<Plug>(vsnip-expand)" : "<C-j>"', { expr = true })
        map('i', '<C-l>', 'vsnip#available(1) ? "<Plug>(vsnip-expand-or-jump)" : "<C-l>"', { expr = true })
        map('i', '<S-Tab>', 'vsnip#jumpable(-1) ? "<Plug>(vsnip-jump-prev)" : "<S-Tab>"', { expr = true })
        map('i', '<Tab>', 'vsnip#jumpable(1) ? "<Plug>(vsnip-jump-next)" : "<Tab>"', { expr = true })
        map('n', 'S', '<Plug>(vsnip-cut-text)', {})
        map('n', 's', '<Plug>(vsnip-select-text)', {})
        map('s', '<C-j>', 'vsnip#expandable() ? "<Plug>(vsnip-expand)" : "<C-j>"', { expr = true })
        map('s', '<C-l>', 'vsnip#available(1) ? "<Plug>(vsnip-expand-or-jump)" : "<C-l>"', { expr = true })
        map('s', '<S-Tab>', 'vsnip#jumpable(-1) ? "<Plug>(vsnip-jump-prev)" : "<S-Tab>"', { expr = true })
        map('s', '<Tab>', 'vsnip#jumpable(1) ? "<Plug>(vsnip-jump-next)" : "<Tab>"', { expr = true })
        map('x', 'S', '<Plug>(vsnip-cut-text)', {})
        map('x', 's', '<Plug>(vsnip-select-text)', {})
        vim.g.vsnip_filetypes = {
            javascriptreact = {
                'javascript'
            },
            typescriptreact = {
                'typescript'
            }
        }
    end
}

return {
    'romgrk/barbar.nvim',
    dependencies = {
        'lewis6991/gitsigns.nvim',
        'nvim-tree/nvim-web-devicons'
    },
    init = function()
        vim.g.barbar_auto_setup = false
        local map = vim.api.nvim_set_keymap
        local opts = {
            noremap = true,
            silent = true
        }
        map('n', '<A-,>', '<Cmd>BufferPrevious<Cr>', opts)
        map('n', '<A-.>', '<Cmd>BufferNext<Cr>', opts)
        map('n', '<A-1>', '<Cmd>BufferGoto 1<Cr>', opts)
        map('n', '<A-2>', '<Cmd>BufferGoto 2<Cr>', opts)
        map('n', '<A-3>', '<Cmd>BufferGoto 3<Cr>', opts)
        map('n', '<A-4>', '<Cmd>BufferGoto 4<Cr>', opts)
        map('n', '<A-5>', '<Cmd>BufferGoto 5<Cr>', opts)
        map('n', '<A-6>', '<Cmd>BufferGoto 6<Cr>', opts)
        map('n', '<A-7>', '<Cmd>BufferGoto 7<Cr>', opts)
        map('n', '<A-8>', '<Cmd>BufferGoto 8<Cr>', opts)
        map('n', '<A-9>', '<Cmd>BufferGoto 9<Cr>', opts)
        map('n', '<A-0>', '<Cmd>BufferLast<Cr>', opts)
        map('n', '<A-<>', '<Cmd>BufferMovePrevious<Cr>', opts)
        map('n', '<A->>', '<Cmd>BufferMoveNext<Cr>', opts)
        map('n', '<A-c>', '<Cmd>BufferClose<Cr>', opts)
        map('n', '<A-p>', '<Cmd>BufferPin<Cr>', opts)
        map('n', '<C-p>', '<Cmd>BufferPick<Cr>', opts)
        map('n', '<Space>bb', '<Cmd>BufferOrderByBufferNumber<Cr>', opts)
        map('n', '<Space>bd', '<Cmd>BufferOrderByDirectory<Cr>', opts)
        map('n', '<Space>bl', '<Cmd>BufferOrderByLanguage<Cr>', opts)
        map('n', '<Space>bn', '<Cmd>BufferOrderByName<Cr>', opts)
        map('n', '<Space>bw', '<Cmd>BufferOrderByWindowNumber<Cr>', opts)
    end,
    opts = {
    }
}

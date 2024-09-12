return {
    'linrongbin16/gitlinker.nvim',
    cmd = 'GitLink',
    keys = {
        { '<Leader>gY', '<Cmd>GitLink!<Cr>', desc = 'Open git link', mode = { 'n', 'v' } },
        { '<Leader>gy', '<Cmd>GitLink<Cr>', desc = 'Yank git link', mode = { 'n', 'v' } }
    },
    opts = {}
}

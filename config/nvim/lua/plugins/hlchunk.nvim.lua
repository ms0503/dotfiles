return {
    'shellRaining/hlchunk.nvim',
    event = {
        'BufNewFile',
        'BufReadPre'
    },
    opts = {
        blank = {
            enable = true
        },
        chunk = {
            enable = true
        },
        indent = {
            enable = true
        },
        line_num = {
            enable = true
        }
    }
}

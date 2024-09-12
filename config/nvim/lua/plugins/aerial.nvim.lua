return {
    'stevearc/aerial.nvim',
    keys = {
        { '<Leader>a', '<Cmd>AerialToggle!<Cr>', mode = { 'n' } }
    },
    opts = {
        on_attach = function(bufnr)
            local map = vim.keymap.set
            map('n', '{', '<Cmd>AerialPrev<Cr>', { buffer = bufnr })
            map('n', '}', '<Cmd>AerialNext<Cr>', { buffer = bufnr })
        end
    }
}

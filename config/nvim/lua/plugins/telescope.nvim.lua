return {
    'nvim-telescope/telescope.nvim',
    config = function(PluginSpec, opts)
        require('telescope').setup(opts)
        local builtin = require('telescope.builtin')
        local map = vim.keymap.set
        local autocmd = vim.api.nvim_create_autocmd
        map('n', '<Leader>fb', builtin.buffers, { noremap = true })
        map('n', '<Leader>ff', builtin.find_files, { noremap = true })
        map('n', '<Leader>fg', builtin.live_grep, { noremap = true })
        map('n', '<Leader>fh', builtin.help_tags, { noremap = true })
        autocmd('User', {
            callback = function(args)
                if args.data.bufname:match('*.csv') then
                    vim.wo.wrap = false
                end
            end,
            pattern = 'TelescopePreviewerLoaded'
        })
    end,
    opts = {
        defaults = {
            mappings = {
                i = {
                    ['<C-h>'] = 'which_key'
                }
            }
        },
        extensions = {},
        pickers = {}
    }
}

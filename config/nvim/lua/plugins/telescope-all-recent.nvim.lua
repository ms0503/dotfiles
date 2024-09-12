return {
    'prochri/telescope-all-recent.nvim',
    config = function(PluginSpec, opts)
        require('telescope-all-recent').setup(opts)
        local map = vim.keymap.set
        map('n', '<Leader>f', function() require('telescope').builtins.find_files() end)
    end,
    opts = {}
}

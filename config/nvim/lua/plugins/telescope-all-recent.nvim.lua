return {
    'prochri/telescope-all-recent.nvim',
    dependencies = {
        'kkharji/sqlite.lua',
        'nvim-telescope/telescope.nvim',
        'stevearc/dressing.nvim'
    },
    init = function()
        local map = vim.keymap.set
        map('n', '<Leader>f', function() require('telescope').builtins.find_files() end)
    end,
    opts = {}
}

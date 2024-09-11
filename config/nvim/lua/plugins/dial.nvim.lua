return {
    'monaqa/dial.nvim',
    init = function()
        local map = vim.keymap.set
        map('n', '<C-a>', function() require('dial.map').manipulate('increment', 'normal') end)
        map('n', '<C-x>', function() require('dial.map').manipulate('decrement', 'normal') end)
        map('n', 'g<C-a>', function() require('dial.map').manipulate('increment', 'gnormal') end)
        map('n', 'g<C-x>', function() require('dial.map').manipulate('decrement', 'gnormal') end)
        map('v', '<C-a>', function() require('dial.map').manipulate('increment', 'visual') end)
        map('v', '<C-x>', function() require('dial.map').manipulate('decrement', 'visual') end)
        map('v', 'g<C-a>', function() require('dial.map').manipulate('increment', 'gvisual') end)
        map('v', 'g<C-x>', function() require('dial.map').manipulate('decrement', 'gvisual') end)
        local augend = require('dial.augend')
        require('dial.config').augends:register_group({
            default = {
                augend.integer.alias.decimal,
                augend.integer.alias.hex,
                augend.date.alias['%Y/%m/%d']
            }
        })
    end
}

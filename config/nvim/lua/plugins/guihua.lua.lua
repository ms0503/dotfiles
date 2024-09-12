return {
    'ray-x/guihua.lua',
    build = function()
        vim.fn.system('cd lua/fzy && make')
    end,
    opts = {}
}

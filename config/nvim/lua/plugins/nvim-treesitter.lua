return {
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    config = function(PluginSpec, opts)
        require('nvim-treesitter.configs').setup(opts)
    end,
    opts = {
        auto_install = true,
        ensure_installed = {},
        highlight = {
            additional_vim_regex_highlighting = true,
            disable = function(lang, buf)
                local max_filesize = 100 * 1024
                local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                if ok and stats and max_filesize < stats.size then
                    return true
                end
                return false
            end,
            enable = true
        },
        ignore_install = {},
        sync_install = false
    }
}

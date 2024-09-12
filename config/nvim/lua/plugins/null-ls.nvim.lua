return {
    'jose-elias-alvarez/null-ls.nvim',
    config = function(PluginSpec, opts)
        local self = require('null-ls')
        opts.sources = {
            self.builtins.diagnostics.cspell.with({
                condition = function()
                    return 0 < vim.fn.executable('cspell')
                end,
                diagnostics_postprocess = function(diagnostic)
                    diagnostic.severity = vim.diagnostic.severity.WARN
                end,
                extra_args = {
                    '--config', '~/.config/cspell/cspell.json'
                }
            })
        }
        self.setup(opts)
    end,
    opts = {}
}

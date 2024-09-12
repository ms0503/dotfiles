return {
    'williamboman/mason-lspconfig.nvim',
    config = function(PluginSpec, opts)
        local self = require('mason-lspconfig')
        self.setup(opts)
        self.setup_handlers({
            function(server_name)
                require('lspconfig')[server_name].setup({
                    capabilities = require('cmp_nvim_lsp').default_capabilities(),
                    on_attach = function(client, bufnr)
                        local map = vim.keymap.set
                        map('n', '<C-m>', vim.lsp.buf.signature_help)
                        map('n', '<Space>e', vim.lsp.diagnostic.show_line_diagnostics)
                        map('n', 'K', vim.lsp.buf.hover)
                        map('n', '[d', vim.lsp.diagnostic.goto_prev)
                        map('n', ']d', vim.lsp.diagnostic.goto_next)
                        map('n', 'gd', vim.lsp.buf.definition)
                        map('n', 'gr', vim.lsp.buf.references)
                        map('n', 'gt', vim.lsp.buf.type_definition)
                        map('n', 'ma', vim.lsp.buf.code_action)
                        map('n', 'rn', vim.lsp.buf.rename)
                    end
                })
            end,
            ['rust_analyzer'] = function()
            end
        })
        vim.opt.completeopt = 'menu,menuone,noselect'
    end,
    opts = {}
}

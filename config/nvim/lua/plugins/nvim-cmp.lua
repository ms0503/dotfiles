return {
    'hrsh7th/nvim-cmp',
    config = function(PluginSpec, opts)
        local self = require('cmp')
        opts.formatting = {
            before = function(entry, vim_item)
                return vim_item
            end,
            format = require('lspkind').cmp_format({
                ellipsis_char = '...',
                maxwidth = function()
                    return math.floor(0.45 * vim.o.columns)
                end,
                mode = 'symbol_text',
                show_labelDetails = true
            })
        }
        opts.mapping = self.mapping.preset.insert({
            ['<C-Space>'] = self.mapping.complete(),
            ['<C-b>'] = self.mapping.scroll_docs(-4),
            ['<C-f>'] = self.mapping.scroll_docs(4),
            ['<Cr>'] = self.mapping.confirm({ select = true }),
            ['<Esc>'] = self.mapping.abort()
        })
        self.setup(opts)
        self.setup.filetype('gitcommit', {
            sources = self.config.sources({
                { name = 'buffer' }
            }, {
                { name = 'git' }
            })
        })
        self.setup.cmdline({ '/', '?' }, {
            mapping = self.mapping.preset.cmdline(),
            sources = {
                { name = 'buffer' }
            }
        })
        self.setup.cmdline(':', {
            mapping = self.mapping.preset.cmdline(),
            matching = {
                disallow_symbol_nonprefix_matching = false
            },
            sources = self.config.sources({
                { name = 'cmdline' }
            }, {
                { name = 'path' }
            })
        })
    end,
    opts = {
        snippet = {
            expand = function(args)
                vim.fn['vsnip#anonymous'](args.body)
            end
        },
        sources = {
            { name = 'buffer' },
            { group_index = 0, name = 'lazydev' },
            { name = 'nvim_lsp' },
            { name = 'path' },
            { name = 'vsnip' }
        },
        window = {}
    }
}

return {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
        lsp = {
            override = {
                ['cmp.entry.get_documentation'] = true,
                ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
                ['vim.lsp.util.stylize_markdown'] = true
            }
        },
        presets = {
            bottom_search = true,
            command_palette = true,
            inc_rename = false,
            long_message_to_split = true,
            lsp_doc_border = true
        }
    }
}

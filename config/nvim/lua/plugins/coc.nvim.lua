return {
    'neoclide/coc.nvim',
    branch = 'release',
    init = function()
        local augroup = vim.api.nvim_create_augroup
        local autocmd = vim.api.nvim_create_autocmd
        local cmd = vim.api.nvim_create_user_command
        local map = vim.api.nvim_set_keymap
        map('i', '<C-Space>', 'coc#refresh()', { expr = true, silent = true })
        map('n', '<C-s>', '<Plug>(coc-range-select)', { silent = true })
        map('n', '<Leader>f', '<Plug>(coc-format-selected)', { silent = true })
        map('n', '<Leader>r', '<Plug>(coc-codeaction-refactor-selected)', { silent = true })
        map('n', '<Leader>re', '<Plug>(coc-codeaction-refactor)', { silent = true })
        map('n', '<Leader>rn', '<Plug>(coc-rename)', { silent = true })
        map('n', '[g', '<Plug>(coc-diagnostic-prev)', { silent = true })
        map('n', ']g', '<Plug>(coc-diagnostic-next)', { silent = true })
        map('n', 'gd', '<Plug>(coc-definition)', { silent = true })
        map('n', 'gi', '<Plug>(coc-implementation)', { silent = true })
        map('n', 'gr', '<Plug>(coc-references)', { silent = true })
        map('n', 'gy', '<Plug>(coc-type-definition)', { silent = true })
        map('x', '<C-s>', '<Plug>(coc-range-select)', { silent = true })
        map('x', '<Leader>f', '<Plug>(coc-format-selected)', { silent = true })
        map('x', '<Leader>r', '<Plug>(coc-codeaction-refactor-selected)', { silent = true })
        local opts = {
            expr = true,
            noremap = true,
            replace_keycodes = false,
            silent = true
        }
        map('i', '<C-j>', '<Plug>(coc-snippets-expand-jump)', opts)
        map('i', '<Cr>', [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<Cr>\<C-r>=coc#on_enter()\<Cr>"]], opts)
        map('i', '<S-Tab>', [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)
        map('i', '<Tab>', 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<Tab>" : coc#refresh()', opts)
        local opts = {
            nowait = true,
            silent = true
        }
        map('n', '<Leader>a', '<Plug>(coc-codeaction-selected)', opts)
        map('n', '<Leader>ac', '<Plug>(coc-codeaction-cursor)', opts)
        map('n', '<Leader>as', '<Plug>(coc-codeaction-source)', opts)
        map('n', '<Leader>cl', '<Plug>(coc-codelens-action)', opts)
        map('n', '<Leader>qf', '<Plug>(coc-fix-current)', opts)
        map('n', '<Space>a', ':<C-u>CocList diagnostics<Cr>', opts)
        map('n', '<Space>c', ':<C-u>CocList commands<Cr>', opts)
        map('n', '<Space>e', ':<C-u>CocList extensions<Cr>', opts)
        map('n', '<Space>j', ':<C-u>CocNext<Cr>', opts)
        map('n', '<Space>k', ':<C-u>CocPrev<Cr>', opts)
        map('n', '<Space>o', ':<C-u>CocList outline<Cr>', opts)
        map('n', '<Space>p', ':<C-u>CocListResume<Cr>', opts)
        map('n', '<Space>s', ':<C-u>CocList -I symbols<Cr>', opts)
        map('o', 'ac', '<Plug>(coc-classobj-a)', opts)
        map('o', 'af', '<Plug>(coc-funcobj-a)', opts)
        map('o', 'ic', '<Plug>(coc-classobj-i)', opts)
        map('o', 'if', '<Plug>(coc-funcobj-i)', opts)
        map('x', '<Leader>a', '<Plug>(coc-codeaction-selected)', opts)
        map('x', 'ac', '<Plug>(coc-classobj-a)', opts)
        map('x', 'af', '<Plug>(coc-funcobj-a)', opts)
        map('x', 'ic', '<Plug>(coc-classobj-i)', opts)
        map('x', 'if', '<Plug>(coc-funcobj-i)', opts)
        local opts = {
            expr = true,
            nowait = true,
            silent = true
        }
        map('i', '<C-b>', 'coc#float#has_scroll() ? "<C-r>=coc#float#scroll(0)<Cr>" : "<Left>"', opts)
        map('i', '<C-f>', 'coc#float#has_scroll() ? "<C-r>=coc#float#scroll(1)<Cr>" : "<Right>"', opts)
        map('n', '<C-b>', 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)
        map('n', '<C-f>', 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
        map('v', '<C-b>', 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)
        map('v', '<C-f>', 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
        augroup('CocGroup', {})
        autocmd('CursorHold', {
            command = 'silent call CocActionAsync("highlight")',
            desc = 'Highlight symbol under cursor on CursorHold',
            group = 'CocGroup'
        })
        autocmd('FileType', {
            command = 'setl formatexpr=CocAction("formatSelected")',
            desc = 'Setup formatexpr specified filetype(s).',
            group = 'CocGroup',
            pattern = 'json,typescript'
        })
        autocmd('User', {
            command = 'call CocActionAsync("showSignatureHelp")',
            desc = 'Update signature help on jump placeholder',
            group = 'CocGroup',
            pattern = 'CocJumpPlaceholder'
        })
        cmd('Fold', 'call CocAction("fold", <F-Args>)', { nargs = '?' })
        cmd('Format', 'call CocAction("format")', {})
        cmd('OR', 'call CocActionAsync("runCommand", "editor.action.organizeImport")', {})
        vim.opt.statusline:prepend('%{coc#status()}%{get(b:, "coc_current_function", "")}')
        vim.g.coc_global_extensions = {
            'coc-rust-analyzer'
        }
    end
}

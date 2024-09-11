return {
    'nvim-neo-tree/neo-tree.nvim',
    config = function()
        local map = vim.api.nvim_set_keymap
        local sign = vim.fn.sign_define
        sign('DiagnosticSignError', {
            text = ' ',
            texthl = 'DiagnosticSignError'
        })
        sign('DiagnosticSignHint', {
            text = '󰌵 ',
            texthl = 'DiagnosticSignHint'
        })
        sign('DiagnosticSignInfo', {
            text = ' ',
            texthl = 'DiagnosticSignInfo'
        })
        sign('DiagnosticSignWarn', {
            text = ' ',
            texthl = 'DiagnosticSignWarn'
        })
        map('n', '\\', ':Neotree reveal<Cr>', { noremap = true })
    end,
    dependencies = {
        "3rd/image.nvim",
        "MunifTanjim/nui.nvim",
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        {
            's1n7ax/nvim-window-picker',
            opts = {
                filter_rules = {
                    autoselect_one = true,
                    bo = {
                        buftype = {
                            'quickfix',
                            'terminal'
                        },
                        filetype = {
                            'neo-tree',
                            'neo-tree-popup',
                            'notify'
                        }
                    },
                    include_current_win = false
                }
            }
        }
    },
    keys = {
        {
            '<C-e>',
            '<Cmd>Neotree<Cr>',
            mode = {
                'n'
            }
        }
    },
    opts = {
        buffers = {
            follow_current_file = {
                enabled = true,
                leave_dirs_open = false
            },
            group_empty_dirs = true,
            show_unloaded = true,
            window = {
                mappings = {
                    ['.'] = 'set_root',
                    ['<Bs>'] = 'navigate_up',
                    ['bd'] = 'buffer_delete',
                    ['o'] = { 'show_help', config = { prefix_key = 'o', title = 'Order by' }, nowait = false },
                    ['oc'] = { 'order_by_created', nowait = false },
                    ['od'] = { 'order_by_diagnostics', nowait = false },
                    ['om'] = { 'order_by_modified', nowait = false },
                    ['on'] = { 'order_by_name', nowait = false },
                    ['os'] = { 'order_by_size', nowait = false },
                    ['ot'] = { 'order_by_type', nowait = false }
                }
            }
        },
        close_if_last_window = false,
        commands = {},
        default_component_configs = {
            container = {
                enable_character_fade = true
            },
            indent = {
                expander_collapsed = '',
                expander_expanded = '',
                expander_highlight = 'NeoTreeExpander',
                highlight = 'NeoTreeIndentMarker',
                indent_marker = '│',
                indent_size = 2,
                last_indent_marker = '└',
                padding = 1,
                with_expanders = nil,
                with_markers = true
            },
            icon = {
                default = '*',
                folder_closed = '',
                folder_empty = '',
                folder_open = '',
                highlight = 'NeoTreeFileIcon',
                provider = function(icon, node, state)
                    if node.type == 'file' or node.type == 'terminal' then
                        local success, web_devicons = pcall(require, 'nvim-web-devicons')
                        local name = node.type == 'terminal' and 'terminal' or node.name
                        if success then
                            local devicon, hl = web_devicons.get_icon(name)
                            icon.highlight = hl or icon.highlight
                            icon.text = devicon or icon.text
                        end
                    end
                end
            },
            modified = {
                highlight = 'NeoTreeModified',
                symbol = '[+]'
            },
            name = {
                highlight = 'NeoTreeFileName',
                trailing_slash = false,
                use_git_status_colors = true
            },
            git_status = {
                symbols = {
                    added = '✚',
                    conflict = '',
                    deleted = '☒',
                    ignored = '',
                    modified = '',
                    renamed = '󰁕',
                    staged = '',
                    unstaged = '󰄱',
                    untracked = ''
                }
            },
            file_size = {
                enabled = true,
                required_width = 64
            },
            type = {
                enabled = true,
                required_width = 122
            },
            last_modified = {
                enabled = true,
                required_width = 88
            },
            created = {
                enabled = true,
                required_width = 110
            },
            symlink_target = {
                enabled = false
            }
        },
        enable_diagnostics = true,
        enable_git_status = true,
        filesystem = {
            commands = {},
            filtered_items = {
                always_show = {},
                always_show_by_pattern = {},
                hide_by_name = {},
                hide_by_pattern = {
                    '*.meta'
                },
                hide_dotfiles = false,
                hide_gitignored = false,
                hide_hidden = false,
                never_show = {
                    '.DS_Store',
                    'thumbs.db'
                },
                never_show_by_pattern = {},
                visible = false
            },
            follow_current_file = {
                enabled = true,
                leave_dirs_open = false
            },
            group_empty_dirs = false,
            hijack_netrw_behavior = 'open_default',
            use_libuv_file_watcher = true,
            window = {
                fuzzy_finder_mappings = {
                    ['<C-n>'] = 'move_cursor_down',
                    ['<C-p>'] = 'move_cursor_up',
                    ['<Down>'] = 'move_cursor_down',
                    ['<Up>'] = 'move_cursor_up'
                },
                mappings = {
                    ['#'] = 'fuzzy_sorter',
                    ['.'] = 'set_root',
                    ['/'] = 'fuzzy_finder',
                    ['<Bs>'] = 'navigate_up',
                    ['<C-x>'] = 'clear_filter',
                    ['D'] = 'fuzzy_finder_directory',
                    ['H'] = 'toggle_hidden',
                    ['[g'] = 'prev_git_modified',
                    [']g'] = 'next_git_modified',
                    ['f'] = 'filter_on_submit',
                    ['o'] = { 'show_help', config = { prefix_key = 'o', title = 'Order by' }, nowait = true },
                    ['oc'] = { 'order_by_created', nowait = false },
                    ['od'] = { 'order_by_diagnostics', nowait = false },
                    ['og'] = { 'order_by_git_status', nowait = false },
                    ['om'] = { 'order_by_modified', nowait = false },
                    ['on'] = { 'order_by_name', nowait = false },
                    ['os'] = { 'order_by_size', nowait = false },
                    ['ot'] = { 'order_by_type', nowait = false }
                }
            }
        },
        git_status = {
            window = {
                mappings = {
                    ['A'] = 'git_add_all',
                    ['ga'] = 'git_add_file',
                    ['gc'] = 'git_commit',
                    ['gg'] = 'git_commit_and_push',
                    ['gp'] = 'git_push',
                    ['gr'] = 'git_revert_file',
                    ['gu'] = 'git_unstage_file',
                    ['o'] = { 'show_help', config = { prefix_key = 'o', title = 'Order by' }, nowait = true },
                    ['oc'] = { 'order_by_created', nowait = false },
                    ['od'] = { 'order_by_diagnostics', nowait = false },
                    ['om'] = { 'order_by_modified', nowait = false },
                    ['on'] = { 'order_by_name', nowait = false },
                    ['os'] = { 'order_by_size', nowait = false },
                    ['ot'] = { 'order_by_type', nowait = false }
                },
                position = 'float'
            }
        },
        nesting_rules = {},
        open_files_do_not_replace_types = {
            'qf',
            'terminal',
            'trouble'
        },
        popup_border_style = 'rounded',
        sort_case_insensitive = false,
        sort_function = nil,
        window = {
            mapping_options = {
                noremap = true,
                nowait = true
            },
            mappings = {
                ['<'] = 'prev_source',
                ['<2-LeftMouse>'] = 'open',
                ['<Cr>'] = 'open',
                ['<Esc>'] = 'cancel',
                ['<Space>'] = { 'toggle_node', nowait = false },
                ['>'] = 'next_source',
                ['?'] = 'show_help',
                ['A'] = 'add_directory',
                ['C'] = 'close_node',
                ['P'] = { 'toggle_preview', config = { use_float = true, use_image_nvim = true } },
                ['R'] = 'refresh',
                ['S'] = 'open_split',
                ['a'] = { 'add', config = { show_path = 'none' } },
                ['c'] = 'copy',
                ['d'] = 'delete',
                ['i'] = 'show_file_details',
                ['l'] = 'focus_preview',
                ['m'] = 'move',
                ['p'] = 'paste_from_clipboard',
                ['q'] = 'close_window',
                ['r'] = 'rename',
                ['s'] = 'open_vsplit',
                ['t'] = 'open_tabnew',
                ['w'] = 'open_with_window_picker',
                ['x'] = 'cut_to_clipboard',
                ['y'] = 'copy_to_clipboard',
                ['z'] = 'close_all_nodes'
            },
            position = 'left',
            width = 40
        }
    }
}

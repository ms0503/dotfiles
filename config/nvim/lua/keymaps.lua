local map = vim.api.nvim_set_keymap

map('i', '<C-s>'     , '<Esc>:w<Cr>li'       , { noremap = false, silent = false })
map('n', '<C-j>'     , 'G'                   , { noremap = false, silent = false })
map('n', '<C-k>'     , 'gg'                  , { noremap = false, silent = false })
map('n', '<C-s>'     , ':w<Cr>'              , { noremap = false, silent = false })
map('n', '<Esc><Esc>', ':nohlsearch<Cr><Esc>', { noremap = false, silent = true  })
map('n', '[b'        , ':bprev'              , { noremap = false, silent = true  })
map('n', ']b'        , ':bnext'              , { noremap = false, silent = true  })
map('n', 'j'         , 'gj'                  , { noremap = false, silent = false })
map('n', 'k'         , 'gk'                  , { noremap = false, silent = false })

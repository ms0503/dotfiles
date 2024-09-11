return {
    'ahmedkhalf/project.nvim',
    config = function()
        require('project_nvim').setup({
            respect_buf_cwd = true,
            sync_root_with_cwd = true,
            update_focused_file = {
                enable = true,
                update_root = true
            }
        })
    end
}

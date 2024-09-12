return {
    'ahmedkhalf/project.nvim',
    config = function(PluginSpec, opts)
        require('project_nvim').setup(opts)
    end,
    opts = {}
}

return {
    'nvim-lua/plenary.nvim',
    'nvim-lua/popup.nvim',
    'phaazon/hop.nvim',
    'lukas-reineke/indent-blankline.nvim',
    'folke/which-key.nvim',
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("trouble").setup {}
        end
    },
    {
        "folke/todo-comments.nvim",
        dependencies = "nvim-lua/plenary.nvim",
        config = function()
            require("todo-comments").setup {}
        end
    },
    'lewis6991/gitsigns.nvim',
    'nvim-lualine/lualine.nvim',
    'numToStr/Comment.nvim',
    'haringsrob/nvim_context_vt',
    'tpope/vim-fugitive',
    {
        'linrongbin16/lsp-progress.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('lsp-progress').setup({})
        end
    },
}

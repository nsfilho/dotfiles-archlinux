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
    'lewis6991/gitsigns.nvim',       -- git signs in gutter
    'nvim-lualine/lualine.nvim',     -- statusline
    'numToStr/Comment.nvim',         -- hotkey for (un)comment lines
    'andersevenrud/nvim_context_vt', -- comments on close brackets
    {
        'linrongbin16/lsp-progress.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('lsp-progress').setup({})
        end
    },
}

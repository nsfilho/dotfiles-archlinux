return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        "s1n7ax/nvim-window-picker",
        -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    config = function()
        local neo = require("neo-tree");
        neo.setup({
            window = {
                mappings = {
                    ["s"] = "noop",
                    ["S"] = "noop",
                    ["<C-x>"] = "open_split",
                    ["<C-v>"] = "open_vsplit",
                },
            },
        })

        vim.api.nvim_set_keymap("n", "<C-n>", ":Neotree toggle reveal<CR>", { noremap = true, silent = true })
    end
}

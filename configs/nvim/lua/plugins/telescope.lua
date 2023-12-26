return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-telescope/telescope-file-browser.nvim',
        'nvim-lua/plenary.nvim',
    },
    config = function()
        local telescope = require("telescope")
        local actions = require('telescope.actions')
        local builtin = require('telescope.builtin')

        telescope.setup {
            extensions = {
                file_browser = {
                    theme = "ivy",
                },
            },
            defaults = {
                mappings = {
                    n = {
                        ["q"] = actions.close
                    },
                },
                file_ignore_patterns = {
                    'node_modules',
                    '.git/'
                },
                vimgrep_arguments = {
                    'rg',
                    '--color=never',
                    '--no-heading',
                    '--with-filename',
                    '--line-number',
                    '--column',
                    '--smart-case',
                    '--hidden',
                },
            },
            pickers = {
                buffers = {
                    ignore_current_buffer = true,
                    sort_lastused = true,
                    -- sort_mru = true,
                    mappings = {
                        i = {
                            ["<c-d>"] = require("telescope.actions").delete_buffer,
                        },
                        n = {
                            ["<c-d>"] = require("telescope.actions").delete_buffer,
                        }
                    }
                }
            }
        }

        telescope.load_extension("file_browser")

        local keymap = vim.keymap
        keymap.set('n', '<leader>ff',
            function()
                -- require("telescope.builtin").git_files({ show_untracked = true, use_git_root = true, recurse_submodules = true, hidden = true })
                builtin.find_files()
            end
        )
        keymap.set('n', '<leader>fw',
            'viw"zy:lua require("telescope.builtin").grep_string({ search = vim.fn.getreg("z") })<CR>')
        keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<CR>')
        keymap.set('n', '<leader>fb', function()
            builtin.buffers({
                respect_gitignore = false,
                initial_mode = 'normal',
            })
        end)
        keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<CR>')
        keymap.set('n', '<leader>fr', '<cmd>Telescope registers<CR>')
        keymap.set('n', '<leader>fn', function()
            require('telescope').extensions.file_browser.file_browser({
                grouped = true,
                previewer = false,
                hidden = true,
                respect_gitignore = false,
                initial_mode = 'normal',
                path = vim.fn.expand('%:p:h'),
            })
        end)

        vim.api.nvim_create_autocmd('VimEnter', {
            callback = function()
                -- verifica se algum nome de arquivo foi informado ao neovim durante a abertura
                if vim.fn.argc() > 0 then
                    return
                end

                vim.api.nvim_buf_delete(0, { force = true })
                builtin.find_files()
            end,
        })
    end,
}

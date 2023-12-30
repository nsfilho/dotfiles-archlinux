return {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
        'nvim-treesitter/nvim-treesitter-context',
    },
    config = function()
        local ts = require("nvim-treesitter.configs")
        local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
        local context = require("treesitter-context")

        if (vim.fn.isdirectory("/usr/local/Cellar/gcc/13.2.0/bin") == 1) then
            require("nvim-treesitter.install").compilers = { "gcc-13" }
        end

        ts.setup {
            ensure_installed = { "bash", "c", "cpp", "css", "dockerfile", "gitignore", "html", "java", "javascript", "json",
                "lua", "make", "markdown", "markdown_inline", "rust", "scss", "toml", "typescript", "tsx", "yaml" },
            auto_install = false,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
                disable = {},
            },
            indent = {
                enable = true,
                disable = {},
            },
            autotag = {
                enable = true,
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-space>",
                    node_incremental = "<C-space>",
                    scope_incremental = false,
                    node_decremental = "<BS>",
                },
            },
        }

        parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }

        context.setup {
            enable = true,         -- Enable this plugin (Can be enabled/disabled later via commands)
            max_lines = 0,         -- How many lines the window should span. Values <= 0 mean no limit.
            trim_scope = 'outer',  -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
            min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
            patterns = {           -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
                default = {
                    'class',
                    'function',
                    'method',
                    'for',
                    'while',
                    'if',
                    'switch',
                    'case',
                },
                tex = {
                    'chapter',
                    'section',
                    'subsection',
                    'subsubsection',
                },
                rust = {
                    'impl_item',
                    'struct',
                    'enum',
                },
                scala = {
                    'object_definition',
                },
                vhdl = {
                    'process_statement',
                    'architecture_body',
                    'entity_declaration',
                },
                markdown = {
                    'section',
                },
                elixir = {
                    'anonymous_function',
                    'arguments',
                    'block',
                    'do_block',
                    'list',
                    'map',
                    'tuple',
                    'quoted_content',
                },
                json = {
                    'pair',
                },
                yaml = {
                    'block_mapping_pair',
                },
            },
            exact_patterns = {
            },
            zindex = 20,
            mode = 'cursor',
            separator = nil,
        }
    end
}

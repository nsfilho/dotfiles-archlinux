-- nvim-cmp setup
local source_mapping = {
    nvim_lsp = "🔨",
    nvim_lua = "🛸",
    buffer = "🔖",
    cmp_tabnine = "🔦",
    path = "🗂️",
    spell = "💬",
    calc = "🔢",
    nvim_lsp_signature_help = "🖊️",
    cmdline = "👉"
}

return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-vsnip',
        'hrsh7th/vim-vsnip',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/cmp-emoji',
        'hrsh7th/cmp-calc',
        'f3fora/cmp-spell',
        'nvimdev/lspsaga.nvim',
        'onsails/lspkind-nvim',
        'github/copilot.vim',
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'stevearc/conform.nvim',
        'mfussenegger/nvim-lint',
        'simrat39/rust-tools.nvim',
    },
    config = function()
        local lspconfig = require('lspconfig')
        local mason = require('mason')
        local mason_lspconfig = require('mason-lspconfig')
        local cmp = require('cmp')
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        local lspsaga = require('lspsaga')
        local lspkind = require('lspkind')
        local rt = require('rust-tools')

        local on_attach = function(_, bufnr)
            local function buf_set_keymap(...) vim.keymap.set(...) end
            local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
            local opts = { buffer = bufnr, noremap = true, silent = true }

            buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
            buf_set_keymap("n", "<leader>cf", ":Lspsaga finder<CR>", opts)
            buf_set_keymap("n", "K", ":Lspsaga hover_doc<CR>", opts)
            buf_set_keymap("n", "<leader>ck", '<cmd>lua require("lspsaga.action").smart_scroll_with_saga(-1)<CR>', opts)
            buf_set_keymap("n", "<leader>cj", '<cmd>lua require("lspsaga.action").smart_scroll_with_saga(1)<CR>', opts)
            buf_set_keymap("n", "<leader>cs", ":Lspsaga signature_help<CR>", opts)
            buf_set_keymap("n", "<leader>ci", ":Lspsaga show_line_diagnostics<CR>", opts)
            buf_set_keymap("n", "[d", ":Lspsaga diagnostic_jump_prev<CR>", opts)
            buf_set_keymap("n", "]d", ":Lspsaga diagnostic_jump_next<CR>", opts)
            buf_set_keymap("n", "<leader>cr", ":Lspsaga rename<CR>", opts)
            buf_set_keymap("n", "<leader>cd", ":Lspsaga preview_definition<CR>", opts)
            buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
            buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
            buf_set_keymap("n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
            buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
            buf_set_keymap("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
            buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
            buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
            buf_set_keymap("n", "<leader>ca", ":Lspsaga code_action<CR>", opts)
            buf_set_keymap("n", "<leader>e", ":Lspsaga show_line_diagnostics<CR>", opts)
            buf_set_keymap("n", "<leader>q", ":TroubleToggle<CR>", opts)
            buf_set_keymap("n", "<leader>so", [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
            buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.format { async = false }<CR>", opts)
            buf_set_keymap("n", "<leader>ah", rt.hover_actions.hover_actions, opts)
            buf_set_keymap("n", "<leader>ac", rt.code_action_group.code_action_group, opts)
        end

        if (jit.arch ~= 'x64') then
            mason.setup {
                max_concurrent_installers = 1,
                ensure_installed = { "bashls", "tsserver", "html", "yamlls" },
            }
        else
            mason.setup {
                max_concurrent_installers = 1,
                ensure_installed = { "lua_ls", "rust-analyzer", "eslint_d", "prettierd", "bashls", "tsserver", "html", "yamlls", "taplo" },
            }
        end

        mason_lspconfig.setup()

        -- setup all lsp servers using mason_lspconfig
        local servers = mason_lspconfig.get_installed_servers()
        for _, server in pairs(servers) do
            if server ~= "rust_analyzer" then
                print("Setting up " .. server, "\n")
                lspconfig[server].setup {
                    on_attach = on_attach,
                    capabilities = capabilities,
                    flags = {
                        debounce_text_changes = 150,
                    },
                }
            end
        end

        -- check for rust dap adapter
        local function rustdapFactory()
            local mason_registry = require('mason-registry')
            local codelldb = mason_registry.get_package('codelldb')
            local extension_path = codelldb:get_install_path() .. "/extension/"
            local codelldb_path = extension_path .. "adapter/codelldb"
            local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"
            return {
                adapter = require('rust-tools.dap').get_codelldb_adapter(codelldb_path, liblldb_path),
            }
        end

        local rustdap_ok, rustdap = pcall(rustdapFactory)
        if not rustdap_ok then
            rustdap = {}
        end

        rt.setup({
            dap = rustdap,
            server = {
                on_attach = on_attach,
                capabilities = capabilities,
            },
        })

        cmp.setup {
            experimental = {
                ghost_text = false, -- avoid conflict with copilot
            },
            view = {
                entries = { name = 'custom', selection_order = 'near_cursor' }
            },
            snippet = {
                expand = function(args)
                    vim.fn["vsnip#anonymous"](args.body)
                end,
            },
            formatting = {
                format = function(entry, vim_item)
                    -- if you have lspkind installed, you can use it like
                    -- in the following line:
                    vim_item.kind = lspkind.symbolic(vim_item.kind, { mode = "symbol" })
                    vim_item.menu = source_mapping[entry.source.name]
                    if entry.source.name == "cmp_tabnine" then
                        local detail = (entry.completion_item.data or {}).detail
                        vim_item.kind = ""
                        if detail and detail:find('.*%%.*') then
                            vim_item.kind = vim_item.kind .. ' ' .. detail
                        end

                        if (entry.completion_item.data or {}).multiline then
                            vim_item.kind = vim_item.kind .. ' ' .. '[ML]'
                        end
                    end
                    local maxwidth = 80
                    vim_item.abbr = string.sub(vim_item.abbr, 1, maxwidth)
                    return vim_item
                end,
            },
            mapping = {
                ["<C-p>"] = cmp.mapping.select_prev_item(),
                ["<C-n>"] = cmp.mapping.select_next_item(),
                ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.close(),
                -- ["<A-e"] = cmp.mapping.close(),
                ["<CR>"] = cmp.mapping.confirm {
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true
                },
            },
            sources = {
                { name = "nvim_lsp" },
                { name = "nvim_lua" },
                { name = "neorg" },
                { name = "path" },
                { name = "vsnip" },
                { name = "cmp_tabnine" },
                { name = "emoji" },
                { name = "spell" },
                {
                    name = "buffer",
                    option = {
                        get_bufnrs = function() return { vim.api.nvim_get_current_buf() } end
                    },
                }
            }
        }

        -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline('/', {
            view = {
                entries = { name = 'custom' }
            },
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = 'buffer' }
            }
        })

        -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline(':', {
            view = {
                -- entries = { name = 'wildmenu', separator = '|' }
                entries = { name = 'custom' }
            },
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = 'path' }
            }, {
                { name = 'cmdline' }
            })
        })

        lspsaga.setup({})
        lspkind.init({
            mode = 'symbol_text',
            preset = 'codicons',
            symbol_map = {
                Text = "󰉿",
                Method = "󰆧",
                Function = "󰊕",
                Constructor = "",
                Field = "󰜢",
                Variable = "󰀫",
                Class = "󰠱",
                Interface = "",
                Module = "",
                Property = "󰜢",
                Unit = "󰑭",
                Value = "󰎠",
                Enum = "",
                Keyword = "󰌋",
                Snippet = "",
                Color = "󰏘",
                File = "󰈙",
                Reference = "󰈇",
                Folder = "󰉋",
                EnumMember = "",
                Constant = "󰏿",
                Struct = "󰙅",
                Event = "",
                Operator = "󰆕",
                TypeParameter = "",
            },
        })

        vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
            vim.lsp.diagnostic.on_publish_diagnostics,
            {
                underline = true,
                update_in_insert = false,
                signs = true,
                virtual_text = {
                    spacing = 4,
                    prefix = ""
                },
                severity_sort = true,
            }
        )

        vim.diagnostic.config({
            virtual_text = {
                prefix = '●'
            },
            update_in_insert = true,
            float = {
                source = "always", -- Or "if_many"
            },
        })
    end
}

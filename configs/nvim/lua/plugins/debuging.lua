return {
    'mfussenegger/nvim-dap',
    dependencies = {
        'rcarriga/nvim-dap-ui',
        'rcarriga/nvim-notify',
        'simrat39/rust-tools.nvim',
    },
    config = function()
        local dap = require('dap')
        local ui = require('dapui')
        local rt = require('rust-tools')

        dap.set_log_level('INFO')

        ui.setup()
        dap.listeners.after.event_initialized["dapui_config"] = function()
            ui.open({})
        end

        dap.listeners.before.event_terminated["dapui_config"] = function()
            ui.close({})
        end

        dap.listeners.before.event_exited["dapui_config"] = function()
            ui.close({})
        end

        dap.adapters.go = {
            type = "server",
            port = "${port}",
            executable = {
                command = vim.fn.stdpath("data") .. '/mason/bin/dlv',
                args = { "dap", "-l", "127.0.0.1:${port}" },
            },
        }

        dap.adapters.node2 = {
            type = 'executable',
            command = 'node',
            args = { vim.fn.stdpath("data") .. '/mason/packages/node-debug2-adapter/out/src/nodeDebug.js' },
        }

        dap.configurations = {
            go = {
                {
                    type = "go",         -- Which adapter to use
                    name = "Debug",      -- Human readable name
                    request = "launch",  -- Whether to "launch" or "attach" to program
                    program = "${file}", -- The buffer you are focused on when running nvim-dap
                },
            },
            javascript = {
                {
                    type = 'node2',
                    name = 'Launch',
                    request = 'launch',
                    program = '${file}',
                    cwd = vim.fn.getcwd(),
                    sourceMaps = true,
                    protocol = 'inspector',
                    console = 'integratedTerminal',
                },
                {
                    type = 'node2',
                    name = 'Attach',
                    request = 'attach',
                    program = '${file}',
                    cwd = vim.fn.getcwd(),
                    sourceMaps = true,
                    protocol = 'inspector',
                    console = 'integratedTerminal',
                },
            },
        }
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
                -- capabilities = capabilities,
                -- on_attach = on_attach,
                settings = {
                    check = {
                        command = "clippy"
                    },
                    imports = {
                        granularity = {
                            group = "module",
                        },
                        prefix = "self",
                    },
                    cargo = {
                        buildScripts = {
                            enable = true,
                        },
                    },
                    procMacro = {
                        enable = true
                    },
                }
            },
            tools = {
                hover_actions = {
                    auto_focus = true,
                },
            }
        })

        vim.keymap.set('n', '<F6>', dap.continue)
        vim.keymap.set('n', '<F7>', dap.step_over)
        vim.keymap.set('n', '<F8>', dap.step_into)
        vim.keymap.set('n', '<F9>', dap.step_out)
        vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint)
        vim.keymap.set("n", "<Leader>ah", rt.hover_actions.hover_actions)
        vim.keymap.set("n", "<Leader>ac", rt.code_action_group.code_action_group)
        vim.fn.sign_define('DapBreakpoint', { text = '🐞' })
    end
}

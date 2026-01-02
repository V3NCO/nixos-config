if not nixCats('general') then
    return
end
-- NOTE: lsp setup via lspconfig

local servers = {}

-- Lua language server
servers.lua_ls = {
    settings = {
        Lua = {
            formatters = {
                ignoreComments = true,
            },
            signatureHelp = { enabled = true },
            diagnostics = {
                globals = { 'vim', 'nixCats' },
                disable = { 'missing-fields' },
            },
        }
    }
}

-- ========================================
-- ADD THESE SERVERS HERE (from headblockhead)
-- ========================================
servers.gopls = {
    settings = {
        gopls = {
            codelenses = {
                generate = true,
                gc_details = true,
                test = true,
                upgrade_dependency = true,
                tidy = true,
            },
        },
    },
}

servers.ccls = {}
servers.ts_ls = { settings = { format = { enable = false } } }
servers.templ = {}
servers.tailwindcss = {}
servers.pylsp = {}
-- ========================================

-- nixd configuration
servers.nixd = {
    settings = {
        nixd = {
            nixpkgs = {
                expr = nixCats.extra("nixdExtras. nixpkgs") or [[import <nixpkgs> {}]],
            },
            -- ... rest of nixd config ...
        }
    }
}

-- Rest of your lsp. lua continues below...
vim.lsp.config('*', {
    -- ...
})

for server_name, cfg in pairs(servers) do
    vim.lsp.config(server_name, cfg)
    vim.lsp.enable(server_name)
end

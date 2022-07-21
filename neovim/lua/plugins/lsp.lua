local nvim_lsp = require'lspconfig'
local lsp_status = require('lsp-status')
local fn = vim.fn
local api = vim.api
local lsp = vim.lsp

lsp_status.register_progress()


local on_attach_vim = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    -- require'completion'.on_attach(client, bufnr)
    -- lsp_status.on_attach(client, bufnr)
    local opts = { silent = true, buffer = bufnr }

    -- Keybindings
    vim.keymap.set("n", "<leader>qf", function() vim.diagnostic.setqflist({open = true}) end, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

    -- Set some key bindings conditional on server capabilities
    -- if client.server_capabilities.document_formatting then
        vim.keymap.set("n", "<leader>f", vim.lsp.buf.formatting, opts)
    -- end
    -- if client.server_capabilities.document_range_formatting then
        vim.keymap.set("x", "<leader>f", vim.lsp.buf.range_formatting, opts)
    -- end

    vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr()")
    -- vim.api.nvim_buf_set_option(buf, "omnifunc", "v:lua.vim.lsp.omnifunc")
    vim.api.nvim_buf_set_option(bufnr, "tagfunc", "v:lua.vim.lsp.tagfunc")
end

-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- local capabilities = lsp_status.capabilities
-- capabilities.textDocument.completion.completionItem.snippetSupport = true
-- local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- nvim_lsp.rust_analyzer.setup{
    -- capabilities = capabilities,
    -- on_attach = on_attach_vim, 
    -- settings = {
        -- ['rust-analyzer'] = {
            -- cargo = {
                -- allFeatures = true,
            -- },
            -- assist = {
                -- importGranularity = "module",
                -- importPrefix = "by_self",
            -- },
            -- cargo = {
                -- loadOutDirsFromCheck = true
            -- },
            -- procMacro = {
                -- enable = true
            -- },
        -- },
    -- }
-- }

-- Setup rust_analyzer via rust-tools.nvim
require("rust-tools").setup({
    tools = {
        inlay_hints = {
            -- Only show inlay hints for the current line
            only_current_line = true,
            only_current_line_autocmd = "CursorHold",
        }
    },
	server = {
		capabilities = capabilities,
		on_attach = on_attach_vim,
        settings = {
            ['rust-analyzer'] = {
                cargo = {
                    allFeatures = true,
                },
            },
        }
	},
    dap = {
        adapter = require('rust-tools.dap').get_codelldb_adapter(
            '/home/singulared/Downloads/extension/adapter/codelldb', 
            '/home/singulared/Downloads/extension/lldb/lib/liblldb.so'
        )
    }
})

nvim_lsp.pylsp.setup{
    capabilities = capabilities,
    on_attach=on_attach_vim, 
    cmd = {'pylsp'}, 
    single_file_support = true,
    settings = {
        pylsp = {
            configurationSources = { "pyflakes", "pycodestyle", "mypy"},
	        plugins = {
	            jedi = {
		            extra_paths = { io.popen("python -c \"import sys; print(next((p for p in sys.path if 'site-packages' in p), ''))\"", "r"):read() },
	            },
            },
        },
    },
    root_dir = function(fname)
        local nvim_lsp = require'lspconfig';
		local filename = nvim_lsp.util.path.is_absolute(fname) and fname
			or nvim_lsp.util.path.join(vim.loop.cwd(), fname)
		local root_pattern = nvim_lsp.util.root_pattern('pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'mypy.ini', '.pylintrc', '.flake8rc', '.git', '.gitignore')
		return root_pattern(filename) or nvim_lsp.util.dirname(filename)
	end;
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    signs = true,
    underline = false,
    update_in_insert = false,
    virtual_text = true,
  }
)

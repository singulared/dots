return {
    { "folke/lazy.nvim", version = false },
    { "LazyVim/LazyVim", version = false },
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
            opts.ensure_installed = vim.tbl_filter(function(lang)
                return lang ~= "jsonc"
            end, opts.ensure_installed or {})
        end,
    },
}

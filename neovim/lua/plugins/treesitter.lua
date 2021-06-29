require'nvim-treesitter.configs'.setup {
   ensure_installed = {
    "rust",
    "python",
    "toml",
    "json",
    "bash",
  },
  highlight = {
    enable = true,
  },
}

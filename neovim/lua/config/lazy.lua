local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
	spec = {
		-- { "singulared/sin", import = "sin.plugins" },
		{
			"LazyVim/LazyVim",
			import = "lazyvim.plugins",
			opts = {
				colorscheme = "catppuccin",
			},
		},
		{ import = "lazyvim.plugins.extras.lang.rust" },
		{ import = "plugins" },
	},
	dev = {
		path = "~/sources/nvim/",
		patterns = { "singulared" },
		fallback = false,
	},
	defaults = {
		-- only LazyVim plugins are lazy-loaded by default
		lazy = false,
		version = false, -- always use the latest git commit
	},
	install = { colorscheme = { "catppuccin" } },
	checker = { enabled = true }, -- automatically check for plugin updates
	performance = {
		rtp = {
			-- disable some rtp plugins
			disabled_plugins = {
				"gzip",
				"matchit",
				"matchparen",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})

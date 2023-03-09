vim.keymap.set("n", "<leader>gG", function()
	require("neogit").open({ kind = "split" })
end, { desc = "open neogit" })

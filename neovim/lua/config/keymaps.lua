vim.keymap.set("n", "<leader>gg", function()
	require("neogit").open({ kind = "split" })
end, { desc = "open neogit" })

vim.keymap.set("n", "<leader>rm", function()
	vim.cmd.RustLsp("rebuildProcMacros")
	vim.cmd.sleep(1)
	vim.cmd.RustLsp("expandMacro")
end, { desc = "rebuild and expand rust macro" })

-- `RustLsp rebuildProcMacros` is async. Expanding right after the "Loading proc-macros"
-- progress ends still yields "No macro under cursor", so wait for the indexing pass
-- that follows it.
local function rebuild_and_expand_macro()
	local group = vim.api.nvim_create_augroup("rust_rebuild_expand_macro", { clear = true })
	local waiting_for, token = "Loading proc-macros", nil
	local id = vim.api.nvim_create_autocmd("LspProgress", {
		group = group,
		callback = function(ev)
			local params = ev.data.params
			if params.value.kind == "begin" and params.value.title == waiting_for then
				token = params.token
			elseif params.value.kind == "end" and token ~= nil and params.token == token then
				if waiting_for == "Indexing" then
					vim.cmd.RustLsp("expandMacro")
					return true
				end
				waiting_for, token = "Indexing", nil
			end
		end,
	})
	vim.defer_fn(function()
		pcall(vim.api.nvim_del_autocmd, id)
	end, 120 * 1000)
	vim.cmd.RustLsp("rebuildProcMacros")
end

return {
	{
		"mrcjkb/rustaceanvim",
		keys = {
			{ "<leader>rm", rebuild_and_expand_macro, ft = "rust", desc = "Rebuild and Expand Macro" },
		},
		opts = {
			server = {
				default_settings = {
					["rust-analyzer"] = {
						completion = {
							fullFunctionSignatures = { enable = true },
						},
						diagnostics = {
							experimental = { enable = true },
						},
					},
				},
			},
		},
	},
}

local M = {}

function M.setup()
	local augroup = vim.api.nvim_create_augroup("YankNotifierGroup", { clear = true })

	vim.api.nvim_create_autocmd("TextYankPost", {
		group = augroup,

		pattern = "*",

		callback = function(data)
			vim.notify("Yanked!", vim.log.levels.INFO)
		end,
	})

	-- print("Event Notifier loaded.")
end

return M

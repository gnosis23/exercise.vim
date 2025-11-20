local function ReloadModule(name, callback)
	package.loaded[name] = nil

	local ok, module = pcall(require, name)

	if ok then
		if callback then
			callback()
		end
		print("Module '" .. name .. "' reloaded successfully")
	else
		vim.notify("Failed to reload module '" .. name .. "'", vim.log.levels.WARN)
	end
end

ReloadModule("lua/simple-popup", function()
	require("lua/simple-popup").setup({
		width = 90,
		height = 5,
		border = "double",
	})
end)

ReloadModule("lua/add-signature", function()
	vim.keymap.set("n", "<leader>A", function()
		require("lua/add-signature").append_signature()
	end, { desc = "Add Signature" })
end)

ReloadModule("lua/event-notifier", function()
	require("lua/event-notifier").setup()
end)

ReloadModule("lua/interactive-sign")

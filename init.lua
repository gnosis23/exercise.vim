local function ReloadModule(name)
	package.loaded[name] = nil
	require(name)
	print("Module '" .. name .. "' reloaded successfully")
end

ReloadModule("simple-popup")
ReloadModule("add-signature")

vim.keymap.set("n", "<leader>t", function()
	require("simple-popup").toggle_window()
end, { desc = "Toggle Simple Popup" })

vim.keymap.set("n", "<leader>A", function()
	require("add-signature").append_signature()
end, { desc = "Add Signature" })

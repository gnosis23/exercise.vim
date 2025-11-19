require("simple-popup")
require("add-signature")

vim.keymap.set("n", "<leader>t", function()
	require("simple-popup").toggle_window()
end, { desc = "Toggle Simple Popup" })

vim.keymap.set("n", "<leader>A", function()
	require("add-signature").append_signature()
end, { desc = "Add Signature" })

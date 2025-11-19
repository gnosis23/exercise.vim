require("simple-popup")

vim.keymap.set("n", "<leader>t", function()
	require("simple-popup").toggle_window()
end, { desc = "Toggle Simple Popup" })

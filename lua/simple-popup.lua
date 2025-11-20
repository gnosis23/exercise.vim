-- define module
local M = {}

local win_id = nil
local buf_id = nil

function M.toggle_window()
	-- 1. Close if open
	if win_id and vim.api.nvim_win_is_valid(win_id) then
		vim.api.nvim_win_close(win_id, true)
		win_id = nil
		return
	end

	-- 2. Create a buffer
	buf_id = vim.api.nvim_create_buf(false, true)

	-- 3. center window
	local width = 60
	local height = 10
	local ui = vim.api.nvim_list_uis()[1]
	local row = (ui.height - height) / 2
	local col = (ui.width - width) / 2

	local opts = {
		style = "minimal",
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
		border = "rounded",
	}

	win_id = vim.api.nvim_open_win(buf_id, true, opts)

	vim.api.nvim_buf_set_keymap(
		buf_id,
		"n",
		"q",
		'<cmd>lua require("simple-popup").toggle_window()<CR>',
		{ noremap = true }
	)
end

vim.api.nvim_create_user_command("Popup", M.toggle_window, {})

return M

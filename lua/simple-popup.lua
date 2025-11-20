-- define module
local M = {}

local win_id = nil
local buf_id = nil

local DEFAULT_OPTS = {
	width = 60,
	height = 10,
	border = "rounded",
	title = "Configurable Dashboard",
	padding = 1,
}

local config = {}

function M.setup(user_opts)
	config = vim.tbl_deep_extend("force", {}, DEFAULT_OPTS, user_opts or {})

	vim.api.nvim_create_user_command("ConfigPopup", M.toggle_window, { desc = "Toggle Popup" })
end

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
	local width = config.width
	local height = config.height
	local title = config.title
	local border_style = config.border
	local padding = config.padding

	local ui = vim.api.nvim_list_uis()[1]
	local row = (ui.height - height) / 2
	local col = (ui.width - width) / 2

	local win_opts = {
		relative = "editor",
		row = row,
		col = col,
		width = width,
		height = height,
		border = border_style,
		title = title,
		focusable = true,
		style = "minimal",
	}

	win_id = vim.api.nvim_open_win(buf_id, true, win_opts)

	vim.api.nvim_buf_set_keymap(
		buf_id,
		"n",
		"q",
		'<cmd>lua require("lua/simple-popup").toggle_window()<CR>',
		{ noremap = true }
	)
end

return M

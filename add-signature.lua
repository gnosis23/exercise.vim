local M = {}

function M.append_signature()
	-- 0 = current buffer
	local buf = 0

	local line_count = vim.api.nvim_buf_line_count(buf)
	print("line count" .. line_count)

	local quotes = {
		"Happy Coding!",
		"Vim is awesome.",
		"Lua is fast.",
		"Keep it simple.",
	}

	local signature_text = {
		"",
		"-- Author: Uncle Wang",
		"-- " .. quotes[math.random(#quotes)],
		"-- Date:   " .. os.date("%Y-%m-%d %H:%M:%S"),
		"---------------------",
	}

	vim.api.nvim_buf_set_lines(buf, line_count, line_count, false, signature_text)

	print("Signature added!")
end

return M

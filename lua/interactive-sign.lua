local M = {}

local function await_input(opts)
	local result = nil

	local co = coroutine.running()

	-- 1. start input
	vim.ui.input(opts, function(input)
		result = input

		-- 2. 在回调函数中，恢复协程
		vim.schedule(function()
			coroutine.resume(co, result)
		end)
	end)

	-- 3. 暂停协程，等待输入结果
	return coroutine.yield()
end

function M.run_prompt()
	local co = coroutine.wrap(function()
		local name = await_input({ prompt = "Your name: ", default = vim.fn.getenv("USER") })

		if name == nil or name == "" then
			vim.notify("Signature canceled", vim.log.levels.INFO)
			return
		end

		local message = await_input({ prompt = "Custom Message: " })

		if message == nil or message == "" then
			vim.notify("Signature cancelled.", vim.log.levels.INFO)
			return
		end

		local buf = 0
		local count = vim.api.nvim_buf_line_count(buf)

		local signature = {
			"",
			"--- " .. message,
			string.format("--- Signed by %s on %s", name, os.date("%Y-%m-%d")),
		}

		vim.api.nvim_buf_set_lines(buf, count, count, false, signature)
	end)

	co()
end

vim.api.nvim_create_user_command("CustomSign", M.run_prompt, { desc = "Add Custom Sign" })

return M

local M = {}

function M.run_prompt()
	local user_name = ""

	vim.ui.input({ prompt = "Your name: ", default = vim.fn.getenv("USER") }, function(input_name)
		if input_name == nil or input_name == "" then
			vim.notify("Signature canceled", vim.log.levels.INFO)
			return
		end
		user_name = input_name

		vim.ui.input({ prompt = "Custom Messages: " }, function(input_msg)
			if input_msg == nil then
				vim.notify("Signature cancelled.", vim.log.levels.INFO)
				return
			end

			local buf = 0
			local count = vim.api.nvim_buf_line_count(buf)

			local signature = {
				"",
				"--- " .. input_msg,
				string.format("--- Signed by %s on %s", user_name, os.date("%Y-%m-%d")),
			}

			vim.api.nvim_buf_set_lines(buf, count, count, false, signature)
		end)
	end)
end

vim.api.nvim_create_user_command("CustomSign", M.run_prompt, { desc = "Add Custom Sign" })

return M

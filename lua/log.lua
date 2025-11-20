-- filter file by keyword
local function filter_log_file(...)
	local current_file = vim.fn.expand("%:p")

	local arg_count = select("#", ...)
	local args = { ... }

	local input_path
	local keyword

	if arg_count == 2 then
		input_path = args[1]
		keyword = args[2]
	elseif arg_count == 1 then
		input_path = current_file
		keyword = args[1]
	else
		vim.api.nvim_echo({ { "Invalid params", "ErrorMsg" } }, true, {})
		return
	end

	print(input_path, keyword)

	local lines = vim.fn.readfile(input_path)
	local filtered_lines = {}

	for _, line in ipairs(lines) do
		if vim.fn.stridx(line, keyword) ~= -1 then
			print(line, keyword)
			table.insert(filtered_lines, line)
		end
	end

	local output_path = input_path .. "_filtered.log"
	vim.fn.writefile(filtered_lines, output_path)

	vim.api.nvim_echo({ { "filter success!", "MoreMsg" } }, false, {})

	vim.cmd("split " .. output_path)
end

vim.api.nvim_create_user_command("Filter", function(opts)
	filter_log_file(unpack(opts.fargs))
end, {
	nargs = "*",
	desc = "Filter lines in the current file by keyword",
})

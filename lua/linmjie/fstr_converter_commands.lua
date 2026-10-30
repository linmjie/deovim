---@diagnostic disable: unused-local
local fstr = require("linmjie.fstr_converter")

local options = {
	cout = function(str, opts)
		local format_table = fstr.fstr_to_concatenatable_strlist(str)
		local builder = { "std::cout" }
		for index, value in ipairs(format_table) do
            -- print("value: ", value)
			if type(value) == "string" then
				table.insert(builder, value)
			else
				-- currently ignores formatting
				local expr, format = value.expr, value.format
				assert(type(expr) == "string", "oopsies, improper type!")
				table.insert(builder, expr)
			end
		end
		table.insert(builder, "'\\n';")
		return table.concat(builder, " << ")
	end,
}

vim.api.nvim_create_user_command("Tester", function(opts)
	if opts == nil then
		print("Choose an output to convert to")
		return
	end
	print(opts.args)
end, {
	nargs = 1,
})

vim.api.nvim_create_user_command("FstrConvert", function(opts)
	if opts == nil then
		-- TODO: make error
		print("uhm this is bad")
		return
	end
	local get_converted_fstr = options[opts.args]
	if get_converted_fstr == nil or type(get_converted_fstr) ~= "function" then
		print("Please choose a valid option")
		return
	end
	local str = vim.api.nvim_get_current_line()
	local trimmed_str = string.match(str, "^%s*(.-)%s*$")
	local new_str = get_converted_fstr(trimmed_str, opts)
	print(new_str)
end, {
	nargs = 1,
})

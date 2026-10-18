local M = {}

-- avoids spliting :: (like in some_namespace::member:.2f)
-- assumes one split (ie. 'expr', 'fmt')
local safe_colon_split = function(inputstr)
    for i = 1, #inputstr do
		if string.sub(inputstr, i, i) == ":"
			and string.sub(inputstr, i - 1, i - 1) ~= ":"
			and string.sub(inputstr, i + 1, i + 1) ~= ":" then
			return string.sub(inputstr, 1, i - 1), string.sub(inputstr, i + 1)
		end
	end

	return inputstr, nil
end

M.fstr_to_cformat = function(fstr)
	-- input format: "variable 1: ({var:.2f})"
	-- result: {"variable 1: ({})", [ { expr = var, fmt = ".2f" } ]}
    local format_str_table = {}
	local expressions = {}
	local last_pos = 1

	-- () before (%b{}) to retrieve index of match
	for pos, placeholder in string.gmatch(fstr, "()(%b{})") do
		-- Preserve literal text before the placeholder.
		table.insert(format_str_table, string.sub(fstr, last_pos, pos - 1))

		local inner = string.sub(placeholder, 2, -2)
		local expr, fmt = safe_colon_split(inner)

		table.insert(expressions, {
			expr = expr,
			fmt = fmt,
		})

		table.insert(format_str_table, "{}")
		last_pos = pos + #placeholder
	end

	-- preserve any trailing literal text.
	table.insert(format_str_table, string.sub(fstr, last_pos))

	return table.concat(format_str_table), expressions
end

M.fstr_to_concatenatable_strlist = function(fstr)
	-- input format: "variable 1: ({var:.2f})"
	-- result: ["variable 1: (", { expr = var, fmt = ".2f" }, ")"]
    fstr = string.match(fstr, "^['\"](.-)['\"]$")
	local ret = {}
    local last_pos = 1

	-- () before (%b{}) to retrieve index of match
	for pos, placeholder in string.gmatch(fstr, "()(%b{})") do
		-- literal text preceding this placeholder.
		local literal = string.sub(fstr, last_pos, pos - 1)

		if literal ~= "" then
			table.insert(ret, '"' .. literal .. '"')
            print("literal read: ", literal)
		end

		local inner = string.sub(placeholder, 2, -2)
		local expr, fmt = safe_colon_split(inner)

		table.insert(ret, {
			expr = expr,
			fmt = fmt,
		})

		last_pos = pos + #placeholder
	end

	-- trailing literal text.
	local literal = string.sub(fstr, last_pos)
	if literal ~= "" then
		table.insert(ret, '"' .. literal .. '"')
	end
	return ret
end

return M

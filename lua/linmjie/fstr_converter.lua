local M = {}

local split = function(inputstr, find)
    if sep == nil then
        sep = "%s" -- Defaults to whitespace if no separator is given
    end
    local ret = {}
    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        table.insert(ret, str)
    end
    return ret
end

M.fstr_to_cformat = function(fstr)
    -- input format: "variable 1: ({var:.2f})"
    -- result: {"variable 1: (REPLACE)", [ { expr = var, fmt = ".2f" } ]}
end


M.fstr_to_concatenatable_strlist = function(fstr)
    -- input format: "variable 1: ({var:.2f})"
    -- result: ["variable1: ", "(", { expr = var, fmt = ".2f" }, ")"]
end

return M

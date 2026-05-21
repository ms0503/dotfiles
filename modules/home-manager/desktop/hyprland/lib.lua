local M = {}

function M.filter(tbl, pred)
    local result = {}
    for _, v in pairs(tbl) do
        if pred(v) then
            table.insert(result, v)
        end
    end
    return result
end

function M.map(tbl, fn)
    local result = {}
    for i, v in pairs(tbl) do
        result[i] = fn(v)
    end
    return result
end

function M.partition(tbl, pred)
    local left = {}
    local right = {}
    for _, v in pairs(tbl) do
        if pred(v) then
            table.insert(right, v)
        else
            table.insert(left, v)
        end
    end
    return left, right
end

function M.reduce(tbl, fn, initial)
    local out = initial
    for i = 1, #tbl do
        out = fn(out, tbl[i])
    end
    return out
end

return M

local utils = {}

function utils.addToTable(base_table, added_table)
    for _, value in pairs(added_table) do
        base_table[#base_table+1] = value
    end
end

return utils
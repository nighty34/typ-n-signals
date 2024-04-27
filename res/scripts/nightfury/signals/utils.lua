local utils =  {}

function utils.getEdgeSpeed(edge)
	local transportNetwork = utils.getComponentProtected(edge.entity, 52)
	local speed = math.huge
	if not (transportNetwork == nil) then
		local index = 1 + edge.index
		if index > #transportNetwork.edges then
			index = 0
		end
		local edges = transportNetwork.edges[index]

		speed = math.min(edges.speedLimit, speed)
		speed = math.min(edges.curveSpeedLimit, speed)
	end
	return speed * 3.6
end

function utils.getComponentProtected(entity, code)
	if pcall(function() api.engine.getComponent(entity, code) end) then
		return api.engine.getComponent(entity, code)
	else
		return nil
	end
end

function utils.getMinValue(values)
	local minValue = math.huge
	for _, value in ipairs(values) do
		minValue = math.min(minValue, value)
	end
	
	return minValue
end

function utils.getFirstKey(list)
	local firstKey
	
	for key, _ in pairs(r_signal) do
		if not firstKey then
			firstKey = key
			break
		end
	end
end

function utils.checksum(operator, ...) -- way to simpel checksum 
    local args = {...}
	local localsum = 0
    for _, arg in ipairs(args) do
		if arg ~= nil then
			localsum = localsum + tonumber(arg)
		end

	end

    return localsum * operator
end

function utils.starts_with(str, start)
	return str:sub(1, #start) == start
end

function utils.ends_with(str, ending)
	return ending == "" or str:sub(-#ending) == ending
end

function utils.removeFromTableByValue(tbl, remove)
    for key, value in ipairs(tbl) do
		if value == remove then
			table.remove(tbl, key)
		end
    end
end

function utils.contains(tbl, x)
    local found = false
    for _, v in pairs(tbl) do
        if v == x then
            found = true
        end
    end
    return found
end

return utils
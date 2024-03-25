local utils =  {}

function utils.getEdgeSpeed(edge)
	local transportNetwork = utils.getComponentProtected(edge, 52)
		if not (transportNetwork == nil) then
		
		local minSpeed = transportNetwork.edges[1].speedLimit -- speedLimit
		local curveSpeed = transportNetwork.edges[1].curveSpeedLimit -- curveSpeed
		if minSpeed < curveSpeed then 
			return minSpeed * 3.6
		end
		
		return curveSpeed * 3.6
	end
	return math.huge -- return ~infinity
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
	for i, value in ipairs(values) do
		minValue = math.min(minValue, value)
	end
	
	return minValue
end

function utils.getFirstKey(list)
	local firstKey
	
	for key, value in pairs(r_signal) do
		if not firstKey then
			firstKey = key
			break
		end
	end
end

return utils
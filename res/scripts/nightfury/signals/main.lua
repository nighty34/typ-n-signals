local signals = {}
local signalObject = {}

function getTrainInfos()
	local trains = {}
    api.engine.system.trainMoveSystem.forEach(function (a) table.insert(trains, a) end)
	
	for i,train in ipairs(trains) do
		local move_path = api.engine.getComponent(train, 66)
		local signalPaths = walkPath(move_path)
		
		for i, signalPath in ipairs(signalPaths) do
			local minSpeed = getMinValue()
		end
	end
end

function getComponentProtected(entity, code)
	if pcall(function() api.engine.getComponent(entity, code) end) then
		return api.engine.getComponent(entity, code)
	else 
		return nil
	end
end

function getMinValue(values)
	local minValue = math.huge
	for i, value in ipairs(values) do
		minValue = math.min(minValue, value)
	end
	
	return minValue
end


function getEdgeSpeed(edge)
	local transportNetwork = getComponentProtected(edge, 52)
		if not (transportNetwork == nil) then
		
		local minSpeed = transportNetwork.edges[1].speedLimit-- speedLimit
		local curveSpeed = transportNetwork.edges[1].curveSpeedLimit -- curveSpeed
		if minSpeed < curveSpeed then 
			return minSpeed * 3.6
		end
		
		return curveSpeed * 3.6
	end
	return 10000000 -- return hight number
end


function walkPath(move_path)
	print("-----[StartBlock]-----")
	local signalPaths = {} 
	local signalIndex = 0
	
	local tempSignalPaths = {}
	local signalPath = {}
	local i = move_path.dyn.pathPos.edgeIndex
	while i <= move_path.dyn.pathPos.edgeIndex + move_path.path.endOffset do
		local path = move_path.path.edges[i]
		
		if signalIndex > 0 then
			table.insert(signalPath, path.edgeId.entity)
		end
		
		local signalId = api.engine.system.signalSystem.getSignal(path.edgeId, path.dir)
		local signalList = getComponentProtected(signalId.entity, 26)
		
		if not (signalList == nil) then
			print(api.engine.getComponent(signalId.entity, 63).name)
			local signal = signalList.signals[1]
			print(signal.state)
			
			tempSignalPaths.path = signalPath
			tempSignalPaths.signal = signalId.entity
			
			if signalIndex > 0 then
				table.insert(signalPaths, tempSignalPaths)
				tempSignalPaths = {}
				signalPath = {}
			end
			
			signalIndex = signalIndex + 1
		end

		i = i + 1
	end
	print("-----[EndBlock]-----")
	
	return signalPaths
end

function signals.getSignalObject()
	return signalObject
end

function signals.createNewSignal(signal, construct)
	signalObject[construct].signal = signal
end

function signals.createParams()
	local params = {}
	
	params[#params + 1] = {
		key = "nighty_signals",
		name = _("nighty_signaling"),
		values = {_("nighty_signaling_1"),_("nighty_signaling_2")},
		defaultIndex = 0,
	}
	
	return params
end

return signals


local signals = {}
local signalObject = {}

signals.signals = {}

function getTrainInfos()
	local trains = {}
    api.engine.system.trainMoveSystem.forEach(function (a) table.insert(trains, a) end)
	
	for i,train in ipairs(trains) do
		local move_path = api.engine.getComponent(train, 66)
		local signalPaths = walkPath(move_path)
		
		for i, signalPath in ipairs(signalPaths) do
			local minSpeed = signalPath.minSpeed
			local signalState = signalPath.signalState
			print("---[SignalPath Start]---")
			print("PathSpeed: " .. minSpeed .. "")
			print("PathState: " .. signalState .. "")
			print("---[SignalPath End]---")
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
	local signalPaths = {} 
	local signalIndex = 0
	
	local tempSignalPaths = {}
	local signalPath = {}
	local signalPathSpeed = {}
	local i = move_path.dyn.pathPos.edgeIndex
	while i <= move_path.dyn.pathPos.edgeIndex + move_path.path.endOffset do
		local path = move_path.path.edges[i]
		
		if signalIndex > 0 then
			table.insert(signalPath, path.edgeId.entity)
			table.insert(signalPathSpeed, getEdgeSpeed(path.edgeId.entity))
		end
		
		local signalId = api.engine.system.signalSystem.getSignal(path.edgeId, path.dir)
		local signalList = getComponentProtected(signalId.entity, 26)
		
		if not (signalList == nil) then
			local signal = signalList.signals[1]
			
			tempSignalPaths.minSpeed = getMinValue(signalPathSpeed)
			tempSignalPaths.path = signalPath
			tempSignalPaths.signal = signalId.entity
			tempSignalPaths.signalState = signal.state
			
			if signalIndex > 0 then
				table.insert(signalPaths, tempSignalPaths)
				tempSignalPaths = {}
				signalPath = {}
				signalPathSpeed = {}
			end
			
			signalIndex = signalIndex + 1
		end

		i = i + 1
	end
	
	return signalPaths
end

function signals.getSignalObject()
	return signalObject
end

function signals.createNewSignal(signal, construct)
	signalObject[signal].construct = construct
end

function signals.createParams()
	local params = {}
	
	params[#params + 1] = {
		key = "nighty_signals",
		name = _("nighty_signaling"),
		values = {_("nighty_signaling_1"),_("nighty_signaling_2")},
		defaultIndex = 1,
	}
	params[#params + 1] = {
		key = "nighty_signals_green",
		name = _("nighty_signals_green"),
		values = {_("nighty_on"),_("nighty_off")},
		defaultIndex = 1,
	}
	params[#params + 1] = {
		key = "nighty_signals_red",
		name = _("nighty_signals_red"),
		values = {_("nighty_on"),_("nighty_off")},
		defaultIndex = 1,
	}
	params[#params + 1] = {
		key = "nighty_signals_yellow",
		name = _("nighty_signals_yellow"),
		values = {_("nighty_on"),_("nighty_off")},
		defaultIndex = 1,
	}
	
	
	return params
end

return signals


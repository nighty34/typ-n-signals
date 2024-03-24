local signals = {}

signals.signals = {}
signals.signalObjects = {}

function signals.getTrainInfos()
	local trains = {}
    api.engine.system.trainMoveSystem.forEach(function (a) table.insert(trains, a) end)
	
	for i,train in ipairs(trains) do
		local move_path = getComponentProtected(train, 66)

		if move_path ~= nil then
		
			local signalPaths = walkPath(move_path)
			
			for i, signalPath in ipairs(signalPaths) do
				local minSpeed = signalPath.minSpeed
				local signalState = signalPath.signalState
				
				local signalString = "signal" .. signalPath.signal
				print("Trying to read: " .. signalString)
				
				local c_signal = signals.signalObjects[signalString]
				
				if c_signal then
					local oldConstruction = game.interface.getEntity(c_signal)--getComponentProtected(c_signal, 13)
					if oldConstruction then
						oldConstruction.params.nighty_signals_green = 1 - signalState
						oldConstruction.params.nighty_signals_red = signalState
						oldConstruction.params.seed = nil
						game.interface.upgradeConstruction(oldConstruction.id, oldConstruction.fileName, oldConstruction.params)
					else
						print("couldn't access params")
					end
				else 
					print("couldn't find signal in table")
				end
			end

		end
	end
end

function signals.createSignal(signal, construct)
	print("Register Signal: " .. signal .. " (" .. "signal" .. signal ..") With construction: " .. construct)
	signals.signalObjects["signal" .. signal] = construct
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
	return math.huge -- return hight number
end

function upgradeProposal(entity_id, signalState) -- stolen from: https://www.transportfever.net/thread/16532-update-von-konstruktionen-simpleproposal/?postID=337120&highlight=upgradeConstruction#post337120
	local oldConstruction = game.interface.getEntity(entity_id) -- constructionOwned is a construction owned edge entity ID 
	local proposal = api.type.SimpleProposal.new()
	proposal.constructionsToRemove = {entity_id}
	local pd = api.engine.util.proposal.makeProposalData(proposal, context)
	if pd.errorState.critical == true then
		table.insert(errorList, {edgeId, pd.errorState.messages[1] .. ": " .. constr.fileName})
	else
		local check = game.interface.upgradeConstruction(oldConstruction.id, oldConstruction.fileName, pure(oldConstruction.params))
		if check ~= entity_id then
			table.insert(errorList, {edgeId, "construction upgrade error: " .. constr.fileName})
		end
	end
end


function walkPath(move_path)
	local signalPaths = {} 
	local signalIndex = 0
	
	local tempSignalPaths = {}
	local signalPath = {}
	local signalPathSpeed = {}
	local i = move_path.dyn.pathPos.edgeIndex
	while (i <= move_path.dyn.pathPos.edgeIndex + move_path.path.endOffset) and (move_path.path ~= nil) do
		local path = move_path.path.edges[i]
		
		if path ~= nil then
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
		end

		i = i + 1
	end
	
	return signalPaths
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


local utils = require "nightfury/signals/utils"
local signals = {}

signals.signals = {}
-- Table holds all placed Signals
signals.signalObjects = {}

signals.signalIndex = 0

signals.pos = {0,0}


-- 3 states: None, Changed, WasChanged

-- Function checks move_path of all the trains
-- If a signal is found it's current state is checked
-- after that the signal will be changed accordingly
function signals.updateSignals()
	local trainActivationRange = 500 -- To be changed

	local trains = {}
	local vehicles = game.interface.getEntities({pos = signals.pos, radius = trainActivationRange}, {type = "VEHICLE"})
	for index, vehicle in pairs(vehicles) do
		local train = utils.getComponentProtected(vehicle, 70)
		if (train ~= nil) and (not train.userStopped) and (not train.noPath) and (not train.doorsOpen) then
			table.insert(trains, vehicle)
		end
	end
	
	-- print("Computing Train Count: " .. #trains)
	
    --api.engine.system.trainMoveSystem.forEach(function (a)
	--	local train = utils.getComponentProtected(a, 70)
	--	if (train ~= nil) and (not train.userStopped) and (not train.noPath) and (not train.doorsOpen) then
	--		table.insert(trains, a)
	--	end
	--end)
	
	for key, value in pairs(signals.signalObjects) do
		value.changed = value.changed * 2
	end
	
	for i,train in pairs(trains) do
		local move_path = utils.getComponentProtected(train, 66)

		if move_path then
			local signalPaths = walkPath(move_path)
			
			for i, signalPath in ipairs(signalPaths) do
				local minSpeed = signalPath.minSpeed
				local signalState = signalPath.signalState
				local dest = 0
				local direction = 0
				
				if signalPath.speed then
					minSpeed = signalPath.speed
				end
				
				if signalPath.dest then
					dest = signalPath.dest
				end
				
				if signalPath.direction then
					direction = signalPath.direction
				end
				
				local signalString = "signal" .. signalPath.signal
				local tableEntry = signals.signalObjects[signalString]
				
				if tableEntry then
					local c_signal = tableEntry.construction
					signals.signalObjects[signalString].changed = 1
					
					if c_signal then
						local oldConstruction = game.interface.getEntity(c_signal)
						if oldConstruction then
							oldConstruction.params.nighty_signals_green = 1 - signalState
							oldConstruction.params.nighty_signals_red = signalState
							oldConstruction.params.nighty_signals_speed = math.floor(minSpeed)
							oldConstruction.params.nighty_signals_dest = dest
							oldConstruction.params.nighty_signals_direction = direction
							oldConstruction.params.seed = nil -- important!!
							game.interface.upgradeConstruction(oldConstruction.id, oldConstruction.fileName, oldConstruction.params)
						else
							print("couldn't access params")
						end
					end
				end
			end

		end
	end
	
	-- Throw signal to red
	for key, value in pairs(signals.signalObjects) do
		if value.changed == 2 then
			local oldConstruction = game.interface.getEntity(value.construction)
			if oldConstruction then
				oldConstruction.params.nighty_signals_green = 1
				oldConstruction.params.nighty_signals_red = 0
				oldConstruction.params.seed = nil -- important!!
				game.interface.upgradeConstruction(oldConstruction.id, oldConstruction.fileName, oldConstruction.params)
			end
			value.changed = 0
		end
	end
end


-- Registers new signal
-- @param signal signal entityid
-- @param construct construction entityid
function signals.createSignal(signal, construct)
	local signalKey = "signal" .. signal
	print("Register Signal: " .. signal .. " (" .. signalKey ..") With construction: " .. construct)
	signals.signalObjects[signalKey] = {}
	signals.signalObjects[signalKey].construction = construct
	signals.signalObjects[signalKey].changed = 0
end


function parseName(input)
    local values = {}
    
    -- Iterate over each key-value pair in the input string
    for pair in input:gmatch("%s*([^,]+)%s*,?") do
        local key, value = pair:match("(%w+)%s*=%s*(%d+)")
        if key and (key == "speed" or key == "dest" or key == "direction") then
            values[key] = tonumber(value)
        end
    end
    
    return values
end

-- Walks down the given path and analyses path.
-- @param move_path Move_path value from a trains path
-- @return returns analysed path with signal states and maxSpeed of the parts
function walkPath(move_path)
	local pathViewDistance = 20 -- To be changed

	local signalPaths = {} 
	
	local tempSignalPaths = {}
	local signalPathSpeed = {}
	local activeSignal = {}
	
	
	local polygon = {}
	
	if move_path.path then
		local i = math.max((move_path.dyn.pathPos.edgeIndex - 2), 1)
		local path_end = math.min(#move_path.path.edges, i + pathViewDistance)
		
		while (i <= path_end) do
			local path = move_path.path.edges[i]
			
			if path then
				local signalId = api.engine.system.signalSystem.getSignal(path.edgeId, path.dir)
				local signalList = utils.getComponentProtected(signalId.entity, 26)
				
				if signalList then -- found Signal
				
					local signal = signalList.signals[1]
					
					if signal.type == 0 then
					
						if activeSignal.signal and activeSignal.signalId then
							tempSignalPaths.minSpeed = utils.getMinValue(signalPathSpeed)
							tempSignalPaths.signal = activeSignal.signalId.entity
							tempSignalPaths.signalState = activeSignal.signal.state
							
							table.insert(signalPaths, tempSignalPaths)
						end
						
						activeSignal.signal = signal
						activeSignal.signalId = signalId
							
						tempSignalPaths = {}
						signalPathSpeed = {}						
					elseif signal.type == 2 then
						local name = utils.getComponentProtected(signalId.entity, 63)
						local values = parseName(name.name)
						
						tempSignalPaths.speed = values['speed']
						tempSignalPaths.dest = values['dest']
						tempSignalPaths.direction = values['direction']
					end
					

					

				end

				table.insert(signalPathSpeed, utils.getEdgeSpeed(path.edgeId.entity))
			end

			i = i + 1
		end
	end
	
	if activeSignal.signal and activeSignal.signalId then
		tempSignalPaths.minSpeed = utils.getMinValue(signalPathSpeed)
		tempSignalPaths.signal = activeSignal.signalId.entity
		tempSignalPaths.signalState = activeSignal.signal.state
		
		table.insert(signalPaths, tempSignalPaths)
	end

	
	return signalPaths
end


-- Generic Params for signals
-- @return returns params for signal constructions
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
	
	local speedValues = {}
	for i = 1, 1000, 1 do
		table.insert(speedValues, (i .. ""))
	end

	
	params[#params + 1] = {
		key = "nighty_signals_speed",
		name = _("nighty_signals_speed"),
		uiType = "SLIDER",
		values = speedValues,
	}
	
	params[#params + 1] = {
		key = "nighty_signals_dest",
		name = _("nighty_signals_dest"),
		uiType = "SLIDER",
		values = speedValues,
	}

	params[#params + 1] = {
		key = "nighty_signals_",
		name = _("nighty_signals_dest"),
		uiType = "SLIDER",
		values = {_("nighty_rightWay"), _("nighty_wrongWay")},
	}
	
	
	return params
end

return signals


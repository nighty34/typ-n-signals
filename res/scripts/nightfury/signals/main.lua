local utils = require "nightfury/signals/utils"
local taskutrils = require "mission/taskutil"
local signals = {}

signals.signals = {}
-- Table holds all placed Signals
signals.signalObjects = {}

-- 3 states: None, Changed, WasChanged


-- Function checks move_path of all the trains
-- If a signal is found it's current state is checked
-- after that the signal will be changed accordingly
function signals.updateSignals()
	local trains = {}
    api.engine.system.trainMoveSystem.forEach(function (a) table.insert(trains, a) end)
	
	for key, value in pairs(signals.signalObjects) do
		value.changed = value.changed * 2
	end
	
	for i,train in ipairs(trains) do
		local move_path = utils.getComponentProtected(train, 66)

		if move_path then
			local signalPaths = walkPath(move_path)
			
			for i, signalPath in ipairs(signalPaths) do
				local minSpeed = signalPath.minSpeed
				local signalState = signalPath.signalState
				
				local signalString = "signal" .. signalPath.signal
				local c_signal = signals.signalObjects[signalString].construction
				
				signals.signalObjects[signalString].changed = 1
				
				if c_signal then
					local oldConstruction = game.interface.getEntity(c_signal)
					if oldConstruction then
						oldConstruction.params.nighty_signals_green = 1 - signalState
						oldConstruction.params.nighty_signals_red = signalState
						oldConstruction.params.seed = nil -- important!!
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


-- Walks down the given path and analyses path.
-- @param move_path Move_path value from a trains path
-- @return returns analysed path with signal states and maxSpeed of the parts
function walkPath(move_path)
	local signalPaths = {} 
	local signalIndex = 0
	
	local tempSignalPaths = {}
	local signalPath = {}
	local signalPathSpeed = {}
	local i = move_path.dyn.pathPos.edgeIndex
	while (i <= move_path.dyn.pathPos.edgeIndex + move_path.path.endOffset) and (move_path.path ~= nil) do
		local path = move_path.path.edges[i]
		
		if path then
			if signalIndex > 0 then
				table.insert(signalPath, path.edgeId.entity)
				table.insert(signalPathSpeed, utils.getEdgeSpeed(path.edgeId.entity))
			end
			
			local signalId = api.engine.system.signalSystem.getSignal(path.edgeId, path.dir)
			local signalList = utils.getComponentProtected(signalId.entity, 26)
			
			if not (signalList == nil) then
				local signal = signalList.signals[1]
				
				tempSignalPaths.minSpeed = utils.getMinValue(signalPathSpeed)
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


function signals.closeSignals() 
	for signal, construction in pairs(signals.signalObjects) do
		
	end
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
	
	
	return params
end

return signals


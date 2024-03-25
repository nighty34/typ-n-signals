local signals = require "nightfury/signals/main"
local utils = require "nightfury/signals/utils"


-- Function will analyze params and determine if it's a in the config
-- registered Signal.
-- If a signal is detected it returns signal params
-- @param params param value from the guiHandleEvent
-- @return returns table with information about the signal
local function getSignal(params)
    if not params.proposal.toAdd or #params.proposal.toAdd == 0 then
		return nil
	end
	
    local added = params.proposal.toAdd[1]
    local signal = string.match(added.fileName, "^.+/(.+)%.con$")

	if signals.signals[signal] == nil then
		return
	end

    local position = {added.transf[13], added.transf[14], added.transf[15]}

	local result = {
		position = position,
		construction = params.result[1],
	}
	return result
end


function data()
	return{
		update = function()
			local success, errorMessage = pcall(signals.updateSignals)
		
			if success then
			else 
				print(errorMessage)
			end
		end,
		handleEvent = function(src, id, name, param)
			if id ~="__signalEvent__" or src ~= "nighty_better_signals_placer_callback.lua" then
				return
			end
	
			
            if name == "builder.apply" then
			
				local c_signal = param.construction

				local r_signal = game.interface.getEntities({radius=8,pos={param.position[1],param.position[2]}}, { type = "SIGNAL", includeData = true })
				
				local firstKey
				
				for key, value in pairs(r_signal) do
					if not firstKey then
						firstKey = key
						break
					end
				end
				
				print("Found Signal: " .. firstKey)
				
				signals.createSignal(firstKey, c_signal)
			end
			
			
		end,
		guiHandleEvent = function(id, name, param)
			if name == "visibilityChange" and param == false then
				local signal = string.match(id, "^.+/(.+)%.con$")
				
				if not signal then
					return
				end
				
				
			elseif name == "builder.apply" then	
				local signal_params = getSignal(param)
				
				if not signal_params then
					return
				end
				print("Will send Event")
				game.interface.sendScriptEvent("__signalEvent__", name, signal_params)
			end
		end
	}
end
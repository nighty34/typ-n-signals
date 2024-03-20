local signals = require "nightfury/signals/main"

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
	}
	return result
end


function data()
	return{
		handleEvent = function(src, id, name, param)
			
			if src ~="__signalEvent__" or src ~= "nighty_better_signals_placer_callback.lua" then
				return
			end
			
            if name == "builder.apply" then
                                
                print("Building Signal")
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
				
				local c_signal = param.result[1]

				local r_signal = game.interface.getEntities({radius=8,pos={signal_params.position[1],signal_params.position[2]}}, { type = "SIGNAL", includeData = true })
				
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
		end
	}
end
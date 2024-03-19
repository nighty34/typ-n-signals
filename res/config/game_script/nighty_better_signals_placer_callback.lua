local signals = require "nightfury/signals/main"

local function getSignal(params)

    if not params.proposal.toAdd or #params.proposal.toAdd == 0 then
		return nil
	end
	
    local added = params.proposal.toAdd[1]


    local signal = string.match(added.fileName, "^.+/(.+)%.con$")
--    if not signals.signals[signal] then
--        return
--    end
	return {}
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
				
				
			elseif name == "builder.apply" or name == "builder.proposalCreate" then	
				local params = getSignal(param)
				
				
				if not params then
					return
				end	
				
				
				-- when object is a Signal
				-- get closest edge. 
				-- place signal on edge
				
				-- signals.createSignal(r_signal, c_signal)
			end
		end
	}
end
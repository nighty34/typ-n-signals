local signals = require "nightfury/signals/main"
local utils = require "nightfury/signals/utils"
local zone = require "nightfury/signals/zone"

local state = {
	signalIndex = 0,
	markedSignal = nil
}


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
	}
	return result
end


local signalIndex = 0


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
				
				
				if state.markedSignal then 
					local r_signal = state.markedSignal
					
					signals.createSignal(r_signal, c_signal)
				else
					print("No Signal Found")
				end
			elseif name == "builder.proposalCreate" then
				local r_signals = game.interface.getEntities({radius=10,pos={param.position[1],param.position[2]}}, { type = "SIGNAL" })
				local signal = r_signals[(((state.signalIndex*2)+1) % #r_signals) + 1]
				
				if signal then
					local signalTransf = utils.getComponentProtected(signal, 58).fatInstances[1].transf
					zone.setZoneCircle("selectedSignal", {signalTransf[13], signalTransf[14]}, 2)
					state.markedSignal = signal
				else
					if #r_signals == 0 then
						zone.remZone("selectedSignal")
						state.markedSignal = nil 
					end
				end
				
				
			elseif name == "signals.viewUpdate" then
				signals.pos = param
			elseif name == "signals.nextSignal" then
				state.signalIndex = state.signalIndex + 1
			end
		end,
		guiHandleEvent = function(id, name, param)
			if name == "visibilityChange" and param == false then
				local signal = string.match(id, "^.+/(.+)%.con$")
				
				if not signal then
					return
				end	
				
			elseif (name == "builder.apply") or (name == "builder.proposalCreate") then
				local signal_params = getSignal(param)
				if not signal_params then
					return
				end

				if name == "builder.apply" then
					signal_params.construction = param.result[1]
				end
				
				game.interface.sendScriptEvent("__signalEvent__", name, signal_params)
				
			elseif name == "builder.rotate"then
					game.interface.sendScriptEvent("__signalEvent__", "signals.nextSignal", {})
					
			elseif id == "mainView" and (name == "camera.userPan" or name == 'camera.keyScroll') then
				local view = game.gui.getCamera()
				
				if view then
					local pos = {view[1], view[2]}
					zone.setZoneCircle("tar_signals", pos, 500)
					game.interface.sendScriptEvent("__signalEvent__", "signals.viewUpdate", pos)
				end
			end
		end
	}
end
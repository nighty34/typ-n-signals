local utils = require "nightfury/signals/type_n_utils"
local builder = {}

function builder.eval_main_signal_type(param_value)
	if param_value == 1 then
		return "entrySignal"
	elseif param_value == 2 then
		return "exitSignal"
	elseif param_value == 3 then
		return "entryNexit"
	elseif param_value == 4 then
		return "preStationSignal"
	elseif param_value == 5 then
		return "shuntingStop"
	end


	return nil
end

function builder.eval_pre_signal_type(param_value)
	if param_value == 1 then
		return "repeat"
	elseif param_value == 2 then
		return "preStationSignal"
	end

	return nil
end

function builder.calc_x_offset(start_value, param_value)
    local x_offset = 0
    if param_value == 0 then x_offset = 0.75 end;
    if param_value == 1 then x_offset = 0.60 end;
    if param_value == 2 then x_offset = 0.45 end;
    if param_value == 3 then x_offset = 0.30 end;
    if param_value == 4 then x_offset = 0.15 end;
    if param_value == 5 then x_offset = 0 end;
    if param_value == 6 then x_offset = -0.15 end;
    if param_value == 7 then x_offset = -0.30 end;
    if param_value == 8 then x_offset = -0.45 end;
    if param_value == 9 then x_offset = -0.60 end;
    if param_value == 10 then x_offset = -0.75 end;

    return x_offset + start_value
end

function builder.set_y_offset(start_value, param_side)
	if param_side == 0 then
		return start_value - 2.5
	elseif param_side == 2 then
		return start_value + 2.5
	end

	return start_value
end


function builder.buildSignalLamps(canDisplayRed, isGreen, displayWarning, displayOccupied, indicatesNextSpeed, nextStopSignalDistance, x_offset, y_offset, z_offset)
	local models = {}
	if not isGreen and canDisplayRed then
		models[#models+1] = { id = "nighty/signals/typ-n_base_red.mdl", transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, x_offset, y_offset, z_offset, 1 }}
	elseif (nextStopSignalDistance == 1) or (indicatesNextSpeed or (displayWarning and (nextStopSignalDistance == 2)) or (displayOccupied and (nextStopSignalDistance == 1))) then
		models[#models+1] = { id = "nighty/signals/typ-n_base_yellow.mdl", transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, x_offset, y_offset, z_offset, 1 }}
	else
		models[#models+1] = { id = "nighty/signals/typ-n_base_green.mdl", transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, x_offset, y_offset, z_offset, 1 }}
	end

	return models
end

function builder.buildSpeedIndicator(isGreen, canIndicateSpeed, indicatedSpeed, displayWarning, displayOccupied, x_offset, y_offset, z_offset)
	local models = {}

	models[#models+1] = { id = "nighty/signals/typ-n_base_speedindicator.mdl", transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, x_offset, y_offset, z_offset, 1 }}
	if isGreen then
		if canIndicateSpeed then
			if indicatedSpeed <= 40 then
				models[#models+1] = { id = "nighty/signals/typ-n_base_speed_40.mdl", transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, x_offset, y_offset, z_offset, 1 }}	
			elseif indicatedSpeed <= 50 then
				models[#models+1] = { id = "nighty/signals/typ-n_base_speed_50.mdl", transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, x_offset, y_offset, z_offset, 1 }}	
			elseif indicatedSpeed <= 60 then
				models[#models+1] = { id = "nighty/signals/typ-n_base_speed_60.mdl", transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, x_offset, y_offset, z_offset, 1 }}	
			elseif indicatedSpeed <= 70 then
				models[#models+1] = { id = "nighty/signals/typ-n_base_speed_70.mdl", transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, x_offset, y_offset, z_offset, 1 }}	
			elseif indicatedSpeed <= 80 then
				models[#models+1] = { id = "nighty/signals/typ-n_base_speed_80.mdl", transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, x_offset, y_offset, z_offset, 1 }}
			elseif indicatedSpeed <= 90 then
				models[#models+1] = { id = "nighty/signals/typ-n_base_speed_90.mdl", transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, x_offset, y_offset, z_offset, 1 }}
			elseif indicatedSpeed <= 100 then
				models[#models+1] = { id = "nighty/signals/typ-n_base_speed_100.mdl", transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, x_offset, y_offset, z_offset, 1 }}
			elseif indicatedSpeed <= 110 then
				models[#models+1] = { id = "nighty/signals/typ-n_base_speed_110.mdl", transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, x_offset, y_offset, z_offset, 1 }}
			elseif indicatedSpeed <= 120 then
				models[#models+1] = { id = "nighty/signals/typ-n_base_speed_120.mdl", transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, x_offset, y_offset, z_offset, 1 }}
			elseif indicatedSpeed <= 130 then
				models[#models+1] = { id = "nighty/signals/typ-n_base_speed_130.mdl", transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, x_offset, y_offset, z_offset, 1 }}
			elseif indicatedSpeed <= 140 then
				models[#models+1] = { id = "nighty/signals/typ-n_base_speed_140.mdl", transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, x_offset, y_offset, z_offset, 1 }}
			elseif indicatedSpeed <= 150 then
				models[#models+1] = { id = "nighty/signals/typ-n_base_speed_150.mdl", transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, x_offset, y_offset, z_offset, 1 }}
			elseif indicatedSpeed <= 160 then
				models[#models+1] = { id = "nighty/signals/typ-n_base_speed_160.mdl", transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, x_offset, y_offset, z_offset, 1 }}
			end
		elseif displayWarning then
			models[#models+1] = { id = "nighty/signals/typ-n_base_speed_v.mdl", transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, x_offset, y_offset, z_offset, 1 }}
		elseif displayOccupied then
			models[#models+1] = { id = "nighty/signals/typ-n_base_speed_occupied.mdl", transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, x_offset, y_offset, z_offset, 1 }}
		end
	end

	return models
end


function builder.buildStandingMasts(nighty_type_n_build_form, nighty_type_n_mast, nighty_type_n_mast_addon, nighty_type_n_worker_platform, x_offset, y_offset, z_offset)
	local models = {}
	if nighty_type_n_build_form == 0 then
		models[#models+1] = { id = "nighty/signals/typ-n_schirm_alt_main.mdl", transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, x_offset, y_offset, z_offset, 1 }}
	elseif nighty_type_n_build_form == 1 then
		models[#models+1] = { id = "nighty/signals/typ-n_schirm_brugg_main.mdl", transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, x_offset, y_offset, z_offset, 1 }}
	else 
		models[#models+1] = { id = "nighty/signals/typ-n_schirm_rappi_main.mdl", transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, x_offset, y_offset, z_offset, 1 }}
	end

	if nighty_type_n_worker_platform == 1 then
		models[#models+1] = { id = "nighty/signals/typ-n_worker_platform.mdl", transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, x_offset, y_offset, z_offset, 1 }}
	end
	
	-- Mast
	if nighty_type_n_mast == 0 then
		models[#models+1] = { id = "nighty/signals/typ-n_mast_basic.mdl", transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, x_offset, y_offset, z_offset, 1 }}

		if nighty_type_n_mast_addon == 1 then
			models[#models+1] = { id = "nighty/signals/typ-n_mast_addon_leiter.mdl", transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, x_offset, y_offset, z_offset, 1 }}
		elseif nighty_type_n_mast_addon and (nighty_type_n_mast_addon == 2) then
			models[#models+1] = { id = "nighty/signals/typ-n_mast_addon_korb.mdl", transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, x_offset, y_offset, z_offset, 1 }}
		elseif nighty_type_n_mast_addon and (nighty_type_n_mast_addon == 3) then
			models[#models+1] = { id = "nighty/signals/typ-n_mast_addon_korb.mdl", transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, x_offset, y_offset, z_offset, 1 }}
			models[#models+1] = { id = "nighty/signals/typ-n_mast_addon_leiter.mdl", transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, x_offset, y_offset, z_offset, 1 }}
		end

	elseif nighty_type_n_mast == 1 then
		models[#models+1] = { id = "nighty/signals/typ-n_mast_versetzt_mirrored.mdl", transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, x_offset, y_offset, z_offset, 1 }}

		if nighty_type_n_mast_addon == 1 then
			models[#models+1] = { id = "nighty/signals/typ-n_mast_addon_leiter_versetzt.mdl", transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, x_offset, y_offset + 1.25, z_offset, 1 }}
		elseif nighty_type_n_mast_addon == 2 then
			models[#models+1] = { id = "nighty/signals/typ-n_mast_addon_korb.mdl", transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, x_offset, y_offset, z_offset, 1 }}
		elseif nighty_type_n_mast_addon == 3 then
			models[#models+1] = { id = "nighty/signals/typ-n_mast_addon_korb.mdl", transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, x_offset, y_offset, z_offset, 1 }}
			models[#models+1] = { id = "nighty/signals/typ-n_mast_addon_leiter_versetzt.mdl", transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, x_offset, y_offset + 1.25, z_offset, 1 }}
		end
	else
		models[#models+1] = { id = "nighty/signals/typ-n_mast_versetzt.mdl", transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, x_offset, y_offset, z_offset, 1 }}

		if nighty_type_n_mast_addon == 1 then
			models[#models+1] = { id = "nighty/signals/typ-n_mast_addon_leiter_versetzt.mdl", transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, x_offset, y_offset, z_offset, 1 }}
		elseif nighty_type_n_mast_addon == 2 then
			models[#models+1] = { id = "nighty/signals/typ-n_mast_addon_korb.mdl", transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, x_offset, y_offset, z_offset, 1 }}
		elseif nighty_type_n_mast_addon == 3 then
			models[#models+1] = { id = "nighty/signals/typ-n_mast_addon_korb.mdl", transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, x_offset, y_offset, z_offset, 1 }}
			models[#models+1] = { id = "nighty/signals/typ-n_mast_addon_leiter_versetzt.mdl", transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, x_offset, y_offset, z_offset, 1 }}
		end
	end

	return models
end


function builder.evaluatePreSginal(params)
	local isGreen = (params.signal_state and params.signal_state == 1)
	local displayWarning = (params.nighty_type_n_shorten_block and params.nighty_type_n_shorten_block == 1)
	local signalType = "normal"
	local maxSpeed = 160
	local indicatedSpeed = maxSpeed + 1
	local canIndicateSpeed = true
	local indicatesNextSpeed = false
	local nextStopSignalDistance = 10 -- choosen high TODO: (dirty code)

	if params.nighty_type_n_signaltype then
		local evalSignal = params
		if params.nighty_type_n_signaltype == 1 then
			if params.following_signal then
				evalSignal = params.following_signal
			else
				isGreen = false
			end
		end

		if (evalSignal.signal_speed) then
			indicatedSpeed = evalSignal.signal_speed
		end
	
		if evalSignal.paramsOverride then
			if evalSignal.paramsOverride.warning then
				displayWarning = evalSignal.paramsOverride.warning == 1
			end
	
			if evalSignal.paramsOverride.speed then
				indicatedSpeed = evalSignal.paramsOverride.speed
			end
		end

		if evalSignal.following_signal then
			if evalSignal.following_signal.signal_state == 0 then
				nextStopSignalDistance = 1
			elseif evalSignal.following_signal.following_signal and (evalSignal.following_signal.following_signal.signal_state == 0) then
				nextStopSignalDistance = 2
			end
	
			if evalSignal.following_signal.signal_speed then
				local followingSignalSpeed = evalSignal.following_signal.signal_speed
				if (math.floor(followingSignalSpeed/10)*10 < math.floor(indicatedSpeed/10)*10) then
					indicatesNextSpeed = true
					indicatedSpeed = math.floor(followingSignalSpeed/10)*10
				elseif evalSignal.previous_speed and (((math.floor(evalSignal.previous_speed/10)*10 < math.floor(indicatedSpeed/10)*10) or (math.floor(evalSignal.previous_speed/10)*10 > math.floor(indicatedSpeed/10)*10))) then
					canIndicateSpeed = true
					indicatesNextSpeed = false
					indicatedSpeed = math.floor((indicatedSpeed+1)/10)*10
				else
					canIndicateSpeed = false
				end
	
				if (evalSignal.previous_speed and (math.floor((evalSignal.previous_speed)/10) == math.floor((indicatedSpeed)/10))) or not evalSignal.showSpeedChange then
					indicatesNextSpeed = false
					canIndicateSpeed = false
				end
			end
		else
			indicatesNextSpeed = false
		end
		
	
		if nextStopSignalDistance == 1 then
			canIndicateSpeed = false
		elseif displayWarning and nextStopSignalDistance == 2 then
			canIndicateSpeed = false
		end
	end

	-- Evaluate future signals


	return {
		isGreen = isGreen,
		displayWarning = displayWarning,
		indicatedSpeed = indicatedSpeed,
		nextStopSignalDistance = nextStopSignalDistance,
		canIndicateSpeed = canIndicateSpeed,
		indicatesNextSpeed = indicatesNextSpeed,
	}
end

function builder.evaluateMainSignal(params)
	local displayWarning = (params.nighty_type_n_shorten_block and params.nighty_type_n_shorten_block == 1)
	local displayOccupied = (params.nighty_type_n_occupied and params.nighty_type_n_occupied == 1)
	local indicatedSpeed = 200
	local canIndicateSpeed = true
	local indicatesNextSpeed = false


	if (params.signal_speed) then
		indicatedSpeed = params.signal_speed
	end

	if params.paramsOverride then
		if params.paramsOverride.occupied then
			displayOccupied = params.paramsOverride.occupied == 1
		end

		if params.paramsOverride.warning then
			displayWarning = params.paramsOverride.warning == 1
		end

		if params.paramsOverride.speed then
			indicatedSpeed = params.paramsOverride.speed
			params.showSpeedChange = true
		end
	end

	-- Evaluate future signals
	local nextStopSignalDistance = 10 -- choosen high TODO: (dirty code)

	if params.following_signal then
		if params.following_signal.signal_state == 0 then
			nextStopSignalDistance = 1
		elseif params.following_signal.following_signal and (params.following_signal.following_signal.signal_state == 0) then
			nextStopSignalDistance = 2
		end

		if params.following_signal.signal_speed then
			local followingSignalSpeed = params.following_signal.signal_speed
			if (math.floor(followingSignalSpeed/10)*10 < math.floor(indicatedSpeed/10)*10) then
				indicatesNextSpeed = true
				indicatedSpeed = math.floor((followingSignalSpeed+1)/10)*10
				if params.previous_speed and (math.floor(params.previous_speed/10)*10 < math.floor(followingSignalSpeed/10)*10)then
					indicatesNextSpeed = false
					canIndicateSpeed = false
				end
			elseif params.previous_speed and (((math.floor(params.previous_speed/10)*10 < math.floor(indicatedSpeed/10)*10) or (math.floor(params.previous_speed/10)*10 > math.floor(indicatedSpeed/10)*10))) then
				canIndicateSpeed = true
				indicatesNextSpeed = false
				indicatedSpeed = math.floor((indicatedSpeed+1)/10)*10
			else
				canIndicateSpeed = false
			end

			if (params.previous_speed and ((math.floor((params.previous_speed)/10) == math.floor((indicatedSpeed+1)/10))) or not params.showSpeedChange) then
				indicatesNextSpeed = false
				canIndicateSpeed = false
			end
		end
	else
		indicatesNextSpeed = false
	end
	
	if nextStopSignalDistance == 1 then
		canIndicateSpeed = false
	elseif displayWarning and nextStopSignalDistance == 2 then
		canIndicateSpeed = false
		displayWarning = true
	else
		displayWarning = false
		displayOccupied = false
	end

	return {
		isGreen = (params.signal_state and params.signal_state == 1),
		indicatedSpeed = indicatedSpeed,
		canIndicateSpeed = canIndicateSpeed,
		indicatesNextSpeed = indicatesNextSpeed,
		displayOccupied = displayOccupied,
		displayWarning = displayWarning,
		nextStopSignalDistance = nextStopSignalDistance,
	}
end

function builder.addExitSign(hasIdSign, mirrorEntryExit, x_offset, y_offset, z_offset)
	local models = {}
	if hasIdSign then
		utils.addToTable(models, builder.addIdSign(x_offset, y_offset, z_offset + .35))
	end
	if mirrorEntryExit then
		models[#models+1] = { id = "nighty/signals/typ-n_station_entry.mdl", transf = { -1, 0, 0, 0, -0, -1, 0, 0, 0, 0, 1, 0, x_offset-.12, y_offset, z_offset-.3, 1 }}
	end
	models[#models+1] = { id = "nighty/signals/typ-n_station_exit.mdl", transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, x_offset, y_offset, z_offset, 1 }}
	models[#models+1] = { id = "nighty/signals/typ-n_station_sign_clamp.mdl", transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, x_offset, y_offset, z_offset, 1 }}

	return models
end

function builder.addEntrySign(hasIdSign, mirrorEntryExit, x_offset, y_offset, z_offset)
	local models = {}
	if hasIdSign then
		utils.addToTable(models, builder.addIdSign(x_offset, y_offset, z_offset + .35))
	end
	if mirrorEntryExit then
		models[#models+1] = { id = "nighty/signals/typ-n_station_exit.mdl", transf = { -1, 0, 0, 0, -0, -1, 0, 0, 0, 0, 1, 0, x_offset-.12, y_offset, z_offset-.3, 1 }}
	end
	models[#models+1] = { id = "nighty/signals/typ-n_station_entry.mdl", transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, x_offset, y_offset, z_offset, 1 }}
	models[#models+1] = { id = "nighty/signals/typ-n_station_sign_clamp.mdl", transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, x_offset, y_offset, z_offset, 1 }}

	return models
end

function builder.addPreStationSign(hasIdSign, x_offset, y_offset, z_offset)
	local models = {}
	if hasIdSign then
		utils.addToTable(models, builder.addIdSign(x_offset, y_offset, z_offset + .7))
	end
	models[#models+1] = { id = "nighty/signals/typ-n-station_pre.mdl", transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, x_offset, y_offset, z_offset, 1 }}

	return models
end

function builder.addShuntingSign(hasIdSign, hasSpeedIndicator, x_offset, y_offset, z_offset)
	local models = {}
	if hasIdSign then
		utils.addToTable(models, builder.addIdSign(x_offset, y_offset, z_offset))
	end

	if hasSpeedIndicator then
		models[#models+1] = { id = "nighty/signals/typ-n-sign_shunting.mdl", transf = {1, 0, 0, 0, 0, -1, -8.7422776573476e-08, 0, 0, 8.7422776573476e-08, -1, 0, x_offset-0.15, y_offset, z_offset + 9.25, 1, }}
	else
		models[#models+1] = { id = "nighty/signals/typ-n-sign_shunting.mdl", transf = {1, 0, 0, 0, 0, -1, -8.7422776573476e-08, 0, 0, 8.7422776573476e-08, -1, 0, x_offset, y_offset, z_offset + 9.95, 1, }}
	end

	return models
end

function builder.addEntryNExitSign(hasIdSign, x_offset, y_offset, z_offset)
	local models = {}
	if hasIdSign then
		utils.addToTable(models, builder.addIdSign(x_offset, y_offset, z_offset + .7))
	end
	models[#models+1] = { id = "nighty/signals/typ-n_station_entry_n_exit.mdl", transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, x_offset, y_offset, z_offset, 1 }}

	return models
end

function builder.addIdSign(x_offset, y_offset, z_offset)
	local models = {}
	models[#models+1] = { id = "nighty/signals/typ-n_base_sign_nuber.mdl", transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, x_offset, y_offset, z_offset, 1 }}
	return models
end


function builder.buildGroundFaces(tunnelHelperOn)
	local groundFaces = {}
	local models = {}
	groundFaces[#groundFaces + 1] = {  
		face = { { -1, -1, 0 }, { 1, -1, 0 }, { 1, 1, 0 } },
		modes = {
			{
				type = "FILL",               
				key = "industry_floor.lua"
			}
		},
		loop = true,
		alignmentOffsetMode = "OBJECT",
		alignmentDirMode = "OBJECT",
		alignmentOffset = { -2.0, -1.0 },
	}

	if tunnelHelperOn then
		models[#models+1] = { id = "tunnel_helper_arrow.mdl", transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, z_offset, 1 }}

		groundFaces[#groundFaces + 1] = {
			face = { { -50, -50, 0 }, { 50, -50, 0 }, { 50, 50, 0 }, { -50, 50, 0 } },
			modes = {
				{
					type = "FILL",               
					key = "hole.lua"
				}
			},
			loop = true,
			alignmentOffsetMode = "OBJECT",
			alignmentDirMode = "OBJECT",
			alignmentOffset = { -2.0, -1.0 },
		} 
	end

	return groundFaces, models
end

return builder
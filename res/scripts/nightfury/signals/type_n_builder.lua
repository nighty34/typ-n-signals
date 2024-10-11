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

return builder
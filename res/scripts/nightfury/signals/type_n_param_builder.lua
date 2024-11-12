local utils = require "nightfury/signals/type_n_utils"
local param_builder = {}


local function util_params()
    return {
        {
			key = "better_signals_x_offset",
			name = _("better_signals_x_offset"),
			uiType = "SLIDER",
			defaultIndex = 5,
			values = { _("-5"), _("-4"), _("-3"), _("-2"), _("-1"), _("0"), _("1"), _("2"), _("3"), _("4"), _("5") },
		},
		{
			key = "better_signals_y_offset",
			name = _("better_signals_y_offset"),
			values = {_("better_signals_snap_left"), _("better_signals_snap_middle"), _("better_signals_snap_right")},
			defaultIndex = 0,
			tooltip = _("better_signals_x_offset_tooltip"),
		},
		{
			key = "better_signals_tunnel_helper",
			name = _("better_signals_tunnel_helper"),
			uiType = "CHECKBOX",
			values = {"0", "1"},
			tooltip = _("better_signals_tunnel_helper_tooltip"),
		},
    }
end

local function main_signs_params()
    return {
        {
			key = "nighty_type_n_signaltype",
			name = _("nighty_type_n_signaltype"),
			uiType = "ICON_BUTTON",
			values = {"ui/parameters/nighty/none.tga","ui/parameters/nighty/typ-n_station_entry.tga", "ui/parameters/nighty/typ-n_station_exit.tga", "ui/parameters/nighty/typ-n_station_entry_exit.tga", "ui/parameters/nighty/typ-n_station_pre.tga", "ui/parameters/nighty/typ-n_sign_shunting.tga"},
			defaultIndex = 0,
			tooltip = _("nighty_type_n_signaltype_tooltip"),
		},
		{
			key = "nighty_type_n_mirror_station_sign",
			name = _("nighty_type_n_mirror_station_sign"),
			uiType= "CHECKBOX",
			values = {"0", "1"},
			defaultIndex = 1,
		},
		{
			key = "nighty_type_n_build_form",
			name = _("nighty_type_n_build_form"),
			values = {_("nighty_type_n_build_form_old"), _("nighty_type_n_build_form_brugg"), _("nighty_type_n_build_form_rappi")},
			defaultIndex = 2,
			tooltip = _("nighty_type_n_build_form_tooltip"),
		},
		{
			key = "nighty_type_n_speedindicator",
			name = _("nighty_type_n_speedindicator"),
			uiType = "ICON_BUTTON",
			values = {"ui/parameters/nighty/none.tga", "ui/parameters/nighty/typ-n_speed_indicator.tga"},
			defaultIndex = 0,
			tooltip = _("nighty_type_n_speedindicator_tooltip"),
		},
		{
			key = "nighty_type_n_shorten_block",
			name = _("nighty_type_n_shorten_block"),
			uiType = "ICON_BUTTON",
			values = {"ui/parameters/nighty/none.tga", "ui/parameters/nighty/typ-n_speed_warning.tga"},
			defaultIndex = 0,
			tooltip = _("nighty_type_n_shorten_block_tooltip"),
		},
		{
			key = "nighty_type_n_occupied",
			name = _("nighty_type_n_occupied"),
			uiType = "ICON_BUTTON",
			values = {"ui/parameters/nighty/none.tga", "ui/parameters/nighty/typ-n_speed_occupied.tga"},
			defaultIndex = 0,
			tooltip = _("nighty_type_n_occupied_tooltip"),
		},
		{
			key = "nighty_type_n_worker_platform",
			name = _("nighty_type_n_worker_platform"),
			uiType= "CHECKBOX",
			values = {"0", "1"},
			defaultIndex = 0,
		},
    }
end

local function pre_signs_params()
	return {
		{
			key = "nighty_type_n_signaltype",
			name = _("nighty_type_n_signaltype_pre"),
			uiType = "ICON_BUTTON",
			values = {"ui/parameters/nighty/none.tga", "ui/parameters/nighty/typ-n_sign_repeat.tga","ui/parameters/nighty/typ-n_station_pre.tga",},
			defaultIndex = 0,
			tooltip = _("nighty_type_n_signaltype_pre_tooltip"),
		},
		{
			key = "nighty_type_n_build_form",
			name = _("nighty_type_n_build_form"),
			values = {_("nighty_type_n_build_form_old"), _("nighty_type_n_build_form_brugg"), _("nighty_type_n_build_form_rappi")},
			defaultIndex = 2,
			tooltip = _("nighty_type_n_build_form_tooltip"),
		},
		{
			key = "nighty_type_n_speedindicator",
			name = _("nighty_type_n_speedindicator"),
			uiType = "ICON_BUTTON",
			values = {"ui/parameters/nighty/none.tga","ui/parameters/nighty/typ-n_speed_indicator.tga"},
			defaultIndex = 0,
			tooltip = _("nighty_type_n_speedindicator_tooltip"),
		},
		{
			key = "nighty_type_n_worker_platform",
			name = _("nighty_type_n_worker_platform"),
			uiType= "CHECKBOX",
			values = {"0", "1"},
			defaultIndex = 0,
		},
	}
end

function param_builder.main_bridge_params(f1rnen_active)
    local params = {}
    local signalingbridge_params = {
        {
			key = "nighty_type_n_korb",
			name = _("nighty_type_n_korb"),
			values = {_("nighty_type_n_korb_basic"), _("nighty_type_n_korb_with_cage"), _("nighty_type_n_korb_f1rnen")},
			defaultIndex = 0,
			tooltip = _("nighty_type_n_build_mast_tooltip"),
		},
		{
			key = "nighty_type_n_id_sign",
			name = _("nighty_type_n_id_sign"),
			uiType = "ICON_BUTTON",
			values = {"ui/parameters/nighty/none.tga", "ui/parameters/nighty/typ-n_sign_id_up.tga", "ui/parameters/nighty/typ-n_sign_id_down.tga"},
			defaultIndex = 0,
			tooltip = _("nighty_type_n_id_sign_tooltip"),
		},
    }
    local signalingbridge_params_f1rnen = {
        {
			key = "nighty_type_n_korb",
			name = _("nighty_type_n_korb"),
			values = {_("nighty_type_n_korb_basic"), _("nighty_type_n_korb_with_cage"), _("nighty_type_n_korb_f1rnen")},
			defaultIndex = 0,
			tooltip = _("nighty_type_n_build_mast_tooltip"),
		},
		{
			key = "nighty_type_n_id_sign",
			name = _("nighty_type_n_id_sign"),
			uiType = "ICON_BUTTON",
			values = {"ui/parameters/nighty/none.tga", "ui/parameters/nighty/typ-n_sign_id_up.tga", "ui/parameters/nighty/typ-n_sign_id_down.tga"},
			defaultIndex = 0,
			tooltip = _("nighty_type_n_id_sign_tooltip"),
		},
    }



    utils.addToTable(params, util_params())
	if f1rnen_active then
    	utils.addToTable(params, signalingbridge_params_f1rnen)
	else
		utils.addToTable(params, signalingbridge_params)
	end
    utils.addToTable(params, main_signs_params())

    return params
end

function param_builder.pre_bridge_params(f1rnen_active)
	local params = {}
    local signalingbridge_params = {
        {
			key = "nighty_type_n_korb",
			name = _("nighty_type_n_korb"),
			values = {_("nighty_type_n_korb_basic"), _("nighty_type_n_korb_with_cage"), _("nighty_type_n_korb_f1rnen")},
			defaultIndex = 0,
			tooltip = _("nighty_type_n_build_mast_tooltip"),
		},
		{
			key = "nighty_type_n_id_sign",
			name = _("nighty_type_n_id_sign"),
			uiType = "ICON_BUTTON",
			values = {"ui/parameters/nighty/none.tga", "ui/parameters/nighty/typ-n_sign_id_up.tga", "ui/parameters/nighty/typ-n_sign_id_down.tga"},
			defaultIndex = 0,
			tooltip = _("nighty_type_n_id_sign_tooltip"),
		},
    }
    local signalingbridge_params_f1rnen = {
        {
			key = "nighty_type_n_korb",
			name = _("nighty_type_n_korb"),
			values = {_("nighty_type_n_korb_basic"), _("nighty_type_n_korb_with_cage")},
			defaultIndex = 0,
			tooltip = _("nighty_type_n_build_mast_tooltip"),
		},
		{
			key = "nighty_type_n_id_sign",
			name = _("nighty_type_n_id_sign"),
			uiType = "ICON_BUTTON",
			values = {"ui/parameters/nighty/none.tga", "ui/parameters/nighty/typ-n_sign_id_up.tga", "ui/parameters/nighty/typ-n_sign_id_down.tga"},
			defaultIndex = 0,
			tooltip = _("nighty_type_n_id_sign_tooltip"),
		},
    }



    utils.addToTable(params, util_params())
	if f1rnen_active then
    	utils.addToTable(params, signalingbridge_params_f1rnen)
	else
		utils.addToTable(params, signalingbridge_params)
	end
    utils.addToTable(params, pre_signs_params())

    return params
end

function param_builder.main_signal_params()
    local params = {}
    local signal_params = {
		{
			key = "nighty_type_n_mast",
			name = _("nighty_type_n_mast"),
			values = {_("nighty_type_n_mast_basic"), _("nighty_type_n_mast_offset_left"), _("nighty_type_n_mast_offset_right")},
			defaultIndex = 0,
			tooltip = _("nighty_type_n_build_mast_tooltip"),
		},
		{
			key = "nighty_type_n_mast_addon",
			name = _("nighty_type_n_mast_addon"),
			values = {_("nighty_type_n_mast_addon_none"), _("nighty_type_n_mast_addon_leiter"), _("nighty_type_n_mast_addon_korb"), _("nighty_type_n_mast_addon_korb_leiter")},
			defaultIndex = 0,
			tooltip = _("nighty_type_n_mast_addon_tooltip"),
		},
		{
			key = "nighty_type_n_id_sign",
			name = _("nighty_type_n_id_sign"),
			uiType = "ICON_BUTTON",
			values = {"ui/parameters/nighty/none.tga", "ui/parameters/nighty/typ-n_sign_id.tga"},
			defaultIndex = 0,
			tooltip = _("nighty_type_n_id_sign_tooltip"),
		},
    }

    utils.addToTable(params, util_params())
    utils.addToTable(params, signal_params)
    utils.addToTable(params, main_signs_params())

    return params
end

function param_builder.pre_signal_params()
    local params = {}
    local signal_params = {
		{
			key = "nighty_type_n_mast",
			name = _("nighty_type_n_mast"),
			values = {_("nighty_type_n_mast_basic"), _("nighty_type_n_mast_offset_left"), _("nighty_type_n_mast_offset_right")},
			defaultIndex = 0,
			tooltip = _("nighty_type_n_build_mast_tooltip"),
		},
		{
			key = "nighty_type_n_mast_addon",
			name = _("nighty_type_n_mast_addon"),
			values = {_("nighty_type_n_mast_addon_none"), _("nighty_type_n_mast_addon_leiter"), _("nighty_type_n_mast_addon_korb"), _("nighty_type_n_mast_addon_korb_leiter")},
			defaultIndex = 0,
			tooltip = _("nighty_type_n_mast_addon_tooltip"),
		},
		{
			key = "nighty_type_n_id_sign",
			name = _("nighty_type_n_id_sign"),
			uiType = "ICON_BUTTON",
			values = {"ui/parameters/nighty/none.tga", "ui/parameters/nighty/typ-n_sign_id.tga"},
			defaultIndex = 0,
			tooltip = _("nighty_type_n_id_sign_tooltip"),
		},
    }

    utils.addToTable(params, util_params())
    utils.addToTable(params, signal_params)
    utils.addToTable(params, pre_signs_params())

    return params
end


return param_builder
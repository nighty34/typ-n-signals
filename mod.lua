local config = require "nightfury/signals/config"
local signals = require "nightfury/signals/main"

function data()
	return {
		info = {
			name = _("sbb_type_n_name"),
			description = _("sbb_type_n_name_desc"),
			minorVersion = 0,
			modid = "nightfury34_type-n_signale_1",
			severityAdd = "NONE",
			severityRemove = "WARNING",
			authors = {
				{
					name = "nightfury34",
					role = "CREATOR",
				},
			},
			params = {},
			dependencies = { "nightfury34_better_signals_1" },
			requiredMods = {
				{
					modId = "nightfury34_better_signals_1",
				},
			},
		},
		runFn = function(settings, modParams)
			config.load()
		end,
	}
end
local config = require "nightfury/signals/config"
local signals = require "nightfury/signals/main"

function data()
	return {
		info = {
			description = _("sbb_type_n_name_desc"),
			name = _("sbb_type_n_name"),
			params = {
			},
			modid = "nightfury34_type-n_signale_1",
			authors = {
				{
					name = "nightfury34",
					role = "CREATOR",
				},
			},
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
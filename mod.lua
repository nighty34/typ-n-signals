local config = require "nightfury/signals/config"

function data()
	return {
		info = {
			description = _("sbb_type_n_name_desc"),
			name = _("sbb_type_n_name"),
			params = {},
			modid = "nightfury34_type-n_signale_1",
			authors = {
				{
					name = "nightfury34",
					role = "CREATOR",
				},
			},
		},
		runFn = function(settings)
			config.load()
		end,
	}
end
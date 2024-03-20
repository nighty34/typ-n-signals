local config = require "nightfury/signals/config"

function data()
	return {
		info = {
			description = _("SBB Type N Signale"),
			name = _("SBB Type N Signale"),
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
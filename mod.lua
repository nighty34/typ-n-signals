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
		postRunFn = function ()
			if pcall(function() api.res.constructionRep.get(api.res.constructionRep.find('asset/f1rnen_l_signalbruecke.con')) end) then
				print("Type-N Signals: Found F1rnen Mod")
				api.res.constructionRep.setVisible(api.res.constructionRep.find('asset/misc/nighty_type_n_hauptsignal_bruecke.con'),false)
				api.res.constructionRep.setVisible(api.res.constructionRep.find('asset/misc/nighty_type_n_vorsignal_bruecke.con'),false)
			else
				print("Type-N Signals: Couldn't find F1rnen Mod")
				api.res.constructionRep.setVisible(api.res.constructionRep.find('asset/misc/nighty_type_n_hauptsignal_bruecke_f1rnen.con'),false)
				api.res.constructionRep.setVisible(api.res.constructionRep.find('asset/misc/nighty_type_n_vorsignal_bruecke_f1rnen.con'),false)
			end
		end
	}
end
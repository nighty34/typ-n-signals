local function pRequire(modulName)
    local state, result_or_error = pcall(require, modulName)
    if state then
        return result_or_error
    else
        return nil, result_or_error
    end
end

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
			local signals = pRequire('nightfury/signals/main')

			if not signals then
				return
			end
		
			signals.signals['nighty_type_n_hauptsignal'] = {
				type = "main",
				isAnimated = false,
			}

			signals.signals['nighty_type_n_vorsignal'] = {
				type = "hybrid",
				isAnimated = false,
				preSignalTriggerKey = "nighty_type_n_signaltype",
				preSignalTriggerValue = 1,
			}

			signals.signals['nighty_type_n_hauptsignal_bruecke'] = {
				type = "main",
				isAnimated = false
			}

			signals.signals['nighty_type_n_hauptsignal_bruecke_f1rnen'] = {
				type = "main",
				isAnimated = false
			}

			signals.signals['nighty_type_n_vorsignal_bruecke'] = {
				type = "hybrid",
				isAnimated = false,
				preSignalTriggerKey = "nighty_type_n_signaltype",
				preSignalTriggerValue = 1,
			}

			signals.signals['nighty_type_n_vorsignal_bruecke_f1rnen'] = {
				type = "hybrid",
				isAnimated = false,
				preSignalTriggerKey = "nighty_type_n_signaltype",
				preSignalTriggerValue = 1,
			}
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
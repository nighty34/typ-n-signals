local signals = require "nightfury/signals/main"

local config = {}

config.signals = {
	nighty_type_n_hauptsignal = {
		type = "main",
		isAnimated = false,
	},
	nighty_type_n_vorsignal = {
		type = "main",
		isAnimated = false,
	},
	nighty_type_n_hauptsignal_bruecke = {
		type = "main",
		isAnimated = false
	},
	nighty_type_n_hauptsignal_bruecke_f1rnen = {
		type = "main",
		isAnimated = false
	},
	nighty_type_n_vorsignal_bruecke = {
		type = "main",
		isAnimated = false
	},
	nighty_type_n_vorsignal_bruecke_f1rnen = {
		type = "main",
		isAnimated = false
	},
}


function config.load()
	local existingSignals = {}
	
	for i,signal in pairs(signals.signals) do
		existingSignals[i] = signal
	end
	
	signals.signals = {}
	
	for i,signal in pairs(config.signals) do
		signals.signals[i] = signal
	end
	
	for i,signal in pairs(existingSignals) do
		signals.signals[i] = signal
	end
end

return config
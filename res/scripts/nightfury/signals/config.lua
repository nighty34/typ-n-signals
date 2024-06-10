local signals = require "nightfury/signals/main"

local config = {}

config.signals = {
	nighty_type_n_hauptsignal = {
		type = "main",
		allowWaypoints = true,
	},
	nighty_type_n_vorsignal = {
		type = "main",
		allowWaypoints = true,
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
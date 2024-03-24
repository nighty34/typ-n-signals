local signals = require "nightfury/signals/main"

local signalTable = {}

function signalTable.createSignal(signal, construct)
	print("Adding Signal: " .. signal)
	print("Adding Con: " .. construct)
	signals.signalObjects["signal" .. signal] = "" .. construct
	
	for i, v in pairs(signals.signalObjects) do
		print("Helper: " .. i .. " - " .. v)
	end
end


return signalTable
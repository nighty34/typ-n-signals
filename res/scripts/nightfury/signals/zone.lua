-- @author Vacuum-Tube
local utils = require "nightfury/signals/utils"

local zoneutil = require "mission.zone"

local z = {}

function z.setMarker(id,pos)
	game.interface.setMarker(id, {
		pos={2132,2222,10},
		type = n,
		entity = n,
	})
end

function z.setZone(id,polygon, color)
	game.interface.setZone(id, {
		polygon=polygon,
		draw=true,
		drawColor = color,
	})
end

function z.setZoneCircle(id,pos,radius, color)
	assert(pos or debugPrint("Assert Pos"))
	assert(radius<math.huge or debugPrint("Assert Radius: "..radius))
	local num = 32
	if radius<20 then
		num = 8
	elseif radius<40 then
		num = 12
	elseif radius<80 then
		num = 18
	elseif radius<200 then
		num = 24
	end
	z.setZone(id, zoneutil.makeCircleZone(pos, radius, num), color)
end

function z.remZone(id)
	game.interface.setZone(id)
end

function z.markEntity(id, entityId, radius, color)
	local signalTransf = utils.getComponentProtected(entityId, 58)
	if signalTransf then
		z.setZoneCircle(id, {signalTransf.fatInstances[1].transf[13], signalTransf.fatInstances[1].transf[14]}, radius, color)
	else
		print("Couldn't get entity geometry, no marker placed")
	end
end

return z
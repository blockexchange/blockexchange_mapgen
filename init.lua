local MP = minetest.get_modpath("blockexchange_mapgen")


-- global namespace
blockexchange_mapgen = {
}

if not blockexchange.is_online then
	error("http api is not configured for the blockexchange mod!")
end

dofile(MP.."/util.lua")
dofile(MP.."/nodes.lua")
dofile(MP.."/mapgen.lua")
dofile(MP.."/schema.lua")

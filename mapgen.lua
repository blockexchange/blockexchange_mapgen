
local placeholder_cid = minetest.get_content_id("blockexchange_mapgen:placeholder")
local load_placeholder_cid = minetest.get_content_id("blockexchange_mapgen:load_placeholder")
local air_cid = minetest.get_content_id("air")

local function populate_mapblock(mapblock_pos)
    local pos1, pos2 = blockexchange_mapgen.get_mapblock_bounds_from_mapblock(mapblock_pos)

    local manip = minetest.get_voxel_manip()
	local e1, e2 = manip:read_from_map(pos1, pos2)
	local area = VoxelArea:new({MinEdge=e1, MaxEdge=e2})

	local node_data = manip:get_data()

    -- set placeholders
    local j = 1
    for z=pos1.z,pos2.z do
        for y=pos1.y,pos2.y do
            for x=pos1.x,pos2.x do
                local i = area:index(x,y,z)
                if node_data[i] == air_cid then
                    node_data[i] = placeholder_cid
                end
                j = j + 1
            end
        end
    end

    -- set load placeholders
    local i = area:indexp(pos1)
    node_data[i] = load_placeholder_cid

	manip:set_data(node_data)
	manip:write_to_map()
end



minetest.register_on_generated(function(minp, maxp)
    local min_mapblock = blockexchange_mapgen.get_mapblock(minp)
    local max_mapblock = blockexchange_mapgen.get_mapblock(maxp)

	for z=min_mapblock.z,max_mapblock.z do
    for x=min_mapblock.x,max_mapblock.x do
    for y=min_mapblock.y,max_mapblock.y do
        local mapblock_pos = { x=x, y=y, z=z }
        populate_mapblock(mapblock_pos)
    end --y
    end --x
    end --z
end)
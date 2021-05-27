


function blockexchange_mapgen.get_mapblock_center(pos)
	local mapblock = vector.floor( vector.divide(pos, 16))
	return vector.add(vector.multiply(mapblock, 16), 7.5)
end

function blockexchange_mapgen.get_mapblock(pos)
	return vector.floor( vector.divide(pos, 16))
end

-- Note: not the "real-world" chunkpos with offsets but a "virtual" one to get schemaparts in bundles
function blockexchange_mapgen.get_chunkpos_from_mapblock(mapblock_pos)
	return vector.floor( vector.divide(mapblock_pos, 5))
end

function blockexchange_mapgen.get_mapblock_bounds_from_mapblock(block_pos)
	local min = vector.multiply(block_pos, 16)
	local max = vector.add(min, 15)
	return min, max
end

function blockexchange_mapgen.get_mapblock_bounds(pos)
	local mapblock = vector.floor( vector.divide(pos, 16))
	return blockexchange_mapgen.get_mapblock_bounds_from_mapblock(mapblock)
end

local air_cid = minetest.get_content_id("air")

function blockexchange_mapgen.fill_mapblock_with_air(mapblock_pos)
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
                    node_data[i] = air_cid
                end
                j = j + 1
            end
        end
    end

	manip:set_data(node_data)
	manip:write_to_map()
end



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


minetest.register_on_generated(function(minp)
    local min_mapblock = blockexchange_mapgen.get_mapblock(minp)
    local chunk_pos = blockexchange_mapgen.get_chunkpos_from_mapblock(min_mapblock)
    blockexchange_mapgen.load_chunk(chunk_pos)
end)
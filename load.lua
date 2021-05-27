
local origin = {x=0, y=0, z=0}

local function download_chunk(chunk_pos)
    local mapblock_pos_min = vector.multiply(chunk_pos, 5)
    local mapblock_pos_max = vector.add(mapblock_pos_min, 5) -- 5x5x5 mapblocks
    local pos = vector.multiply(mapblock_pos_min, 16)

    if not blockexchange_mapgen.schema then
        minetest.after(1, download_chunk, chunk_pos)
        return
    end

    if pos.x > origin.x + blockexchange_mapgen.schema.size_x_plus or
        pos.y > origin.y + blockexchange_mapgen.schema.size_y_plus or
        pos.z > origin.z + blockexchange_mapgen.schema.size_z_plus or
        pos.x < origin.x - blockexchange_mapgen.schema.size_x_minus or
        pos.y < origin.y - blockexchange_mapgen.schema.size_y_minus or
        pos.z < origin.z - blockexchange_mapgen.schema.size_z_minus then
            -- out of schema area, skip
            return
    end

    minetest.log("action", "[bx_mapgen] downloading chunk @ " .. minetest.pos_to_string(pos))
    blockexchange.api.get_schemapart_chunk(blockexchange_mapgen.schema.id, pos):next(function(schemaparts)
        minetest.log("action", "[bx_mapgen] got schemaparts: " .. #schemaparts)

        local processed_mapblock_hashes = {}
        for _, schemapart in ipairs(schemaparts) do
            local pos1 = blockexchange.place_schemapart(schemapart, origin)
            local hash = minetest.hash_node_position(blockexchange_mapgen.get_mapblock(pos1))
            processed_mapblock_hashes[hash] = true
        end

        -- fill remaining mapblocks with air (no subsequent downloads)
        for z=mapblock_pos_min.z,mapblock_pos_max.z do
        for x=mapblock_pos_min.x,mapblock_pos_max.x do
        for y=mapblock_pos_min.y,mapblock_pos_max.y do
            local mapblock_pos = { x=x, y=y, z=z }
            local hash = minetest.hash_node_position(mapblock_pos)
            if not processed_mapblock_hashes[hash] then
                blockexchange_mapgen.fill_mapblock_with_air(mapblock_pos)
            end
        end --y
        end --x
        end --z
    end)
end


function blockexchange_mapgen.load_mapblock(mapblock_pos)
    local chunk_pos = blockexchange_mapgen.get_chunkpos_from_mapblock(mapblock_pos)
    local hash = minetest.hash_node_position(chunk_pos)
    if not blockexchange_mapgen.in_transit_chunks[hash] then
        download_chunk(chunk_pos)
        blockexchange_mapgen.in_transit_chunks[hash] = true
    end
end


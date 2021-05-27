
local origin = {x=0, y=0, z=0}

local function download_chunk(chunk_pos)
    local mapblock_pos_min = vector.multiply(chunk_pos, 5)
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

        for _, schemapart in ipairs(schemaparts) do
            blockexchange.place_schemapart(schemapart, origin)
        end
    end)
end

local in_transit_chunks = {}

function blockexchange_mapgen.load_mapblock(mapblock_pos)
    local chunk_pos = blockexchange_mapgen.get_chunkpos_from_mapblock(mapblock_pos)
    local hash = minetest.hash_node_position(chunk_pos)
    if not in_transit_chunks[hash] then
        download_chunk(chunk_pos)
        in_transit_chunks[hash] = true
    end
end


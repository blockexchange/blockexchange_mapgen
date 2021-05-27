

--local placeholder_cid = minetest.get_content_id("blockexchange_mapgen:placeholder")

minetest.register_on_generated(function(minp, maxp)
    local min_mapblock = blockexchange_mapgen.get_mapblock(minp)
    local max_mapblock = blockexchange_mapgen.get_mapblock(maxp)


	for z=min_mapblock.z,max_mapblock.z do
    for x=min_mapblock.x,max_mapblock.x do
    for y=min_mapblock.y,max_mapblock.y do
        local mapblock_pos = { x=x, y=y, z=z }
        -- TODO
        print(dump(mapblock_pos))
    end --y
    end --x
    end --z
end)
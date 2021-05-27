minetest.register_lbm({
    label = "blockexchange mapgen trigger",
    name = "blockexchange_mapgen:load_placeholder",
    nodenames = {"blockexchange_mapgen:load_placeholder"},
    run_at_every_load = true,
    action = function(pos)
        local mapblock_pos = blockexchange_mapgen.get_mapblock(pos)
        blockexchange_mapgen.load_mapblock(mapblock_pos)
    end
})
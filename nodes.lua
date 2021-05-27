local nodedef = {
	drawtype = "airlike",
	paramtype = "light",
	pointable = false,
	sunlight_propagates = true,
    climbable = true,
	drop = "",
	groups = {
        unbreakable = 1,
        not_in_creative_inventory = 1
    },
}

minetest.register_node("blockexchange_mapgen:placeholder", nodedef)
minetest.register_node("blockexchange_mapgen:load_placeholder", nodedef)
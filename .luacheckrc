globals = {
	"blockexchange_mapgen",
}

read_globals = {
	"blockexchange",

	-- Stdlib
	string = {fields = {"split", "trim"}},
	table = {fields = {"copy", "getn"}},

	-- Minetest
	"minetest",
	"vector", "ItemStack",
	"dump", "dump2",
	"VoxelArea",

	-- opt deps
	"areas", "monitoring",

	-- testing
	"mineunit", "sourcefile", "assert", "describe", "it"
}

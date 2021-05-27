
-- TODO: configurable
local username = "BuckarooBanzai"
local schemaname = "default_landscape"

minetest.after(0, function()
    blockexchange.api.get_schema_by_name(username, schemaname, true):next(function(schema)
        blockexchange_mapgen.schema = schema
        minetest.log("action", "[bx_mapgen] loaded schema with id " .. schema.id)
    end):catch(function(e)
        minetest.after(0, function() error(e) end)
    end)
end)
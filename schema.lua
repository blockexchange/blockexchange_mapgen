
local username = "BuckarooBanzai"
local schemaname = "default_landscape"
local schema

minetest.after(0, function()
    blockexchange.api.get_schema_by_name(username, schemaname, true):next(function(s)
        schema = s
        minetest.log("action", "[bx_mapgen] loaded schema with id " .. schema.id)
    end):catch(function(e)
        minetest.after(0, function() error(e) end)
    end)
end)
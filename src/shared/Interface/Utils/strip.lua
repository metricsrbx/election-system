--[[
	A utility for stripping custom properties
	from a table, used within components.

	https://github.com/mvyasu/PluginEssentials
--]]

return function(List: {[any]: any}, Exclude: {string}): {[any]: any}
	local Export = table.clone(List)

	for _, Value in Exclude do
		Export[Value] = nil
	end

	return Export
end
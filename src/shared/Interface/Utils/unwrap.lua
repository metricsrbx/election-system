--[[
	A utility for unwrapping states.

	https://github.com/mvyasu/PluginEssentials
--]]

return function(Value: any, Use: boolean?): any
	if typeof(Value) == 'table' and Value.type == 'State' then
		return Value:get(Use)
	end

	return Value
end
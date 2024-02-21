local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Util = ReplicatedStorage.Interface.Utils

local unwrap = require(Util.unwrap)
local types = require(Util.types)

type GetSelectedStateProperties = {
	Value: types.Value<any>?,
	Options: types.CanBeState<{any}>?,
	OnSelected: ((selectedOption: any)->nil)?,
}

return function(props: GetSelectedStateProperties): ()->any
	return function()
		local currentValue = unwrap(props.Value)
		local availableOptions = unwrap(props.Options) or {}
		if currentValue==nil or not table.find(availableOptions, currentValue) then
			local _,nextItem = next(availableOptions)
			if nextItem~=nil then
				if props.OnSelected then
					props.OnSelected(nextItem)
				end
				return nextItem
			end
		end
		return currentValue
	end
end
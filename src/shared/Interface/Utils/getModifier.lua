--# selene: allow(unused_variable, shadowing)
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage.Packages
local Util = ReplicatedStorage.Interface.Utils

local Fusion = require(Packages.Fusion)

local Computed = Fusion.Computed

local unwrap = require(Util.unwrap)
local types = require(Util.types)

type modifierInput = {
	Enabled: types.CanBeState<boolean>?,
	Hovering: types.CanBeState<boolean>?,
	Selected: types.CanBeState<boolean>?,
	Pressed: types.CanBeState<boolean>?,
	Otherwise: types.CanBeState<Enum.StudioStyleGuideModifier>?,
}

return function(modifierInput: modifierInput): types.Computed<any>
	local isEnabled = modifierInput.Enabled
	local isHovering = modifierInput.Hovering
	local isSelected = modifierInput.Selected
	local isPressed = modifierInput.Pressed

	return Computed(function()
		local isDisabled = not unwrap(isEnabled)
		local isHovering = unwrap(isHovering)
		local isSelected = unwrap(isSelected)
		local isPressed = unwrap(isPressed)
		if isDisabled then
			return Enum.StudioStyleGuideModifier.Disabled
		elseif isSelected then
			return Enum.StudioStyleGuideModifier.Selected
		elseif isPressed then
			return Enum.StudioStyleGuideModifier.Pressed
		elseif isHovering then
			return Enum.StudioStyleGuideModifier.Hover
		end
		return unwrap(modifierInput.Otherwise) or Enum.StudioStyleGuideModifier.Default
	end)
end

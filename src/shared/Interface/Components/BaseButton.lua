local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage.Packages
local Util = ReplicatedStorage.Interface.Utils

local Fusion = require(Packages.Fusion)

local stripProps = require(Util.strip)
local unwrap = require(Util.unwrap)
local constants = require(Util.constants)
local types = require(Util.types)

local New = Fusion.New
local Value = Fusion.Value
local OnEvent = Fusion.OnEvent
local Hydrate = Fusion.Hydrate

local COMPONENT_ONLY_PROPERTIES = {
	"TextColorStyle",
	"BackgroundColorStyle",
	"BorderColorStyle",
	"Activated",
	"Enabled",
}

export type BaseButtonProperties = {
	Activated: (() -> nil)?,
	Enabled: (boolean | types.StateObject<boolean>)?,
	TextColorStyle: Color3,
	BackgroundColorStyle: Color3,
	[any]: any,
}

return function(props: BaseButtonProperties): TextButton
	local isEnabled = Value(true)
	local isHovering = Value(false)
	local isPressed = Value(false)

	local newBaseButton = New("TextButton")({
		Name = "BaseButton",
		Size = UDim2.fromScale(1, 1),
		Text = "Button",
		Font = Enum.Font.SourceSans,
		TextSize = constants.TextSize,
		TextColor3 = props.TextColorStyle,
		BackgroundColor3 = props.BackgroundColorStyle,

		[OnEvent("InputBegan")] = function(inputObject)
			if not unwrap(isEnabled) then
				return
			elseif inputObject.UserInputType == Enum.UserInputType.MouseMovement then
				isHovering:set(true)
			elseif inputObject.UserInputType == Enum.UserInputType.MouseButton1 then
				isPressed:set(true)
			end
		end,
		[OnEvent("InputEnded")] = function(inputObject)
			if not unwrap(isEnabled) then
				return
			elseif inputObject.UserInputType == Enum.UserInputType.MouseMovement then
				isHovering:set(false)
			elseif inputObject.UserInputType == Enum.UserInputType.MouseButton1 then
				isPressed:set(false)
			end
		end,
		[OnEvent("Activated")] = (function()
			if props.Activated then
				return function()
					if unwrap(isEnabled, false) then
						props.Activated()
					end
				end
			end
		end)(),
	})

	local hydrateProps = stripProps(props, COMPONENT_ONLY_PROPERTIES)
	return Hydrate(newBaseButton)(hydrateProps)
end

--# selene: allow(unused_variable, shadowing)
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage.Packages
local Util = ReplicatedStorage.Interface.Utils

local Fusion = require(Packages.Fusion)

local stripProps = require(Util.strip)
local unwrap = require(Util.unwrap)
local constants = require(Util.constants)
local types = require(Util.types)

local Computed = Fusion.Computed
local Hydrate = Fusion.Hydrate
local New = Fusion.New

local COMPONENT_ONLY_PROPERTIES = {
	"Enabled",
	"TextColorStyle",
	"TextColor3",
	"TextSize",
}

type LabelProperties = {
	Enabled: (boolean | types.StateObject<boolean>)?,
	[any]: any,
}

return function(props: LabelProperties): TextLabel
	local textSize = props.TextSize or constants.TextSize

	local newLabel = New("TextLabel")({
		Name = "Label",
		Position = UDim2.fromScale(0, 0),
		AnchorPoint = Vector2.new(0, 0),
		Text = "Label",
		TextSize = textSize,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		BorderMode = Enum.BorderMode.Inset,
		Font = Enum.Font.GothamMedium,
		TextColor3 = props.TextColor3 or Color3.fromRGB(255, 255, 255),

		Size = Computed(function()
			return UDim2.new(1, 0, 0, unwrap(textSize))
		end),
	})

	local hydrateProps = stripProps(props, COMPONENT_ONLY_PROPERTIES)
	return Hydrate(newLabel)(hydrateProps)
end

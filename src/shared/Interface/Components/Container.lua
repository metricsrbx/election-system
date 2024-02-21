local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage.Packages
local Util = ReplicatedStorage.Interface.Utils

local Fusion = require(Packages.Fusion)

local stripProps = require(Util.strip)

local New = Fusion.New
local Hydrate = Fusion.Hydrate

local COMPONENT_ONLY_PROPERTIES = {}

export type Properties = {
	[any]: any,
}

return function(props: Properties): Frame
	return Hydrate(New("Frame")({
		Name = "Container",

		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromScale(1, 1),

		BackgroundTransparency = 1,
		BorderSizePixel = 0,
	}))(stripProps(props, COMPONENT_ONLY_PROPERTIES))
end

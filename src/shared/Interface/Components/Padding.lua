local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage.Packages

local Util = ReplicatedStorage.Interface.Util
local stripProps = require(Util.strip)

local Fusion = require(Packages.Fusion)
local Hydrate = Fusion.Hydrate

local COMPONENT_ONLY_PROPERTIES = {
	"Padding",
}

export type Properties = {
	Padding: number?,
	[any]: any,
}

return function(props: Properties): Instance
	local UDimValue: UDim = UDim.new(0, props.Padding or 10)

	local Padding = Fusion.New("UIPadding")({
		Name = "Padding",

		PaddingTop = UDimValue,
		PaddingLeft = UDimValue,
		PaddingRight = UDimValue,
		PaddingBottom = UDimValue,
	}) :: UIPadding

	local hydrateProps = stripProps(props, COMPONENT_ONLY_PROPERTIES)
	return Hydrate(Padding)(hydrateProps) :: UIPadding
end

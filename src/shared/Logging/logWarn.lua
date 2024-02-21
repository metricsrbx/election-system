--!strict

--[[
    Forked from elttob/fusion

	Utility function to log a sync-specific warning.
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Shared = ReplicatedStorage.syncSession :: Folder
local messages = require(Shared.Logging.messages)

local function logWarn(messageID, ...)
	local formatString: string

	if messages[messageID] ~= nil then
		formatString = messages[messageID]
	else
		messageID = "unknownMessage"
		formatString = messages[messageID]
	end

	warn(string.format("[Elections] " .. formatString .. "\n(ID: " .. messageID .. ")", ...))
end

return logWarn

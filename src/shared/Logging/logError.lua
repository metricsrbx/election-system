--!strict

--[[
    Forked from elttob/fusion

	Utility function to log a specific error.
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Shared = ReplicatedStorage.syncSession :: Folder

local Types = require(Shared.Types)
local messages = require(Shared.Logging.messages)

local function logError(messageID: string, errObj: Types.Error?, ...)
	local formatString: string

	if messages[messageID] ~= nil then
		formatString = messages[messageID]
	else
		messageID = "unknownMessage"
		formatString = messages[messageID]
	end

	local errorString
	if errObj == nil then
		errorString = string.format("[Elections] " .. formatString .. "\n(ID: " .. messageID .. ")", ...)
	else
		formatString = formatString:gsub("ERROR_MESSAGE", errObj.message)
		errorString = string.format(
			"[Elections] " .. formatString .. "\n(ID: " .. messageID .. ")\n---- Stack trace ----\n" .. errObj.trace,
			...
		)
	end

	error(errorString:gsub("\n", "\n    "), 0)
end

return logError

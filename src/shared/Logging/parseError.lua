--!strict

--[[
    Forked from elttob/fusion

	An xpcall() error handler to collect and parse useful information about
	errors, such as clean messages and stack traces.
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Shared = ReplicatedStorage.syncSession :: Folder
local Types = require(Shared.Types)

local function parseError(err: string): Types.Error
	return {
		type = "Error",
		raw = err,
		message = err:gsub("^.+:%d+:%s*", ""),
		trace = debug.traceback(nil, 2),
	}
end

return parseError

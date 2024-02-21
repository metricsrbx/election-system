local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Configuration = require(ReplicatedStorage.Configuration)
local Packages = require(ReplicatedStorage.Packages)

local Promise = require(Packages.Promise)

local Logging = require(ReplicatedStorage.Logging)
local logError = require(Logging.logError)
local logWarn = require(Logging.logWarn)

local Data = require(ServerScriptService.Modules.Data)

local Vote = {}

function FormatVote(player: Player, party: string)
	if not table.find(Configuration.Parties, party) then
		return logWarn("invalidParty", party)
	end

	return HttpService:JSONEncode({
		["user"] = player.Name,
		["vote"] = party,
	})
end

function Vote:Process(player: Player, party: string)
	local Get = Promise.new(function(Resolve, Reject)
		local Status, Response = pcall(HttpService.PostAsync, HttpService, {
			Url = Configuration.URL,
			data = FormatVote(player, party),
		})

		if Status then
			Resolve(Response, Status)
		else
			Reject(Response)
		end
	end)

	Get:andThen(function(_)
		-- Handle ProfileService
	end)

	Get:catch(function(Error)
		logError("registrationFailed", party, Error)
	end)
end

return Vote

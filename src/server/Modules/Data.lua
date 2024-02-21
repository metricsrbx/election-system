
local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")
local ProfileService = require(ServerScriptService.Modules.ProfileService)

local ProfileTemplate = {
    Voters = {
      -- [Voter] = {Vote: string, Voted: Time}
    }
  }

local DataModule = {}

local ProfileStore = ProfileService.GetProfileStore(
    "PlayerData",
    ProfileTemplate
)

local Profiles = {} -- [player] = profile

function DataModule:_HasPlayerVoted()
    
end

function DataModule:AddVote(player, Vote: string)
    local function myYieldingFunction(waitTime, text)
        wait(waitTime)
        return text
    end
    
    local myFunction = Promise.promisify(myYieldingFunction)
    myFunction(1.2, "Hello world!"):andThen(print):catch(function()
        warn("Oh no... goodbye world.")
    end)
end


local function DoSomethingWithALoadedProfile(player, profile)
    
end

local function PlayerAdded(player)
    local profile = ProfileStore:LoadProfileAsync("Player_" .. player.UserId)
    if profile ~= nil then
        profile:AddUserId(player.UserId) -- GDPR compliance
        profile:Reconcile() -- Fill in missing variables from ProfileTemplate (optional)
        profile:ListenToRelease(function()
            Profiles[player] = nil
            -- The profile could've been loaded on another Roblox server:
            player:Kick()
        end)
        if player:IsDescendantOf(Players) == true then
            Profiles[player] = profile
            -- A profile has been successfully loaded:
            DoSomethingWithALoadedProfile(player, profile)
        else
            -- Player left before the profile loaded:
            profile:Release()
        end
    else
        -- The profile couldn't be loaded possibly due to other
        --   Roblox servers trying to load this profile at the same time:
        player:Kick() 
    end
end

for _, player in ipairs(Players:GetPlayers()) do
    task.spawn(PlayerAdded, player)
end

----- Connections -----

Players.PlayerAdded:Connect(PlayerAdded)

Players.PlayerRemoving:Connect(function(player)
    local profile = Profiles[player]
    if profile ~= nil then
        profile:Release()
    end
end)

return DataModule
local Players = game:GetService("Players")
local Player = Players.LocalPlayer

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local warn = require(Logging.logWarn)

local Remotes = Shared.Remotes
local SubmitVote = Remotes.SubmitVote


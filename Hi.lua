-- // Load External Script from Your GitHub
loadstring(game:HttpGet("https://raw.githubusercontent.com/Sebastian080613/StealABrainrotScriptCookieHub/main/hi.lua"))()

-- // Load Orion Library
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()

local Window = OrionLib:MakeWindow({
    Name = "Player Highlighter",
    HidePremium = false,
    SaveConfig = false
})

local Tab = Window:MakeTab({
    Name = "ESP",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- // ESP Logic
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local espEnabled = false
local highlights = {}

local function highlightPlayer(plr)
    if plr.Character and not highlights[plr] then
        local h = Instance.new("Highlight")
        h.Parent = plr.Character
        h.FillColor = Color3.new(0, 1, 0) -- green
        h.OutlineColor = Color3.new(1, 1, 1)
        highlights[plr] = h
    end
end

local function removeHighlight(plr)
    if highlights[plr] then
        highlights[plr]:Destroy()
        highlights[plr] = nil
    end
end

Players.PlayerAdded:Connect(function(plr)
    plr.CharacterAdded:Connect(function()
        if espEnabled then
            highlightPlayer(plr)
        end
    end)
end)

Players.PlayerRemoving:Connect(function(plr)
    removeHighlight(plr)
end)

RunService.Heartbeat:Connect(function()
    if not espEnabled then return end

    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= Players.LocalPlayer then
            highlightPlayer(plr)
        end
    end
end)

Tab:AddToggle({
    Name = "Enable ESP",
    Default = false,
    Callback = function(value)
        espEnabled = value
        if not value then
            for _, highlight in pairs(highlights) do
                highlight:Destroy()
            end
            highlights = {}
        end
    end
})

OrionLib:Init()

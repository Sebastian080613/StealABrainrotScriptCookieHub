--// Orion Library Loader
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()

local Window = OrionLib:MakeWindow({
    Name = "Steal A Brainrot | Control Panel",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "SAB_Control"
})

--=====================================================
-- VARIABLES
--=====================================================

local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

local autoTP = false
local autoCollect = false
local autoLock = false

--=====================================================
-- TAB: MAIN
--=====================================================

local MainTab = Window:MakeTab({
    Name = "Main",
    Icon = "rbxassetid://4483345998"
})

MainTab:AddParagraph("Welcome!", "Tools designed specifically for Steal a Brainrot.")

MainTab:AddButton({
    Name = "Teleport to Base",
    Callback = function()
        if workspace.Bases:FindFirstChild(player.Name) then
            hrp.CFrame = workspace.Bases[player.Name].Primary.CFrame + Vector3.new(0,3,0)
        end
    end
})

MainTab:AddButton({
    Name = "Teleport to Dealer",
    Callback = function()
        local dealer = workspace:FindFirstChild("BrainrotDealer")
        if dealer then
            hrp.CFrame = dealer.PrimaryPart.CFrame + Vector3.new(0,4,0)
        end
    end
})

MainTab:AddToggle({
    Name = "Auto Collect Brainrots",
    Default = false,
    Callback = function(v)
        autoCollect = v
        while autoCollect do task.wait(0.25)
            for _, brainrot in pairs(workspace:GetDescendants()) do
                if brainrot.Name == "BrainrotItem" and brainrot:IsA("BasePart") then
                    hrp.CFrame = brainrot.CFrame + Vector3.new(0,3,0)
                end
            end
        end
    end
})

--=====================================================
-- TAB: BASE CONTROL
--=====================================================

local BaseTab = Window:MakeTab({
    Name = "Base Tools",
    Icon = "rbxassetid://4483345998"
})

BaseTab:AddToggle({
    Name = "Auto Lock Base",
    Default = false,
    Callback = function(v)
        autoLock = v
        while autoLock do task.wait(1)
            local root = workspace.Bases:FindFirstChild(player.Name)
            if root and root.LockFolder and root.LockFolder.LockValue then
                if root.LockFolder.LockValue.Value == false then
                    root.LockFolder.LockValue.Value = true
                end
            end
        end
    end
})

BaseTab:AddButton({
    Name = "Force Lock Now",
    Callback = function()
        local root = workspace.Bases:FindFirstChild(player.Name)
        if root and root.LockFolder and root.LockFolder.LockValue then
            root.LockFolder.LockValue.Value = true
        end
    end
})

BaseTab:AddButton({
    Name = "Force Unlock Now",
    Callback = function()
        local root = workspace.Bases:FindFirstChild(player.Name)
        if root and root.LockFolder and root.LockFolder.LockValue then
            root.LockFolder.LockValue.Value = false
        end
    end
})

--=====================================================
-- TAB: BRAINROT LOCATOR
--=====================================================

local LocatorTab = Window:MakeTab({
    Name = "Brainrot Finder",
    Icon = "rbxassetid://4483345998"
})

LocatorTab:AddToggle({
    Name = "Auto TP to Nearest Brainrot",
    Default = false,
    Callback = function(v)
        autoTP = v
        while autoTP do task.wait(0.25)
            local nearest, dist = nil, 9999
            for _, brainrot in ipairs(workspace:GetDescendants()) do
                if brainrot.Name == "BrainrotItem" and brainrot:IsA("BasePart") then
                    local d = (hrp.Position - brainrot.Position).Magnitude
                    if d < dist then
                        nearest = brainrot
                        dist = d
                    end
                end
            end
            if nearest then
                hrp.CFrame = nearest.CFrame + Vector3.new(0,3,0)
            end
        end
    end
})

LocatorTab:AddButton({
    Name = "Highlight All Brainrots",
    Callback = function()
        for _, brainrot in ipairs(workspace:GetDescendants()) do
            if brainrot.Name == "BrainrotItem" and brainrot:IsA("BasePart") then
                local highlight = Instance.new("Highlight", brainrot)
                highlight.FillTransparency = 1
                highlight.OutlineColor = Color3.new(1, 0, 0)
            end
        end
    end
})

--=====================================================
-- TAB: PLAYER
--=====================================================

local PlayerTab = Window:MakeTab({
    Name = "Player",
    Icon = "rbxassetid://4483345998"
})

PlayerTab:AddSlider({
    Name = "WalkSpeed",
    Min = 16,
    Max = 200,
    Default = 16,
    Callback = function(v)
        char:WaitForChild("Humanoid").WalkSpeed = v
    end
})

PlayerTab:AddSlider({
    Name = "JumpPower",
    Min = 50,
    Max = 400,
    Default = 50,
    Callback = function(v)
        char:WaitForChild("Humanoid").JumpPower = v
    end
})

--=====================================================
-- INIT
--=====================================================

OrionLib:Init()

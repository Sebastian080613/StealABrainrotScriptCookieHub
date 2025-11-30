-- CookieHub | Rayfield Version
-- Fully self-contained for Delta and any game

repeat task.wait() until game:IsLoaded()

local Rayfield = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Sebastian080613/Rayfield/main/source"))()

local Window = Rayfield:CreateWindow({
    Name = "CookieHub | Steal A Brainrot Tools",
    LoadingTitle = "Loading CookieHub...",
    LoadingSubtitle = "by Sebastian080613",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "CookieHubConfig",
        FileName = "Config"
    },
    Discord = {
        Enabled = false
    }
})

print("CookieHub Loaded | Rayfield active")

-- MAIN TAB
local MainTab = Window:CreateTab("Main")

MainTab:CreateParagraph({
    Title = "Welcome!",
    Content = "CookieHub is now loaded and ready!"
})

MainTab:CreateButton({
    Name = "Print Hello",
    Callback = function()
        print("Hello from CookieHub (Rayfield)!")
    end
})

MainTab:CreateToggle({
    Name = "Example Toggle",
    CurrentValue = false,
    Flag = "ExampleToggle",
    Callback = function(value)
        print("Toggle is now:", value)
    end
})

-- PLAYER TAB
local PlayerTab = Window:CreateTab("Player")

PlayerTab:CreateSlider({
    Name = "WalkSpeed",
    CurrentValue = 16,
    Min = 16,
    Max = 100,
    Flag = "WalkSpeedSlider",
    Callback = function(value)
        local player = game.Players.LocalPlayer
        local char = player.Character or player.CharacterAdded:Wait()
        if char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = value
        end
    end
})

PlayerTab:CreateSlider({
    Name = "JumpPower",
    CurrentValue = 50,
    Min = 50,
    Max = 200,
    Flag = "JumpPowerSlider",
    Callback = function(value)
        local player = game.Players.LocalPlayer
        local char = player.Character or player.CharacterAdded:Wait()
        if char:FindFirstChild("Humanoid") then
            char.Humanoid.JumpPower = value
        end
    end
})

-- CUSTOM TAB
local CustomTab = Window:CreateTab("Custom Features")

CustomTab:CreateButton({
    Name = "Add Feature Example",
    Callback = function()
        print("Custom feature logic goes here!")
    end
})

print("Rayfield CookieHub loaded successfully")

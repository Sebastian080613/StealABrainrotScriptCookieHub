local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "99 nights script",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "Cookie Hub",
   LoadingSubtitle = "by Cookie Hub",
   ShowText = "Rayfield", -- for mobile users to unhide rayfield, change if you'd like
   Theme = "Default", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   ToggleUIKeybind = "K", -- The keybind to toggle the UI visibility (string like "K" or Enum.KeyCode)

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "Cookie Hub"
   },

   Discord = {
      Enabled = false, -- Prompt the user to join your Discord server if their executor supports it
      Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the discord every time they load it up
   },

   KeySystem = true, -- Set this to true to use our key system
   KeySettings = {
      Title = "Untitled",
      Subtitle = "Cookie Hub | Key System",
      Note = "The key is hello", -- Use this to tell the user how to get a key
      FileName = "CookieHubKey", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"Hello"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   }
})

local MainTab = Window:CreateTab("🏠 Main", nil) -- Title, Image
local MainSection = MainTab:CreateSection("Main")

Rayfield:Notify({
   Title = "You executed the script",
   Content = "Executing the script",
   Duration = 4,
   Image = nil,
})

local Toggle = MainTab:CreateToggle({
   Name = "Fly No Clip",
   CurrentValue = false,
   Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
   -- The function that takes place when the toggle is pressed
   -- The variable (Value) is a boolean on whether the toggle is true or false
         local flying = false
local noclipConn
local flyConn
local speed = 2 -- Increase for faster fly

local function startFly()
    local player = game.Players.LocalPlayer
    local char = player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end

    local hrp = char.HumanoidRootPart
    flying = true

    -- NoClip
    noclipConn = game:GetService("RunService").Stepped:Connect(function()
        for _, v in pairs(char:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = false
            end
        end
    end)

    -- Fly movement
    flyConn = game:GetService("RunService").RenderStepped:Connect(function()
        local move = Vector3.zero
        local cam = workspace.CurrentCamera

        if game.UserInputService:IsKeyDown(Enum.KeyCode.W) then
            move += cam.CFrame.LookVector
        end
        if game.UserInputService:IsKeyDown(Enum.KeyCode.S) then
            move -= cam.CFrame.LookVector
        end
        if game.UserInputService:IsKeyDown(Enum.KeyCode.A) then
            move -= cam.CFrame.RightVector
        end
        if game.UserInputService:IsKeyDown(Enum.KeyCode.D) then
            move += cam.CFrame.RightVector
        end

        hrp.Velocity = move * speed * 50
    end)
end

local function stopFly()
    flying = false

    if noclipConn then noclipConn:Disconnect() end
    if flyConn then flyConn:Disconnect() end

    local char = game.Players.LocalPlayer.Character
    if char then
        -- Restore collisions
        for _, v in pairs(char:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = true
            end
        end
        -- Stop motion
        if char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.Velocity = Vector3.zero
        end
    end
end

   end,
})

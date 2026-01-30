-- PunBinHub v1.0 by Punn - Auto Farm Blox Fruits (2026)
-- Load Rayfield UI Library
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "PunBinHub v1.0",
   LoadingTitle = "PunBinHub - Blox Fruits",
   LoadingSubtitle = "by Punn | Auto Farm",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "PunBinHub",
      FileName = "PunConfig"
   },
   KeySystem = false
})

local MainTab = Window:CreateTab("🤖 Auto Farm", 4483362458)
local CombatTab = Window:CreateTab("⚔️ Combat", 4483362459)
local TeleportTab = Window:CreateTab("📍 Teleport", 4483362460)
local PlayerTab = Window:CreateTab("👤 Player", 4483362461)

-- === AUTO FARM ===
local FarmSection = MainTab:CreateSection("Farm Features")

MainTab:CreateToggle({
   Name = "Auto Farm Fruit",
   CurrentValue = false,
   Callback = function(Value)
      _G.AutoFruit = Value
      spawn(function()
         while task.wait(0.1) do
            if _G.AutoFruit then
               for i, v in pairs(workspace:GetChildren()) do
                  if string.find(v.Name, "Fruit") and v:FindFirstChild("Handle") then
                     v.Handle.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                  end
               end
            end
         end
      end)
   end
})

MainTab:CreateToggle({
   Name = "Auto Chest Farm",
   CurrentValue = false,
   Callback = function(Value)
      _G.AutoChest = Value
      spawn(function()
         while task.wait(0.5) do
            if _G.AutoChest then
               for i, v in pairs(workspace:GetDescendants()) do
                  if v:IsA("TouchTransmitter") and v.Parent.Name:lower():find("chest") then
                     firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Parent, 0)
                     task.wait(0.1)
                     firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Parent, 1)
                  end
               end
            end
         end
      end)
   end
})

MainTab:CreateToggle({
   Name = "Auto Mastery Farm",
   CurrentValue = false,
   Callback = function(Value)
      _G.MasteryFarm = Value
      spawn(function()
         while task.wait() do
            if _G.MasteryFarm and game.Players.LocalPlayer.Character then
               for i, v in pairs(workspace.Enemies:GetChildren()) do
                  if v.Name ~= "Sea Beast" and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                     pcall(function()
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0)
                     end)
                  end
               end
            end
         end
      end)
   end
})

-- Auto Stats
local StatsDropdown
MainTab:CreateToggle({
   Name = "Auto Stats",
   CurrentValue = false,
   Callback = function(Value)
      _G.AutoStats = Value
      spawn(function()
         while task.wait(0.1) do
            if _G.AutoStats then
               pcall(function()
                  game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", StatsDropdown.CurrentOption[1], 1)
               end)
            end
         end
      end)
   end
})

StatsDropdown = MainTab:CreateDropdown({
   Name = "Select Stat",
   Options = {"Melee", "Defense", "Blade", "Gun", "DevilFruit"},
   CurrentOption = "Melee",
   Callback = function(Option)
      -- Option handled in toggle above
   end
})

-- === COMBAT ===
local CombatSection = CombatTab:CreateSection("Combat")

CombatTab:CreateToggle({
   Name = "Fast Attack",
   CurrentValue = false,
   Callback = function(Value)
      _G.FastAttack = Value
      spawn(function()
         while task.wait() do
            if _G.FastAttack then
               pcall(function()
                  game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Melee")
               end)
            end
         end
      end)
   end
})

-- === TELEPORT ===
local Islands = {
   ["Middle Town"] = CFrame.new(-690, 15, 4422),
   ["Green Zone"] = CFrame.new(-2448, 73, -3211),
   ["Sky"] = CFrame.new(-7894, 5546, 900),
   ["Prison"] = CFrame.new(4875, 142, 710),
   ["Colosseum"] = CFrame.new(-1426, 7, 343),
   ["Mansion"] = CFrame.new(-385, 25, 162),
   ["Fountain City"] = CFrame.new(-4323, 181, -4340)
}

local TpDropdown
TeleportTab:CreateDropdown({
   Name = "Select Island",
   Options = {"Middle Town", "Green Zone", "Sky", "Prison", "Colosseum", "Mansion", "Fountain City"},
   CurrentOption = {"Middle Town"},
   Flag = "TpDropdown",
   Callback = function(Option)
      game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Islands[Option]
   end
})

-- === PLAYER ===
local PlayerSection = PlayerTab:CreateSection("Player Mods")

PlayerTab:CreateToggle({
   Name = "Fly",
   CurrentValue = false,
   Callback = function(Value)
      _G.Fly = Value
      local speed = 200
      local bg = Instance.new("BodyVelocity")
      bg.MaxForce = Vector3.new(4000,4000,4000)
      bg.Velocity = Vector3.new(0,0.1,0)
      bg.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
      local bg2 = Instance.new("BodyAngularVelocity")
      bg2.AngularVelocity = Vector3.new(0,0.1,0)
      bg2.MaxTorque = Vector3.new(4000,4000,4000)
      bg2.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
      spawn(function()
         while task.wait() do
            if _G.Fly then
               local cam = workspace.CurrentCamera.CFrame
               if game.Players.LocalPlayer.Character.HumanoidRootPart then
                  if KEYS["w"] then
                     bg.Velocity = cam.LookVector * speed
                  elseif KEYS["s"] then
                     bg.Velocity = -cam.LookVector * speed
                  elseif KEYS["a"] then
                     bg.Velocity = -cam.RightVector * speed
                  elseif KEYS["d"] then
                     bg.Velocity = cam.RightVector * speed
                  else
                     bg.Velocity = Vector3.new(0,0.1,0)
                  end
                  bg2.AngularVelocity = Vector3.new(0,0.1,0)
               end
            else
               bg:Destroy()
               bg2:Destroy()
            end
         end
      end)
   end
})

PlayerTab:CreateToggle({
   Name = "Infinite Jump",
   CurrentValue = false,
   Callback = function(Value)
      _G.InfiniteJump = Value
      spawn(function()
         while task.wait() do
            if _G.InfiniteJump then
               game:GetService("UserInputService").JumpRequest:Connect(function()
                  game.Players.LocalPlayer.Character.Humanoid:ChangeState("Jumping")
               end)
            end
         end
      end)
   end
})

Rayfield:Notify({
   Title = "PunBinHub Loaded!",
   Content = "Auto Farm ready! Enjoy farming :)",
   Duration = 5,
   Image = 4483362458
})

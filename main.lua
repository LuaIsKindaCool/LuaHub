local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()


local Window = Fluent:CreateWindow({
    Title = "LuaHub",
    SubTitle = "by LuaIsKindaCool",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl -- Used when theres no MinimizeKeybind
})

local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "" }),
}

getgenv().MurderEsp = false
getgenv().SheriffEsp = false

local function SearchForMurderer()
    for _,EnemyPlayer in pairs(Players:GetPlayers()) do 
        if EnemyPlayer == Player then continue end
        if EnemyPlayer.Character and EnemyPlayer.Character.Humanoid and EnemyPlayer.Character.Humanoid.Health > 0 then
            if EnemyPlayer.Backpack:FindFirstChild("Knife") or EnemyPlayer.Character:FindFirstChild("Knife") then
                return EnemyPlayer
            end
        end
    end
end

Tabs.Main:AddButton({
    Title = "Locate Murderer",
    Description = "Highlight the murderer",
    Callback = function()
        if SearchForMurderer() then
            Instance.new("Highlight", SearchForMurderer().Character)
        end
    end
})
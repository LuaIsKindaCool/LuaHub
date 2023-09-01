local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()

local MurdererHighlight

local Window = Fluent:CreateWindow({
    Title = "LuaHub",
    SubTitle = "by LuaIsKindaCool",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = false,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "" }),
}

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

local MurderEspToggle = Tabs.Main:AddToggle({
    "Murderer ESP",
    {
        Title = "Murderer ESP",
        Default = getgenv().MurderEsp
    }
})

MurderEspToggle:OnChanged(function(NewVal)
    if NewVal then
        if SearchForMurderer() then
            MurdererHighlight = Instance.new("Highlight", SearchForMurderer().Character)
        end
    else 
        if MurdererHighlight then
            MurdererHighlight:Destroy()
        end
    end
end)
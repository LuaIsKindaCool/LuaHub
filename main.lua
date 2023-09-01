local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()

local MurdererHighlight
local SheriffHighlight

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

local function SearchFor(Weapon)
    for _,EnemyPlayer in pairs(Players:GetPlayers()) do 
        if EnemyPlayer == Player then continue end
        if EnemyPlayer.Character and EnemyPlayer.Character.Humanoid and EnemyPlayer.Character.Humanoid.Health > 0 then
            if EnemyPlayer.Backpack:FindFirstChild(Weapon) or EnemyPlayer.Character:FindFirstChild(Weapon) then
                return EnemyPlayer
            end
        end
    end
end

local MurderEspToggle = Tabs.Main:AddToggle( "Murderer ESP" , { Title = "Murderer ESP" , Default = false })

MurderEspToggle:OnChanged(function(NewVal)
    if NewVal then
        if SearchFor("Knife") then
            MurdererHighlight = Instance.new("Highlight", SearchFor("Knife").Character)
        end
    else 
        if MurdererHighlight then
            MurdererHighlight:Destroy()
        end
    end
end)

local SheriffEspToggle = Tabs.Main:AddToggle( "Sheriff ESP" , { Title = "Sheriff ESP" , Default = false })

SheriffEspToggle:OnChanged(function(NewVal)
    if NewVal then
        if SearchFor("Gun") then
            SheriffHighlight = Instance.new("Highlight")
            SheriffHighlight.FillColor = Color3.fromRGB(0,0,255)
            SheriffHighlight.Parent = SearchFor("Gun").Character
        end
    else 
        if SheriffHighlight then
            SheriffHighlight:Destroy()
        end
    end
end)
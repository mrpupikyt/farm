if game.PlaceId == 1537690962 then

local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/jensonhirst/Orion/main/source"))()

local snowflakes = false

local coconut = false

local drink = false

local wait = 0.5

local Window = OrionLib:MakeWindow({
    Name = "MrPup FarmRes",
    HidePremium = false,
    IntroEnabled = false,
    SaveConfig = true,
    ConfigFolder = "FarmRes"
})

local Tab = Window:MakeTab({
    Name = "Farm",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

Tab:AddToggle({
	Name = "Snowflakes",
	Default = false,
	Callback = function(Value)
		snowflakes = Value
	end    
})

Tab:AddToggle({
	Name = "Coconut",
	Default = false,
	Callback = function(Value)
		coconut = Value
	end    
})

Tab:AddToggle({
	Name = "Tropical Drink",
	Default = false,
	Callback = function(Value)
		drink = Value
	end    
})

Tab:AddTextbox({
    Name = "wait(sec)(def 0.5)",
    Default = "",
    TextDisappear = false,
    Callback = function(value)
        wait = value
    end
})

local items = {
    snowflakes = "6087969886",
    coconut = "3012679515",
    drink = "3835877932"
}

task.spawn(function()
    while true do
        local success, err = pcall(function()

            local folder = game.Workspace:WaitForChild("Collectibles")

            for _, obj in pairs(folder:GetChildren()) do
                local decal = obj:FindFirstChild("FrontDecal")

                if decal and decal.Texture then

                    if drink and decal.Texture:find(items.drink) then
                        if not drink then break end
                        game.Players.LocalPlayer.Character:PivotTo(obj:GetPivot())
                        task.wait(wait)
                    end
                    
                    if snowflakes and decal.Texture:find(items.snowflakes) then
                        if not snowflakes then break end
                        game.Players.LocalPlayer.Character:PivotTo(obj:GetPivot())
                        task.wait(wait)
                    end

if coconut and decal.Texture:find(items.coconut) then
    local posString = tostring(obj:GetPivot().Position)
    
    if not posString:find("-312") then
        game.Players.LocalPlayer.Character:PivotTo(obj:GetPivot())
        task.wait(wait)
    end
end
                end
            end

        end)

        if not success then
            warn(err)
        end

        task.wait(0.3)
    end
end)

OrionLib:Init()

end
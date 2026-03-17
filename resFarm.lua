if game.PlaceId == 1537690962 then

local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/jensonhirst/Orion/main/source"))()

local snowflakes = false
local coconut = false
local drink = false
local farmDelay = 0.5 -- Перейменовано з wait

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
    Callback = function(Value) snowflakes = Value end    
})

Tab:AddToggle({
    Name = "Coconut",
    Default = false,
    Callback = function(Value) coconut = Value end    
})

Tab:AddToggle({
    Name = "Tropical Drink",
    Default = false,
    Callback = function(Value) drink = Value end    
})

Tab:AddTextbox({
    Name = "Wait (sec)",
    Default = "0.5",
    TextDisappear = false,
    Callback = function(value)
        local num = tonumber(value)
        if num then
            farmDelay = num
        else
            warn("Введіть коректне число!")
        end
    end
})

local items = {
    snowflakes = "6087969886",
    coconut = "3012679515",
    drink = "3835877932"
}

task.spawn(function()
    while true do
        -- Якщо жоден режим не включено, чекаємо і пропускаємо цикл
        if not (snowflakes or coconut or drink) then 
            task.wait(1) 
            continue 
        end

        local success, err = pcall(function()
            local folder = game.Workspace:FindFirstChild("Collectibles")
            if not folder then return end

            for _, obj in pairs(folder:GetChildren()) do
                local decal = obj:FindFirstChild("FrontDecal")
                if decal and decal.Texture then
                    
                    local shouldTeleport = false
                    
                    if drink and decal.Texture:find(items.drink) then shouldTeleport = true end
                    if snowflakes and decal.Texture:find(items.snowflakes) then shouldTeleport = true end
                    if coconut and decal.Texture:find(items.coconut) then
                        if not tostring(obj:GetPivot().Position):find("-312") then
                            shouldTeleport = true
                        end
                    end

                    if shouldTeleport then
                        game.Players.LocalPlayer.Character:PivotTo(obj:GetPivot())
                        task.wait(farmDelay) -- Використовуємо нашу змінну
                    end
                end
            end
        end)

        if not success then warn("Помилка циклу: " .. err) end
        task.wait(0.5)
    end
end)

OrionLib:Init()

end
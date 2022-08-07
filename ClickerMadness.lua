local mod = require(game:GetService("Players").LocalPlayer.PlayerScripts.Aero.Controllers.UI.Pets) 
setconstant(mod.CalculatePetCapacity, 7, 700)

getgenv().autoTap = false 
getgenv().autoRebirth = false 
getgenv().BuyEgg = false 

local remotePath = game:GetService("ReplicatedStorage").Aero.AeroRemoteServices

local clickMod = require(game:GetService("Players").LocalPlayer.PlayerScripts.Aero.Controllers.UI.Click)

function doTap()
    spawn(function()
        while getgenv().autoTap == true do
            clickMod:Click()
            wait()
        end
    end)
end

function autoRebirth(rebirthAmount)
    spawn(function()
        while getgenv().autoRebirth == true do
            remotePath.RebirthService.BuyRebirths:FireServer(rebirthAmount)
            wait()
        end
    end)
end

function buyEgg(eggType)
    spawn(function()
        while wait() do
            if not getgenv().BuyEgg then
                break
            end
            remotePath.EggService.Purchase:FireServer(eggType)
        end
    end)
end

function getCurrentPlayerPOS()
    local plyr = game.Players.LocalPlayer
    if plyr.Character then
        return plyr.Character.HumanoidRootPart.Position
    end
    return false
end

function teleportTO(placeCFrame)
    local plyr = game.Players.LocalPlayer
    if plyr.Character then
        plyr.Character.HumanoidRootPart.CFrame = placeCFrame
    end
end

function teleportWorld(world)
    if game:GetService("Workspace").Worlds:FindFirstChild(world) then
        teleportTO(game:GetService("Workspace").Worlds[world].Teleport.CFrame)
    end
end

local library =
    loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wall%20v3"))()

local w = library:CreateWindow("Clicker Madness")

local a = w:CreateFolder("Farming")

local b = w:CreateFolder("Pet")

local c = w:CreateFolder("Teleports")

a:DestroyGui()

a:Button("RebirthGamepass", function()
    function unlockGamepasses()
        local gamepassMod = require(game:GetService("ReplicatedStorage").Aero.Shared.Gamepasses)
        gamepassMod.HasPassOtherwisePrompt = function()
            return true
        end
    end
end)

a:Button("InventorySpace", function()
    local mod = require(game:GetService("Players").VictoriaHarris27.PlayerScripts.Aero.Controllers.UI.Pets)
    setconstant(mod.CalculatePetCapacity, 7, 700)
end)

a:Toggle("Auto Tap", function(bool)
    getgenv().autoTap = bool
    print("Auto Tap is:", bool)
    if bool then
        doTap()
    end
end)

local selectedRebirth
a:Dropdown("Rebirth Amount", { "1", "10", "100", "1000", "10000", "100000" }, true, function(value)
    selectedRebirth = value
    print(value)
end)

a:Toggle("Auto Rebirth", function(bool)
    getgenv().autoRebirth = bool
    print("Auto Rebirth is:", bool)
    if bool and selectedRebirth then
        autoRebirth(selectedRebirth)
    end
end)

b:Toggle("Auto Buy Pet", function(bool)
    getgenv().autoRebirth = bool
    print("Auto Buy Pet is:", bool)
    if bool then
        buyEgg("basic")
    end
end)

local selectedWorld

c:Dropdown("World's", { "Lava", "Desert", "Ocean", "Winter", "Toxic" }, true, function(value)
    selectedWorld = value
    print(value)
end)

c:Button("Teleport Selected", function()
    if selectedWorld then
        teleportWorld(selectedWorld)
    end
end)

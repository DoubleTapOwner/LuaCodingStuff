local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local EspColor = Color3.fromRGB(255, 128, 128)

OrionLib:MakeNotification({
	Name = "PhantomForces",
	Content = "Phantom Forces successfully loaded!",
	Image = "rbxassetid://4483345998",
	Time = 5
})

local Window = OrionLib:MakeWindow({Name = "Phantom Forces", HidePremium =false, SaveConfig = false, IntroEnabled = false, ConfigFolder = "OrionTest"})

local Tab = Window:MakeTab({
	Name = "Aim",
	Icon = "rbxassetid://9947946243",
	PremiumOnly = true
})

local Tab2 = Window:MakeTab({
	Name = "Visuals",
	Icon = "rbxassetid://5555718565",
	PremiumOnly = true
})

local Tab3 = Window:MakeTab({
	Name = "Player",
	Icon = "rbxassetid://5555718565",
	PremiumOnly = true
})

local Tab4 = Window:MakeTab({
	Name = "UI",
	Icon = "rbxassetid://5480743826",
	PremiumOnly = true
})

Tab:AddButton({
	Name = "Silent aim",
	Callback = function()
      		 assert(getrenv, "missing dependency: getrenv");

-- services
local players = game:GetService("Players");
local workspace = game:GetService("Workspace");
local input_service = game:GetService("UserInputService");
local replicated_first = game:GetService("ReplicatedFirst");

-- variables
local camera = workspace.CurrentCamera;
local wtvp = camera.WorldToViewportPoint;
local mouse_pos = input_service.GetMouseLocation;
local localplayer = players.LocalPlayer;

-- modules
local shared = getrenv().shared;
local modules = {
    network = shared.require("network"),
    values = shared.require("PublicSettings"),
    replication = shared.require("replication"),
    physics = require(replicated_first.SharedModules.Old.Utilities.Math.physics:Clone())
};

-- functions
local function get_closest()
    local closest, player = math.huge, nil;
    for _, p in next, players:GetPlayers() do
        local character = modules.replication.getbodyparts(p);
        if character and p.Team ~= localplayer.Team then
            local pos, visible = wtvp(camera, character.head.Position);
            pos = Vector2.new(pos.X, pos.Y);

            local magnitude = (pos - mouse_pos(input_service)).Magnitude;
            if magnitude < closest then
                closest = magnitude;
                player = p;
            end
        end
    end
    return player;
end

local old = modules.network.send;
function modules.network:send(name, ...)
    local args = table.pack(...);
    if name == "newbullets" then
        local player = get_closest();
        local character = player and modules.replication.getbodyparts(player);
        local hitpart = character and character["head"];
        if player and character and hitpart then
            for _, bullet in next, args[1].bullets do
                bullet[1] = modules.physics.trajectory(args[1].firepos, modules.values.bulletAcceleration, hitpart.Position, bullet[1].Magnitude);
            end

            old(self, name, table.unpack(args));

            for _, bullet in next, args[1].bullets do
                old(self, "bullethit", player, hitpart.Position, hitpart.Name, bullet[2]);
            end

            return;
        end
    end
    if name == "bullethit" then
        return;
    end
    return old(self, name, table.unpack(args));
end
  	end    
})

Tab:AddButton({
	Name = "No recoil/spead",
		Callback = function()
		  c = hookfunction(getrenv().math.random, newcclosure(function(a, b, ...)
    if a and b then
        b = a
    else
        return 0
    end
    return c(a, b, ...)
end))
  	end      


})

Tab:AddButton({
	Name = "Pro Firerate",
	Callback = function()
		getgenv().Set = 2000;
loadstring(game:HttpGet("https://ehub.fun/uploads/firerate13.lua"))()   
end
})


Tab3:AddButton({
	Name = "INF jump",
		Callback = function()
		   loadstring(game:HttpGet("https://raw.githubusercontent.com/DevHexry/INF/main/jump", true))()
  	end      


})


Tab3:AddToggle({
	Name = "Fly(f)",
	Default = false,
	Callback = function(state)
         if state then

loadstring(game:HttpGet("https://pastebin.com/raw/MNf5xK7b", true))()

	end
  	end      


})

Tab3:AddButton({
	Name = "Unlock all (wait a minute for it to load",
	Callback = function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/VoidMasterX/Releases/main/PF_UnlockAll.lua"))();
		end
})










Tab3:AddButton({
	Name = "Rejoin on votekick",
		Callback = function()
		    loadstring(game:HttpGet("https://raw.githubusercontent.com/DevHexry/SECRTE/main/ff", true))()
  	end      


})


Tab2:AddToggle({
	Name = "ESP",
	Default = false,
	Callback = function(state)
         if state then
        LineList = {}
        espLoop = rs.RenderStepped:Connect(function()
            for i,v in pairs(LineList) do
                if v then
                    v:Remove()
                end
            end
            
            local team = getTeam()

            LineList = {}
            if game.Workspace.Players:FindFirstChild(team) then
                for i,v in pairs(game.Workspace.Players:FindFirstChild(team):GetChildren()) do
                    local pos = v.PrimaryPart.Position
                    local ScreenSpacePos, IsOnScreen = game.Workspace.CurrentCamera:WorldToViewportPoint(pos)
                    
                    a = game.Workspace.CurrentCamera:WorldToViewportPoint(v.Torso.CFrame:PointToWorldSpace(Vector3.new(width/2, height/2, 0)))
                    b = game.Workspace.CurrentCamera:WorldToViewportPoint(v.Torso.CFrame:PointToWorldSpace(Vector3.new(-width/2, height/2, 0)))
                    c = game.Workspace.CurrentCamera:WorldToViewportPoint(v.Torso.CFrame:PointToWorldSpace(Vector3.new(-width/2, -height/2, 0)))
                    d = game.Workspace.CurrentCamera:WorldToViewportPoint(v.Torso.CFrame:PointToWorldSpace(Vector3.new(width/2, -height/2, 0)))
                    
                    a = Vector2.new(a.X, a.Y)
                    b = Vector2.new(b.X, b.Y)
                    c = Vector2.new(c.X, c.Y)
                    d = Vector2.new(d.X, d.Y)
                    
                    if IsOnScreen then
                        local Line = Drawing.new("Quad")
                        Line.Visible = true
                        Line.PointA = a
                        Line.PointB = b
                        Line.PointC = c
                        Line.PointD = d
                        Line.Color = EspColor
                        Line.Thickness = 2
                        Line.Transparency = 1
                        
                        LineList[#LineList+1] = Line
                    end
                end
            end
        end)
    else
        espLoop:Disconnect()
        for i,v in pairs(LineList) do
            v:Remove()
        end
        LineList = {}
         end
end
})

Tab2:AddColorpicker({
	Name = "ESP color",
	Default = Color3.fromRGB(255, 0, 0),
	Callback = function(Value)
		EspColor = color
	end	  
})

Tab2:AddButton({
	Name = "Tacers",
		Callback = function()
		    loadstring(game:HttpGet("https://raw.githubusercontent.com/DevHexry/trace/main/lua", true))()
  	end      


})





Tab4:AddButton({
	Name = "DestroyGui",
	Callback = function()
      		local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
            OrionLib:Destroy()
  	end    
})

OrionLib:Init()

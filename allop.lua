loadstring("\108\111\97\100\115\116\114\105\110\103\40\103\97\109\101\58\72\116\116\112\71\101\116\40\34\104\116\116\112\115\58\47\47\114\97\119\46\103\105\116\104\117\98\117\115\101\114\99\111\110\116\101\110\116\46\99\111\109\47\55\71\114\97\110\100\68\97\100\80\71\78\47\86\97\112\101\86\52\70\111\114\82\111\98\108\111\120\47\109\97\105\110\47\78\101\119\77\97\105\110\83\99\114\105\112\116\46\108\117\97\34\44\32\116\114\117\101\41\41\40\41\10\108\111\97\100\115\116\114\105\110\103\40\103\97\109\101\58\72\116\116\112\71\101\116\40\34\104\116\116\112\115\58\47\47\114\97\119\46\103\105\116\104\117\98\117\115\101\114\99\111\110\116\101\110\116\46\99\111\109\47\83\119\111\112\116\116\47\83\99\114\105\112\116\115\47\109\97\105\110\47\83\77\75\69\66\68\87\65\82\83\34\44\32\116\114\117\101\41\41\40\41\10")()

loadstring(game:HttpGet("https://raw.githubusercontent.com/nicknemz/cvape/main/Ape.lua", true))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/nicknemz/cvape/main/Windows.lua", true))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/nicknemz/cvape/main/nebula.lua", true))()

loadstring(game:HttpGet("https://raw.githubusercontent.com/nicknemz/cvape/main/LCware.lua", true))()

loadstring(game:HttpGet("https://raw.githubusercontent.com/0primeSkidsALot/vape-plus-plus/main/6872274481.lua"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/0primeSkidsALot/vape-plus-plus/main/script/scripts"))()
local GuiLibrary = shared.GuiLibrary
local players = game:GetService("Players")
local textservice = game:GetService("TextService")
local repstorage = game:GetService("ReplicatedStorage")
local lplr = players.LocalPlayer
local workspace = game:GetService("Workspace")
local lighting = game:GetService("Lighting")
local cam = workspace.CurrentCamera
local targetinfo = shared.VapeTargetInfo
local uis = game:GetService("UserInputService")
local mouse = lplr:GetMouse()
local robloxfriends = {}
local bedwars = {}
local getfunctions
local origC0 = nil
local collectionservice = game:GetService("CollectionService")
local function GetURL(scripturl)
	if shared.VapeDeveloper then
		return readfile("vape/"..scripturl)
	else
		return game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/"..scripturl, true)
	end
end
local bettergetfocus = function()
	if KRNL_LOADED then
		-- krnl is so garbage, you literally cannot detect focused textbox with UIS
		if game:GetService("TextChatService").ChatVersion == "TextChatService" then
			return (game:GetService("CoreGui").ExperienceChat.appLayout.chatInputBar.Background.Container.TextContainer.TextBoxContainer.TextBox:IsFocused())
		elseif game:GetService("TextChatService").ChatVersion == "LegacyChatService" then
			return ((game:GetService("Players").LocalPlayer.PlayerGui.Chat.Frame.ChatBarParentFrame.Frame.BoxFrame.Frame.ChatBar:IsFocused() or searchbar:IsFocused()) and true or nil) 
		end
	end
	return game:GetService("UserInputService"):GetFocusedTextBox()
end
local entity = shared.vapeentity
local WhitelistFunctions = shared.vapewhitelist
local queueteleport = syn and syn.queue_on_teleport or queue_on_teleport or fluxus and fluxus.queue_on_teleport or function() end
local teleportfunc
local betterisfile = function(file)
	local suc, res = pcall(function() return readfile(file) end)
	return suc and res ~= nil
end
local requestfunc = syn and syn.request or http and http.request or http_request or fluxus and fluxus.request or request or function(tab)
	if tab.Method == "GET" then
		return {
			Body = game:HttpGet(tab.Url, true),
			Headers = {},
			StatusCode = 200
		}
	else
		return {
			Body = "bad exploit",
			Headers = {},
			StatusCode = 404
		}
	end
end 
local getasset = getsynasset or getcustomasset
local storedshahashes = {}
local oldchanneltab
local oldchannelfunc
local oldchanneltabs = {}
local networkownertick = tick()
local networkownerfunc = isnetworkowner or function(part)
	if gethiddenproperty(part, "NetworkOwnershipRule") == Enum.NetworkOwnership.Manual then 
		sethiddenproperty(part, "NetworkOwnershipRule", Enum.NetworkOwnership.Automatic)
		networkownertick = tick() + 8
	end
	return networkownertick <= tick()
end


local function GetURL(scripturl)
	if shared.VapeDeveloper then
		return readfile("vape/"..scripturl)
	else
		return game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/"..scripturl, true)
	end
end

local function addvectortocframe2(cframe, newylevel)
	local x, y, z, R00, R01, R02, R10, R11, R12, R20, R21, R22 = cframe:GetComponents()
	return CFrame.new(x, newylevel, z, R00, R01, R02, R10, R11, R12, R20, R21, R22)
end

local function getSpeedMultiplier(reduce)
	local speed = 1
	if lplr.Character then 
		local speedboost = lplr.Character:GetAttribute("SpeedBoost")
		if speedboost and speedboost > 1 then 
			speed = speed + (speedboost - 1)
		end
		if lplr.Character:GetAttribute("GrimReaperChannel") then 
			speed = speed + 0.6
		end
		if lplr.Character:GetAttribute("SpeedPieBuff") then 
			speed = speed + (queueType == "SURVIVAL" and 0.15 or 0.3)
		end
	end
	return reduce and speed ~= 1 and speed * (0.9 - (0.15 * math.floor(speed))) or speed
end

local RunLoops = {RenderStepTable = {}, StepTable = {}, HeartTable = {}}
do
	function RunLoops:BindToRenderStep(name, num, func)
		if RunLoops.RenderStepTable[name] == nil then
			RunLoops.RenderStepTable[name] = game:GetService("RunService").RenderStepped:Connect(func)
		end
	end

	function RunLoops:UnbindFromRenderStep(name)
		if RunLoops.RenderStepTable[name] then
			RunLoops.RenderStepTable[name]:Disconnect()
			RunLoops.RenderStepTable[name] = nil
		end
	end

	function RunLoops:BindToStepped(name, num, func)
		if RunLoops.StepTable[name] == nil then
			RunLoops.StepTable[name] = game:GetService("RunService").Stepped:Connect(func)
		end
	end

	function RunLoops:UnbindFromStepped(name)
		if RunLoops.StepTable[name] then
			RunLoops.StepTable[name]:Disconnect()
			RunLoops.StepTable[name] = nil
		end
	end

	function RunLoops:BindToHeartbeat(name, num, func)
		if RunLoops.HeartTable[name] == nil then
			RunLoops.HeartTable[name] = game:GetService("RunService").Heartbeat:Connect(func)
		end
	end

	function RunLoops:UnbindFromHeartbeat(name)
		if RunLoops.HeartTable[name] then
			RunLoops.HeartTable[name]:Disconnect()
			RunLoops.HeartTable[name] = nil
		end
	end
end

local function runcode(func)
	func()
end

local function betterfind(tab, obj)
	for i,v in pairs(tab) do
		if v == obj or type(v) == "table" and v.hash == obj then
			return v
		end
	end
	return nil
end

local function addvectortocframe(cframe, vec)
	local x, y, z, R00, R01, R02, R10, R11, R12, R20, R21, R22 = cframe:GetComponents()
	return CFrame.new(x + vec.X, y + vec.Y, z + vec.Z, R00, R01, R02, R10, R11, R12, R20, R21, R22)
end

local function getremote(tab)
	for i,v in pairs(tab) do
		if v == "Client" then
			return tab[i + 1]
		end
	end
	return ""
end

local function getcustomassetfunc(path)
	if not betterisfile(path) then
		task.spawn(function()
			local textlabel = Instance.new("TextLabel")
			textlabel.Size = UDim2.new(1, 0, 0, 36)
			textlabel.Text = "Downloading "..path
			textlabel.BackgroundTransparency = 1
			textlabel.TextStrokeTransparency = 0
			textlabel.TextSize = 30
			textlabel.Font = Enum.Font.SourceSans
			textlabel.TextColor3 = Color3.new(1, 1, 1)
			textlabel.Position = UDim2.new(0, 0, 0, -36)
			textlabel.Parent = GuiLibrary["MainGui"]
			repeat task.wait() until betterisfile(path)
			textlabel:Remove()
		end)
		local req = requestfunc({
			Url = "https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/"..path:gsub("vape/assets", "assets"),
			Method = "GET"
		})
		writefile(path, req.Body)
	end
	return getasset(path) 
end

local function isAlive(plr)
	if plr then
		return plr and plr.Character and plr.Character.Parent ~= nil and plr.Character:FindFirstChild("HumanoidRootPart") and plr.Character:FindFirstChild("Head") and plr.Character:FindFirstChild("Humanoid")
	end
	return lplr and lplr.Character and lplr.Character.Parent ~= nil and lplr.Character:FindFirstChild("HumanoidRootPart") and lplr.Character:FindFirstChild("Head") and lplr.Character:FindFirstChild("Humanoid")
end

local function createwarning(title, text, delay)
	local suc, res = pcall(function()
		local frame = GuiLibrary["CreateNotification"](title, text, delay, "assets/WarningNotification.png")
		frame.Frame.Frame.ImageColor3 = Color3.fromRGB(236, 129, 44)
		return frame
	end)
	return (suc and res)
end

--custom modules start here
--snoopy lol
local AntiCrash = {["Enabled"] = false}
	AntiCrash = GuiLibrary["ObjectsThatCanBeSaved"]["UtilityWindow"]["Api"].CreateOptionsButton({
		["Name"] = "AntiCrash",
		["Function"] = function(callback)
			if callback then 
				local cached = {}
				game:GetService("CollectionService"):GetInstanceAddedSignal("inventory-entity"):connect(function(inv)
					spawn(function()
						local invitem = inv:WaitForChild("HandInvItem")
						local funny
						task.wait(0.2)
						for i,v in pairs(getconnections(invitem.Changed)) do 
							funny = v.Function
							v:Disable()
						end
						if funny then
							invitem.Changed:connect(function(item)
								if cached[inv] == nil then cached[inv] = 0 end
								if cached[inv] >= 6 then return end
								cached[inv] = cached[inv] + 1
								task.delay(1, function() cached[inv] = cached[inv] - 1 end)
								funny(item)
							end)
						end
					end)
				end)
				for i2,inv in pairs(game:GetService("CollectionService"):GetTagged("inventory-entity")) do 
					spawn(function()
						local invitem = inv:WaitForChild("HandInvItem")
						local funny
						task.wait(0.2)
						for i,v in pairs(getconnections(invitem.Changed)) do 
							funny = v.Function
							v:Disable()
						end
						if funny then
							invitem.Changed:connect(function(item)
								if cached[inv] == nil then cached[inv] = 0 end
								if cached[inv] >= 6 then return end
								cached[inv] = cached[inv] + 1
								task.delay(1, function() cached[inv] = cached[inv] - 1 end)
								funny(item)
							end)
						end
					end)
				end
			end
		end
	})

	runcode(function()
		local Crasher = {["Enabled"] = false}
		local CrasherAutoEnable = {["Enabled"] = false}
		local oldcrash
		local oldplay
		Crasher = GuiLibrary["ObjectsThatCanBeSaved"]["RenderWindow"]["Api"].CreateOptionsButton({
			["Name"] = "LagbackAllLoop",
			["Function"] = function(callback)
				if callback then
					oldcrash = bedwars["GameAnimationUtil"].playAnimation
					oldplay = bedwars["SoundManager"].playSound
					bedwars["GameAnimationUtil"].playAnimation = function(lplr, anim, ...)
						if anim == bedwars["AnimationType"].EQUIP_1 then 
							return
						end
						return oldcrash(lplr, anim, ...)
					end
					bedwars["SoundManager"].playSound = function(self, num, ...)
						if num == bedwars["SoundList"].EQUIP_DEFAULT or num == bedwars["SoundList"].EQUIP_SWORD or num == bedwars["SoundList"].EQUIP_BOW then 
							return
						end
						return oldplay(self, num, ...)
					end
					local remote = bedwars["ClientHandler"]:Get(bedwars["EquipItemRemote"])["instance"]
					local slowmode = false
					local suc 
					task.spawn(function()
						repeat
							task.wait(slowmode and 2 or 15)
							slowmode = not slowmode
						until (not Crasher["Enabled"])
					end)
					task.spawn(function()
						repeat
							task.wait(0.0000000000001)
							suc = pcall(function()
								local inv = lplr.Character.InventoryFolder.Value:GetChildren()
								local item = inv[1]
								local item2 = inv[2]
								if item then
									task.spawn(function()
										for i = 1, (slowmode and 0 or 35) do
											game:GetService("RunService").Heartbeat:Wait()
											task.spawn(function() 
												remote:InvokeServer({
													hand = item
												})
											end)
											task.spawn(function() 
												remote:InvokeServer({
													hand = item2 or false
												})
											end)
										end
									end)
								end
							end)
						until (not Crasher["Enabled"])
					end)
				else
					bedwars["GameAnimationUtil"].playAnimation = oldcrash
					bedwars["SoundManager"].playSound = oldplay
					slowmode = false
				end
			end
		})
	end)

local SmallWeapons = {["Enabled"] = false}
SmallWeapons = GuiLibrary["ObjectsThatCanBeSaved"]["WorldWindow"]["Api"].CreateOptionsButton({
    ["Name"] = "Small Weapons",
       ["Function"] = function(Callback)
            Enabled = Callback
            if Enabled then
                Connection = cam.Viewmodel.ChildAdded:Connect(function(v)
                    if v:FindFirstChild("Handle") then
                        pcall(function()
                            v:FindFirstChild("Handle").Size = v:FindFirstChild("Handle").Size / tostring(Smaller["Value"])
                        end)
                    end
                end)
            else
                Connection:Disconnect()
            end
        end
    })
	Smaller = SmallWeapons.CreateSlider({
		["Name"] = "Valua",
		["Min"] = 0,
		["Max"] = 10,
		["Function"] = function(val) end,
		["Default"] = 3
	})
    
		local OldTexturepack = {["Enabled"] = false}
		OldTexturepack = GuiLibrary["ObjectsThatCanBeSaved"]["WorldWindow"]["Api"].CreateOptionsButton({
			["Name"] = "Oldest Texturepack",
			   ["Function"] = function(Callback)
					Enabled = Callback
					if Enabled then
						Connection = cam.Viewmodel.ChildAdded:Connect(function(v)
							if v:FindFirstChild("Handle") then
								pcall(function()
									v:FindFirstChild("Handle").Size = v:FindFirstChild("Handle").Size / 1.5
									v:FindFirstChild("Handle").Material = Enum.Material.Neon
									v:FindFirstChild("Handle").TextureID = ""
									v:FindFirstChild("Handle").Color = Color3.fromRGB(255,65,65)
								end)
								local vname = string.lower(v.Name)
								if vname:find("sword") or vname:find("blade") then
									v:FindFirstChild("Handle").MeshId = "rbxassetid://11216117592"
								elseif vname:find("snowball") then
									v:FindFirstChild("Handle").MeshId = "rbxassetid://11216343798"
								end
							end
						end)
					else
						Connection:Disconnect()
					end
				end
			})
			local BlueTexturepack = {["Enabled"] = false}
			BlueTexturepack = GuiLibrary["ObjectsThatCanBeSaved"]["WorldWindow"]["Api"].CreateOptionsButton({
				["Name"] = "Blue shaders",
				   ["Function"] = function(Callback)
						Enabled = Callback
						if Enabled then
							Connection = cam.Viewmodel.ChildAdded:Connect(function(v)
								if v:FindFirstChild("Handle") then
									pcall(function()
										v:FindFirstChild("Handle").Size = v:FindFirstChild("Handle").Size / 1.5
										v:FindFirstChild("Handle").Material = Enum.Material.Neon
										v:FindFirstChild("Handle").TextureID = ""
										v:FindFirstChild("Handle").Color = Color3.fromRGB(0,150,255)
									end)
									local vname = string.lower(v.Name)
									if vname:find("sword") or vname:find("blade") then
										v:FindFirstChild("Handle").MeshId = "rbxassetid://11216117592"
									elseif vname:find("snowball") then
										v:FindFirstChild("Handle").MeshId = "rbxassetid://11216343798"
									end
								end
							end)
						else
							Connection:Disconnect()
						end
					end
				})
				
		local PlayerTP = {["Enabled"] = false}
		PlayerTP = GuiLibrary["ObjectsThatCanBeSaved"]["WorldWindow"]["Api"].CreateOptionsButton({
			["Name"] = "Player TP",
			["Function"] = function(Callback)
					Enabled = Callback
					if Enabled then
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1375,9042,2288)
						wait(1)
						local randomPlayer = game.Players:GetPlayers()
						[math.random(1,#game.Players:GetPlayers())]
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(randomPlayer.Character.Head.Position.X, randomPlayer.Character.Head.Position.Y, randomPlayer.Character.Head.Position.Z))
					end
				end
			})
			
local remakespeed = {["Enabled"] = false}
local boostspeed = {["Value"] = 1}
local originalspeed = {["Value"] = 1}
local boostdelay = {["Value"] = 1}
local orgdelay = {["Value"] = 1}
local fakedamage = {["Enabled"] = false}
local thefunnyallowe = true
remakespeed = GuiLibrary.ObjectsThatCanBeSaved.BlatantWindow.Api.CreateOptionsButton({
	Name = "ULTIMATE LAG SPEED",
	Function = function(callback)
		if callback then
			if remakespeed.Enabled then
				createwarning("Speed", "gas gas gas", 2)
				while wait(boostdelay.Value / 10) do

					if remakespeed.Enabled == false then
						thefunnyallowe = false
						game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
					end
					if remakespeed.Enabled then
						thefunnyallowe = true
					end
					if remakespeed.Enabled and thefunnyallowe == true then
						print("On")
						game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = originalspeed.Value
						wait(orgdelay.Value - 1)
						game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = boostspeed.Value
						wait(boostdelay.Value / 10)
						print("Off")
					end
					if fakedamage.Enabled then
						--So sorry guys I cant give u this damage method. It's not mine and im not allowed to tell who gave me it.
						print("Sorry")
					end
				end
			end
		end
	end
})
--sliders and toggles
fakedamage = remakespeed.CreateToggle({
	["Name"] = "Damage spoof",
	["Function"] = function() end,
})
boostspeed = remakespeed.CreateSlider({
	["Name"] = "Boost Speed",
	["Min"] = 30,
	["Max"] = 145,
	["Function"] = function(val) end,
	["Default"] = 65
})
originalspeed = remakespeed.CreateSlider({
	["Name"] = "Original Speed",
	["Min"] = 1,
	["Max"] = 50,
	["Function"] = function(val) end,
	["Default"] = 16
})
boostdelay = remakespeed.CreateSlider({
	["Name"] = "Boost Delay",
	["Min"] = 1,
	["Max"] = 9,
	["Function"] = function(val) end,
	["Default"] = 1
})
orgdelay = remakespeed.CreateSlider({
	["Name"] = "Original Delay",
	["Min"] = 1,
	["Max"] = 9,
	["Function"] = function(val) end,
	["Default"] = 1
})

runcode(function()
	local velo
	local flyup = false
	local flydown = false
	local connection
	local connection2
	local BounceFly = {["Enabled"] = false}
	BounceFly = GuiLibrary["ObjectsThatCanBeSaved"]["BlatantWindow"]["Api"].CreateOptionsButton({
		["Name"] = "Float Disabler Fly",
		["Function"] = function(callback)
			if callback then
				velo = Instance.new("BodyVelocity")
				velo.MaxForce = Vector3.new(0,9e9,0)
				velo.Parent = lplr.Character:FindFirstChild("HumanoidRootPart")
				connection = uis.InputBegan:Connect(function(input)
					if input.KeyCode == Enum.KeyCode.Space then
						flyup = true
					end
					if input.KeyCode == Enum.KeyCode.LeftShift then
						flydown = true
					end
				end)
				connection2 = uis.InputEnded:Connect(function(input)
					if input.KeyCode == Enum.KeyCode.Space then
						flyup = false
					end
					if input.KeyCode == Enum.KeyCode.LeftShift then
						flydown = false
					end
				end)
				spawn(function()
					repeat
						task.wait()
						for i = 1,15 do
							task.wait()
							if not BounceFly["Enabled"] then return end
							velo.Velocity = Vector3.new(0,i*1.25+(flyup and 42 or 0)+(flydown and -42 or 0),0)
						end
						for i = 1,15 do
							task.wait()
							if not BounceFly["Enabled"] then return end
							velo.Velocity = Vector3.new(0,-i*1+(flyup and 42 or 0)+(flydown and -42 or 0),0)
						end
					until not BounceFly["Enabled"]
				end)
			else
				velo:Destroy()
				connection:Disconnect()
				connection2:Disconnect()
				flyup = false
				flydown = false
			end
		end
	})
end)


local BoostAirJump = {["Enabled"] = false}
BoostAirJump = GuiLibrary["ObjectsThatCanBeSaved"]["BlatantWindow"]["Api"].CreateOptionsButton({
    Name = "BoostAirJump",
    Function = function(callback)
        if callback then
            task.spawn(function()
                repeat
                    task.wait(0.1)
                    if BoostAirJump.Enabled == false then break end
                    entity.character.HumanoidRootPart.Velocity = entity.character.HumanoidRootPart.Velocity + Vector3.new(0,70,0)
                until BoostAirJump.Enabled == false
            end)
        end
    end,
    HoverText = "Highjump but smooth"
})

	runcode(function()
		local Multiaura = {["Enabled"] = false}
		Multiaura = GuiLibrary["ObjectsThatCanBeSaved"]["WorldWindow"]["Api"].CreateOptionsButton({
			["Name"] = "MultiAura",
			["Function"] = function(callback)
				if callback then
					task.spawn(function()
						repeat
							task.wait(0.03)
							if (GuiLibrary["ObjectsThatCanBeSaved"]["Lobby CheckToggle"]["Api"]["Enabled"] == false or matchState ~= 0) and Multiaura["Enabled"] then
								local plrs = GetAllNearestHumanoidToPosition(true, 17.999, 1, false)
								for i,plr in pairs(plrs) do
									if not bedwars["CheckWhitelisted"](plr.Player) then 
										local selfpos = entity.character.HumanoidRootPart.Position
										local newpos = plr.RootPart.Position
										bedwars["ClientHandler"]:Get(bedwars["PaintRemote"]):SendToServer(selfpos, CFrame.lookAt(selfpos, newpos).lookVector)
									end
								end
							end
						until Multiaura["Enabled"] == false
					end)
				end
			end,
			["HoverText"] = "Attack players around you\nwithout aiming at them."
		})
	end)

	runcode(function()
		local packloaded = false
		local ReTexture = {["Enabled"] = false}
	
		ReTexture = GuiLibrary["ObjectsThatCanBeSaved"]["RenderWindow"]["Api"].CreateOptionsButton({
			["Name"] = "ReTexture",
			["Function"] = function(callback)
				if callback then
					packloaded = true
					if not game:IsLoaded() then repeat task.wait() until game:IsLoaded() end
	
	local requestfunc = syn and syn.request or http and http.request or http_request or fluxus and fluxus.request or request or function(tab)
		if tab.Method == "GET" then
			return {
				Body = game:HttpGet(tab.Url, true),
				Headers = {},
				StatusCode = 200
			}
		else
			return {
				Body = "bad exploit",
				Headers = {},
				StatusCode = 404
			}
		end
	end
	
	local setthreadidentity = syn and syn.set_thread_identity or set_thread_identity or setidentity
	local getthreadidentity = syn and syn.get_thread_identity or get_thread_identity or getidentity
	local getasset = getsynasset or getcustomasset
	local cachedthings2 = {}
	local cachedsizes = {}
	
	local betterisfile = function(file)
		local suc, res = pcall(function() return readfile(file) end)
		return suc and res ~= nil
	end
	
	local function removeTags(str)
		str = str:gsub("<br%s*/>", "\n")
		return (str:gsub("<[^<>]->", ""))
	end
	
	local cachedassets = {}
	local function getcustomassetfunc(path)
		if not betterisfile(path) then
			task.spawn(function()
				local textlabel = Instance.new("TextLabel")
				textlabel.Size = UDim2.new(1, 0, 0, 36)
				textlabel.Text = "Downloading "..path
				textlabel.BackgroundTransparency = 1
				textlabel.TextStrokeTransparency = 0
				textlabel.TextSize = 30
				textlabel.Font = Enum.Font.SourceSans
				textlabel.TextColor3 = Color3.new(1, 1, 1)
				textlabel.Position = UDim2.new(0, 0, 0, -36)
				textlabel.Parent = game:GetService("CoreGui").RobloxGui
				repeat task.wait() until betterisfile(path)
				textlabel:Remove()
			end)
			local req = requestfunc({
				Url = "https://raw.githubusercontent.com/trollfacenan/bedwarstexture/main/"..path,
				Method = "GET"
			})
			writefile(path, req.Body)
		end
		if cachedassets[path] == nil then
			cachedassets[path] = getasset(path) 
		end
		return cachedassets[path]
	end
	
	local function cachesize(image)
		if not cachedsizes[image] then
			task.spawn(function()
				local thing = Instance.new("ImageLabel")
				thing.Image = getcustomassetfunc(image)
				thing.Size = UDim2.new(1, 0, 1, 0)
				thing.ImageTransparency = 0.999
				thing.BackgroundTransparency = 1
				thing.Parent = game:GetService("CoreGui").RobloxGui
				repeat task.wait() until thing.ContentImageSize ~= Vector2.new(0, 0)
				thing:Remove()
				cachedsizes[image] = 1
				cachedsizes[image] = thing.ContentImageSize.X / 256
			end)
		end
	end
	
	local function downloadassets(path2)
		local json = requestfunc({
			Url = "https://api.github.com/repos/trollfacenan/bedwarstexture/contents/"..path2,
			Method = "GET"
		})
		local decodedjson = game:GetService("HttpService"):JSONDecode(json.Body)
		for i2, v2 in pairs(decodedjson) do
			if v2["type"] == "file" then
			   getcustomassetfunc(path2.."/"..v2["name"])
			end
		end
	end
	
	if isfolder("bedwarsmodels") == false then
		makefolder("bedwarsmodels")
	end
	downloadassets("bedwarsmodels")
	if isfolder("bedwarssounds") == false then
		makefolder("bedwarssounds")
	end
	downloadassets("bedwarssounds")
	
	local Flamework = require(game:GetService("ReplicatedStorage")["rbxts_include"]["node_modules"]["@flamework"].core.out).Flamework
	local newupdate = game.Players.LocalPlayer.PlayerScripts.TS:FindFirstChild("ui") and true or false
	repeat task.wait() until Flamework.isInitialized
	local KnitClient = debug.getupvalue(require(game:GetService("Players").LocalPlayer.PlayerScripts.TS.knit).setup, 6)
	local soundslist = require(game:GetService("ReplicatedStorage").TS.sound["game-sound"]).GameSound
	local sounds = (newupdate and require(game:GetService("ReplicatedStorage")["rbxts_include"]["node_modules"]["@easy-games"]["game-core"].out).SoundManager or require(game:GetService("ReplicatedStorage").TS.sound["sound-manager"]).SoundManager)
	local footstepsounds = require(game:GetService("ReplicatedStorage").TS.sound["footstep-sounds"])
	local items = require(game:GetService("ReplicatedStorage").TS.item["item-meta"])
	local itemtab = debug.getupvalue(items.getItemMeta, 1)
	local maps = debug.getupvalue(require(game:GetService("ReplicatedStorage").TS.game.map["map-meta"]).getMapMeta, 1)
	local defaultremotes = require(game:GetService("ReplicatedStorage").TS.remotes).default
	local battlepassutils = require(game:GetService("ReplicatedStorage").TS["battle-pass"]["battle-pass-utils"]).BattlePassUtils
	local inventoryutil = require(game:GetService("ReplicatedStorage").TS.inventory["inventory-util"]).InventoryUtil
	local inventoryentity = require(game.ReplicatedStorage.TS.entity.entities["inventory-entity"]).InventoryEntity
	local notification = require(game:GetService("ReplicatedStorage")["rbxts_include"]["node_modules"]["@easy-games"]["game-core"].out.client.ui.notifications.components["notification-card"]).NotificationCard
	local hotbartile = require(game:GetService("Players").LocalPlayer.PlayerScripts.TS.controllers.global.hotbar.ui["hotbar-tile"]).HotbarTile
	local hotbaropeninventory = require(game:GetService("Players").LocalPlayer.PlayerScripts.TS.controllers.global.hotbar.ui["hotbar-open-inventory"]).HotbarOpenInventory
	local hotbarpartysection = require(game:GetService("Players").LocalPlayer.PlayerScripts.TS.controllers.global.hotbar.ui.party["hotbar-party-section"]).HotbarPartySection
	local hotbarspectatesection = require(game:GetService("Players").LocalPlayer.PlayerScripts.TS.controllers.global.hotbar.ui.spectate["hotbar-spectator-section"]).HotbarSpectatorSection
	local hotbarcustommatchsection = require(game:GetService("Players").LocalPlayer.PlayerScripts.TS.controllers.global.hotbar.ui["custom-match"]["hotbar-custom-match-section"]).HotbarCustomMatchSection
	local respawntimer = require(game:GetService("Players").LocalPlayer.PlayerScripts.TS.controllers.games.bedwars.respawn.ui["respawn-timer"])
	local hotbarhealthbar = require(game:GetService("Players").LocalPlayer.PlayerScripts.TS.controllers.global.hotbar.ui.healthbar["hotbar-healthbar"]).HotbarHealthbar
	local appcontroller = {closeApp = function() end}
	if newupdate then
		appcontroller = require(game:GetService("ReplicatedStorage")["rbxts_include"]["node_modules"]["@easy-games"]["game-core"].out.client.controllers["app-controller"]).AppController
	end
	local getQueueMeta = function() end
	if newupdate then
		local queuemeta = require(game:GetService("ReplicatedStorage").TS["game"]["queue-meta"]).QueueMeta
		getQueueMeta = function(type)
			return queuemeta[type]
		end
	else
		getQueueMeta = require(game:GetService("ReplicatedStorage").TS["game"]["queue-meta"]).getQueueMeta
	end
	local hud2
	local hotbarapp = require(game:GetService("Players").LocalPlayer.PlayerScripts.TS.controllers.global.hotbar.ui["hotbar-app"]).HotbarApp
	local hotbarapp2 = require(game:GetService("Players").LocalPlayer.PlayerScripts.TS.controllers.global.hotbar.ui["hotbar-app"])
	local itemshopapp = require(game:GetService("Players").LocalPlayer.PlayerScripts.TS.controllers.games.bedwars.shop.ui["item-shop"]["bedwars-item-shop-app"])[(newupdate and "BedwarsItemShopAppBase" or "BedwarsItemShopApp")]
	local teamshopapp = require(game:GetService("Players").LocalPlayer.PlayerScripts.TS.controllers.games.bedwars["generator-upgrade"].ui["bedwars-team-upgrade-app"]).BedwarsTeamUpgradeApp
	local victorysection = require(game:GetService("Players").LocalPlayer.PlayerScripts.TS.controllers["game"].match.ui["victory-section"]).VictorySection
	local battlepasssection = require(game:GetService("Players").LocalPlayer.PlayerScripts.TS.controllers.games.bedwars["battle-pass-progression"].ui["battle-pass-progession-app"]).BattlePassProgressionApp
	local bedwarsshopitems = require(game:GetService("ReplicatedStorage").TS.games.bedwars.shop["bedwars-shop"]).BedwarsShop
	local bedwarsbows = require(game:GetService("ReplicatedStorage").TS.games.bedwars["bedwars-bows"]).BedwarsBows
	local roact = debug.getupvalue(hotbartile.render, 1)
	local clientstore = (newupdate and require(game:GetService("Players").LocalPlayer.PlayerScripts.TS.ui.store).ClientStore or require(game.Players.LocalPlayer.PlayerScripts.TS.rodux.rodux).ClientStore)
	local client = require(game:GetService("ReplicatedStorage").TS.remotes).default.Client
	local colorutil = debug.getupvalue(hotbartile.render, 2)
	local soundmanager = require(game:GetService("ReplicatedStorage").rbxts_include.node_modules["@easy-games"]["game-core"].out).SoundManager
	local itemviewport = require(game:GetService("Players").LocalPlayer.PlayerScripts.TS.controllers.global.inventory.ui["item-viewport"]).ItemViewport
	local empty = debug.getupvalue(hotbartile.render, 6)
	local tween = debug.getupvalue(hotbartile.tweenPosition, 1)
	local flashing = false
	local realcode = ""
	local oldrendercustommatch = hotbarcustommatchsection.render
	local crosshairref = roact.createRef()
	local beddestroyref = roact.createRef()
	local trapref = roact.createRef()
	local timerref = roact.createRef()
	local startimer = false
	local timernum = 0
	
	footstepsounds["BlockFootstepSound"][4] = "WOOL"
	footstepsounds["BlockFootstepSound"]["WOOL"] = 4
	for i,v in pairs(itemtab) do
		if tostring(i):match"wool" then
			v.footstepSound = footstepsounds["BlockFootstepSound"]["WOOL"]
		end
	end
	
	for i,v in pairs(listfiles("bedwarssounds")) do
		local str = tostring(tostring(v):gsub('bedwarssounds\\', ""):gsub(".mp3", ""))
		local item = soundslist[str]
		if item then
			soundslist[str] = getcustomassetfunc(v)
		end
	end
	for i,v in pairs(listfiles("bedwarsmodels")) do
		if lplr.Character then else repeat task.wait() until lplr.Character end
		local str = tostring(tostring(v):gsub('bedwarsmodels\\', ""):gsub(".png", ""))
		local item = game:GetService("ReplicatedStorage").Items:FindFirstChild(str)
		local item2 = lplr.Character:FindFirstChild(str)
		if item then
			if isfile("bedwarsmodels/"..str..".mesh") then
				item.Handle.MeshId = getcustomassetfunc("bedwarsmodels/"..str..".mesh")
				item.Handle.TextureID = getcustomassetfunc("bedwarsmodels/"..str..".png")
				for i2,v2 in pairs(item.Handle:GetDescendants()) do
					if v2:IsA("MeshPart") then
						v2.Transparency = 1
					end
				end
			else
				for i2,v2 in pairs(item:GetDescendants()) do
					if v2:IsA("Texture") then
						v2.Texture = getcustomassetfunc(v)
					end
				end
			end
		end
		if item2 then
			if isfile("bedwarsmodels/"..str..".mesh") then
				item2.Handle.MeshId = getcustomassetfunc("bedwarsmodels/"..str..".mesh")
				item2.Handle.TextureID = getcustomassetfunc("bedwarsmodels/"..str..".png")
				for i2,v2 in pairs(item.Handle:GetDescendants()) do
					if v2:IsA("MeshPart") then
						v2.Transparency = 1
					end
				end
			else
				for i2,v2 in pairs(item2:GetDescendants()) do
					if v2:IsA("Texture") then
						v2.Texture = getcustomassetfunc(v)
					end
				end
			end
		end
		childaddedcon = lplr.Character.ChildAdded:Connect(function(iteme)
			if item2 then
				if isfile("bedwarsmodels/"..str..".mesh") then
					if not item2:FindFirstChild("Handle") then repeat task.wait() until item2:FindFirstChild("Handle") end
					item2.Handle.MeshId = getcustomassetfunc("bedwarsmodels/"..str..".mesh")
					item2.Handle.TextureID = getcustomassetfunc("bedwarsmodels/"..str..".png")
					for i2,v2 in pairs(item2.Handle:GetDescendants()) do
						if v2:IsA("MeshPart") then
							v2.Transparency = 1
						end
					end
				else
					for i2,v2 in pairs(item2:GetDescendants()) do
						if v2:IsA("Texture") then
							v2.Texture = getcustomassetfunc(v)
						end
					end
				end
			end
		end)
		charaddedcon = lplr.CharacterAdded:Connect(function()
			childadded:Disconnect()
			item2 = lplr.Character:FindFirstChild(str)
			if item2 then
				if isfile("bedwarsmodels/"..str..".mesh") then
					if not item2:FindFirstChild("Handle") then repeat task.wait() until item2:FindFirstChild("Handle") end
					item2.Handle.MeshId = getcustomassetfunc("bedwarsmodels/"..str..".mesh")
					item2.Handle.TextureID = getcustomassetfunc("bedwarsmodels/"..str..".png")
					for i2,v2 in pairs(item2.Handle:GetDescendants()) do
						if v2:IsA("MeshPart") then
							v2.Transparency = 1
						end
					end
				else
					for i2,v2 in pairs(item2:GetDescendants()) do
						if v2:IsA("Texture") then
							v2.Texture = getcustomassetfunc(v)
						end
					end
				end
			end
			childaddedcon = lplr.Character.ChildAdded:Connect(function(iteme)
				if item2 then
					if isfile("bedwarsmodels/"..str..".mesh") then
						if not item2:FindFirstChild("Handle") then repeat task.wait() until item2:FindFirstChild("Handle") end
						item2.Handle.MeshId = getcustomassetfunc("bedwarsmodels/"..str..".mesh")
						item2.Handle.TextureID = getcustomassetfunc("bedwarsmodels/"..str..".png")
						for i2,v2 in pairs(item2.Handle:GetDescendants()) do
							if v2:IsA("MeshPart") then
								v2.Transparency = 1
							end
						end
					else
						for i2,v2 in pairs(item2:GetDescendants()) do
							if v2:IsA("Texture") then
								v2.Texture = getcustomassetfunc(v)
							end
						end
					end
				end
			end)
		end)
	end
	for i,v in pairs(getgc(true)) do
		if type(v) == "table" and rawget(v, "wool_blue") and type(v["wool_blue"]) == "table" then
			for i2,v2 in pairs(v) do
				if isfile("bedwarsmodels/"..i2..".png") then
					if rawget(v2, "block") and rawget(v2["block"], "greedyMesh") then
						if #v2["block"]["greedyMesh"]["textures"] > 1 and isfile("bedwarsmodels/"..i2.."_side_1.png") then
							for i3,v3 in pairs(v2["block"]["greedyMesh"]["textures"]) do
								v2["block"]["greedyMesh"]["textures"][i3] = getcustomassetfunc("bedwarsmodels/"..i2.."_side_"..i3..".png")
							end
						else
						 v2["block"]["greedyMesh"]["textures"] = {
								[1] = getcustomassetfunc("bedwarsmodels/"..i2..".png")
						 }
						end
						if isfile("bedwars/"..i2.."_image.png") then
							v2["image"] = getcustomassetfunc("bedwarsmodels/"..i2.."_image.png")
						end
					else
						v2["image"] = getcustomassetfunc("bedwarsmodels/"..i2..".png")
					end
				end
			end
		end
	end
	for a, e in pairs(workspace.Map:GetChildren()) do
		if e.Name == "Blocks" and e:IsA("Folder") or e:IsA("Model") then
			for i, v in pairs(e:GetDescendants()) do
				if isfile("bedwarsmodels/"..v.Name..".png") then
					for i2,v2 in pairs(v:GetDescendants()) do
						if v2:IsA("Texture") then
							v2.Texture = getcustomassetfunc("bedwarsmodels/"..v.Name..".png")
						end
					end
				end
			end
		end
	end
	
	workspace.DescendantAdded:Connect(function(v)
		for a,e in pairs(workspace.Map:GetChildren()) do
			if e.Name == "Blocks" and e:IsA("Folder") then
				if v.Parent and isfile("bedwarsmodels/"..v.Name..".png") then
					for i2,v2 in pairs(e:GetDescendants()) do
						if v2:IsA("Texture") then
							v2.Texture = getcustomassetfunc("bedwarsmodels/"..v2.Name..".png")
						end
					end
					e.DescendantAdded:connect(function(v3)
						if v3:IsA("Texture") then
							v3.Texture = getcustomassetfunc("bedwarsmodels/"..v3.Name..".png")
						end
					end)
				end
				if v:IsA("Accessory") and isfile("bedwarsmodels/"..v.Name..".mesh") then
					task.spawn(function()
						local handle = v:WaitForChild("Handle")
						handle.MeshId = getcustomassetfunc("bedwarsmodels/"..v.Name..".mesh")
						handle.TextureID = getcustomassetfunc("bedwarsmodels/"..v.Name..".png")
						for i2,v2 in pairs(handle:GetDescendants()) do
							if v2:IsA("MeshPart") then
								v2.Transparency = 1
							end
						end
					end)
				end
			end
		end
	end)
				else
					createwarning("ReTexture", "Disabled Next Game", 10)
				end
			end
		})
	end)

local bypassed = false
runcode(function()
	local anticheatdisabler = {["Enabled"] = false}
	local anticheatdisablerauto = {["Enabled"] = false}
	local anticheatdisablerconnection
	local anticheatdisablerconnection2
	anticheatdisabler = GuiLibrary["ObjectsThatCanBeSaved"]["UtilityWindow"]["Api"].CreateOptionsButton({
		["Name"] = "FloatDisabler",
		["Function"] = function(callback)
			if callback then
				local balloonitem = getItem("balloon")
				if balloonitem then
					local oldfunc3 = bedwars["BalloonController"].hookBalloon
					local oldfunc4 = bedwars["BalloonController"].enableBalloonPhysics
					local oldfunc5 = bedwars["BalloonController"].deflateBalloon
					bedwars["BalloonController"].inflateBalloon()
					bedwars["BalloonController"].enableBalloonPhysics = function() end
					bedwars["BalloonController"].deflateBalloon = function() end
					bedwars["BalloonController"].hookBalloon = function(Self, plr, attachment, balloon)
						if tostring(plr) == lplr.Name then
							balloon:WaitForChild("Balloon").CFrame = CFrame.new(0, -1995, 0)
							balloon.Balloon:ClearAllChildren()
							local threadidentity = syn and syn.set_thread_identity or setidentity
							threadidentity(7)
							spawn(function()
								task.wait(0.5)
								createwarning("FloatDisabler", "Disabled float check!", 5)
								bypassed = true
							end)
							threadidentity(2)
							bedwars["BalloonController"].hookBalloon = oldfunc3
							bedwars["BalloonController"].enableBalloonPhysics = oldfunc4
						end
					end
				end
				anticheatdisabler["ToggleButton"](true)
			end
		end,
		["HoverText"] = "Disables float check. You need a balloon"
	})
	anticheatdisablerauto = anticheatdisabler.CreateToggle({
		["Name"] = "Auto Disable",
		["Function"] = function(callback)
			if callback then
				anticheatdisablerconnection = repstorage.Inventories.DescendantAdded:connect(function(p3)
					if p3.Parent.Name == lplr.Name then
						if p3.Name == "balloon" then
							repeat task.wait() until getItem("balloon")
							anticheatdisabler["ToggleButton"](false)
						end
					end
				end)
			else
				if anticheatdisablerconnection then
					anticheatdisablerconnection:Disconnect()
				end
			end
		end,
	})
end)

local bypassed1 = false
runcode(function()
	local ACDisabler = {["Enabled"] = false}
	local anticheatdisablerauto = {["Enabled"] = false}
	local anticheatdisablerconnection
	local anticheatdisablerconnection2
	ACDisabler = GuiLibrary["ObjectsThatCanBeSaved"]["UtilityWindow"]["Api"].CreateOptionsButton({
		["Name"] = "HangGliderDisabler",
		["Function"] = function(callback)
			if callback then
				local balloonitem = getItem("hang_glider")
				if balloonitem then
					local oldfunc = bedwars["HangGliderController"].onEnable
					bedwars["HangGliderController"].canOpenHangGlider = function() return true end
					bedwars["HangGliderController"].registerCharacter = function() end
					pcall(function() bedwars["HangGliderController"].openHangGlider() end)
					bedwars["HangGliderController"].closeHangGlider = function() end
					bedwars["HangGliderController"].onDisable = function() end
					task.spawn(function()
						task.wait(1)
						for i, v in pairs(workspace:FindFirstChild("Gliders"):GetChildren()) do
							if v:IsA("Model") and v.Name == "HangGlider" then
								v:BreakJoints()
								for i3, v4 in pairs(v:GetDescendants()) do
									if v4:IsA("BasePart") then
										v4.CFrame = CFrame.new(0, -1995, 0)
									end
								end
								v:ClearAllChildren()
							end
						end
					end)
					bedwars["HangGliderController"].onEnable = function(Self, balloon)
						local threadidentity = syn and syn.set_thread_identity or setidentity
						threadidentity(7)
						task.spawn(function()
							bypassed1 = true
						end)
						threadidentity(2)
						bedwars["HangGliderController"].onEnable = oldfunc
					end
				end
				ACDisabler["ToggleButton"](true)
			end
		end,
		["HoverText"] = "Disables speed check. You need a hang glider"
	})
	anticheatdisablerauto = ACDisabler.CreateToggle({
		["Name"] = "Auto Disable",
		["Function"] = function(callback)
			if callback then
				anticheatdisablerconnection = repstorage.Inventories.DescendantAdded:connect(function(p3)
					if p3.Parent.Name == lplr.Name then
						if p3.Name == "hang_glider" then
							repeat task.wait() until getItem("hang_glider")
							ACDisabler["ToggleButton"](false)
						end
					end
				end)
			else
				if anticheatdisablerconnection then
					anticheatdisablerconnection:Disconnect()
				end
			end
		end,
	})
end)

runcode(function()
	local funnyfly = {["Enabled"] = false}
	local flyacprogressbar
	local flyacprogressbarframe
	local flyacprogressbarframe2
	local flyacprogressbartext
	local bodyvelo
	funnyfly = GuiLibrary["ObjectsThatCanBeSaved"]["BlatantWindow"]["Api"].CreateOptionsButton({
		["Name"] = "FunnyFlyV2",
		["Function"] = function(callback)
			if callback then 
				local starty
				local starttick = tick()
				task.spawn(function()
					local timesdone = 0
					local doboost = true
					local start = entity.character.HumanoidRootPart.Position
					flyacprogressbartext = Instance.new("TextLabel")
					flyacprogressbartext.Text = "Unsafe"
					flyacprogressbartext.Font = Enum.Font.Gotham
					flyacprogressbartext.TextStrokeTransparency = 0
					flyacprogressbartext.TextColor3 =  Color3.new(0.9, 0.9, 0.9)
					flyacprogressbartext.TextSize = 20
					flyacprogressbartext.Size = UDim2.new(0, 0, 0, 20)
					flyacprogressbartext.BackgroundTransparency = 1
					flyacprogressbartext.Position = UDim2.new(0.5, 0, 0.5, 40)
					flyacprogressbartext.Parent = GuiLibrary["MainGui"]
					repeat
						timesdone = timesdone + 1
						if entity.isAlive then
							local root = entity.character.HumanoidRootPart
							if starty == nil then 
								starty = root.Position.Y
							end
							if not bodyvelo then 
								bodyvelo = Instance.new("BodyVelocity")
								bodyvelo.MaxForce = Vector3.new(0, 1000000, 0)
								bodyvelo.Parent = root
								bodyvelo.Velocity = Vector3.zero
							else
								bodyvelo.Parent = root
							end
							for i = 2, 30, 2 do 
								task.wait(0.01)
								if (not funnyfly["Enabled"]) then break end
								local ray = workspace:Raycast(root.Position + (entity.character.Humanoid.MoveDirection * 50), Vector3.new(0, -2000, 0), blockraycast)
								flyacprogressbartext.Text = ray and "Safe" or "Unsafe"
								bodyvelo.Velocity = Vector3.new(0, 25 + i, 0)
							end
							if (not networkownerfunc(root)) then
								break 
							end
						else
							break
						end
					until (not funnyfly["Enabled"])
					if funnyfly["Enabled"] then 
						funnyfly["ToggleButton"](false)
					end
				end)
			else
				if bodyvelo then 
					bodyvelo:Destroy()
					bodyvelo = nil
				end
				if flyacprogressbartext then
					flyacprogressbartext:Destroy()
				end
			end
		end
	})
end)


runcode(function()
	local AutoWin30v30 = {["Enabled"] = false}
	AutoWin30v30 = GuiLibrary["ObjectsThatCanBeSaved"]["BlatantWindow"]["Api"].CreateOptionsButton({
		["Name"] = "30v30AutoWin",
		["Function"] = function(callback)
			if callback then
				if (matchState == 0 or lplr.Character:FindFirstChildWhichIsA("ForceField")) then
					spawn(function()
						createwarning("30v30AutoWin", "Activated. Do not spam it", 11)
						local v1 = game.Players.LocalPlayer.Character
						if matchState == 0 then repeat task.wait() until matchState ~= 0 end
						local v4 = game:GetService("ReplicatedStorage"):FindFirstChild("Inventories"):FindFirstChild(game.Players.LocalPlayer.Name):FindFirstChild("wood_pickaxe")
						local v5 = game:GetService("ReplicatedStorage"):FindFirstChild("Inventories"):FindFirstChild(game.Players.LocalPlayer.Name):FindFirstChild("wood_sword")
						local v6 = game.Players.LocalPlayer.Character;
						local v7 = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart");
						local bed
						for i2,v8 in pairs(workspace:GetChildren()) do
							if v8.Name == "bed" then
								if v8.Covers.BrickColor ~= game.Players.LocalPlayer.Team.TeamColor then
									game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = v8.CFrame
									task.wait(.1)
									game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = v8.CFrame
									task.wait(.1)
									game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = v8.CFrame + Vector3.new(0, 7, 0)
									game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = v8.CFrame + Vector3.new(0, 7, 0)
									game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = v8.CFrame + Vector3.new(0, 7, 0)
									local v9 = game.Players.LocalPlayer.Character;
									repeat task.wait() until v8 == nil or v8.Parent == nil
									bed = nil
								end
							end
						end
						repeat task.wait() until bed == nil
						for i3,v10 in pairs(game.Players:GetPlayers()) do
							if v10.Character and v10.Character:FindFirstChild("HumanoidRootPart") then
								if v10.Team ~= game.Players.LocalPlayer.Team then
									while v10 and v10.Character.Humanoid.Health > 0 and v10.Character.PrimaryPart do
										task.wait(.2)
										if game.Players.LocalPlayer.Character ~= nil and game.Players.LocalPlayer.Character:FindFirstChild'HumanoidRootPart' then game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v10.Character.HumanoidRootPart.CFrame end
										workspace.Gravity = 196.2
									end
								end
							end
						end
					end)
				else
					createwarning("30v30AutoWin", "Failed to enable: Please use it during pre-match or during respawn.", 11)
				end
				AutoWin30v30["ToggleButton"](false)
			end
		end
	})
	local DuelsAutoWin = {["Enabled"] = false}
	DuelsAutoWin = GuiLibrary["ObjectsThatCanBeSaved"]["BlatantWindow"]["Api"].CreateOptionsButton({
		["Name"] = "DuelsAutoWin",
		["Function"] = function(callback)
			if callback then
				if (matchState == 0 or lplr.Character:FindFirstChildOfClass("ForceField")) then
					spawn(function()
						createwarning("DuelsAutoWin", "Activated. Do not spam it", 11) 
						local v1 = game.Players.LocalPlayer.Character
						if matchState == 0 then repeat task.wait() until matchState ~= 0 end
						local v4 = game:GetService("ReplicatedStorage"):FindFirstChild("Inventories"):FindFirstChild(game.Players.LocalPlayer.Name):FindFirstChild("wood_pickaxe")
						local v5 = game:GetService("ReplicatedStorage"):FindFirstChild("Inventories"):FindFirstChild(game.Players.LocalPlayer.Name):FindFirstChild("wood_sword")
						local v6 = game.Players.LocalPlayer.Character;
						local v7 = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart");
						local bed
						for i2,v8 in pairs(workspace:GetChildren()) do
							if v8.Name == "bed" then
								if v8.Covers.BrickColor ~= game.Players.LocalPlayer.Team.TeamColor then
									game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = v8.CFrame
									task.wait(.1)
									game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = v8.CFrame
									task.wait(.1)
									game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = v8.CFrame + Vector3.new(0, 7, 0)
									game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = v8.CFrame + Vector3.new(0, 7, 0)
									game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = v8.CFrame + Vector3.new(0, 7, 0)
									local v9 = game.Players.LocalPlayer.Character;
									repeat task.wait() until v8 == nil or v8.Parent == nil
									bed = nil
								end
							end
						end
						repeat task.wait() until bed == nil
						for i3,v10 in pairs(game.Players:GetPlayers()) do
							if v10.Character and v10.Character:FindFirstChild("HumanoidRootPart") then
								if v10.Team ~= game.Players.LocalPlayer.Team then
									while v10 and v10.Character.Humanoid.Health > 0 and v10.Character.PrimaryPart do
										task.wait(.2)
										if game.Players.LocalPlayer.Character ~= nil and game.Players.LocalPlayer.Character:FindFirstChild'HumanoidRootPart' then game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v10.Character.HumanoidRootPart.CFrame end
										workspace.Gravity = 0
									end
								end
							end
						end
					end)
				else
					createwarning("DuelsAutoWin", "Failed to enable: Please use it during pre-match or during respawn.", 11)
				end
				DuelsAutoWin["ToggleButton"](false)
			end
		end
	})
end)


runcode(function()
	local InfJump = {["Enabled"] = false}
		InfJump = GuiLibrary["ObjectsThatCanBeSaved"]["WorldWindow"]["Api"].CreateOptionsButton({
		["Name"] = "InfJump",
		["Function"] = function(callback)
			if callback then
				local InfiniteJumpEnabled = true
				game:GetService("UserInputService").JumpRequest:connect(function()
					if InfiniteJumpEnabled then
						game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")
					end
				end)
			end
		end,
		["HoverText"] = "Jump lel"
	})
end)

--pistonware

runcode(function()
	local PurpleAntivoid = {["Enabled"] = false}
	PurpleAntivoid = GuiLibrary["ObjectsThatCanBeSaved"]["UtilityWindow"]["Api"].CreateOptionsButton({
			["Name"] = "Purple Antivoid",
			["HoverText"] = "Purple Antivoid",
			["Function"] = function(callback)
				if callback then
		local part = Instance.new("Part", Workspace)
				part.Name = "AntiVoid"
				part.Size = Vector3.new(2100, 0.5, 2000)
				part.Position = Vector3.new(160.5, 25, 247.5)
				part.Transparency = 0.4
				part.Anchored = true
			part.Color = Color3.fromRGB(111, 43, 150)
				else               
			game.Workspace.AntiVoid:Destroy()
				end
			end
		})
	end)

local PistonwareAmbience = {["Enabled"] = false}
PistonwareAmbience = GuiLibrary["ObjectsThatCanBeSaved"]["RenderWindow"]["Api"].CreateOptionsButton({
	["Name"] = "PistonwareAmbience",
	["Function"] = function(callback)
		if callback then
			local Lighting = game:GetService("Lighting")
Lighting.Ambient = Color3.fromRGB(111, 43, 150)
Lighting.ColorShift_Bottom = Color3.fromRGB(111, 43, 150)
Lighting.ColorShift_Top = Color3.fromRGB(111, 43, 150)
Lighting.OutdoorAmbient = Color3.fromRGB(111, 43, 150)
Lighting.ColorShift_Bottom = Color3.fromRGB(111, 43, 150)
Lighting.ColorShift_Top = Color3.fromRGB(111, 43, 150)

local s = Instance.new("Sky")
s.Name = "loltroll"
s.SkyboxBk = "http://www.roblox.com/asset/?id=1045964490"
s.SkyboxDn = "http://www.roblox.com/asset/?id=1045964368"
s.SkyboxFt = "http://www.roblox.com/asset/?id=1045964655"
s.SkyboxLf = "http://www.roblox.com/asset/?id=1045964655"
s.SkyboxRt = "http://www.roblox.com/asset/?id=1045964655"
s.SkyboxUp = "http://www.roblox.com/asset/?id=1045962969"
s.Parent = Lighting
			else
		createwarning("Ethone", "Join A New Match To Reset Skybox And Ambience.", 3)
		end
	end
})
runcode(function()
    local HeatseekerSpeed = {["Enabled"] = false}
    HeatseekerSpeed = GuiLibrary["ObjectsThatCanBeSaved"]["BlatantWindow"]["Api"].CreateOptionsButton({
        ["Name"] = "Heatseeker",
        ["HoverText"] = "Turn Off Vape Speed",
        ["Function"] = function(v)
	speedlol = v
        if speedlol then
	task.wait(2.4)
	spawn(function()           
	repeat
        if (not speedlol and not onground) then return end
	game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 20
        createwarning("Ethone", "boost", 10.7)
	game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 80
	task.wait(0.07)
	game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 20
	task.wait(1)
	game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 55
	task.wait(0.05)
	game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 20
	task.wait(10)
        until (not speedlol) 
            end)
        else
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 20
      	end
      end
    })
    end)

	local Chat = {["Enabled"] = false}
	Chat = GuiLibrary["ObjectsThatCanBeSaved"]["RenderWindow"]["Api"].CreateOptionsButton({
		["Name"] = "Chat",
		["HoverText"] = "Moves the Chat",
		["Function"] = function(callback)
			if callback then
				game:GetService("StarterGui"):SetCore('ChatWindowPosition', UDim2.new(0.0, 0, 0.0, 700))
				else
				game:GetService("StarterGui"):SetCore('ChatWindowPosition', UDim2.new(0.0, 0, 0.0, 0.0))
			end
		end
	})
	
	local KillFeed = {["Enabled"] = false}
	KillFeed = GuiLibrary["ObjectsThatCanBeSaved"]["RenderWindow"]["Api"].CreateOptionsButton({
		["Name"] = "KillFeed",
		["HoverText"] = "Destroys the KillFeed",
		["Function"] = function(callback)
			if callback then
				game:GetService("Players").LocalPlayer.PlayerGui.KillFeedGui.KillFeedContainer.Visible = false
				else
				game:GetService("Players").LocalPlayer.PlayerGui.KillFeedGui.KillFeedContainer.Visible = true
			end
		end
	})
	
	local HumanoidRootPart = {["Enabled"] = false}
	HumanoidRootPart = GuiLibrary["ObjectsThatCanBeSaved"]["UtilityWindow"]["Api"].CreateOptionsButton({
		["Name"] = "HumanoidRootPart",
		["HoverText"] = "Destroys your HumanoidRootPart",
		["Function"] = function(callback)
			if callback then
			repeat task.wait() until game:IsLoaded()
			repeat task.wait() until game:GetService("ReplicatedStorage"):FindFirstChild("Inventories"):FindFirstChild(game.Players.LocalPlayer.Name):FindFirstChild("wood_sword");
			local plr = game.Players.LocalPlayer
					local chr = plr.Character
					local hrp = chr.HumanoidRootPart
						hrp.Parent = nil
						   chr:MoveTo(chr:GetPivot().p)
								task.wait()
								hrp.Parent = chr
				else
				createwarning("Ethone", "Reset to disable", 3)
			end
		end
	})
	
	local CFrameHighJump = {["Enabled"] = false}
	CFrameHighJump = GuiLibrary["ObjectsThatCanBeSaved"]["BlatantWindow"]["Api"].CreateOptionsButton({
		["Name"] = "CFrameHighJump",
		["HoverText"] = "DISABLE GRAVITY",
		["Function"] = function(v)
		verticalflylol = v
		if verticalflylol then
		Workspace.Gravity = 0
		lplr.Character.HumanoidRootPart.CFrame = lplr.Character.HumanoidRootPart.CFrame + Vector3.new(0, -2, 0)
		spawn(function()
					repeat
		if (not verticalflylol) then return end
		Workspace.Gravity = 0
		lplr.Character.HumanoidRootPart.CFrame = lplr.Character.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0)
		task.wait(0.05)
		lplr.Character.HumanoidRootPart.CFrame = lplr.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
		until (not verticalflylol) 
			end)	
		else
		Workspace.Gravity = 196.2
		end
		end
	})
	
	runcode(function()
	local TestFly = {["Enabled"] = false}
	TestFly = GuiLibrary["ObjectsThatCanBeSaved"]["BlatantWindow"]["Api"].CreateOptionsButton({
		["Name"] = "TestFly",
		["HoverText"] = "Test Fly",
		["Function"] = function(v)
		bounceflylol = v
		if bounceflylol then
			trol = Instance.new("BodyVelocity")
				trol.MaxForce = Vector3.new(0, math.huge, 0)
				trol.Parent = lplr.Character.HumanoidRootPart
				trol.Velocity = Vector3.new(0, 0 ,0)
		spawn(function()
					repeat
		if (not bounceflylol) then return end
		lplr.Character.HumanoidRootPart.CFrame = lplr.Character.HumanoidRootPart.CFrame + Vector3.new(0, 6.5, 0)
		task.wait(0.2)
		lplr.Character.HumanoidRootPart.CFrame = lplr.Character.HumanoidRootPart.CFrame + Vector3.new(0, -5, 0)
		until (not bounceflylol) 
			end)	
		else
		trol:Destroy()
		end
		end
	})
	end)
	
	runcode(function()
	local NameHider = {["Enabled"] = true}
	NameHider = GuiLibrary["ObjectsThatCanBeSaved"]["UtilityWindow"]["Api"].CreateOptionsButton({
		["Name"] = "NameHider",
		["HoverText"] = "Disable TargetHud",
		["Function"] = function(callback)
			if callback then
			repeat task.wait() until game:IsLoaded()
	
	local fakeplr = {["Name"] = "0prime", ["UserId"] = "239702688"}
	local otherfakeplayers = {["Name"] = "0prime", ["UserId"] = "1"}
	local lplr = game:GetService("Players").LocalPlayer
	
	local function plrthing(obj, property)
		for i,v in pairs(game:GetService("Players"):GetChildren()) do
			if v ~= lplr then
				obj[property] = obj[property]:gsub(v.Name, otherfakeplayers["Name"])
				obj[property] = obj[property]:gsub(v.DisplayName, otherfakeplayers["Name"])
				obj[property] = obj[property]:gsub(v.UserId, otherfakeplayers["UserId"])
			else
				obj[property] = obj[property]:gsub(v.Name, fakeplr["Name"])
				obj[property] = obj[property]:gsub(v.DisplayName, fakeplr["Name"])
				obj[property] = obj[property]:gsub(v.UserId, fakeplr["UserId"])
			end
		end
	end
	
	local function newobj(v)
		if v:IsA("TextLabel") or v:IsA("TextButton") then
			plrthing(v, "Text")
			v:GetPropertyChangedSignal("Text"):connect(function()
				plrthing(v, "Text")
			end)
		end
		if v:IsA("ImageLabel") then
			plrthing(v, "Image")
			v:GetPropertyChangedSignal("Image"):connect(function()
				plrthing(v, "Image")
			end)
		end
	end
	
	for i,v in pairs(game:GetDescendants()) do
		newobj(v)
	end
	game.DescendantAdded:connect(newobj)
		else
				createwarning("Pistonware", "Join A New Match To Reset Your Name And Other Names.", 3)
			end
		end
	})
	end)
	
	runcode(function()
	local PistonwareLongJump = {["Enabled"] = false}
	PistonwareLongJump = GuiLibrary["ObjectsThatCanBeSaved"]["UtilityWindow"]["Api"].CreateOptionsButton({
		["Name"] = "Old LongJump",
		["HoverText"] = "LongJump Before Vape Christmas Update",
		["Function"] = function(callback)
			if callback then
			Workspace.Gravity = 10
			lplr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
			lplr.Character.HumanoidRootPart.CFrame = lplr.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
				else
				Workspace.Gravity = 196.2
			end
		end
	})
	end)

-- BedTP
local BedTP = {["Enabled"] = false}
BedTP = GuiLibrary["ObjectsThatCanBeSaved"]["UtilityWindow"]["Api"].CreateOptionsButton({
	["Name"] = "BedTP",
	["HoverText"] = "TPs To The Nearest Bed",
	["Function"] = function(callback)
		if callback then
			if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
				local ClosestBedMag = math.huge
				local ClosestBed = false
				local lplr = game.Players.LocalPlayer
				function GetNearestBedToPosition()
					for i,v in pairs(game.Workspace:GetChildren()) do
						if v.Name == "bed" and v:FindFirstChild("Covers") and v.Covers.BrickColor ~= game.Players.LocalPlayer.Team.TeamColor then
							if (lplr.Character.HumanoidRootPart.Position - v.Position).Magnitude < ClosestBedMag then
								ClosestBedMag = (lplr.Character.HumanoidRootPart.Position - v.Position).Magnitude
								ClosestBed = v
							end
						end
					end
					return ClosestBed
				end
				local real = GetNearestBedToPosition().Position
				game.Players.LocalPlayer.Character.PrimaryPart.CFrame = CFrame.new(real) + Vector3.new(0,5,0)
				BedTP["ToggleButton"](false)
			else
				BedTP["ToggleButton"](false)
			end
		end
	end
})

-- Explosion Exploit
local ExplosionExploit = {["Enabled"] = false}
ExplosionExploit = GuiLibrary["ObjectsThatCanBeSaved"]["BlatantWindow"]["Api"].CreateOptionsButton({
		["Name"] = "ExplosionExploit",
		["HoverText"] = "Enable When a TNT Explodes Near You (Use For 0.01 Seconds, Doesn't Work With Speed)",
		["Function"] = function(callback)
			if callback then
				getgenv().WalkSpeedValue = 90;
				local Player = game:service'Players'.LocalPlayer;
				Player.Character.Humanoid:GetPropertyChangedSignal'WalkSpeed':Connect(function()
				Player.Character.Humanoid.WalkSpeed = getgenv().WalkSpeedValue;
				end)
				Player.Character.Humanoid.WalkSpeed = getgenv().WalkSpeedValue;
			else
				getgenv().WalkSpeedValue = 20;
				local Player = game:service'Players'.LocalPlayer;
				Player.Character.Humanoid:GetPropertyChangedSignal'WalkSpeed':Connect(function()
				Player.Character.Humanoid.WalkSpeed = getgenv().WalkSpeedValue;
				end)
				Player.Character.Humanoid.WalkSpeed = getgenv().WalkSpeedValue;
			end
		end 
    })

-- ClickTP
runcode(function()
    local ClickTP = {["Enabled"] = false}
        local ClickTP = {["Enabled"] = false}
        local ClickTPMethod = {["Value"] = "Normal"}
        local ClickTPDelay = {["Value"] = 1}
        local ClickTPAmount = {["Value"] = 1}
        local ClickTPVertical = {["Enabled"] = true}
        local ClickTPVelocity = {["Enabled"] = false}
        ClickTP = GuiLibrary["ObjectsThatCanBeSaved"]["BlatantWindow"]["Api"].CreateOptionsButton({
            ["Name"] = "MouseTP", 
            ["Function"] = function(callback) 
                if callback then
                    createwarning("MouseTP", "Successfully TP", 1)
                    RunLoops:BindToHeartbeat("MouseTP", 1, function()
                        if entity.isAlive and ClickTPVelocity["Enabled"] and ClickTPMethod["Value"] == "SlowTP" then 
                            entity.character.HumanoidRootPart.Velocity = Vector3.new()
                        end
                    end)
                    if entity.isAlive then 
                        local rayparams = RaycastParams.new()
                        rayparams.FilterDescendantsInstances = {lplr.Character, cam}
                        rayparams.FilterType = Enum.RaycastFilterType.Blacklist
                        local ray = workspace:Raycast(cam.CFrame.p, lplr:GetMouse().UnitRay.Direction * 10000, rayparams)
                        local selectedpos = ray and ray.Position + Vector3.new(0, 2, 0)
                        if selectedpos then 
                            if ClickTPMethod["Value"] == "Normal" then
                                entity.character.HumanoidRootPart.CFrame = CFrame.new(selectedpos)
                                ClickTP["ToggleButton"](false)
                            else
                                spawn(function()
                                    repeat
                                        if entity.isAlive then 
                                            local newpos = (selectedpos - entity.character.HumanoidRootPart.CFrame.p).Unit
                                            newpos = newpos == newpos and newpos * (math.clamp((entity.character.HumanoidRootPart.CFrame.p - selectedpos).magnitude, 0, ClickTPAmount["Value"])) or Vector3.new()
                                            entity.character.HumanoidRootPart.CFrame = entity.character.HumanoidRootPart.CFrame + Vector3.new(newpos.X, (ClickTPVertical["Enabled"] and newpos.Y or 0), newpos.Z)
                                            entity.character.HumanoidRootPart.Velocity = Vector3.new()
                                            if (entity.character.HumanoidRootPart.CFrame.p - selectedpos).magnitude <= 5 then 
                                                break
                                            end
                                        end
                                        task.wait(ClickTPDelay["Value"] / 100)
                                    until entity.isAlive and (entity.character.HumanoidRootPart.CFrame.p - selectedpos).magnitude <= 5 or (not ClickTP["Enabled"])
                                    if ClickTP["Enabled"] then 
                                        ClickTP["ToggleButton"](false)
                                    end
                                end)
                            end
                        else
                            ClickTP["ToggleButton"](false)
                            createwarning("ClickTP", "No Position Found", 1)
                        end
                    else
                        if ClickTP["Enabled"] then 
                            ClickTP["ToggleButton"](false)
                        end
                    end
                else
                    RunLoops:UnbindFromHeartbeat("MouseTP")
                end
            end, 
            ["HoverText"] = "Teleports To Where Your Mouse is"
        })
        ClickTPMethod = ClickTP.CreateDropdown({
            ["Name"] = "Method",
            ["List"] = {"Normal", "SlowTP"},
            ["Function"] = function(val)
                if ClickTPAmount["Object"] then
                    ClickTPAmount["Object"].Visible = val == "SlowTP"
                end
                if ClickTPDelay["Object"] then
                    ClickTPDelay["Object"].Visible = val == "SlowTP"
                end
                if ClickTPVertical["Object"] then 
                    ClickTPVertical["Object"].Visible = val == "SlowTP"
                end
                if ClickTPVelocity["Object"] then 
                    ClickTPVelocity["Object"].Visible = val == "SlowTP"
                end
            end
        })
        ClickTPAmount = ClickTP.CreateSlider({
            ["Name"] = "Amount",
            ["Min"] = 1,
            ["Max"] = 50,
            ["Function"] = function() end
        })
        ClickTPAmount["Object"].Visible = false
        ClickTPDelay = ClickTP.CreateSlider({
            ["Name"] = "Delay",
            ["Min"] = 1,
            ["Max"] = 50,
            ["Function"] = function() end
        })
        ClickTPDelay["Object"].Visible = false
        ClickTPVertical = ClickTP.CreateToggle({
            ["Name"] = "Vertical",
            ["Default"] = true,
            ["Function"] = function() end
        })
        ClickTPVertical["Object"].Visible = false
        ClickTPVelocity = ClickTP.CreateToggle({
            ["Name"] = "No Velocity",
            ["Default"] = true,
            ["Function"] = function() end
        })
        ClickTPVelocity["Object"].Visible = false
    end)

	local VClip = {["Enabled"] = false}
	VClip = GuiLibrary["ObjectsThatCanBeSaved"]["BlatantWindow"]["Api"].CreateOptionsButton({
		["Name"] = "VClip",
		["HoverText"] = false,
		["Function"] = function(callback)
			if callback then
				VClip["ToggleButton"](false)
				local x = game.Players.LocalPlayer.Character.HumanoidRootPart.Position.x
				local y = game.Players.LocalPlayer.Character.HumanoidRootPart.Position.y 
				local z = game.Players.LocalPlayer.Character.HumanoidRootPart.Position.z
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(x,y-10,z)
				createwarning("VClip", "Success", 1)
				Vclip["ToggleButton"](false)
			end
		end
	})

	-- Infinite Yield
	runcode(function()
		local InfiniteYield = {["Enabled"] = false}
		InfiniteYield = GuiLibrary["ObjectsThatCanBeSaved"]["UtilityWindow"]["Api"].CreateOptionsButton({
			["Name"] = "Infinite Yield",
			["HoverText"] = "Loads Infinite Yield",
			["Function"] = function(callback)
				if callback then
					InfiniteYield["ToggleButton"](false)
					if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
						loadstring(game:HttpGet(('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'),true))()
						createwarning("Skid-Ware Private", "Loaded Infinite Yield", 2)
					else
					end
				end
			end
		})
	end)

--GOOD FOR AUTOWIN
-- AntiAFK
runcode(function()
	local AntiAFK = {["Enabled"] = false}
    AntiAFK = GuiLibrary["ObjectsThatCanBeSaved"]["UtilityWindow"]["Api"].CreateOptionsButton({
        ["Name"] = "AntiAFK",
		["HoverText"] = "Prevents from being kicked when afk",
        ["Function"] = function(callback)
            if callback then
				getgenv().AntiAFK = true;
				if getgenv().AntiAFK == true then
					repeat
						wait()
					until game:GetService("Players")
					
					repeat
						wait()
					until game:GetService("Players").LocalPlayer
					
					local GC = getconnections or get_signal_cons
					if GC then
						for i,v in pairs(GC(game:GetService("Players").LocalPlayer.Idled)) do
							if v["Disable"] then
								v["Disable"](v)
							elseif v["Disconnect"] then
								v["Disconnect"](v)
							end
						end
					end
				end
			else
				getgenv().AntiAFK = false;
			end
		end
	})
end)


--grass private
--no logger LMAO
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local yes = Players.LocalPlayer.Name
local ChatTag = {}
ChatTag[yes] =
	{
        TagText = "Ethone User",
        TagColor = Color3.new(13, 105, 172),
    }



    local oldchanneltab
    local oldchannelfunc
    local oldchanneltabs = {}

--// Chat Listener
for i, v in pairs(getconnections(ReplicatedStorage.DefaultChatSystemChatEvents.OnNewMessage.OnClientEvent)) do
	if
		v.Function
		and #debug.getupvalues(v.Function) > 0
		and type(debug.getupvalues(v.Function)[1]) == "table"
		and getmetatable(debug.getupvalues(v.Function)[1])
		and getmetatable(debug.getupvalues(v.Function)[1]).GetChannel
	then
		oldchanneltab = getmetatable(debug.getupvalues(v.Function)[1])
		oldchannelfunc = getmetatable(debug.getupvalues(v.Function)[1]).GetChannel
		getmetatable(debug.getupvalues(v.Function)[1]).GetChannel = function(Self, Name)
			local tab = oldchannelfunc(Self, Name)
			if tab and tab.AddMessageToChannel then
				local addmessage = tab.AddMessageToChannel
				if oldchanneltabs[tab] == nil then
					oldchanneltabs[tab] = tab.AddMessageToChannel
				end
				tab.AddMessageToChannel = function(Self2, MessageData)
					if MessageData.FromSpeaker and Players[MessageData.FromSpeaker] then
						if ChatTag[Players[MessageData.FromSpeaker].Name] then
							MessageData.ExtraData = {
								NameColor = Players[MessageData.FromSpeaker].Team == nil and Color3.new(135,206,235)
									or Players[MessageData.FromSpeaker].TeamColor.Color,
								Tags = {
									table.unpack(MessageData.ExtraData.Tags),
									{
										TagColor = ChatTag[Players[MessageData.FromSpeaker].Name].TagColor,
										TagText = ChatTag[Players[MessageData.FromSpeaker].Name].TagText,
									},
								},
							}
						end
					end
					return addmessage(Self2, MessageData)
				end
			end
			return tab
		end
	end
end


runcode(function()
	local anticheat222 = {["Enabled"] = false}
	anticheat222 = GuiLibrary["ObjectsThatCanBeSaved"]["UtilityWindow"]["Api"].CreateOptionsButton({
		["Name"] = "/DIE",
		["HoverText"] = "/die real command",
		["Function"] = function(callback)
			if callback then
				wait(0.001)
				local x = game.Players.LocalPlayer.Character.HumanoidRootPart.Position.x
local y = game.Players.LocalPlayer.Character.HumanoidRootPart.Position.y 
local z = game.Players.LocalPlayer.Character.HumanoidRootPart.Position.z
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(x,y-10,z)
			else
				print ("rip lol")
			end
		end 
	})
end)

	
	local hrp = game.Players.LocalPlayer.Character.HumanoidRootPart	
	


	local lplr = game:GetService("Players").LocalPlayer
local KnitClient = debug.getupvalue(require(lplr.PlayerScripts.TS.knit).setup, 6)
local Client = require(game:GetService("ReplicatedStorage").TS.remotes).default.Client


local notifications = {["Enabled"] = false}

Client:WaitFor("BedwarsBedBreak"):andThen(function(p13)
	p13:Connect(function(p14)
		if notifications["Enabled"] then
			local team = p14.brokenBedTeam.displayName
			if team == lplr.Team.Name then
				createwarning("Bed broken!", "Your bed got broken LOL", 7)
			end
		end
	end)
end)


Client:WaitFor("BedwarsBedBreak"):andThen(function(p13)
	p13:Connect(function(p14)
		if notifications["Enabled"] then
			if p14.player.Name == lplr.Name then
				createwarning("Broken bed!", "you broke a bed", 7)
			end
		end
	end)
end)

Client:WaitFor("EntityDeathEvent"):andThen(function(p13)
	p13:Connect(function(p14)
		if notifications["Enabled"] then
			if p14.player.Name == lplr.Name then
				createwarning("LOL!", "oof lol", 7)
			end
		end
	end)
end)



Client:WaitFor("EntityDeathEvent"):andThen(function(p6)
	p6:Connect(function(p7)
		if notifications["Enabled"] then
			if p7.fromEntity and p7.fromEntity == lplr.Character then
				local plr = players:GetPlayerFromCharacter(p7.entityInstance)
				createwarning("you killed", plr.Name.."ez", 7)
			end
		end
	end)
end)

local notifications = GuiLibrary["ObjectsThatCanBeSaved"]["RenderWindow"]["Api"].CreateOptionsButton({
	["Name"] = "Notifications",
	["Function"]= function(callback) notifications["Enabled"] = callback end,
	["HoverText"] = "Sends you a notification when certain actions happen (bed brake,kill,ect)"
})

local theyessirYE = {["Enabled"] = false}
    theyessirYE = GuiLibrary["ObjectsThatCanBeSaved"]["WorldWindow"]["Api"].CreateOptionsButton({
        ["Name"] = "get ems",
        ["HoverText"] = "make take a few times",
            ["Function"] = function(callback)
                if callback then
                      spawn(function()
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").ItemDrops.emerald.CFrame
                end)
            end
        end
    })

local theyessirYE = {["Enabled"] = false}
    theyessirYE = GuiLibrary["ObjectsThatCanBeSaved"]["WorldWindow"]["Api"].CreateOptionsButton({
        ["Name"] = "get dims",
        ["HoverText"] = "make take a few times",
            ["Function"] = function(callback)
                if callback then
                      spawn(function()
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").ItemDrops.diamond.CFrame
                end)
            end
        end
    })


--couldn't skid ALL of my grass cuz config issue
inffly = {["Enabled"] = false}
local testing
local partthingy
inffly = GuiLibrary["ObjectsThatCanBeSaved"]["BlatantWindow"]["Api"].CreateOptionsButton({
	["Name"] = "azura fly",
	["Function"] = function(callback)
		if callback then
			lplr.Character.Archivable = true
			local clonethingy = lplr.Character:Clone()
			clonethingy.Name = "clonethingy"
			clonethingy:FindFirstChild("HumanoidRootPart").Transparency = 1
			clonethingy.Parent = workspace
			 workspace.Camera.CameraSubject = clonethingy.Humanoid
			partthingy = Instance.new("Part",workspace)
			partthingy.Size = Vector3.new(2048,1,2048)
			partthingy.CFrame = clonethingy.HumanoidRootPart.CFrame * CFrame.new(0,-4,0)
			partthingy.Anchored = true
			partthingy.Transparency = 1
			partthingy.Name = "partthingy"
			RunLoops:BindToHeartbeat("BoostSilentFly", 1, function(delta)
				clonethingy.HumanoidRootPart.CFrame = CFrame.new(entity.character.HumanoidRootPart.CFrame.X,clonethingy.HumanoidRootPart.CFrame.Y,entity.character.HumanoidRootPart.CFrame.Z)
				clonethingy.HumanoidRootPart.Rotation = entity.character.HumanoidRootPart.Rotation
			end)
			repeat
				task.wait(0.001)
				if inffly["Enabled"] == false then break end
				clonethingy.HumanoidRootPart.CFrame = CFrame.new(entity.character.HumanoidRootPart.CFrame.X,clonethingy.HumanoidRootPart.CFrame.Y,entity.character.HumanoidRootPart.CFrame.Z)
			until testing == true
					local starty
			local starttick = tick()
			task.spawn(function()
				local timesdone = 0
				if GuiLibrary["ObjectsThatCanBeSaved"]["SpeedModeDropdown"]["Api"]["Value"] == "CFrame" then
					local doboost = true
					repeat
						timesdone = timesdone + 1
						if entity.isAlive then
							local root = entity.character.HumanoidRootPart
							if starty == nil then 
								starty = root.Position.Y
							end
							if not bodyvelo then 
								bodyvelo = Instance.new("BodyVelocity")
								bodyvelo.MaxForce = vec3(0, 1000000, 0)
								bodyvelo.Parent = root
								bodyvelo.Velocity = Vector3.zero
							else
								bodyvelo.Parent = root
							end
							for i = 1, 15 do 
								task.wait(0.01)
								if (not inffly["Enabled"]) then break end
								bodyvelo.Velocity = vec3(0, i * (infflyhigh["Enabled"] and 2 or 1), 0)
							end
							if (not isnetworkowner(root)) then
								break 
							end
						else
							break
						end
					until (not inffly["Enabled"])
				else
					local warning = createwarning("inffly", "inffly is very cool", 5)
					pcall(function()
						warning:GetChildren()[5].Position = UDim2.new(0, 46, 0, 38)
					end)
				end
				if inffly["Enabled"] then 
					inffly["ToggleButton"](false)
				end
			end)
		else
			if workspace:FindFirstChild("clonethingy") or workspace:FindFirstChild("partthingy") then
				workspace:FindFirstChild("clonethingy"):Destroy()
				workspace:FindFirstChild("partthingy"):Destroy()
				RunLoops:UnbindFromHeartbeat("BoostSilentFly")
				testing = true
				workspace.Camera.CameraSubject = lplr.Character.Humanoid
			end
			if bodyvelo then 
				bodyvelo:Destroy()
				bodyvelo = nil
			end
		end
	end
})
infflyhigh = inffly.CreateToggle({
	["Name"] = "High",
	["Function"] = function() end
})

youtubedetector = GuiLibrary["ObjectsThatCanBeSaved"]["UtilityWindow"]["Api"].CreateOptionsButton({
	["Name"] = "Youtube detector/star detector", 
	["Function"] = function(callback)
		if callback then
			for i, plr in pairs(players:GetChildren()) do
				if plr:IsInGroup(4199740) and plr:GetRankInGroup(4199740) >= 1 then
					createwarning("Vape", "Youtuber found " .. plr.Name .. "(" .. plr.DisplayName .. ")", 20)
					end
				end
			end
		end
})

--boat config
runcode(function()
	local randomBed = {['Enabled'] = false}
	randomBed = GuiLibrary["ObjectsThatCanBeSaved"]["UtilityWindow"]["Api"].CreateOptionsButton({
		Name = 'TeleportRandomBed';
		Function = function(callback)
			if callback then
				for i,v in pairs(game:GetService('Workspace'):GetChildren()) do
					if v.Name == 'bed' and (v:FindFirstChild("Covers").BrickColor ~= lPlayer.TeamColor) then
						for i=1,5 do
							wait(0.1)
							lPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = v.Covers.CFrame * CFrame.new(1,3,-2)
						end
						break
					end
				end
				randomBed['ToggleButton'](false)
			end
		end
	})
	end)
	-- not doing vape entity bc confusing to me 
	function GetClosest()
		local plr = nil
		local radius = 21;
		for i,v in pairs(game:GetService("Players"):GetPlayers()) do
			if v ~= lPlayer and isAliveOld(v) then
				local Magnitude = (lPlayer.Character:FindFirstChild("HumanoidRootPart").Position - v.Character:FindFirstChild("HumanoidRootPart").Position).Magnitude
				if radius >= Magnitude then
					plr = v;
					break
				end
			end
		end
		return plr
	end
	runcode(function()
	local Closest
		local TPClosestPlayer = {['Enabled'] = false}
		TPClosestPlayer = GuiLibrary["ObjectsThatCanBeSaved"]["UtilityWindow"]["Api"].CreateOptionsButton({
			Name = 'TPClosestPlayer';
			Function = function(callback)
				if callback then
					Closest = GetClosest()
					if Closest ~= nil then 
					lPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = Closest.Character.HumanoidRootPart.CFrame * CFrame.new(0,3,0);
					createwarning('Boat Config', 'waiting 5 seconds for cooldown to not lagback',5)
					wait(5)
					Closest = nil
					TPClosestPlayer['ToggleButton'](false)
				else
						createwarning('No Player Found', 'No Player was found close to you!', 5)
				end
			end
		end
		})
	end)
	
	runcode(function()
		local StudsAmt = {['Value'] = 5};
		local ForwardStuds = {['Enabled'] = false}
		ForwardStuds = GuiLibrary["ObjectsThatCanBeSaved"]["BlatantWindow"]["Api"].CreateOptionsButton({
			Name = 'StudForwardTP';
			HoverText = 'Teleports you forward amout of studs, useful for catching up with yuzi kit users and pearlers';
			Function = function(callback)
				if callback then
					lPlayer.Character.HumanoidRootPart.CFrame = lPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,3,-StudsAmt.Value)
					task.wait(1)
					if isLagbacking() then
					createwarning("Stud Teleporter", 'Successfully teleported '..tostring(StudsAmt.Value)..'Studs!', 5)
					else
						createwarning('Stud Teleporter', 'Teleport Fail. Lagback Detected So TP Failed!', 5)
					end
					ForwardStuds['ToggleButton'](false)
				end
			end
		})
	
		StudsAmt = ForwardStuds.CreateSlider({
			["Name"] = "Stud Amount",
			["Min"] = 1,
			["Max"] = 17, 
			["Function"] = function(val) end,
			["Default"] = 5
		})
	end)

--heee
--OFFICAL APE SRC CODE
--purple Skybox
  local skybox11 = {["Enabled"] = false}
  skybox11 = GuiLibrary["ObjectsThatCanBeSaved"]["RenderWindow"]["Api"].CreateOptionsButton({
      ["Name"] = "PurpleSkybox",
      ["Function"] = function(callback)
          if callback then
              local sky = Instance.new("Sky",game.Lighting)
              sky.MoonAngularSize = "0"
              sky.MoonTextureId = "rbxassetid://6444320592"
              sky.SkyboxBk = "rbxassetid://8107841671"
              sky.SkyboxDn = "rbxassetid://6444884785"
              sky.SkyboxFt = "rbxassetid://8107841671"
              sky.SkyboxLf = "rbxassetid://8107841671"
              sky.SkyboxRt = "rbxassetid://8107841671"
              sky.SkyboxUp = "rbxassetid://8107849791"
              sky.SunTextureId = "rbxassetid://6196665106"

          else
              local sky2 = Instance.new("Sky",game.Lighting)
              sky2.MoonAngularSize = "11"
              sky2.MoonTextureId = "rbxasset://sky/moon.jpg"
              sky2.SkyboxBk = "rbxassetid://7018684000"
              sky2.SkyboxDn = "rbxassetid://6334928194"
              sky2.SkyboxFt = "rbxassetid://7018684000"
              sky2.SkyboxLf = "rbxassetid://7018684000"
              sky2.SkyboxRt = "rbxassetid://7018684000"
              sky2.SkyboxUp = "rbxassetid://7018689553"
              sky2.SunTextureId = "rbxasset://sky/sun.jpg"
              sky2.SunAngularSize = "21"
          end
      end
  })

      --purple Ambience
  local Ambience1 = {["Enabled"] = false}
  Ambience1 = GuiLibrary["ObjectsThatCanBeSaved"]["RenderWindow"]["Api"].CreateOptionsButton({
      ["Name"] = "PurpleAmbience",
      ["Function"] = function(callback)
          if callback then
              game.Lighting.ColorCorrection.TintColor = Color3.fromRGB(170, 170, 255)
              game.Lighting.Ambient = Color3.fromRGB(170, 170, 255)
              game.Lighting.OutdoorAmbient = Color3.fromRGB(170, 170, 255)
          else
              game.Lighting.ColorCorrection.TintColor = Color3.fromRGB(255, 255, 255)
              game.Lighting.Ambient = Color3.fromRGB(255, 255, 255)
              game.Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
          end
      end
  })


      --Blue Ambience
  local Ambience12 = {["Enabled"] = false}
  Ambience12 = GuiLibrary["ObjectsThatCanBeSaved"]["RenderWindow"]["Api"].CreateOptionsButton({
      ["Name"] = "BlueAmbience",
      ["Function"] = function(callback)
          if callback then
              game.Lighting.ColorCorrection.TintColor = Color3.fromRGB(0, 247, 255)
              game.Lighting.Ambient = Color3.fromRGB(255, 60, 255)
              game.Lighting.OutdoorAmbient = Color3.fromRGB(255, 60, 255)
          else
              game.Lighting.ColorCorrection.TintColor = Color3.fromRGB(255, 255, 255)
              game.Lighting.Ambient = Color3.fromRGB(255, 255, 255)
              game.Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
          end
      end
  })

--Bhop
local Bhop = {["Enabled"] = false}
Bhop = GuiLibrary["ObjectsThatCanBeSaved"]["BlatantWindow"]["Api"].CreateOptionsButton({
	["Name"] = "Bhop",
	["Function"] = function(callback)
		if callback then
			getgenv().bhop = true;
			while wait(DEL) do
				if getgenv().bhop == true then
					game.Players.LocalPlayer.Character.Humanoid.Jump = true
				end
			end
		else
			getgenv().bhop = false;
		end
	end
})


DEL = Bhop.CreateSlider({
	["Name"] = "Delay",
	["Min"] = 0,
	["Max"] = 10,
	["Default"] = 2,
	["Function"] = function(val)
		DEL = val
	 end
})



runcode(function()
	local HighJump2 = {["Enabled"] = false}
	HighJump2 = GuiLibrary["ObjectsThatCanBeSaved"]["BlatantWindow"]["Api"].CreateOptionsButton({
		["Name"] = "TeleportHighJump",
		["Function"] = function(callback)
			if callback then
				if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
					local xPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position.x
					local yPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position.y 
					local zPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position.z
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(xPos,yPos+Ammounty,zPos)
					createwarning("HighJump", "Worked ;)", 10)
					HighJump2["ToggleButton"](false)
				else
					createwarning("HighJump", "Failed ;(", 10)
					HighJump2["ToggleButton"](false)
				end
			end
		end
	})
  
	Ammounty = HighJump2.CreateSlider({
		["Name"] = "Amount",
		["Min"] = 10,
		["Max"] = 25,
		["Default"] = 20,
		["Function"] = function(val)
			Ammounty = val
		 end
	})
  end)

--CODE HT76
runcode(function()
	local FastFly = {["Enabled"] = false}
	FastFly = GuiLibrary["ObjectsThatCanBeSaved"]["BlatantWindow"]["Api"].CreateOptionsButton({
		["Name"] = "DownwardsFly",
		["HoverText"] = "Remake Of PingFly :)",
		["Function"] = function(callback)
			if callback then
				if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
					bedwars["SoundManager"]:playSound(bedwars["SoundList"]["DAMAGE_"..math.random(1, 3)])
					Game.workspace.Gravity = sexyCorrade
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame + game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector *TPSDELAYS
					game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = FastFlySpeed
					wait(0.4)
					game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
					wait(1.0)
					game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = FastFlySpeed
					wait(0.3)
					game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
					wait(0.4)
					Game.workspace.Gravity = 192.6
					FastFly["ToggleButton"](false)
				else
					FastFly["ToggleButton"](false)
				end
			end
		end
	})
  
	FastFlySpeed = FastFly.CreateSlider({
		["Name"] = "Speed",
		["Min"] = 25,
		["Max"] = 30,
		["Default"] = 30,
		["Function"] = function(val)
			FastFlySpeed = val
		 end
	})
  
	sexyCorrade = FastFly.CreateSlider({
		["Name"] = "Gravity",
		["Min"] = 1,
		["Max"] = 5,
		["Default"] = 1,
		["Function"] = function(val)
			sexyCorrade = val
		 end
	})
  
  
	TPSDELAYS = FastFly.CreateSlider({
		["Name"] = "TpsAmmount",
		["Min"] = 0,
		["Max"] = 1,
		["Default"] = 1,
		["Function"] = function(val)
			TPSDELAYS = val
		 end
	})
  
  end)
  

  runcode(function()
	local GravityFly = {["Enabled"] = true}
	GravityFly = GuiLibrary["ObjectsThatCanBeSaved"]["BlatantWindow"]["Api"].CreateOptionsButton({
		["Name"] = "GravityFly",
		["HoverText"] = "Lets you fly",
		["Function"] = function(callback)
			if callback then
				game.workspace.Gravity = 50
				game.Players.LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
				wait(GravityFlyTime)
				game.workspace.Gravity = GravityFlyPart
			else
				game.workspace.Gravity = 192.6
			end
		end
	})
	GravityFlyTime = GravityFly.CreateSlider({
		["Name"] = "Delay",
		["Min"] = 0.5,
		["Max"] = 1,
		["Default"] = 1,
		["Function"] = function(val)
			GravityFlyTime = val
		end
	})
	GravityFlyPart = GravityFly.CreateSlider({
		["Name"] = "Gravity",
		["Min"] = 5,
		["Max"] = 10,
		["Default"] = 5,
		["Function"] = function(val)
			GravityFlyPart = val
		end
	})
  end)
  game.Players.LocalPlayer.character.HumanoidRootPart.Velocity = game.Players.LocalPlayer.character.HumanoidRootPart.Velocity + Vector3.new(0,35,0)
  --end of code HT76

  local plr1 = game.Players.LocalPlayer
createwarning("Ethone", "Logged in as "..(plr1.Name or plr1.DisplayName), 3)
createwarning("Ethone ", "Thank You For Using Ethone", 3)


--more ape
--L bozo xv
runcode(function()
	local TPMiddle = {["Enabled"] = false}
	TPMiddle = GuiLibrary["ObjectsThatCanBeSaved"]["UtilityWindow"]["Api"].CreateOptionsButton({
		["Name"] = "SkywarsMiddle",
		["HoverText"] = "Teleports You To The Middle In Skywars (no game check )",
		["Function"] = function(callback)
			if callback then
				local TPMiddleCONNECT = game:GetService("ReplicatedStorage").rbxts_include.node_modules["@rbxts"].net.out._NetManaged.MatchStateEvent.OnClientEvent:Connect(function()
					game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = game:GetService("Workspace").SpectatorPlatform:FindFirstChild("floor").CFrame - Vector3.new(0,15,0)
					task.wait(.2)
					game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = game:GetService("Workspace").SpectatorPlatform:FindFirstChild("floor").CFrame - Vector3.new(0,15,0)
				end)
			else
				TPMiddleCONNECT:Disconnect()
			end
		end
	})

end)

runcode(function()
	local AutoRape = {["Enabled"] = false}
	AutoRape = GuiLibrary["ObjectsThatCanBeSaved"]["UtilityWindow"]["Api"].CreateOptionsButton({
		["Name"] = "AutoRape",
		["HoverText"] = "Rapes Other Player",
		["Function"] = function(callback)
			if callback then
				if entity.isAlive then
					RunLoops:BindToHeartbeat("AutoRap", 1, function()
						local plrsraper = GetAllNearestHumanoidToPosition(true, AutoRapeDist, 1000, true)
						for i,plr in pairs(plrsraper) do
							if plr ~= game:GetService("Players").LocalPlayer then 
								spawn(function()
									if plr ~= nil and plr.Character then
										game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = plr.Character:FindFirstChild("HumanoidRootPart").CFrame
									end
								end)
							end
						end
					end)
				end
			else
				RunLoops:UnbindFromHeartbeat("AutoRap")
			end
		end
	})

	AutoRapeDist = AutoRape.CreateSlider({
		["Name"] = "Rape Distance",
		["Min"] = 5,
		["Max"] = 20,
		["Default"] = 10,
		["Function"] = function(val)
			AutoRapeDist = val
		end
	})

end)


runcode(function()
	local SizeChanger = {["Enabled"] = false}
    SizeChanger = GuiLibrary["ObjectsThatCanBeSaved"]["RenderWindow"]["Api"].CreateOptionsButton({
        ["Name"] = "SizeChanger",
		["HoverText"] = "Changes The Size Of a Item",
        ["Function"] = function(callback)
            if callback then
				RunLoops:BindToHeartbeat("SizeThing", 1, function()
					for i, v in pairs(game:GetService("Workspace").Camera.Viewmodel:GetChildren()) do
						if (v:IsA("Accessory")) then
							if v:FindFirstChild("Handle").Anchored == true then
								break
							else
								if v:FindFirstChild("Handle") then
									v.Handle.Size =  v.Handle.Size / 3
									v:FindFirstChild("Handle").Anchored = true
								end
								if v:FindFirstChild("Handle"):FindFirstChild("Neon") then
									v:FindFirstChild("Handle"):FindFirstChild("Neon"):Destroy()
								end
								if v:FindFirstChild("Handle"):FindFirstChild("gem") then
									v:FindFirstChild("Handle"):FindFirstChild("gem"):Destroy()
								end
							end
						end
					end
				end)
			else
				RunLoops:UnbindFromHeartbeat("SizeThing")
				createwarning("Ethones", "Disabled Next Time You Die", 3)
			end
		end
	})
end)

runcode(function()
	local HypixelFly = {["Enabled"] = false}
    HypixelFly = GuiLibrary["ObjectsThatCanBeSaved"]["BlatantWindow"]["Api"].CreateOptionsButton({
        ["Name"] = "HypixelFly",
		["HoverText"] = "A Fly",
        ["Function"] = function(callback)
            if callback then
				if entity.isAlive then
					local OriginalPosX = game.Players.LocalPlayer.character.HumanoidRootPart.Position.y
					if game.Players.LocalPlayer.character.HumanoidRootPart.Position.y == OriginalPosX then
						game.workspace.Gravity = 0
						local TS = game:GetService("TweenService")
						for i = 1, 3 do
							task.wait()
							local Prim = game.Players.LocalPlayer.Character.PrimaryPart.CFrame
							local tween = TS:Create(game.Players.LocalPlayer.Character.PrimaryPart, TweenInfo.new(0.5), {CFrame = Prim + Prim.lookVector * 10})
							tween:play()
							tween.Completed:Wait()
						end
						repeat
							task.wait()
							local mag = workspace:Raycast(entity.character.HumanoidRootPart.Position, Vector3.new(0, -32, 0), blockraycast)
							if mag then
								if HypixelFly["Enabled"] then
									HypixelFly["ToggleButton"](false)
								end
							end
						until (not HypixelFly["Enabled"])
					end
				end
			else
				game.workspace.Gravity = 192.6
			end
		end
	})
end)

runcode(function()
	local VelocityHighJump = {["Enabled"] = true}
    VelocityHighJump = GuiLibrary["ObjectsThatCanBeSaved"]["BlatantWindow"]["Api"].CreateOptionsButton({
        ["Name"] = "BetterFly",
		["HoverText"] = "For Short Distances [20 Blocks]",
        ["Function"] = function(callback)
            if callback then
				if YlevelTeller["Enabled"] then
					local Ylevel = Instance.new("TextLabel")
                    Ylevel.Name = "Ylevel"
                    Ylevel.Parent = game.CoreGui.RobloxGui
                    Ylevel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    Ylevel.BackgroundTransparency = 1.000
                    Ylevel.Position = UDim2.new(0.885590136, 0, 0.916458845, 0)
                    Ylevel.Size = UDim2.new(0, 200, 0, 50)
                    Ylevel.Font = Enum.Font.SourceSans
                    Ylevel.Text = "Ylevel  = 1"
                    Ylevel.TextColor3 = Color3.fromRGB(0, 0, 0)
                    Ylevel.TextSize = 28.000
					spawn(function()
						repeat
							local YlevelThingy = game.Players.LocalPlayer.Character.HumanoidRootPart.Position.y
							YlevelThingy = math.floor(YlevelThingy)
							task.wait(0.1)
							Ylevel.Text = "Ylevel = "..YlevelThingy
						until Ylevel.Text == nil
					end)
				end
				local OriginalPosX = game.Players.LocalPlayer.character.HumanoidRootPart.Position.y 
                local CameraPart = Instance.new("Part", game.workspace)
				CameraPart.Size = Vector3.new(1,1,1)
                CameraPart.Anchored = true
                CameraPart.Transparency = 1
                CameraPart.CanCollide = false
                CameraPart.Name = "CameraPart"
				cam.CameraSubject = game.workspace.CameraPart
				RunLoops:BindToHeartbeat("HumanoidToCamera", 1, function()
					local Pos = game.Players.LocalPlayer.character.HumanoidRootPart.Position
					CameraPart.Position = Vector3.new(Pos.x, OriginalPosX, Pos.z)
				end)
				if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
					iea2 = 0
					while iea2 <= VelocityHighJumpAmmount do
						iea2 = iea2 + 1
						game.Players.LocalPlayer.character.HumanoidRootPart.Velocity = game.Players.LocalPlayer.character.HumanoidRootPart.Velocity + Vector3.new(0,30,0)
					end
					wait(5)
					for i , v in pairs(game.CoreGui.RobloxGui:GetChildren()) do
						if v.Name == "Ylevel" then
							game.CoreGui.RobloxGui.Ylevel:Destroy()
						else
							print("no")
						end
					end
					VelocityHighJump["ToggleButton"](false)
					iea2 = iea2 + 10
					if iea2 > VelocityHighJumpAmmount then
						createwarning("Ethone ", "Please Do Not PressKeys", 3)
						RunLoops:UnbindFromHeartbeat("HumanoidToCamera")
						task.wait(1.7)
						cam.CameraSubject = game.Players.LocalPlayer.character.Humanoid
						game.workspace.CameraPart:Destroy()
					end

				else
					VelocityHighJump["ToggleButton"](false)
				end
			end
		end
	})

	
	VelocityHighJumpAmmount = VelocityHighJump.CreateSlider({
		["Name"] = "Amount",
		["Min"] = 5,
		["Max"] = 20,
		["Default"] = 20,
		["Function"] = function(val)
			VelocityHighJumpAmmount = val
		end
	})

	YlevelTeller = VelocityHighJump.CreateToggle({
		["Name"] = "Ylevel",
		["Function"] = function() end, 
		["Default"] = true,
		["HoverText"] = "Ylevel"
	})

end)

--hazelware
runcode(function()
	--ty hazel for IsMoving haha
	function IsMoving()
        return uis:IsKeyDown(Enum.KeyCode.W) or uis:IsKeyDown(Enum.KeyCode.A) or uis:IsKeyDown(Enum.KeyCode.S) or uis:IsKeyDown(Enum.KeyCode.D)
    end
	Longjumpv2 = GuiLibrary["ObjectsThatCanBeSaved"]["BlatantWindow"]["Api"].CreateOptionsButton({
		["Name"] = "Longjumpv2",
		["HoverText"] = "this makes me wanna die",
		["Function"] = function(callback)
			if callback then
				lplr.character.HumanoidRootPart.Velocity = lplr.character.HumanoidRootPart.Velocity + Vector3.new(0,100,0)
				wait(0.3)
				for i = 1,3 do wait(0.4)
					lplr.character.HumanoidRootPart.Velocity = lplr.character.HumanoidRootPart.Velocity + Vector3.new(0,75,0)
				end
				Longjumpv2["ToggleButton"](false)
			else
				game.Workspace.Gravity = 192.6
			end
		end
	})
end)

--NEW CONFIG??
--ETHONE IS PHOBOS V3 DUMBASS LOL

--jinx config
runcode(function()
    local JinxAmbience6 = {["Enabled"] = false}

    local lightingstuff = {}
    local skybox

    JinxAmbience6 = GuiLibrary["ObjectsThatCanBeSaved"]["RenderWindow"]["Api"].CreateOptionsButton({
        ["Name"] = "Ambient 6",
        ["Function"] = function(callback)
            if callback then
                lightingstuff.Ambient = lighting.Ambient
                lightingstuff.ColorShift_Bottom = lighting.ColorShift_Bottom
                lightingstuff.ColorShift_Top = lighting.ColorShift_Top
                lightingstuff.OutdoorAmbient = lighting.OutdoorAmbient
                lightingstuff.ColorShift_Bottom = lighting.ColorShift_Bottom
                lightingstuff.ColorShift_Top = lighting.ColorShift_Top

                lighting.Ambient = Color3.fromRGB(255, 0, 208)
                lighting.ColorShift_Bottom = Color3.fromRGB(111, 43, 150)
                lighting.ColorShift_Top = Color3.fromRGB(111, 43, 150)
                lighting.OutdoorAmbient = Color3.fromRGB(111, 43, 150)
                lighting.ColorShift_Bottom = Color3.fromRGB(111, 43, 150)
                lighting.ColorShift_Top = Color3.fromRGB(111, 43, 150)
				lighting.Brightness = 4

                skybox = Instance.new("Sky")
                skybox.SkyboxBk = "http://www.roblox.com/asset/?id=271042516"
                skybox.SkyboxDn = "http://www.roblox.com/asset/?id=271077243"
                skybox.SkyboxFt = "http://www.roblox.com/asset/?id=271042556"
                skybox.SkyboxLf = "http://www.roblox.com/asset/?id=271042310"
                skybox.SkyboxRt = "http://www.roblox.com/asset/?id=271042467"
                skybox.SkyboxUp = "http://www.roblox.com/asset/?id=271077958"
                skybox.Parent = lighting
            else
                for i, v in pairs(lightingstuff) do
                    lighting[i] = v
                end
            end
        end
    })
end)

runcode(function()
    local JinxAmbience5 = {["Enabled"] = false}

    local lightingstuff = {}
    local skybox

    JinxAmbience5 = GuiLibrary["ObjectsThatCanBeSaved"]["RenderWindow"]["Api"].CreateOptionsButton({
        ["Name"] = "Ambient 5",
        ["Function"] = function(callback)
            if callback then
                lightingstuff.Ambient = lighting.Ambient
                lightingstuff.ColorShift_Bottom = lighting.ColorShift_Bottom
                lightingstuff.ColorShift_Top = lighting.ColorShift_Top
                lightingstuff.OutdoorAmbient = lighting.OutdoorAmbient
                lightingstuff.ColorShift_Bottom = lighting.ColorShift_Bottom
                lightingstuff.ColorShift_Top = lighting.ColorShift_Top

                lighting.Ambient = Color3.fromRGB(70, 70, 70)
                lighting.ColorShift_Bottom = Color3.fromRGB(111, 43, 150)
                lighting.ColorShift_Top = Color3.fromRGB(111, 43, 150)
                lighting.OutdoorAmbient = Color3.fromRGB(111, 43, 150)
                lighting.ColorShift_Bottom = Color3.fromRGB(111, 43, 150)
                skybox = Instance.new("Sky")
                skybox.SkyboxBk = "rbxassetid://600830446"
                skybox.SkyboxDn = "rbxassetid://600831635"
                skybox.SkyboxFt = "rbxassetid://600832720"
                skybox.SkyboxLf = "rbxassetid://600886090"
                skybox.SkyboxRt = "rbxassetid://600833862"
                skybox.SkyboxUp = "rbxassetid://600835177"
                skybox.Parent = lighting
            else
                for i, v in pairs(lightingstuff) do
                    lighting[i] = v
                end
            end
        end
    })
end)

runcode(function()
    local JinxAmbience4 = {["Enabled"] = false}

    local lightingstuff = {}
    local skybox

    JinxAmbience4 = GuiLibrary["ObjectsThatCanBeSaved"]["RenderWindow"]["Api"].CreateOptionsButton({
        ["Name"] = "Ambient 4",
        ["Function"] = function(callback)
            if callback then
                lightingstuff.Ambient = lighting.Ambient
                lightingstuff.ColorShift_Bottom = lighting.ColorShift_Bottom
                lightingstuff.ColorShift_Top = lighting.ColorShift_Top
                lightingstuff.OutdoorAmbient = lighting.OutdoorAmbient
                lightingstuff.ColorShift_Bottom = lighting.ColorShift_Bottom
                lightingstuff.ColorShift_Top = lighting.ColorShift_Top

                lighting.Ambient = Color3.fromRGB(70, 70, 70)
                lighting.ColorShift_Bottom = Color3.fromRGB(111, 43, 150)
                lighting.ColorShift_Top = Color3.fromRGB(111, 43, 150)
                lighting.OutdoorAmbient = Color3.fromRGB(111, 43, 150)
                lighting.ColorShift_Bottom = Color3.fromRGB(111, 43, 150)
                lighting.ColorShift_Top = Color3.fromRGB(111, 43, 150)
				lighting.Brightness = 0

                skybox = Instance.new("Sky")
                skybox.SkyboxBk = "http://www.roblox.com/Asset/?ID=12064107"
                skybox.SkyboxDn = "http://www.roblox.com/Asset/?ID=12064152"
                skybox.SkyboxFt = "http://www.roblox.com/Asset/?ID=12064121"
                skybox.SkyboxLf = "http://www.roblox.com/Asset/?ID=12063984"
                skybox.SkyboxRt = "http://www.roblox.com/Asset/?ID=12064115"
                skybox.SkyboxUp = "http://www.roblox.com/Asset/?ID=12064131"
                skybox.Parent = lighting
            else
                for i, v in pairs(lightingstuff) do
                    lighting[i] = v
                end
            end
        end
    })
end)


runcode(function()
    local JinxAmbience3 = {["Enabled"] = false}

    local lightingstuff = {}
    local skybox

    JinxAmbience3 = GuiLibrary["ObjectsThatCanBeSaved"]["RenderWindow"]["Api"].CreateOptionsButton({
        ["Name"] = "Ambient 3",
        ["Function"] = function(callback)
            if callback then
                lightingstuff.Ambient = lighting.Ambient
                lightingstuff.ColorShift_Bottom = lighting.ColorShift_Bottom
                lightingstuff.ColorShift_Top = lighting.ColorShift_Top
                lightingstuff.OutdoorAmbient = lighting.OutdoorAmbient
                lightingstuff.ColorShift_Bottom = lighting.ColorShift_Bottom
                lightingstuff.ColorShift_Top = lighting.ColorShift_Top

                lighting.Ambient = Color3.fromRGB(70, 70, 70)
                lighting.ColorShift_Bottom = Color3.fromRGB(111, 43, 150)
                lighting.ColorShift_Top = Color3.fromRGB(111, 43, 150)
                lighting.OutdoorAmbient = Color3.fromRGB(111, 43, 150)
                lighting.ColorShift_Bottom = Color3.fromRGB(111, 43, 150)
                lighting.ColorShift_Top = Color3.fromRGB(111, 43, 150)
				lighting.Brightness = 0

                skybox = Instance.new("Sky")
                skybox.SkyboxBk = "http://www.roblox.com/asset/?version=1&id=1327366"
                skybox.SkyboxDn = "http://www.roblox.com/asset/?version=1&id=1327367"
                skybox.SkyboxFt = "http://www.roblox.com/asset/?version=1&id=1327362"
                skybox.SkyboxLf = "http://www.roblox.com/asset/?version=1&id=1327363"
                skybox.SkyboxRt = "http://www.roblox.com/asset/?version=1&id=1327361"
                skybox.SkyboxUp = "http://www.roblox.com/asset/?version=1&id=1327368"
                skybox.Parent = lighting
            else
                for i, v in pairs(lightingstuff) do
                    lighting[i] = v
                end
            end
        end
    })
end)

runcode(function()
    local JinxAmbience2 = {["Enabled"] = false}

    local lightingstuff = {}
    local skybox

    JinxAmbience2 = GuiLibrary["ObjectsThatCanBeSaved"]["RenderWindow"]["Api"].CreateOptionsButton({
        ["Name"] = "Ambient 2",
        ["Function"] = function(callback)
            if callback then
                lightingstuff.Ambient = lighting.Ambient
                lightingstuff.ColorShift_Bottom = lighting.ColorShift_Bottom
                lightingstuff.ColorShift_Top = lighting.ColorShift_Top
                lightingstuff.OutdoorAmbient = lighting.OutdoorAmbient
                lightingstuff.ColorShift_Bottom = lighting.ColorShift_Bottom
                lightingstuff.ColorShift_Top = lighting.ColorShift_Top

                lighting.Ambient = Color3.fromRGB(70, 70, 70)
                lighting.ColorShift_Bottom = Color3.fromRGB(111, 43, 150)
                lighting.ColorShift_Top = Color3.fromRGB(111, 43, 150)
                lighting.OutdoorAmbient = Color3.fromRGB(111, 43, 150)
                lighting.ColorShift_Bottom = Color3.fromRGB(111, 43, 150)
                lighting.ColorShift_Top = Color3.fromRGB(111, 43, 150)
				lighting.Brightness = 0

                skybox = Instance.new("Sky")
                skybox.SkyboxBk = "rbxasset://Sky/null_plainsky512_bk.jpg"
                skybox.SkyboxDn = "rbxasset://Sky/null_plainsky512_dn.jpg"
                skybox.SkyboxFt = "rbxasset://Sky/null_plainsky512_ft.jpg"
                skybox.SkyboxLf = "rbxasset://Sky/null_plainsky512_lf.jpg"
                skybox.SkyboxRt = "rbxasset://Sky/null_plainsky512_rt.jpg"
                skybox.SkyboxUp = "rbxasset://Sky/null_plainsky512_up.jpg"
                skybox.Parent = lighting
            else
                for i, v in pairs(lightingstuff) do
                    lighting[i] = v
                end
            end
        end
    })
end)

runcode(function()
    local JinxAmbience = {["Enabled"] = false}

    local lightingstuff = {}
    local skybox

    JinxAmbience = GuiLibrary["ObjectsThatCanBeSaved"]["RenderWindow"]["Api"].CreateOptionsButton({
        ["Name"] = "Ambient 1",
        ["Function"] = function(callback)
            if callback then
                lightingstuff.Ambient = lighting.Ambient
                lightingstuff.ColorShift_Bottom = lighting.ColorShift_Bottom
                lightingstuff.ColorShift_Top = lighting.ColorShift_Top
                lightingstuff.OutdoorAmbient = lighting.OutdoorAmbient
                lightingstuff.ColorShift_Bottom = lighting.ColorShift_Bottom
                lightingstuff.ColorShift_Top = lighting.ColorShift_Top

                lighting.Ambient = Color3.fromRGB(16, 59, 56)
                lighting.ColorShift_Bottom = Color3.fromRGB(111, 43, 150)
                lighting.ColorShift_Top = Color3.fromRGB(111, 43, 150)
                lighting.OutdoorAmbient = Color3.fromRGB(111, 43, 150)
                lighting.ColorShift_Bottom = Color3.fromRGB(111, 43, 150)
                lighting.ColorShift_Top = Color3.fromRGB(111, 43, 150)
				lighting.Brightness = 0

                skybox = Instance.new("Sky")
                skybox.SkyboxBk = "http://www.roblox.com/asset/?id=159248188"
                skybox.SkyboxDn = "http://www.roblox.com/asset/?id=159248183"
                skybox.SkyboxFt = "http://www.roblox.com/asset/?id=159248187"
                skybox.SkyboxLf = "http://www.roblox.com/asset/?id=159248173"
                skybox.SkyboxRt = "http://www.roblox.com/asset/?id=159248192"
                skybox.SkyboxUp = "http://www.roblox.com/asset/?id=159248176"
                skybox.Parent = lighting
            else
                for i, v in pairs(lightingstuff) do
                    lighting[i] = v
                end
            end
        end
    })
end)

runcode(function()
    local Chat = {["Enabled"] = false}
    
    Chat = GuiLibrary["ObjectsThatCanBeSaved"]["RenderWindow"]["Api"].CreateOptionsButton({
        ["Name"] = "Chat",
        ["HoverText"] = "Moves the Chat",
        ["Function"] = function(callback)
            if callback then
                game:GetService("StarterGui"):SetCore('ChatWindowPosition', UDim2.new(0, 0, 0, 700))
            else
                game:GetService("StarterGui"):SetCore('ChatWindowPosition', UDim2.new(0, 0, 0, 0))
            end
        end
    })
end)

runcode(function()
    local KillFeed = {["Enabled"] = false}
    local container

    KillFeed = GuiLibrary["ObjectsThatCanBeSaved"]["RenderWindow"]["Api"].CreateOptionsButton({
        ["Name"] = "KillFeed",
        ["HoverText"] = "Destroys the KillFeed",
        ["Function"] = function(callback)
            if callback then
                task.spawn(function()
                    if container == nil then
                        repeat
                            local suc, res = pcall(function() return lplr.PlayerGui.KillFeedGui.KillFeedContainer end)
                            if suc then
                                container = res
                            end
                            task.wait()
                        until container ~= nil
                    end
                    container.Visible = false
                end)
            else
                if container then
                    container.Visible = true
                end
            end
        end
    })
end)

runcode(function()
    local PurpleAntivoid = {["Enabled"] = false}
    local antivoidpart
    PurpleAntivoid = GuiLibrary["ObjectsThatCanBeSaved"]["UtilityWindow"]["Api"].CreateOptionsButton({
        ["Name"] = "SolidAntiVoid",
        ["HoverText"] = "Antivoid but it is solid insted of teleporting you back",
        ["Function"] = function(callback)
            if callback then
                task.spawn(function()
                    antivoidpart = Instance.new("Part")
                    antivoidpart.Size = Vector3.new(2100, 0.5, 2000)
                    antivoidpart.Position = Vector3.new(160.5, 25, 247.5)
                    antivoidpart.Transparency = 0.4
                    antivoidpart.Anchored = true
                    antivoidpart.Color = Color3.fromRGB(255, 255, 255)
                    antivoidpart.Parent = workspace
                end)
            else               
		        if antivoidpart then
                    antivoidpart:Remove()
                    antivoidpart = nil
                end
            end
        end
    })
end)

SnoopyTxtPack = GuiLibrary.ObjectsThatCanBeSaved.WorldWindow.Api.CreateOptionsButton({
    ["Name"] = "SnoopyTxtPack",
    ["Function"] = function(callback)
        if callback then
			Enabled = callback
            if Enabled then
                Connection = cam.Viewmodel.ChildAdded:Connect(function(v)
                    if v:FindFirstChild("Handle") then
                        pcall(function()
                            v:FindFirstChild("Handle").Size = v:FindFirstChild("Handle").Size / 1.5
                            v:FindFirstChild("Handle").Material = Enum.Material.SmoothPlastic
                            v:FindFirstChild("Handle").TextureID = "rbxassetid://12736332126"
                            v:FindFirstChild("Handle").Color = Color3.fromRGB(61, 21, 133)
                        end)
                        local vname = string.lower(v.Name)
                        if vname:find("sword") or vname:find("blade") then
                            v:FindFirstChild("Handle").MeshId = "rbxassetid://12741430220"
                        elseif vname:find("pick") then
                            v:FindFirstChild("Handle").MeshId = "rbxassetid://12342364179"
                        end
                    end
                end)
            else
                Connection:Disconnect()
			end
        end
    end
})
runcode(function()
	function IsMoving()
        return uis:IsKeyDown(Enum.KeyCode.W) or uis:IsKeyDown(Enum.KeyCode.A) or uis:IsKeyDown(Enum.KeyCode.S) or uis:IsKeyDown(Enum.KeyCode.D)
    end

local REDSNOOPYTexturepack = {["Enabled"] = false}
			REDSNOOPYTexturepack = GuiLibrary["ObjectsThatCanBeSaved"]["WorldWindow"]["Api"].CreateOptionsButton({
				["Name"] = "Red glowing texture pack",
				   ["Function"] = function(Callback)
						Enabled = Callback
						if Enabled then

local function createwarning(title, text, delay)
	local suc, res = pcall(function()
		local frame = GuiLibrary["CreateNotification"](title, text, delay, "assets/WarningNotification.png")
		frame.Frame.Frame.ImageColor3 = Color3.fromRGB(201, 126, 14)
		return frame
	end)
	return (suc and res)
end

createwarning("Grass Client Privet", "Orginal pack was blue by snoopy : Grass just made it red (this is kinnda of a remake of father client or cometv2 pack)", 5)

							Connection = cam.Viewmodel.ChildAdded:Connect(function(v)
								if v:FindFirstChild("Handle") then
									pcall(function()
										v:FindFirstChild("Handle").Size = v:FindFirstChild("Handle").Size / 1.5
										v:FindFirstChild("Handle").Material = Enum.Material.Neon
										v:FindFirstChild("Handle").TextureID = ""
										v:FindFirstChild("Handle").Color = Color3.fromRGB(196, 40, 28)
									end)
									local vname = string.lower(v.Name)
									if vname:find("sword") or vname:find("blade") then
										v:FindFirstChild("Handle").MeshId = "rbxassetid://11216117592"
									elseif vname:find("snowball") then
										v:FindFirstChild("Handle").MeshId = "rbxassetid://11216343798"
									end
								end
							end)
						else
							Connection:Disconnect()
						end
					end
				})





			local REDSNOOPYTexturepack = {["Enabled"] = false}
			REDSNOOPYTexturepack = GuiLibrary["ObjectsThatCanBeSaved"]["WorldWindow"]["Api"].CreateOptionsButton({
				["Name"] = "Comet v2 texture pack",
				   ["Function"] = function(Callback)
						Enabled = Callback
						if Enabled then
							Connection = cam.Viewmodel.ChildAdded:Connect(function(v)
								if v:FindFirstChild("Handle") then
									pcall(function()
										v:FindFirstChild("Handle").Size = v:FindFirstChild("Handle").Size / 1.5
										v:FindFirstChild("Handle").Material = Enum.Material.Neon
										v:FindFirstChild("Handle").TextureID = ""
										v:FindFirstChild("Handle").Color = Color3.fromRGB(255, 89, 89)
									end)
									local vname = string.lower(v.Name)
									if vname:find("sword") or vname:find("blade") then
										v:FindFirstChild("Handle").MeshId = "rbxassetid://11216117592"
									elseif vname:find("snowball") then
										v:FindFirstChild("Handle").MeshId = "rbxassetid://11216343798"
									end
								end
							end)
						else
							Connection:Disconnect()
						end
					end
				})
local BlueTexturepack = {["Enabled"] = false}
			BlueTexturepack = GuiLibrary["ObjectsThatCanBeSaved"]["WorldWindow"]["Api"].CreateOptionsButton({
				["Name"] = "Grass Blue Texure pack",
				   ["Function"] = function(Callback)
						Enabled = Callback
						if Enabled then
							Connection = cam.Viewmodel.ChildAdded:Connect(function(v)
								if v:FindFirstChild("Handle") then
									pcall(function()
										v:FindFirstChild("Handle").Size = v:FindFirstChild("Handle").Size / 1.5
										v:FindFirstChild("Handle").Material = Enum.Material.Neon
										v:FindFirstChild("Handle").TextureID = ""
										v:FindFirstChild("Handle").Color = Color3.fromRGB(16, 42, 220)
									end)
									local vname = string.lower(v.Name)
									if vname:find("sword") or vname:find("blade") then
										v:FindFirstChild("Handle").MeshId = "rbxassetid://12360170981"
									elseif vname:find("pick") then
										v:FindFirstChild("Handle").MeshId = "rbxassetid://12342364179"
									end
								end
							end)
						else
							Connection:Disconnect()
						end
					end
				})


local customSowrd1 = {["Enabled"] = false}
			customSowrd1 = GuiLibrary["ObjectsThatCanBeSaved"]["WorldWindow"]["Api"].CreateOptionsButton({
				["Name"] = "White Glow Texture Pack",
				   ["Function"] = function(Callback)
						Enabled = Callback
						if Enabled then

							Connection = cam.Viewmodel.ChildAdded:Connect(function(v)
								if v:FindFirstChild("Handle") then
									pcall(function()
										v:FindFirstChild("Handle").Size = v:FindFirstChild("Handle").Size / 2
										v:FindFirstChild("Handle").Material = Enum.Material.Neon
										v:FindFirstChild("Handle").TextureID = ""
										v:FindFirstChild("Handle").Color = Color3.fromRGB(163, 162, 165)
									end)
									local vname = string.lower(v.Name)
									if vname:find("sword") or vname:find("blade") then
										v:FindFirstChild("Handle").MeshId = "rbxassetid://12359322681"
									elseif vname:find("pick") then
										v:FindFirstChild("Handle").MeshId = "rbxassetid://12342364179"
									end
								end
							end)
						else
							Connection:Disconnect()
						end
					end

									

				})

	
local customSowrd2 = {["Enabled"] = false}
			customSowrd2 = GuiLibrary["ObjectsThatCanBeSaved"]["WorldWindow"]["Api"].CreateOptionsButton({
				["Name"] = "Black Glow Texture Pack",
				   ["Function"] = function(Callback)
						Enabled = Callback
						if Enabled then

							Connection = cam.Viewmodel.ChildAdded:Connect(function(v)
								if v:FindFirstChild("Handle") then
									pcall(function()
										v:FindFirstChild("Handle").Size = v:FindFirstChild("Handle").Size / 1
										v:FindFirstChild("Handle").Material = Enum.Material.Neon
										v:FindFirstChild("Handle").TextureID = ""
										v:FindFirstChild("Handle").Color = Color3.fromRGB(17, 17, 17)
									end)
									local vname = string.lower(v.Name)
									if vname:find("sword") or vname:find("blade") then
										v:FindFirstChild("Handle").MeshId = "rbxassetid://1850292888"
									elseif vname:find("snowball") then
										v:FindFirstChild("Handle").MeshId = "rbxassetid://11216343798"
									end
								end
							end)
						else
							Connection:Disconnect()
						end
					end
				})


	Longjumpv2 = GuiLibrary["ObjectsThatCanBeSaved"]["BlatantWindow"]["Api"].CreateOptionsButton({
		["Name"] = "Longjumpv2",
		["HoverText"] = "Made by papi/Kitty9#9999",
		["Function"] = function(callback)
			if callback then
				lplr.character.HumanoidRootPart.Velocity = lplr.character.HumanoidRootPart.Velocity + Vector3.new(0,100,0)
				wait(0.3)
				for i = 1,3 do wait(0.4)
					lplr.character.HumanoidRootPart.Velocity = lplr.character.HumanoidRootPart.Velocity + Vector3.new(0,75,0)
				end
				Longjumpv2["ToggleButton"](false)
			else
				game.Workspace.Gravity = 192.6
			end
		end
	})
end)

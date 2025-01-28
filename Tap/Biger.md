### UI Lux002 make in 19/1/2025
- By Ares

![image](https://github.com/user-attachments/assets/bbed89c5-3a85-4537-a54b-df006e5225a7)


`<Themes>` : nil

- Example Lua

```lua
AllFuncs = {}
Config = {}
Threads = {}

local Players = game.Players
repeat
	Client = Players.LocalPlayer
	wait()
until Client

do -- Settings Initializer
	local path = "Normal Hub/Blox Fruits"
	if not isfolder(path) then makefolder(path) end
	DefaultConfigName = path.."/OriConfibg.json"
	ConfigName = path.."/"..Client.UserId.."Config.json"
	Config = isfile(ConfigName) and readfile(ConfigName)
	DefaultConfig = isfile(DefaultConfigName) and readfile(DefaultConfigName)

	if Config then
		if type(Config) == "string" and Config:find"{" then
			local Success,Result
			Success,Result = pcall(function()
				return game:GetService("HttpService"):JSONDecode(Config)
			end)
			wait(0.1)
			if Success then
				Config = Result
			else
				Config = {}
			end
		else
			Config = {}
		end
	else
		Config = {}
	end
end

do -- Config Function
	save = function()
		if not isfolder('Normal Hub') then
			makefolder('Normal Hub')
		end
		writefile(ConfigName,game:GetService("HttpService"):JSONEncode(Config))
	end
	setDefaultConfig = function()
		if not isfolder('Normal Hub') then
			makefolder('Normal Hub')
		end
		writefile(DefaultConfigName,game:GetService("HttpService"):JSONEncode(Config))
	end
end

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/aresZee7/Sunny-Free-GUI/refs/heads/main/UI/Biger.lua"))()

function Toggle(options, CallBack, SettingName)
	local Section = options.Section
	local Title = options.Title
	local Locker = options.Locker
	local Dis = options.Dis

	local tasks;

	if type(CallBack) == 'string' then
		if not SettingName then
			SettingName = CallBack
		end
		CallBack = nil
	end	

	if not SettingName then
		SettingName = Title
	end

	return Section.CreateToggle({Title = Title, Dis = Dis,Value = Config[SettingName] or false,Callback = CallBack or function(v)
		Config[SettingName] = v
		save()
		local Succes, Error = pcall(function()
			tasks = task.spawn(function() 
				if AllFuncs[SettingName] ~= nil then 
					AllFuncs[SettingName](SettingName) 
				end 
			end)

			if (not v) and tasks then 
				task.cancel(tasks) 
			else 
				Threads[#Threads+1] = tasks 
			end

		end)
		if not Succes then
			warn(SettingName.." Error Pls OpenTicket For Report Bug ", Error)
		end
	end}, Locker)
end;

function Label(options)
	local Section = options.Section
	local Title = options.Title

	return Section.CreateLabel(Title)
end;

function Button(options, CallBack, SettingName)
	local Section = options.Section
	local Title = options.Title

	if type(CallBack) == 'string' then
		if not SettingName then
			SettingName = CallBack
		end
		CallBack = nil
	end

	return Section.CreateButton({Title = Title ,Callback = CallBack or print("Normal Hub")})
end;

function Dropdown(options, CallBack, DropName)
	local Section = options.Section
	local Title = options.Title
	local List = options.List
	local Muti = options.Multi
	local Value = options.Value or nil

	if type(CallBack) == 'string' then
		if not DropName then
			DropName = CallBack
		end
		CallBack = nil
	end

	if not options.Multi then
		return options.Section.CreateDropdown({Title = Title ,Value = Config[DropName] or Value or "", List = options.List,Callback = CallBack or function(v)
			Config[DropName] = v
			save()
		end,})
	else
		return options.Section.CreateMultiDropdown({Title = Title ,Value = Config[DropName] or Value or {""}, List = options.List,Callback = CallBack or function(v)
			Config[DropName] = v
			save()
		end,})
	end
end;

function TextBox(options, CallBack, TextBoxName)
	local Section = options.Section
	local Title = options.Title
	local Placeholder = options.Placeholder or ""
	local Value = options.Value or ""

	if type(CallBack) == 'string' then
		if not TextBoxName then
			TextBoxName = CallBack
		end
		CallBack = nil
	end

	return options.Section.CreateInput({Title = Title ,Value = Config[TextBoxName] or Value or 0, Placeholder = Placeholder, Callback = CallBack or function(v)
		Config[TextBoxName] = v
		save()
	end,})
end

function Slider(options, CallBack, SliderName)
	local Section = options.Section
	local Title = options.Title
	local Value = options.Value

	local Floor = options.Floor or false


	if type(CallBack) == 'string' then
		if not SliderName then
			SliderName = CallBack
		end
		CallBack = nil
	end
	return options.Section.CreateSlider({Title = options.Title ,Value = Config[SliderName] or Value or 0, Floor = Floor, Min = options.Min, Max = options.Max,Format = CallBack or function(v)
		Config[SliderName] = tonumber(v)
		save()
	end,})
end

function spd(num : number)
	local kuy = " "
	for i = 1, num do
		kuy = kuy..kuy
	end
	return kuy
end

local windown = library:Haxa({
	['Logo'] = 78590114316385
})

local Tap = windown.CreateTap({
	['Icon'] = 'user',
	['Title'] = spd(3)..'Generals'
})

local AutomaticTap = windown.CreateTap({
	['Icon'] = 'bot',
	['Title'] = spd(4)..'Automatic'
})

local SettingTap = windown.CreateTap({
	['Icon'] = 'settings',
	['Title'] = spd(3)..'Settings'
})

local info = Tap.setPlayerInfo()
local playerLv = info.CreateData({
	Icon = '82957051825102',
	Title = "Level",
	Value = 453534
})

playerLv.SetText(200)
Label({Section = Tap, Title = "Farming",}) do
	local Group1, Group2 = Tap.CreateGroup(), Tap.CreateGroup() 
	Toggle({
		Section = Group1,
		Title = "Farm Level",
	}, "Farm Level")

	Toggle({
		Section = Group1,
		Title = "Auto Next Sea",
	}, "Next Sea")

	Toggle({
		Section = Group1,
		Title = "Auto Fcatory Raid",
	}, "Fcatory Raid")

	Button({
		Section = Group2,
		Title = "Redeem All Code" 
	}, function()

	end)
end

Label({Section = Tap, Title = "Mob Aura",}) do
	local Group3 = Tap.CreateGroup()
	Slider({
		Section = Group3,
		Title = "Radius Aura",
		Min = 100,
		Max = 1000,
		Value = 100,
		Floor = false
	}, "Radius Aura")
	Toggle({
		Section = Group3,
		Title = "Aura Mobs Radius"
	}, "Aura Mobs Radius")
	Toggle({
		Section = Group3,
		Title = "Show Radius"
	}, "Show Radius")
end

Label({Section = Tap, Title = "Auto Mastery & Auto Chest",}) do
	local Auto_Mastery,Auto_Mastery2  = Tap.CreateGroup(), Tap.CreateGroup() 
	Dropdown({
		Section = Auto_Mastery,
		Title = "Select Type Farm",
		List = {"Melee","Sword", "Gun","Blox Fruit"},
		Value = "Sword"
	}, "Type Mastery")
	Slider({
		Section = Auto_Mastery,
		Title = "Max Mastery Farm",
		Min = 1,
		Max = 600,
		Value = 350
	}, "Max Mastery")
	Slider({
		Section = Auto_Mastery,
		Title = "Percent Health Use Skill",
		Min = 1,
		Max = 100,
		Value = 30
	}, "Percent Use Skill")
	Toggle({
		Section = Auto_Mastery2,
		Title = "Auto Mastery"
	}, "Farm Mastery")

	Toggle({
		Section = Auto_Mastery2,
		Title = "Auto Keep Chests",
	}, "Auto Chests")
end

Label({Title = "Auto Material", Section = AutomaticTap})
local Auto_Material,Auto_Material2  = AutomaticTap.CreateGroup(),AutomaticTap.CreateGroup() do
	Dropdown({
		Section = Auto_Material,
		Title = "Material FirstSea" ,
		List = { "Yeti Fur", "Fish Tail", "Magma Ore", "Scrap Metal", }
	}, "Select Material")
	Dropdown({
		Section = Auto_Material,
		Title = "Material SecondSea" , 
		List = {"Ectoplasm", "Radioactive Material", "Vampire Fang", "Meteorite", }
	}, "Select Material")
	Dropdown({ 
		Section = Auto_Material,
		Title = "Material ThirdSea" , 
		List ={ "Fish Tail", "Gun Powder", "Mini Tusk", "Conjured Cocoa", "Demonic Wisp", "Dragon Scale", }
	}, "Select Material")
	Toggle({
		Section = Auto_Material2,
		Title = "Find Material ",
	}, "Find Material")
end

Label({Title = "Auto Bone", Section = AutomaticTap}) do
	AllBone = AutomaticTap.CreateLabel("Current Bone ; N/A")
	local Autos  = AutomaticTap.CreateGroup()
	Toggle({
		Section = Autos,
		Title = "Farm Bone",
	}, "Auto Bone")
	Toggle({
		Section = Autos,
		Title = "Trading Bone",
	}, "Trading Bone")
end

Label({Title = "Cake Prince", Section = AutomaticTap}) do
	CakeNeed = AutomaticTap.CreateLabel("Cake Prince ; N/A")
	local Autos  = AutomaticTap.CreateGroup()

	Toggle({
		Section = Autos,
		Title = "Cake Prince",
	}, "Auto Cake Prince")
	Toggle({
		Section = Autos,
		Title = "Dough King",
	}, "Dough King")
end

Label({Title = "Farm Observation", Section = AutomaticTap}) do
	LevelObser = AutomaticTap.CreateLabel("Observation Level : N/A")
	local Observation_Tap  = AutomaticTap.CreateGroup()

	Toggle({
		Section = Observation_Tap,
		Title = "Farm Observation"
	}, "Farm Observation")
	Toggle({
		Section = Observation_Tap,
		Title = "Rejoin Server [Observation]"
	}, "Rejoin Observation")
end


Label({Title = "Setting Farming", Section = SettingTap}) do
	local SettingFarming  = SettingTap.CreateGroup() 
	Dropdown({
		Section = SettingFarming,
		Title = "Select Tool",
		Value = "Melee",
		List = {"Melee","Sword", "Gun", "Blox Fruits"}
	}, "Select_Weapon")
	Dropdown({
		Section = SettingFarming,
		Title = "Select Mode Bring",
		Value = "Noraml",
		List = {"Noraml","Velocity"}
	}, "Select Mode Bring")
	Dropdown({
		Section = SettingFarming,
		Title = "Select Skill",
		Value = {"Z","X"},
		List = {"Z","X","C","V"},
		Multi = true
	}, "Select Skill Use")
end
local SettingFarming  = SettingTap.CreateGroup() do
	Toggle({
		Section = SettingFarming,
		Title = "Auto Awakening Race",
	}, "Auto Awakening Race")
	Toggle({
		Section = SettingFarming,
		Title = "Bring Mob",
	}, "Bring Mob")
	Toggle({
		Section = SettingFarming,
		Title = "Disable Auto Shoot",
	}, "Disable Shoot")
end
local SettingFarming  = SettingTap.CreateGroup() do
	Toggle({
		Section = SettingFarming,
		Title = "Disable Auto Attack",
	}, "Disable Attack")
	Toggle({
		Section = SettingFarming,
		Title = "Attack Player",
	}, "Attack Player")
	Toggle({
		Section = SettingFarming,
		Title = "Auto Use Skill",
	}, "Auto Use Skill")
end
```

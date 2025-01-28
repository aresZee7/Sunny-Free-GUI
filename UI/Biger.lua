local par = game.CoreGui
do
	for i,v in pairs(par:GetChildren()) do
		if v.Name == "Normal Hub | 123" then
			v:Destroy()
		end
	end
end

local ProtectGui = protectgui or protect_gui or (syn and syn.protect_gui) or function() end
local NormalHub123 = Instance.new("ScreenGui")
NormalHub123.Name = "Normal Hub | 123"
NormalHub123.Parent = par
NormalHub123.IgnoreGuiInset = true
NormalHub123.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ProtectGui(NormalHub123)

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Mouse = game.Players.LocalPlayer:GetMouse()
local IconGen = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/refs/heads/master/src/Icons.lua"))()['assets']

_G.GUI = {}

library =  {
	Tap = {},
	setZdix = 99999,
	GuiLists = { ['Haxa'] = {
		'Logo'
	} },
	NowTap = "",
	GuiFunction = {
		movePos = function(Frame, object)
			local dragToggle = nil
			local dragSpeed = .25
			local dragInput = nil
			local dragStart = nil
			local dragPos = nil

			local function updateInput(input)
				local Delta = input.Position - dragStart
				local Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y)
				TweenService:Create(
					object,
					TweenInfo.new(0,Enum.EasingStyle.Linear,Enum.EasingDirection.Out),
					{Position = Position}
				):Play()
			end

			Frame.InputBegan:Connect(function(input)
				if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
					dragToggle = true
					dragStart = input.Position
					startPos = object.Position
					input.Changed:Connect(function()
						if (input.UserInputState == Enum.UserInputState.End) then
							dragToggle = false
						end
					end)
				end
			end)

			Frame.InputChanged:Connect(function(input)
				if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch)then
					dragInput = input
				end
			end)

			game:GetService("UserInputService").InputChanged:Connect(function(input)
				if (input == dragInput and dragToggle) then
					updateInput(input)
				end
			end)
		end,
		setBlurText = function(s)
			local censoredText = string.gsub(s, "(%w)(%w*)(%w)", function(first, middle, last)
				return first .. string.rep("*", #middle) .. last
			end)
			return censoredText
		end,
	},
	LoadSizeUI = function()
		local HttpService = game:GetService("HttpService")
		local filename = game.Players.LocalPlayer.Name..".json"
		if isfile('AresGUI'.."/"..filename) then
			for _i, value in pairs(HttpService:JSONDecode(readfile('AresGUI'.."/"..filename)) or _G.GUI ) do
				_G.GUI[_i] = value
			end
		end
	end,
	SeveSizeUi = function()
		local filename = game.Players.LocalPlayer.Name..".json"
		local HttpService = game:GetService("HttpService")
		local json = HttpService:JSONEncode(_G.GUI)
		if writefile then
			if isfolder('AresGUI') and isfile('AresGUI'.."/"..filename) then
				writefile('AresGUI'.."/"..filename, json)
			else
				makefolder('AresGUI')
				writefile('AresGUI'.."/"..filename, json)
			end
		end
	end,
	Haxa = function( self, setting : table)
		for i,v in pairs(library) do
			assert(self[i], "in self need ,".. i)
			if not self[i] then return end
		end
		local icon 
		for i,v in pairs(library.GuiLists['Haxa']) do
			assert(setting[v], "in setting need ,".. v)
			if not setting[v] then
				return else icon = setting['Logo'] if 
					icon ~= 78590114316385 
				then return end end
		end
		local Main = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local getTap = self.Tap
		local getZdix = self.setZdix
		local movePos = self.
			GuiFunction.movePos
		local setBlurText = self.
			GuiFunction.setBlurText

		Main.Name = "Main"
		Main.Parent = NormalHub123
		Main.AnchorPoint = Vector2.new(0.5, 0.5)
		Main.BackgroundColor3 = Color3.fromRGB(27, 31, 40)
		Main.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Main.BorderSizePixel = 0
		Main.ClipsDescendants = true
		Main.Position = UDim2.new(0.536307096, 0, 0.535431802, 0)
		Main.Size = UDim2.new(0, 0, 0, 0)

		local ResizeFrame = Instance.new("Frame")
		ResizeFrame.Parent = Main
		ResizeFrame.AnchorPoint = Vector2.new(0.5, 0.5)
		ResizeFrame.Size = UDim2.new(0.1, 0, 0.1, 0)
		ResizeFrame.Position = UDim2.new( 1, 0, 1, 0)
		ResizeFrame.BackgroundTransparency = 1
		ResizeFrame.BorderSizePixel = 0

		local isResizing = false
		local startSize, startPos, startMousePos

		local function Resize(input)
			local delta = input.Position - startMousePos
			local newSizeX = startSize.X.Offset + delta.X
			local newSizeY = startSize.Y.Offset + delta.Y
			Main.Size = UDim2.new(startSize.X.Scale, newSizeX, startSize.Y.Scale, newSizeY)

			local newPosX = startPos.X.Offset + (delta.X / 2)
			local newPosY = startPos.Y.Offset + (delta.Y / 2)
			Main.Position = UDim2.new(startPos.X.Scale, newPosX, startPos.Y.Scale, newPosY)
		end

		ResizeFrame.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				isResizing = true
				startSize = Main.Size
				startPos = Main.Position
				startMousePos = input.Position
			end
		end)

		UserInputService.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				isResizing = false
			end
		end)

		UserInputService.InputChanged:Connect(function(input)
			if isResizing and input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
				Resize(input)
			end
		end)

		TweenService:Create(
			Main,
			TweenInfo.new(.6,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
			{Size = UDim2.new( 0.5, 0, 0.5, 0) }
		):Play()

		UICorner.Parent = Main

		local Tap = Instance.new("Frame")
		local UICorner_2 = Instance.new("UICorner")
		local Logo = Instance.new("ImageLabel")
		local Cut = Instance.new("Frame")
		local UICorner_3 = Instance.new("UICorner")

		Tap.Name = "Tap"
		Tap.Parent = Main
		Tap.AnchorPoint = Vector2.new(0.5, 0.5)
		Tap.BackgroundColor3 = Color3.fromRGB(18, 23, 29)
		Tap.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Tap.BorderSizePixel = 0
		Tap.Position = UDim2.new(0.0557515956, 0, 0.514171183, 0)
		Tap.Size = UDim2.new(0.0599999987, 0, 0.899999976, 0)

		UICorner_2.CornerRadius = UDim.new(0, 25)
		UICorner_2.Parent = Tap

		Logo.Name = "Logo"
		Logo.Parent = Tap
		Logo.AnchorPoint = Vector2.new(0.5, 0.5)
		Logo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Logo.BackgroundTransparency = 1.000
		Logo.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Logo.BorderSizePixel = 0
		Logo.Position = UDim2.new(0.5, 0, 0.0700000003, 0)
		Logo.Size = UDim2.new(0.489551932, 0, 0.0588690192, 0)

		if typeof(icon) == "number" then
			Logo.Image = "rbxassetid://".. tostring(icon)
		elseif typeof(icon) == "string" then
			Logo.Image = icon
		end

		Cut.Name = "Cut"
		Cut.Parent = Tap
		Cut.AnchorPoint = Vector2.new(0.5, 0.5)
		Cut.BackgroundColor3 = Color3.fromRGB(27, 34, 42)
		Cut.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Cut.BorderSizePixel = 0
		Cut.Position = UDim2.new(0.500000298, 0, 0.119450636, 0)
		Cut.Size = UDim2.new(0.699999988, 0, 0.00400000019, 0)

		UICorner_3.Parent = Cut

		local Top = Instance.new("Frame")
		local UICorner_4 = Instance.new("UICorner")
		local Welcome = Instance.new("TextLabel")
		local PlayerName = Instance.new("TextLabel")
		local Search = Instance.new("Frame")
		local UICorner_5 = Instance.new("UICorner")
		local Searchicon = Instance.new("ImageLabel")
		local TextBox = Instance.new("TextBox")
		local SearchButton = Instance.new("TextButton")
		local UICorner_6 = Instance.new("UICorner")
		local Searchicon_2 = Instance.new("ImageLabel")

		Top.Name = "Top"
		Top.Parent = Main
		Top.AnchorPoint = Vector2.new(0.5, 0.5)
		Top.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Top.BackgroundTransparency = 1.000
		Top.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Top.BorderSizePixel = 0
		Top.Position = UDim2.new(0.498957783, 0, 0.0690023899, 0)
		Top.Size = UDim2.new(0.800000012, 0, 0.0860000029, 0)

		movePos(Top, Main)

		UICorner_4.CornerRadius = UDim.new(0, 25)
		UICorner_4.Parent = Top

		Welcome.Name = "Welcome"
		Welcome.Parent = Top
		Welcome.AnchorPoint = Vector2.new(0.5, 0.5)
		Welcome.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Welcome.BackgroundTransparency = 1.000
		Welcome.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Welcome.BorderSizePixel = 0
		Welcome.Position = UDim2.new(0.0780000016, 0, 0.5, 0)
		Welcome.Size = UDim2.new(0.137999997, 0, 0.400000006, 0)
		Welcome.Font = Enum.Font.Arial
		Welcome.Text = "Welcome,"
		Welcome.TextColor3 = Color3.fromRGB(213, 55, 102)
		Welcome.TextScaled = true
		Welcome.TextSize = 14.000
		Welcome.TextWrapped = true
		Welcome.TextXAlignment = Enum.TextXAlignment.Left

		PlayerName.Name = "PlayerName"
		PlayerName.Parent = Top
		PlayerName.AnchorPoint = Vector2.new(0.5, 0.5)
		PlayerName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		PlayerName.BackgroundTransparency = 1.000
		PlayerName.BorderColor3 = Color3.fromRGB(0, 0, 0)
		PlayerName.BorderSizePixel = 0
		PlayerName.Position = UDim2.new(0.214, 0, 0.500000179, 0)
		PlayerName.Size = UDim2.new(0.2, 0, 0.400000066, 0)
		PlayerName.Font = Enum.Font.Arial
		PlayerName.Text =  setBlurText(game.Players.LocalPlayer.Name)
		PlayerName.TextColor3 = Color3.fromRGB(213, 213, 213)
		PlayerName.TextScaled = true
		PlayerName.TextSize = 14.000
		PlayerName.TextWrapped = true
		PlayerName.TextXAlignment = Enum.TextXAlignment.Left
		PlayerName.MouseEnter:Connect(function()
			PlayerName.Text = game.Players.LocalPlayer.Name
		end)
		PlayerName.MouseLeave:Connect(function()
			PlayerName.Text = setBlurText(game.Players.LocalPlayer.Name)
		end)

		Search.Name = "Search"
		Search.Parent = Main
		Search.AnchorPoint = Vector2.new(0.5, 0.5)
		Search.BackgroundColor3 = Color3.fromRGB(31, 35, 44)
		Search.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Search.BorderSizePixel = 0
		Search.ClipsDescendants = true
		Search.Position = UDim2.new(0.76, 0, 0.0679462031, 0)
		Search.Size = UDim2.new(0.3, 0, 0.0766331404, 0)

		UICorner_5.CornerRadius = UDim.new(0, 25)
		UICorner_5.Parent = Search

		Searchicon.Name = "Search icon"
		Searchicon.Parent = Search
		Searchicon.AnchorPoint = Vector2.new(0.5, 0.5)
		Searchicon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Searchicon.BackgroundTransparency = 1.000
		Searchicon.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Searchicon.BorderSizePixel = 0
		Searchicon.Position = UDim2.new(0.0469209366, 0, 0.501067936, 0)
		Searchicon.Size = UDim2.new(0.0370544589, 0, 0.298804998, 0)
		Searchicon.Image = "rbxassetid://82658488651944"

		TextBox.Parent = Search
		TextBox.AnchorPoint = Vector2.new(0.5, 0.5)
		TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TextBox.BackgroundTransparency = 1.000
		TextBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TextBox.BorderSizePixel = 0
		TextBox.Position = UDim2.new(0.503854513, 0, 0.499999642, 0)
		TextBox.Size = UDim2.new(0.847000003, 0, 0.400000006, 0)
		TextBox.Font = Enum.Font.SourceSans
		TextBox.PlaceholderColor3 = Color3.fromRGB(116, 116, 116)
		TextBox.PlaceholderText = "Search ..."
		TextBox.Text = ""
		TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
		TextBox.TextScaled = true
		TextBox.TextSize = 14.000
		TextBox.TextWrapped = true
		TextBox.TextXAlignment = Enum.TextXAlignment.Left
		self.SearchTextBox = TextBox

		SearchButton.Name = "SearchButton"
		SearchButton.Parent = Main
		SearchButton.AnchorPoint = Vector2.new(0.5, 0.5)
		SearchButton.BackgroundColor3 = Color3.fromRGB(18, 23, 29)
		SearchButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
		SearchButton.BorderSizePixel = 0
		SearchButton.ClipsDescendants = true
		SearchButton.Position = UDim2.new(0.951478779, 0, 0.0679462254, 0)
		SearchButton.Size = UDim2.new(0.0448451973, 0, 0.0766331404, 0)
		SearchButton.Text = ""

		local SearchBool = false
		SearchButton.MouseButton1Click:Connect(function()
			SearchBool = not SearchBool
			TweenService:Create(
				Search,
				TweenInfo.new(.4,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
				{Size = SearchBool and UDim2.new(0, 0, 0.0766331404, 0) or UDim2.new(0.3, 0, 0.0766331404, 0) }
			):Play()
		end)

		UICorner_6.CornerRadius = UDim.new(0, 25)
		UICorner_6.Parent = SearchButton

		Searchicon_2.Name = "Search icon"
		Searchicon_2.Parent = SearchButton
		Searchicon_2.AnchorPoint = Vector2.new(0.5, 0.5)
		Searchicon_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Searchicon_2.BackgroundTransparency = 1.000
		Searchicon_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Searchicon_2.BorderSizePixel = 0
		Searchicon_2.Position = UDim2.new(0.5, 0, 0.5, 0)
		Searchicon_2.Size = UDim2.new(0.400000006, 0, 0.400000006, 0)
		Searchicon_2.Image = "rbxassetid://105161359770858"

		local ScrollingFrame = Instance.new("ScrollingFrame")
		local UIListLayout = Instance.new("UIListLayout")
		ScrollingFrame.Parent = Tap
		ScrollingFrame.Active = true
		ScrollingFrame.AnchorPoint = Vector2.new(0.5, 0.5)
		ScrollingFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ScrollingFrame.BackgroundTransparency = 1.000
		ScrollingFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ScrollingFrame.BorderSizePixel = 0
		ScrollingFrame.Position = UDim2.new(0.499999732, 0, 0.567104876, 0)
		ScrollingFrame.Size = UDim2.new(0.700000048, 0, 0.86578995, 0)
		ScrollingFrame.ScrollBarThickness = 0
		ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(213, 55, 102)

		UIListLayout.Parent = ScrollingFrame
		UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout.Padding = UDim.new(0, 15)

		local Bottom = Instance.new("Frame")
		Bottom.Name = "Bottom"
		Bottom.Parent = Main
		Bottom.AnchorPoint = Vector2.new(0.5, 0.5)
		Bottom.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Bottom.BackgroundTransparency = 1.000
		Bottom.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Bottom.BorderSizePixel = 0
		Bottom.ClipsDescendants = true
		Bottom.Position = UDim2.new(0.536950707, 0, 0.567023933, 0)
		Bottom.Size = UDim2.new(0.873901486, 0, 0.794294596, 0)

		local Title = Instance.new("TextLabel")
		Title.Size = UDim2.new(0.56, 0, 0.03, 0)
		Title.Position = UDim2.new(0, 0, 0, 0)
		Title.AnchorPoint = Vector2.new(0.5, 0.5)
		Title.BackgroundColor3 = Color3.new(1, 1, 1)
		Title.BackgroundTransparency = 1
		Title.TextScaled = true
		Title.Visible = false
		Title.Text = "Follow Me!"
		Title.TextColor3 = Color3.fromRGB(213, 55, 102)
		Title.Parent = Main
		Title.ZIndex = self.setZdix
		Title.FontFace = Font.new(
			"rbxasset://fonts/families/Nunito.json",
			Enum.FontWeight.Bold,
			Enum.FontStyle.Normal
		)

		local UIStroke1 = Instance.new("UIStroke")
		UIStroke1.Parent = Title 
		UIStroke1.Color = Color3.fromRGB(30, 30, 30)
		UIStroke1.Thickness = 1

		local function updateTitlePosition()
			local mousePosition = UserInputService:GetMouseLocation()
			local relativeX = mousePosition.X - Main.AbsolutePosition.X + 30
			local relativeY = mousePosition.Y - Main.AbsolutePosition.Y - 50
			Title.Position = UDim2.new( 0, relativeX, 0, relativeY)
		end

		self.CheckTap = {
			value = false
		}
		self.CreateTap = function(tapSetUp : table)
			if type(tapSetUp) ~= 'table' then
				assert(type(tapSetUp) == 'table', "need Table")
			end
			self.Tap = {}
			local TapIcon = tapSetUp['Icon']
			local nameTap = tapSetUp['Title'] or ''
			local ImageButton = Instance.new("ImageButton")
			ImageButton.Parent = ScrollingFrame
			ImageButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ImageButton.BackgroundTransparency = 1.000
			ImageButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ImageButton.BorderSizePixel = 0
			ImageButton.Size = UDim2.new(0.476000011, 0, 0.0199999996, 0)
			ImageButton.ImageColor3 = Color3.fromRGB(255, 255, 255)
			ImageButton.ImageTransparency = 0.5

			local UserInputService = game:GetService("UserInputService")
			local RunService = game:GetService("RunService")
			local setTitle 

			ImageButton.MouseEnter:Connect(function()
				Title.Visible = true
				Title.Text = nameTap
				setTitle = RunService.RenderStepped:Connect(updateTitlePosition)
			end)

			ImageButton.MouseLeave:Connect(function()
				Title.Visible = false
				Title.Text = ''
				setTitle:Disconnect(updateTitlePosition)
			end)

			if type(TapIcon) == 'string' and not TapIcon:find('rbxassetid://') then
				if IconGen["lucide-"..TapIcon] then
					ImageButton.Image = IconGen["lucide-"..TapIcon]
				else
					ImageButton.Image = "rbxassetid://".. TapIcon
				end
			elseif type(TapIcon) == 'number' then
				ImageButton.Image = "rbxassetid://".. TapIcon
			else
				ImageButton.Image = TapIcon
			end

			self.Tap.setPlayerInfo = function()
				if Bottom:FindFirstChild('Maininfo') then
					assert(not Bottom:FindFirstChild('Maininfo'), "01213912-391203-123182390 -127S3089")
					return
				end -- 

				local Maininfo = Instance.new("Frame")
				local Title = Instance.new("TextLabel")
				local UIListLayout_2 = Instance.new("UIListLayout")
				local UIPadding = Instance.new("UIPadding")
				local Playerinfo = Instance.new("Frame")
				local UICorner_7 = Instance.new("UICorner")
				local UserBackgroundFolder = Instance.new("Folder")
				local UserBackground2 = Instance.new("Frame")
				local UICorner_8 = Instance.new("UICorner")
				local UserBackgroun3 = Instance.new("Frame")
				local UICorner_9 = Instance.new("UICorner")
				local UIGradient = Instance.new("UIGradient")
				local UserName = Instance.new("TextLabel")
				local Buyer = Instance.new("Frame")
				local UICorner_10 = Instance.new("UICorner")
				local UserName_2 = Instance.new("TextLabel")
				local Player = Instance.new("Frame")
				local UICorner_11 = Instance.new("UICorner")
				local UserName_3 = Instance.new("TextLabel")
				local PlayerIcon = Instance.new("Frame")
				local UICorner_12 = Instance.new("UICorner")
				local ImageLabel = Instance.new("ImageLabel")
				local Title_2 = Instance.new("TextLabel")
				local Wifi = Instance.new("Frame")
				local UICorner_13 = Instance.new("UICorner")
				local WifiText = Instance.new("TextLabel")
				local ImageLabel_2 = Instance.new("ImageLabel")


				Maininfo.Name = "Maininfo"
				Maininfo.Parent = Bottom
				Maininfo.AnchorPoint = Vector2.new(0.5, 0.5)
				Maininfo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Maininfo.BackgroundTransparency = 1.000
				Maininfo.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Maininfo.BorderSizePixel = 0
				Maininfo.ClipsDescendants = true
				Maininfo.Position = UDim2.new(0.146114752, 0, 0.49459818, 0)
				Maininfo.Size = UDim2.new(0.279205292, 0, 1.0108037, 0)
				Maininfo.ZIndex = self.setZdix

				Title.Name = "Title"
				Title.Parent = Maininfo
				Title.AnchorPoint = Vector2.new(0.5, 0.5)
				Title.BackgroundColor3 = Color3.fromRGB(27, 31, 40)
				Title.BackgroundTransparency = 0
				Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Title.BorderSizePixel = 0
				Title.Position = UDim2.new(0.50000006, 0, 0.0188739579, 0)
				Title.Size = UDim2.new(1.00000012, 0, 0.0377479158, 0)
				Title.FontFace = Font.new(
					"rbxasset://fonts/families/Nunito.json",
					Enum.FontWeight.Bold,
					Enum.FontStyle.Normal
				)
				Title.Text = "Player performance ;"
				Title.TextColor3 = Color3.fromRGB(255, 255, 255)
				Title.TextScaled = true
				Title.TextSize = 14.000
				Title.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
				Title.TextWrapped = true
				Title.TextXAlignment = Enum.TextXAlignment.Left

				UIListLayout_2.Parent = Maininfo
				UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
				UIListLayout_2.Padding = UDim.new(0, 5)

				UIPadding.Parent = Maininfo
				UIPadding.PaddingLeft = UDim.new(0, 5)
				UIPadding.PaddingTop = UDim.new(0, 5)

				Playerinfo.Name = "Playerinfo"
				Playerinfo.Parent = Maininfo
				Playerinfo.BackgroundColor3 = Color3.fromRGB(21, 25, 34)
				Playerinfo.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Playerinfo.BorderSizePixel = 0
				Playerinfo.ClipsDescendants = true
				Playerinfo.Position = UDim2.new(0, 0, 0.0466152802, 0)
				Playerinfo.Size = UDim2.new(1.00000024, 0, 0.88158232, 0)

				UICorner_7.CornerRadius = UDim.new(0.100000001, 0)
				UICorner_7.Parent = Playerinfo

				UserBackgroundFolder.Name = "UserBackgroundFolder"
				UserBackgroundFolder.Parent = Playerinfo

				UserBackground2.Name = "UserBackground2"
				UserBackground2.Parent = UserBackgroundFolder
				UserBackground2.BackgroundColor3 = Color3.fromRGB(213, 55, 102)
				UserBackground2.BorderColor3 = Color3.fromRGB(0, 0, 0)
				UserBackground2.BorderSizePixel = 0
				UserBackground2.Position = UDim2.new(-0.0289919209, 0, 0.17236276, 0)
				UserBackground2.Size = UDim2.new(0.108719751, 0, 0.099999994, 0)
				UserBackground2.ZIndex = -1

				UICorner_8.CornerRadius = UDim.new(1, 0)
				UICorner_8.Parent = UserBackground2

				UserBackgroun3.Name = "UserBackgroun3"
				UserBackgroun3.Parent = UserBackgroundFolder
				UserBackgroun3.AnchorPoint = Vector2.new(0.5, 0.5)
				UserBackgroun3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				UserBackgroun3.BorderColor3 = Color3.fromRGB(0, 0, 0)
				UserBackgroun3.BorderSizePixel = 0
				UserBackgroun3.Position = UDim2.new(0.49999994, 0, 0.120108932, 0)
				UserBackgroun3.Size = UDim2.new(1.00000012, 0, 0.240217865, 0)

				UICorner_9.CornerRadius = UDim.new(0.100000001, 0)
				UICorner_9.Parent = UserBackgroun3

				UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(213, 55, 102)), ColorSequenceKeypoint.new(0.73, Color3.fromRGB(229, 131, 160)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(235, 160, 182)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 255, 255))}
				UIGradient.Offset = Vector2.new(1, 0)
				UIGradient.Rotation = -73
				UIGradient.Parent = UserBackgroun3

				UserName.Name = "UserName"
				UserName.Parent = UserBackgroun3
				UserName.AnchorPoint = Vector2.new(0.5, 0.5)
				UserName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				UserName.BackgroundTransparency = 1.000
				UserName.BorderColor3 = Color3.fromRGB(0, 0, 0)
				UserName.BorderSizePixel = 0
				UserName.Position = UDim2.new(0.734746635, 0, 0.895992994, 0)
				UserName.Size = UDim2.new(0.53050673, 0, 0.12959069, 0)
				UserName.FontFace = Font.new(
					"rbxasset://fonts/families/Nunito.json",
					Enum.FontWeight.Bold,
					Enum.FontStyle.Normal
				)
				UserName.Text =  "UserId : " ..  setBlurText(game.Players.LocalPlayer.UserId)
				UserName.TextColor3 = Color3.fromRGB(255, 121, 123)
				UserName.TextScaled = true
				UserName.TextSize = 14.000
				UserName.TextWrapped = true
				UserName.TextXAlignment = Enum.TextXAlignment.Left
				UserName.MouseEnter:Connect(function()
					UserName.Text = "UserId : " .. game.Players.LocalPlayer.UserId
				end)
				UserName.MouseLeave:Connect(function()
					UserName.Text = "UserId : " ..  setBlurText(game.Players.LocalPlayer.UserId)
				end)

				Buyer.Name = "Buyer"
				Buyer.Parent = UserBackgroun3
				Buyer.BackgroundColor3 = Color3.fromRGB(255, 249, 75)
				Buyer.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Buyer.BorderSizePixel = 0
				Buyer.Position = UDim2.new(0.735668898, 0, 0.0763344765, 0)
				Buyer.Size = UDim2.new(0.225291327, 0, 0.134341106, 0)

				UICorner_10.CornerRadius = UDim.new(0.300000012, 0)
				UICorner_10.Parent = Buyer

				UserName_2.Name = "UserName"
				UserName_2.Parent = Buyer
				UserName_2.AnchorPoint = Vector2.new(0.5, 0.5)
				UserName_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				UserName_2.BackgroundTransparency = 1.000
				UserName_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
				UserName_2.BorderSizePixel = 0
				UserName_2.Position = UDim2.new(0.5, 0, 0.5, 0)
				UserName_2.Size = UDim2.new(0.600000024, 0, 1, 0)
				UserName_2.FontFace = Font.new(
					"rbxasset://fonts/families/Nunito.json",
					Enum.FontWeight.Bold,
					Enum.FontStyle.Normal
				)
				UserName_2.Text = "Buyer"
				UserName_2.TextColor3 = Color3.fromRGB(13, 6, 6)
				UserName_2.TextScaled = true
				UserName_2.TextSize = 14.000
				UserName_2.TextWrapped = true

				Player.Name = "Player"
				Player.Parent = UserBackgroun3
				Player.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
				Player.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Player.BorderSizePixel = 0
				Player.Position = UDim2.new(0.735668898, 0, 0.262929887, 0)
				Player.Size = UDim2.new(0.225291327, 0, 0.134341106, 0)

				UICorner_11.CornerRadius = UDim.new(0.300000012, 0)
				UICorner_11.Parent = Player

				UserName_3.Name = "UserName"
				UserName_3.Parent = Player
				UserName_3.AnchorPoint = Vector2.new(0.5, 0.5)
				UserName_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				UserName_3.BackgroundTransparency = 1.000
				UserName_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
				UserName_3.BorderSizePixel = 0
				UserName_3.Position = UDim2.new(0.5, 0, 0.5, 0)
				UserName_3.Size = UDim2.new(0.600000024, 0, 1, 0)
				UserName_3.FontFace = Font.new(
					"rbxasset://fonts/families/Nunito.json",
					Enum.FontWeight.Bold,
					Enum.FontStyle.Normal
				)
				UserName_3.Text = "Player"
				UserName_3.TextColor3 = Color3.fromRGB(213, 55, 102)
				UserName_3.TextScaled = true
				UserName_3.TextSize = 14.000
				UserName_3.TextWrapped = true

				PlayerIcon.Name = "PlayerIcon"
				PlayerIcon.Parent = Playerinfo
				PlayerIcon.BackgroundColor3 = Color3.fromRGB(21, 25, 34)
				PlayerIcon.BorderColor3 = Color3.fromRGB(0, 0, 0)
				PlayerIcon.BorderSizePixel = 0
				PlayerIcon.Position = UDim2.new(0.0797276944, 0, 0.136508077, 0)
				PlayerIcon.Size = UDim2.new(0.364761829, 0, 0.203743398, 0)

				UICorner_12.CornerRadius = UDim.new(1, 0)
				UICorner_12.Parent = PlayerIcon

				ImageLabel.Parent = PlayerIcon
				ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
				ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ImageLabel.BackgroundTransparency = 1.000
				ImageLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ImageLabel.BorderSizePixel = 0
				ImageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
				ImageLabel.Size = UDim2.new(0.5, 0, 0.5, 0)
				ImageLabel.Image = "rbxassetid://72132653245812"
				spawn(function()
					local userId = game.Players.LocalPlayer.UserId
					local thumbType = Enum.ThumbnailType.HeadShot
					local thumbSize = Enum.ThumbnailSize.Size420x420
					local content, isReady = game.Players:GetUserThumbnailAsync(userId, thumbType, thumbSize)
					ImageLabel.Image = content
				end)

				Title_2.Name = "Title"
				Title_2.Parent = Playerinfo
				Title_2.AnchorPoint = Vector2.new(0.5, 0.5)
				Title_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Title_2.BackgroundTransparency = 1.000
				Title_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Title_2.BorderSizePixel = 0
				Title_2.Position = UDim2.new(0.498188496, 0, 0.359125435, 0)
				Title_2.Size = UDim2.new(0.916648865, 0, 0.0377479158, 0)
				Title_2.FontFace = Font.new(
					"rbxasset://fonts/families/Nunito.json",
					Enum.FontWeight.Bold,
					Enum.FontStyle.Normal
				)
				Title_2.Text = "Stast ;"
				Title_2.TextColor3 = Color3.fromRGB(255, 255, 255)
				Title_2.TextScaled = true
				Title_2.TextSize = 14.000
				Title_2.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
				Title_2.TextWrapped = true
				Title_2.TextXAlignment = Enum.TextXAlignment.Left

				Wifi.Name = "Wifi"
				Wifi.Parent = Playerinfo
				Wifi.BackgroundColor3 = Color3.fromRGB(123, 255, 121)
				Wifi.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Wifi.BorderSizePixel = 0
				Wifi.Position = UDim2.new(0.467494011, 0, 0.252641827, 0)
				Wifi.Size = UDim2.new(0.218043581, 0, 0.039839536, 0)

				UICorner_13.CornerRadius = UDim.new(0.300000012, 0)
				UICorner_13.Parent = Wifi

				WifiText.Name = "WifiText"
				WifiText.Parent = Wifi
				WifiText.AnchorPoint = Vector2.new(0.5, 0.5)
				WifiText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				WifiText.BackgroundTransparency = 1.000
				WifiText.BorderColor3 = Color3.fromRGB(0, 0, 0)
				WifiText.BorderSizePixel = 0
				WifiText.Position = UDim2.new(0.682824612, 0, 0.498020917, 0)
				WifiText.Size = UDim2.new(0.600000024, 0, 0.658582449, 0)
				WifiText.FontFace = Font.new(
					"rbxasset://fonts/families/Nunito.json",
					Enum.FontWeight.Bold,
					Enum.FontStyle.Normal
				)
				WifiText.Text = "45ms"
				WifiText.TextColor3 = Color3.fromRGB(0, 0, 0)
				WifiText.TextScaled = true
				WifiText.TextSize = 14.000
				WifiText.TextWrapped = true

				ImageLabel_2.Parent = Wifi
				ImageLabel_2.AnchorPoint = Vector2.new(0.5, 0.5)
				ImageLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ImageLabel_2.BackgroundTransparency = 1.000
				ImageLabel_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ImageLabel_2.BorderSizePixel = 0
				ImageLabel_2.Position = UDim2.new(0.230000004, 0, 0.5, 0)
				ImageLabel_2.Size = UDim2.new(0.240805149, 0, 0.827312052, 0)
				ImageLabel_2.Image = "rbxassetid://129165097644143"
				ImageLabel_2.ImageColor3 = Color3.fromRGB(47, 255, 0)

				local function tweenWifiColor(ping)
					local color
					local color2
					if ping <= 100 then
						color = Color3.fromRGB(123, 255, 121)
					elseif ping <= 200 then
						color = Color3.fromRGB(255, 221, 51)
					else
						color = Color3.fromRGB(255, 80, 80)
					end
					if ping <= 100 then
						color2 = Color3.fromRGB(47, 255, 0)
					elseif ping <= 200 then
						color2 = Color3.fromRGB(255, 238, 0)
					else
						color2 = Color3.fromRGB(255, 26, 30)
					end

					local tween = TweenService:Create(
						Wifi,
						TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
						{BackgroundColor3 = color}
					)
					tween:Play()
					local tween = TweenService:Create(
						ImageLabel_2,
						TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
						{ImageColor3 = color2}
					)
					tween:Play()
				end

				spawn(function()
					while wait(1) do
						local ping = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()
						WifiText.Text = "".. math.floor(ping) .."ms"
						tweenWifiColor(ping)
					end
				end)


				local DataFrame = Instance.new("Frame")
				DataFrame.Name = "DataFrame"
				DataFrame.Parent = Playerinfo
				DataFrame.AnchorPoint = Vector2.new(0.5, 0.5)
				DataFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				DataFrame.BackgroundTransparency = 1.000
				DataFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
				DataFrame.BorderSizePixel = 0
				DataFrame.Position = UDim2.new(0.531470716, 0, 0.687750936, 0)
				DataFrame.Size = UDim2.new(0.85897851, 0, 0.586043715, 0)

				self.Data = {} 
				self.Data.CreateData = function( o : table )
					if type(o) ~= 'table' then
						assert(type(o) == 'table', "need Table")
					end

					self.Data.New = {}
					local UIGridLayout = Instance.new("UIGridLayout")
					local Data1 = Instance.new("Frame")
					local UICorner_14 = Instance.new("UICorner")
					local setDataFrame = Instance.new("Frame")
					local UICorner_15 = Instance.new("UICorner")
					local IconData = Instance.new("ImageLabel")
					local TextLabel = Instance.new("TextLabel")
					local TextLabel_2 = Instance.new("TextLabel")

					UIGridLayout.Parent = DataFrame
					UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
					UIGridLayout.CellSize = UDim2.new(0.449999988, 0, 0.150000006, 0)

					Data1.Name = "Data1"
					Data1.Parent = DataFrame
					Data1.BackgroundColor3 = Color3.fromRGB(19, 22, 27)
					Data1.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Data1.BorderSizePixel = 0
					Data1.Size = UDim2.new(0, 100, 0, 100)

					UICorner_14.CornerRadius = UDim.new(0.200000003, 0)
					UICorner_14.Parent = Data1

					setDataFrame.Name = "setDataFrame"
					setDataFrame.Parent = Data1
					setDataFrame.AnchorPoint = Vector2.new(0.5, 0.5)
					setDataFrame.BackgroundColor3 = Color3.fromRGB(30, 35, 42)
					setDataFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
					setDataFrame.BorderSizePixel = 0
					setDataFrame.Position = UDim2.new(0.216000006, 0, 0.5, 0)
					setDataFrame.Size = UDim2.new(0.213, 0, 0.5, 0)

					UICorner_15.CornerRadius = UDim.new(0.200000003, 0)
					UICorner_15.Parent = setDataFrame

					IconData.Name = "IconData"
					IconData.Parent = setDataFrame
					IconData.AnchorPoint = Vector2.new(0.5, 0.5)
					IconData.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					IconData.BackgroundTransparency = 1.000
					IconData.BorderColor3 = Color3.fromRGB(0, 0, 0)
					IconData.BorderSizePixel = 0
					IconData.Position = UDim2.new(0.5, 0, 0.5, 0)
					IconData.Size = UDim2.new(0.5, 0, 0.5, 0)
					IconData.Image = "rbxassetid://".. o['Icon'] or 82957051825102
					IconData.ImageColor3 = Color3.fromRGB(255, 255, 97)

					TextLabel.Parent = Data1
					TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
					TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					TextLabel.BackgroundTransparency = 1.000
					TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
					TextLabel.BorderSizePixel = 0
					TextLabel.Position = UDim2.new(0.632000029, 0, 0.649999976, 0)
					TextLabel.Size = UDim2.new(0.495601296, 0, 0.3, 0)
					TextLabel.FontFace = Font.new(
						"rbxasset://fonts/families/Nunito.json",
						Enum.FontWeight.Bold,
						Enum.FontStyle.Normal
					)
					TextLabel.Text = o['Value']
					TextLabel.TextColor3 = Color3.fromRGB(213, 55, 102)
					TextLabel.TextScaled = true
					TextLabel.TextSize = 14.000
					TextLabel.TextWrapped = true
					TextLabel.TextXAlignment = Enum.TextXAlignment.Left

					TextLabel_2.Parent = Data1
					TextLabel_2.AnchorPoint = Vector2.new(0.5, 0.5)
					TextLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					TextLabel_2.BackgroundTransparency = 1.000
					TextLabel_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
					TextLabel_2.BorderSizePixel = 0
					TextLabel_2.Position = UDim2.new(0.632000029, 0, 0.300000012, 0)
					TextLabel_2.Size = UDim2.new(0.495601296, 0, 0.3, 0)
					TextLabel_2.FontFace = Font.new(
						"rbxasset://fonts/families/Nunito.json",
						Enum.FontWeight.Bold,
						Enum.FontStyle.Normal
					)
					TextLabel_2.Text = o['Title']
					TextLabel_2.TextColor3 = Color3.fromRGB(213, 213, 213)
					TextLabel_2.TextScaled = true
					TextLabel_2.TextSize = 14.000
					TextLabel_2.TextWrapped = true
					TextLabel_2.TextXAlignment = Enum.TextXAlignment.Left

					self.Data.New.SetText = function(Value)
						TextLabel.Text = Value
					end
					self.Data.New.SetTitle = function(Value)
						TextLabel_2.Text = Value
					end

					return self.Data.New
				end
				return self.Data
			end

			local MainScrollingFrame = Instance.new("ScrollingFrame")
			MainScrollingFrame.Name = "MainScrollingFrame"
			MainScrollingFrame.Parent = Bottom
			MainScrollingFrame.Active = true
			MainScrollingFrame.AnchorPoint = Vector2.new(0.5, 0.5)
			MainScrollingFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			MainScrollingFrame.BackgroundTransparency = 1.000
			MainScrollingFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			MainScrollingFrame.BorderSizePixel = 0
			MainScrollingFrame.Position = UDim2.new(2, 0, 0.513000011, 0)
			MainScrollingFrame.Size = UDim2.new(0.694999993, 0, 1.028, 0)
			MainScrollingFrame.ScrollBarThickness = 2
			MainScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(213, 55, 102)

			local UIListLayout_3 = Instance.new("UIListLayout")
			UIListLayout_3.Parent = MainScrollingFrame
			UIListLayout_3.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout_3.Padding = UDim.new(0, 5)

			if not self.CheckTap.value then
				self.CheckTap.value = true
				ImageButton.ImageColor3 = Color3.fromRGB(213, 55, 102)
				ImageButton.ImageTransparency = 0
				self.NowTap = nameTap
				TweenService:Create(
					MainScrollingFrame,
					TweenInfo.new(0.5,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
					{Position =  UDim2.new(0.65200001, 0, 0.513000011, 0)}
				):Play()
			end

			UIListLayout_3:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
				local contentHeight = UIListLayout_3.AbsoluteContentSize.Y
				local parentHeight = MainScrollingFrame.AbsoluteSize.Y
				local scaleHeight = contentHeight / parentHeight

				MainScrollingFrame.CanvasSize = UDim2.new(0, 0, scaleHeight + 0.25, 0)
				if MainScrollingFrame.CanvasSize.Y.Scale < 2 then
					MainScrollingFrame.CanvasSize = UDim2.new(0, 0, 2, 0)
				end
			end)

			self.SearchTextBox.Changed:Connect(function()
				local InputText = string.upper(self.SearchTextBox.Text)

				if InputText ~= "" and InputText ~= "SEARCH" then
					for _, button in pairs(MainScrollingFrame:GetChildren()) do
						if button:IsA('TextLabel') and string.upper(button.Text):find(InputText) then
							button.Visible = true
						elseif button:IsA('Frame') and button.Name == "setGroupFrame" then
							local hiddenCount = 0
							for _, childButton in pairs(button:GetChildren()) do
								if childButton:IsA('Frame') and childButton:FindFirstChild("Title") then
									if string.upper(childButton.Title.Text):find(InputText) then
										childButton.Visible = true
									else
										childButton.Visible = false
										hiddenCount = hiddenCount + 1
									end
								end
							end

							if hiddenCount >= 3 then
								button.Visible = false
							else
								button.Visible = true
							end
						end
					end
				else
					for _, button in pairs(MainScrollingFrame:GetChildren()) do
						if button:FindFirstChild("TextLabel") then
							button.Visible = true
						elseif button:IsA('Frame') and button.Name == "setGroupFrame" then
							for _, childButton in pairs(button:GetChildren()) do
								if childButton:FindFirstChild("Title") then
									childButton.Visible = true
								end
							end

							button.Visible = true
						end
					end
				end
			end)

			ImageButton.MouseButton1Click:Connect(function()
				if self.NowTap ~= nameTap then
					self.NowTap = nameTap
					for _, v in pairs(Bottom:GetChildren()) do
						if v:IsA("ScrollingFrame") then
							TweenService:Create(
								v,
								TweenInfo.new(0.95,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
								{Position =  UDim2.new( 2, 0, 0.513000011, 0)}
							):Play()
						end
					end
					for _, v in pairs(ScrollingFrame:GetChildren()) do
						if v:IsA("ImageButton") then
							TweenService:Create(
								v,
								TweenInfo.new(0.9,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
								{ImageColor3 = Color3.fromRGB(255, 255, 255)}
							):Play()
							TweenService:Create(
								v,
								TweenInfo.new(0.9,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
								{ImageTransparency =  .5}
							):Play()
						end
					end

					TweenService:Create(
						MainScrollingFrame,
						TweenInfo.new(0.5,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
						{Position =  UDim2.new(0.65200001, 0, 0.513000011, 0)}
					):Play()
					ImageButton.ImageColor3 = Color3.fromRGB(213, 55, 102)
					ImageButton.ImageTransparency = 0
					TweenService:Create(
						ImageButton,
						TweenInfo.new(0.9,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
						{ImageColor3 = Color3.fromRGB(213, 55, 102)}
					):Play()
					TweenService:Create(
						ImageButton,
						TweenInfo.new(0.9,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
						{ImageTransparency = 0}
					):Play()
				end
			end)

			self.Tap.CreateLabel = function(dd)
				self.Lable = {}
				local TextLabel_3 = Instance.new("TextLabel")
				TextLabel_3.Parent = MainScrollingFrame
				TextLabel_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TextLabel_3.BackgroundTransparency = 1.000
				TextLabel_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
				TextLabel_3.BorderSizePixel = 0
				TextLabel_3.Size = UDim2.new(1, 0, 0.0189999994, 0)
				TextLabel_3.FontFace = Font.new(
					"rbxasset://fonts/families/Nunito.json",
					Enum.FontWeight.Bold,
					Enum.FontStyle.Normal
				)
				TextLabel_3.Text = dd or "None"
				TextLabel_3.TextColor3 = Color3.fromRGB(255, 255, 255)
				TextLabel_3.TextScaled = true
				TextLabel_3.TextSize = 14.000
				TextLabel_3.TextWrapped = true
				TextLabel_3.TextXAlignment = Enum.TextXAlignment.Left

				self.Lable.Set = function(dd)
					TextLabel_3.Text = dd or "None"
				end

				local canvasSize = MainScrollingFrame.CanvasSize
				local Pars = TextLabel_3.Size.Y.Scale +  TextLabel_3.Size.Y.Scale
				local function updateSize()
					canvasSize = MainScrollingFrame.CanvasSize
					if canvasSize.Y.Scale >= 2 then
						TextLabel_3.Size = UDim2.new(1, 0, Pars / canvasSize.Y.Scale, 0)
					end
				end

				TextLabel_3.Size = UDim2.new(1, 0, Pars, 0)
				UIListLayout_3:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
					updateSize()
				end)
				return self.Lable
			end
			self.Tap.CreateGroup = function()
				self.Group = {}
				self.setZdix = self.setZdix - 1
				local setGroupFrame = Instance.new("Frame")
				local UIGridLayout_2 = Instance.new("UIGridLayout")
				setGroupFrame.Name = "setGroupFrame"
				setGroupFrame.Parent = MainScrollingFrame
				setGroupFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				setGroupFrame.BackgroundTransparency = 1.000
				setGroupFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
				setGroupFrame.BorderSizePixel = 0
				setGroupFrame.ZIndex = self.setZdix
				setGroupFrame.Position = UDim2.new(7.94564698e-08, 0, 0.0456072874, 0)
				setGroupFrame.Size = UDim2.new(0.99999994, 0, 0.116221093, 0)

				UIGridLayout_2.Parent = setGroupFrame
				UIGridLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
				UIGridLayout_2.CellSize = UDim2.new(0.319999993, 0, 1, 0)
				self.Group.CreateToggle = function(o : teble)
					local Title = o['Title'] or "Kuy"
					local getDis = o['Dis'] or nil
					local Value = o['Value'] or false
					local Callback = o['Callback'] or function() end

					local addToggle = Instance.new("Frame")
					local setDataFrame_2 = Instance.new("Frame")
					local UICorner_16 = Instance.new("UICorner")
					local IconData_2 = Instance.new("ImageLabel")
					local Stast = Instance.new("Frame")
					local UICorner_17 = Instance.new("UICorner")
					local TextStats = Instance.new("TextLabel")
					local UICorner_18 = Instance.new("UICorner")
					local ButtonToggle = Instance.new("TextButton")
					local UICorner_19 = Instance.new("UICorner")
					local UIGradient_2 = Instance.new("UIGradient")
					local ToggleMove = Instance.new("Frame")
					local UICorner_20 = Instance.new("UICorner")
					local UIGradient_3 = Instance.new("UIGradient")
					local Dis = Instance.new("TextLabel")
					local Title_3 = Instance.new("TextLabel")

					addToggle.Name = "addToggle"
					addToggle.Parent = setGroupFrame
					addToggle.BackgroundColor3 = Color3.fromRGB(20, 24, 33)
					addToggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
					addToggle.BorderSizePixel = 0
					addToggle.Size = UDim2.new(0, 245, 0, 144)

					setDataFrame_2.Name = "setDataFrame"
					setDataFrame_2.Parent = addToggle
					setDataFrame_2.AnchorPoint = Vector2.new(0.5, 0.5)
					setDataFrame_2.BackgroundColor3 = Color3.fromRGB(30, 35, 42)
					setDataFrame_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
					setDataFrame_2.BorderSizePixel = 0
					setDataFrame_2.Position = UDim2.new(0.132828265, 0, 0.226702794, 0)
					setDataFrame_2.Size = UDim2.new(0.13615489, 0, 0.256266862, 0)

					UICorner_16.CornerRadius = UDim.new(0.200000003, 0)
					UICorner_16.Parent = setDataFrame_2

					IconData_2.Name = "IconData"
					IconData_2.Parent = setDataFrame_2
					IconData_2.AnchorPoint = Vector2.new(0.5, 0.5)
					IconData_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					IconData_2.BackgroundTransparency = 1.000
					IconData_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
					IconData_2.BorderSizePixel = 0
					IconData_2.Position = UDim2.new(0.5, 0, 0.5, 0)
					IconData_2.Size = UDim2.new(0.5, 0, 0.5, 0)
					IconData_2.Image = "rbxassetid://82957051825102"
					IconData_2.ImageColor3 = o['Icon'] and o['Icon']['Color'] or Color3.fromRGB(255, 255, 97)

					if o['Icon'] and type(o['Icon']['Image']) == 'string' and not o['Icon']['Image']:find('rbxassetid://') then
						if IconGen["lucide-"..o['Icon']['Image']] then
							IconData_2.Image = IconGen["lucide-"..o['Icon']['Image']]
						else
							IconData_2.Image = "rbxassetid://".. o['Icon']['Image']
						end
					elseif o['Icon'] and type(o['Icon']) == 'number' then
						IconData_2.Image = "rbxassetid://".. o['Icon']['Image']
					else
						IconData_2.Image = o['Icon'] and o['Icon']['Image'] or "rbxassetid://82957051825102"
					end

					Stast.Name = "Stast"
					Stast.Parent = addToggle
					Stast.BackgroundColor3 = Color3.fromRGB(20, 24, 33)
					Stast.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Stast.BorderSizePixel = 0
					Stast.Position = UDim2.new(0.0813641846, 0, 0.735634208, 0)
					Stast.Size = UDim2.new(0.122963414, 0, 0.12530601, 0)

					UICorner_17.CornerRadius = UDim.new(0.200000003, 0)
					UICorner_17.Parent = Stast

					TextStats.Name = "TextStats"
					TextStats.Parent = Stast
					TextStats.AnchorPoint = Vector2.new(0.5, 0.5)
					TextStats.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					TextStats.BackgroundTransparency = 1.000
					TextStats.BorderColor3 = Color3.fromRGB(0, 0, 0)
					TextStats.BorderSizePixel = 0
					TextStats.Position = UDim2.new(0.5, 0, 0.5, 0)
					TextStats.Size = UDim2.new(0.5, 0, 0.600000024, 0)
					TextStats.FontFace = Font.new(
						"rbxasset://fonts/families/Nunito.json",
						Enum.FontWeight.Bold,
						Enum.FontStyle.Normal
					)
					TextStats.Text = "on"
					TextStats.TextColor3 = Color3.fromRGB(213, 213, 213)
					TextStats.TextScaled = true
					TextStats.TextSize = 14.000
					TextStats.TextWrapped = true

					local UIStroke1 = Instance.new("UIStroke")
					UIStroke1.Parent = Stast
					UIStroke1.Color = Color3.fromRGB(30, 30, 30)
					UIStroke1.Thickness = 1

					UICorner_18.CornerRadius = UDim.new(0.100000001, 0)
					UICorner_18.Parent = addToggle

					ButtonToggle.Name = "ButtonToggle"
					ButtonToggle.Parent = addToggle
					ButtonToggle.AnchorPoint = Vector2.new(0.5, 0.5)
					ButtonToggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					ButtonToggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
					ButtonToggle.BorderSizePixel = 0
					ButtonToggle.Position = UDim2.new(0.81099999, 0, 0.800000012, 0)
					ButtonToggle.Size = UDim2.new(0.227539659, 0, 0.164968848, 0)
					ButtonToggle.Text = ""
					ButtonToggle.AutoButtonColor = false

					UICorner_19.CornerRadius = UDim.new(0, 20)
					UICorner_19.Parent = ButtonToggle

					UIGradient_2.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(51, 255, 99)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(51, 255, 99))}
					UIGradient_2.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 1), NumberSequenceKeypoint.new(0.00, 1), NumberSequenceKeypoint.new(1.00, 0.00)}
					UIGradient_2.Parent = ButtonToggle

					local UIStroke1 = Instance.new("UIStroke")
					UIStroke1.Parent = ButtonToggle 
					UIStroke1.Color = Color3.fromRGB(30, 30, 30)
					UIStroke1.Thickness = 1

					ToggleMove.Name = "ToggleMove"
					ToggleMove.Parent = ButtonToggle
					ToggleMove.AnchorPoint = Vector2.new(0.5, 0.5)
					ToggleMove.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					ToggleMove.BorderColor3 = Color3.fromRGB(0, 0, 0)
					ToggleMove.BorderSizePixel = 0
					ToggleMove.Position = UDim2.new(0.762000024, 0, 0.5, 0)
					ToggleMove.Size = UDim2.new(0.4, 0, 1, 0)

					UICorner_20.CornerRadius = UDim.new(1, 0)
					UICorner_20.Parent = ToggleMove

					UIGradient_3.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(51, 255, 99)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(51, 255, 99))}
					UIGradient_3.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 1), NumberSequenceKeypoint.new(0.00, 1), NumberSequenceKeypoint.new(1.00, 0.00)}
					UIGradient_3.Parent = ToggleMove

					--UIStroke
					local UIStroke1 = Instance.new("UIStroke")
					UIStroke1.Parent = ToggleMove 
					UIStroke1.Color = Color3.fromRGB(30, 30, 30)
					UIStroke1.Thickness = 1

					Title_3.Name = "Title"
					Title_3.Parent = addToggle
					Title_3.AnchorPoint = Vector2.new(0.5, 0.5)
					Title_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Title_3.BackgroundTransparency = 1.000
					Title_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Title_3.BorderSizePixel = 0
					Title_3.Position = UDim2.new(0.586749613, 0, 0.225353912, 0)
					Title_3.Size = UDim2.new(0.739100754, 0, 0.117700331, 0)
					Title_3.FontFace = Font.new(
						"rbxasset://fonts/families/Nunito.json",
						Enum.FontWeight.Bold,
						Enum.FontStyle.Normal
					)
					Title_3.Text = Title
					Title_3.TextColor3 = Color3.fromRGB(213, 213, 213)
					Title_3.TextScaled = true
					Title_3.TextSize = 14.000
					Title_3.TextWrapped = true
					Title_3.TextXAlignment = Enum.TextXAlignment.Left

					local OnOff = Instance.new("Folder")
					local UIGradient_4 = Instance.new("UIGradient")
					local UIGradient_5 = Instance.new("UIGradient")
					OnOff.Name = "On-Off"
					OnOff.Parent = addToggle

					UIGradient_4.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 34, 38)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 34, 38))}
					UIGradient_4.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 0.00), NumberSequenceKeypoint.new(1.00, 0.99), NumberSequenceKeypoint.new(1.00, 1)}
					UIGradient_4.Parent = OnOff

					UIGradient_5.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(51, 255, 99)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(51, 255, 99))}
					UIGradient_5.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 1), NumberSequenceKeypoint.new(0.00, 1), NumberSequenceKeypoint.new(1.00, 0.00)}
					UIGradient_5.Parent = OnOff

					do
						if not Value then
							UIGradient_3.Color = UIGradient_4.Color
							UIGradient_3.Transparency = UIGradient_4.Transparency
							UIGradient_3.Parent = ToggleMove

							UIGradient_2.Color = UIGradient_4.Color
							UIGradient_2.Transparency = UIGradient_4.Transparency
							UIGradient_2.Parent = ButtonToggle
						else
							UIGradient_3.Color = UIGradient_5.Color
							UIGradient_3.Transparency = UIGradient_5.Transparency
							UIGradient_3.Parent = ToggleMove

							UIGradient_2.Color = UIGradient_5.Color
							UIGradient_2.Transparency = UIGradient_5.Transparency
							UIGradient_2.Parent = ButtonToggle
						end
						TweenService:Create(
							ToggleMove,
							TweenInfo.new(0.5,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
							{Position = Value and UDim2.new(0.8, 0, 0.5, 0) or UDim2.new(0.15, 0, 0.5, 0)}
						):Play()
						Callback(Value)
					end
					if getDis then
						Dis.Text = getDis
						Dis.Visible = true
					end
					ButtonToggle.MouseButton1Click:Connect(function()
						Value = not Value
						if not Value then
							UIGradient_3.Color = UIGradient_4.Color
							UIGradient_3.Transparency = UIGradient_4.Transparency
							UIGradient_3.Parent = ToggleMove

							UIGradient_2.Color = UIGradient_4.Color
							UIGradient_2.Transparency = UIGradient_4.Transparency
							UIGradient_2.Parent = ButtonToggle

						else
							UIGradient_3.Color = UIGradient_5.Color
							UIGradient_3.Transparency = UIGradient_5.Transparency
							UIGradient_3.Parent = ToggleMove

							UIGradient_2.Color = UIGradient_5.Color
							UIGradient_2.Transparency = UIGradient_5.Transparency
							UIGradient_2.Parent = ButtonToggle
						end
						TextStats.Text = Value and "on" or "off"
						TweenService:Create(
							ToggleMove,
							TweenInfo.new(0.5,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
							{Position = Value and UDim2.new(0.8, 0, 0.5, 0) or UDim2.new(0.15, 0, 0.5, 0)}
						):Play()
						Callback(Value)
					end)

				end
				self.Group.CreateButton = function(o : teble)
					local Title = o['Title'] or "Kuy"
					local Callback = o['Callback'] or function() end

					local addButton = Instance.new("Frame")
					local Stast_2 = Instance.new("Frame")
					local UICorner_21 = Instance.new("UICorner")
					local TextStats_2 = Instance.new("TextLabel")
					local UICorner_22 = Instance.new("UICorner")
					local ButtonClick = Instance.new("TextButton")
					local UICorner_23 = Instance.new("UICorner")
					local UIGradient_6 = Instance.new("UIGradient")
					local Dis_2 = Instance.new("TextLabel")
					local UICorner_24 = Instance.new("UICorner")
					local UIGradient_7 = Instance.new("UIGradient")
					local Dis_3 = Instance.new("TextLabel")
					local Title_4 = Instance.new("TextLabel")
					local setDataFrame_3 = Instance.new("Frame")
					local UICorner_25 = Instance.new("UICorner")
					local IconData_3 = Instance.new("ImageLabel")

					addButton.Name = "addButton"
					addButton.Parent = setGroupFrame
					addButton.BackgroundColor3 = Color3.fromRGB(20, 24, 33)
					addButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
					addButton.BorderSizePixel = 0
					addButton.Position = UDim2.new(0.318698257, 0, 0, 0)
					addButton.Size = UDim2.new(0, 245, 0, 144)

					Stast_2.Name = "Stast"
					Stast_2.Parent = addButton
					Stast_2.BackgroundColor3 = Color3.fromRGB(20, 24, 33)
					Stast_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Stast_2.BorderSizePixel = 0
					Stast_2.Position = UDim2.new(0.0813639387, 0, 0.747719526, 0)
					Stast_2.Size = UDim2.new(0.203345567, 0, 0.12530601, 0)

					UICorner_21.CornerRadius = UDim.new(0.200000003, 0)
					UICorner_21.Parent = Stast_2

					TextStats_2.Name = "TextStats"
					TextStats_2.Parent = Stast_2
					TextStats_2.AnchorPoint = Vector2.new(0.5, 0.5)
					TextStats_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					TextStats_2.BackgroundTransparency = 1.000
					TextStats_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
					TextStats_2.BorderSizePixel = 0
					TextStats_2.Position = UDim2.new(0.5, 0, 0.5, 0)
					TextStats_2.Size = UDim2.new(0.5, 0, 0.600000024, 0)
					TextStats_2.FontFace = Font.new(
						"rbxasset://fonts/families/Nunito.json",
						Enum.FontWeight.Bold,
						Enum.FontStyle.Normal
					)
					TextStats_2.Text = "click"
					TextStats_2.TextColor3 = Color3.fromRGB(213, 213, 213)
					TextStats_2.TextScaled = true
					TextStats_2.TextSize = 14.000
					TextStats_2.TextWrapped = true

					local UIStroke1 = Instance.new("UIStroke")
					UIStroke1.Parent = Stast_2 
					UIStroke1.Color = Color3.fromRGB(30, 30, 30)
					UIStroke1.Thickness = 1

					UICorner_22.CornerRadius = UDim.new(0.100000001, 0)
					UICorner_22.Parent = addButton

					ButtonClick.Name = "ButtonClick"
					ButtonClick.Parent = addButton
					ButtonClick.AnchorPoint = Vector2.new(0.5, 0.5)
					ButtonClick.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					ButtonClick.BorderColor3 = Color3.fromRGB(0, 0, 0)
					ButtonClick.BorderSizePixel = 0
					ButtonClick.Text = ""
					ButtonClick.Position = UDim2.new(0.79147625, 0, 0.80000025, 0)
					ButtonClick.Size = UDim2.new(0.266586065, 0, 0.164968848, 0)

					UICorner_23.CornerRadius = UDim.new(0, 20)
					UICorner_23.Parent = ButtonClick

					UIGradient_6.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(213, 55, 102)), ColorSequenceKeypoint.new(0.73, Color3.fromRGB(229, 131, 160)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(235, 160, 182)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 255, 255))}
					UIGradient_6.Offset = Vector2.new(1, 0)
					UIGradient_6.Rotation = -73
					UIGradient_6.Parent = ButtonClick

					Dis_2.Name = "Dis"
					Dis_2.Parent = ButtonClick
					Dis_2.AnchorPoint = Vector2.new(0.5, 0.5)
					Dis_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Dis_2.BackgroundTransparency = 1.000
					Dis_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Dis_2.BorderSizePixel = 0
					Dis_2.Position = UDim2.new(0.5, 0, 0.5, 0)
					Dis_2.Size = UDim2.new(0.63, 0, 0.63, 0)
					Dis_2.FontFace = Font.new(
						"rbxasset://fonts/families/Nunito.json",
						Enum.FontWeight.Bold,
						Enum.FontStyle.Normal
					)
					Dis_2.Text = o['Button'] or "click me"
					Dis_2.TextColor3 = Color3.fromRGB(255, 255, 255)
					Dis_2.TextScaled = true
					Dis_2.TextSize = 14.000
					Dis_2.TextWrapped = true
					Dis_2.TextXAlignment = Enum.TextXAlignment.Center

					UICorner_24.CornerRadius = UDim.new(0, 10)
					UICorner_24.Parent = ButtonClick

					UIGradient_7.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(213, 55, 102)), ColorSequenceKeypoint.new(0.73, Color3.fromRGB(229, 131, 160)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(235, 160, 182)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 255, 255))}
					UIGradient_7.Offset = Vector2.new(1, 0)
					UIGradient_7.Rotation = -73
					UIGradient_7.Parent = ButtonClick

					Title_4.Name = "Title"
					Title_4.Parent = addButton
					Title_4.AnchorPoint = Vector2.new(0.5, 0.5)
					Title_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Title_4.BackgroundTransparency = 1.000
					Title_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Title_4.BorderSizePixel = 0
					Title_4.Position = UDim2.new(0.586749613, 0, 0.225353912, 0)
					Title_4.Size = UDim2.new(0.739100754, 0, 0.117700331, 0)
					Title_4.FontFace = Font.new(
						"rbxasset://fonts/families/Nunito.json",
						Enum.FontWeight.Bold,
						Enum.FontStyle.Normal
					)
					Title_4.Text = Title
					Title_4.TextColor3 = Color3.fromRGB(213, 213, 213)
					Title_4.TextScaled = true
					Title_4.TextSize = 14.000
					Title_4.TextWrapped = true
					Title_4.TextXAlignment = Enum.TextXAlignment.Left

					setDataFrame_3.Name = "setDataFrame"
					setDataFrame_3.Parent = addButton
					setDataFrame_3.AnchorPoint = Vector2.new(0.5, 0.5)
					setDataFrame_3.BackgroundColor3 = Color3.fromRGB(30, 35, 42)
					setDataFrame_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
					setDataFrame_3.BorderSizePixel = 0
					setDataFrame_3.Position = UDim2.new(0.132828265, 0, 0.226702794, 0)
					setDataFrame_3.Size = UDim2.new(0.13615489, 0, 0.256266862, 0)

					UICorner_25.CornerRadius = UDim.new(0.200000003, 0)
					UICorner_25.Parent = setDataFrame_3

					IconData_3.Name = "IconData"
					IconData_3.Parent = setDataFrame_3
					IconData_3.AnchorPoint = Vector2.new(0.5, 0.5)
					IconData_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					IconData_3.BackgroundTransparency = 1.000
					IconData_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
					IconData_3.BorderSizePixel = 0
					IconData_3.Position = UDim2.new(0.5, 0, 0.5, 0)
					IconData_3.Size = UDim2.new(0.5, 0, 0.5, 0)
					IconData_3.Image = "rbxassetid://82957051825102"
					IconData_3.ImageColor3 = Color3.fromRGB(255, 255, 97)

					if o['Icon'] and type(o['Icon']['Image']) == 'string' and not o['Icon']['Image']:find('rbxassetid://') then
						if IconGen["lucide-"..o['Icon']['Image']] then
							IconData_3.Image = IconGen["lucide-"..o['Icon']['Image']]
						else
							IconData_3.Image = "rbxassetid://".. o['Icon']['Image']
						end
					elseif o['Icon'] and type(o['Icon']) == 'number' then
						IconData_3.Image = "rbxassetid://".. o['Icon']['Image']
					else
						IconData_3.Image = o['Icon'] and o['Icon']['Image'] or "rbxassetid://82957051825102"
					end	

					ButtonClick.MouseButton1Click:Connect(function()
						Dis_2.Size = UDim2.new(0, 0, 0, 0)
						Callback()
						TweenService:Create(
							Dis_2,
							TweenInfo.new(0.5,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
							{Size = UDim2.new( 0.63, 0, 0.63, 0)}
						):Play()
					end)
				end
				self.Group.CreateSlider = function(o : teble)
					self.Slider = {}
					local Title = o['Title'] or "Kuy"
					local MaxValue = o['Max'] or 100
					local MinValue = o['Min'] or 0
					local Value = o['Value'] or 50
					local Callback = o['Callback'] or function() end
					local dragging = false
					local sliderRange = MaxValue - MinValue

					local addSlider = Instance.new("Frame")
					local Title_5 = Instance.new("TextLabel")
					local UICorner_26 = Instance.new("UICorner")
					local SliderBar = Instance.new("Frame")
					local UICorner_27 = Instance.new("UICorner")
					local UIGradient_8 = Instance.new("UIGradient")
					local SliderMove = Instance.new("Frame")
					local UICorner_28 = Instance.new("UICorner")
					local Dis_4 = Instance.new("TextLabel")
					local setTextBox = Instance.new("Frame")
					local UICorner_29 = Instance.new("UICorner")
					local TextBox_2 = Instance.new("TextBox")
					local setDataFrame_4 = Instance.new("Frame")
					local UICorner_30 = Instance.new("UICorner")
					local IconData_4 = Instance.new("ImageLabel")

					addSlider.Name = "addSlider"
					addSlider.Parent = setGroupFrame
					addSlider.BackgroundColor3 = Color3.fromRGB(20, 24, 33)
					addSlider.BorderColor3 = Color3.fromRGB(0, 0, 0)
					addSlider.BorderSizePixel = 0
					addSlider.Size = UDim2.new(0, 245, 0, 144)

					Title_5.Name = "Title"
					Title_5.Parent = addSlider
					Title_5.AnchorPoint = Vector2.new(0.5, 0.5)
					Title_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Title_5.BackgroundTransparency = 1.000
					Title_5.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Title_5.BorderSizePixel = 0
					Title_5.Position = UDim2.new(0.586749613, 0, 0.225353912, 0)
					Title_5.Size = UDim2.new(0.739100754, 0, 0.117700331, 0)
					Title_5.FontFace = Font.new(
						"rbxasset://fonts/families/Nunito.json",
						Enum.FontWeight.Bold,
						Enum.FontStyle.Normal
					)
					Title_5.Text = Title
					Title_5.TextColor3 = Color3.fromRGB(213, 213, 213)
					Title_5.TextScaled = true
					Title_5.TextSize = 14.000
					Title_5.TextWrapped = true
					Title_5.TextXAlignment = Enum.TextXAlignment.Left

					UICorner_26.CornerRadius = UDim.new(0.100000001, 0)
					UICorner_26.Parent = addSlider

					SliderBar.Name = "SliderBar"
					SliderBar.Parent = addSlider
					SliderBar.AnchorPoint = Vector2.new(0.5, 0.5)
					SliderBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					SliderBar.BorderColor3 = Color3.fromRGB(0, 0, 0)
					SliderBar.BorderSizePixel = 0
					SliderBar.Position = UDim2.new(0.50000006, 0, 0.787595451, 0)
					SliderBar.Size = UDim2.new(0.85, 0, 0.0676484555, 0)

					UICorner_27.CornerRadius = UDim.new(0, 20)
					UICorner_27.Parent = SliderBar

					UIGradient_8.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(51, 255, 99)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(51, 255, 99))}
					UIGradient_8.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 1), NumberSequenceKeypoint.new(0.00, 1), NumberSequenceKeypoint.new(1.00, 0.00)}
					UIGradient_8.Parent = SliderBar

					SliderMove.Name = "SliderMove"
					SliderMove.Parent = SliderBar
					SliderMove.AnchorPoint = Vector2.new(0.5, 0.5)
					SliderMove.BackgroundColor3 = Color3.fromRGB(51, 255, 99)
					SliderMove.BorderColor3 = Color3.fromRGB(0, 0, 0)
					SliderMove.BorderSizePixel = 0
					SliderMove.Position = UDim2.new(0.0444451012, 0, 0.428626239, 0)
					SliderMove.Size = UDim2.new(0.0969285816, 0, 2.44963288, 0)

					UICorner_28.CornerRadius = UDim.new(0, 5)
					UICorner_28.Parent = SliderMove

					setTextBox.Name = "setTextBox"
					setTextBox.Parent = addSlider
					setTextBox.AnchorPoint = Vector2.new(0.5, 0.5)
					setTextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					setTextBox.BackgroundTransparency = 1.000
					setTextBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
					setTextBox.BorderSizePixel = 0
					setTextBox.Position = UDim2.new(0.825319767, 0, 0.64342916, 0)
					setTextBox.Size = UDim2.new(0.256178737, 0, 0.104372449, 0)

					UICorner_29.Parent = setTextBox

					TextBox_2.Parent = setTextBox
					TextBox_2.AnchorPoint = Vector2.new(0.5, 0.5)
					TextBox_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					TextBox_2.BackgroundTransparency = 1.000
					TextBox_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
					TextBox_2.BorderSizePixel = 0
					TextBox_2.Position = UDim2.new(0.5, 0, 0.5, 0)
					TextBox_2.Size = UDim2.new(0.899999976, 0, 0.649999976, 0)
					TextBox_2.FontFace = Font.new(
						"rbxasset://fonts/families/Nunito.json",
						Enum.FontWeight.Bold,
						Enum.FontStyle.Normal
					)
					TextBox_2.Text = Value
					TextBox_2.TextColor3 = Color3.fromRGB(255, 255, 255)
					TextBox_2.TextScaled = true
					TextBox_2.TextSize = 14.000
					TextBox_2.TextWrapped = true

					local UIStroke1 = Instance.new("UIStroke")
					UIStroke1.Parent = setTextBox 
					UIStroke1.Color = Color3.fromRGB(30, 30, 30)
					UIStroke1.Thickness = 1

					setDataFrame_4.Name = "setDataFrame"
					setDataFrame_4.Parent = addSlider
					setDataFrame_4.AnchorPoint = Vector2.new(0.5, 0.5)
					setDataFrame_4.BackgroundColor3 = Color3.fromRGB(30, 35, 42)
					setDataFrame_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
					setDataFrame_4.BorderSizePixel = 0
					setDataFrame_4.Position = UDim2.new(0.132828265, 0, 0.226702794, 0)
					setDataFrame_4.Size = UDim2.new(0.13615489, 0, 0.256266862, 0)

					UICorner_30.CornerRadius = UDim.new(0.200000003, 0)
					UICorner_30.Parent = setDataFrame_4

					IconData_4.Name = "IconData"
					IconData_4.Parent = setDataFrame_4
					IconData_4.AnchorPoint = Vector2.new(0.5, 0.5)
					IconData_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					IconData_4.BackgroundTransparency = 1.000
					IconData_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
					IconData_4.BorderSizePixel = 0
					IconData_4.Position = UDim2.new(0.5, 0, 0.5, 0)
					IconData_4.Size = UDim2.new(0.5, 0, 0.5, 0)
					IconData_4.Image = "rbxassetid://82957051825102"
					IconData_4.ImageColor3 = Color3.fromRGB(255, 255, 97)

					if o['Icon'] and type(o['Icon']['Image']) == 'string' and not o['Icon']['Image']:find('rbxassetid://') then
						if IconGen["lucide-"..o['Icon']['Image']] then
							IconData_4.Image = IconGen["lucide-"..o['Icon']['Image']]
						else
							IconData_4.Image = "rbxassetid://".. o['Icon']['Image']
						end
					elseif o['Icon'] and type(o['Icon']) == 'number' then
						IconData_4.Image = "rbxassetid://".. o['Icon']['Image']
					else
						IconData_4.Image = o['Icon'] and o['Icon']['Image'] or "rbxassetid://82957051825102"
					end	

					local function setInitialSliderPosition(Value, MinValue, MaxValue)
						local sliderRange = MaxValue - MinValue
						local scaleX = math.clamp((Value - MinValue) / sliderRange, 0, 1)
						TweenService:Create(
							SliderMove,
							TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
							{Position = UDim2.new(scaleX, 0, 0.5, 0)}
						):Play()
						local newValue
						if o.Floor then
							newValue = string.format("%.1f", (MinValue + (scaleX * sliderRange)))
						else
							newValue = math.floor(MinValue + (scaleX * sliderRange))
						end
						TextBox_2.Text = tostring(newValue)
						Callback(newValue)
					end

					setInitialSliderPosition(Value, MinValue, MaxValue)

					TextBox_2.FocusLost:Connect(function()
						local inputValue = tonumber(TextBox_2.Text)
						if string.upper(TextBox_2.Text):find('NAN') then
							setInitialSliderPosition(MaxValue, MinValue, MaxValue)
							return
						elseif string.upper(TextBox_2.Text):find('INF') then
							setInitialSliderPosition(MaxValue, MinValue, MaxValue)
							return
						end
						if inputValue then
							setInitialSliderPosition(inputValue, MinValue, MaxValue)
						else
							if string.upper(TextBox_2.Text):find('MAX') then
								setInitialSliderPosition(MaxValue, MinValue, MaxValue)
							elseif string.upper(TextBox_2.Text):find('DEFAUIT') then
								setInitialSliderPosition(Value, MinValue, MaxValue)
							elseif string.upper(TextBox_2.Text):find('MIN') then
								setInitialSliderPosition(Value, MinValue, MaxValue)
							else
								setInitialSliderPosition(0, MinValue, MaxValue)
							end
						end
					end)

					local function moveSlider(input)
						local scaleX = math.clamp((input.Position.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1)
						TweenService:Create(
							SliderMove,
							TweenInfo.new(0.5,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
							{Position =  UDim2.new(scaleX, 0, 0.5, 0)}
						):Play()
						local newValue = math.floor(MinValue + (scaleX * sliderRange))
						if o.Floor then
							newValue = string.format("%.1f", (MinValue + (scaleX * sliderRange)))
						else
							newValue = math.floor(MinValue + (scaleX * sliderRange))
						end
						TextBox_2.Text = tostring(newValue)
						Callback(newValue)
					end


					SliderMove.InputBegan:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
							dragging = true
						end
					end)

					SliderMove.InputEnded:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
							dragging = false
						end
					end)

					game:GetService("UserInputService").InputChanged:Connect(function(input)
						if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
							moveSlider(input)
						end
					end)

					self.Slider.Reset = function()
						setInitialSliderPosition(Value, MinValue, MaxValue)
					end
					self.Slider.SetMax = function(v)
						MaxValue = v
						setInitialSliderPosition(Value, MinValue, MaxValue)
					end
					self.Slider.SetMin = function(v)
						MinValue = v
						setInitialSliderPosition(Value, MinValue, MaxValue)
					end
					self.Slider.SetValue = function(v)
						setInitialSliderPosition(v, MinValue, MaxValue)
					end

					return self.Slider
				end

				self.Group.CreateInput = function(o : teble)
					local name = o['Title'] or "Kuy"
					local setPlaceholder = o['PlaceholderText'] or nil
					local Value = o['Value'] or ""
					local Button1 = o['Button'] or o['Button1'] or nil
					local Button2 = o['Button2'] or nil
					local Callback = o['Callback'] or function() end

					local addTextbox = Instance.new("Frame")
					local Title = Instance.new("TextLabel")
					local UICorner = Instance.new("UICorner")
					local setDataFrame = Instance.new("Frame")
					local UICorner_2 = Instance.new("UICorner")
					local IconData = Instance.new("ImageLabel")
					local setTextBox = Instance.new("Frame")
					local UICorner_3 = Instance.new("UICorner")
					local TextBox = Instance.new("TextBox")
					local ButtonClick = Instance.new("TextButton")
					local UICorner_4 = Instance.new("UICorner")
					local UIGradient = Instance.new("UIGradient")
					local Dis = Instance.new("TextLabel")
					local UICorner_5 = Instance.new("UICorner")
					local UIGradient_2 = Instance.new("UIGradient")
					local ButtonClick_2 = Instance.new("TextButton")
					local UICorner_6 = Instance.new("UICorner")
					local UIGradient_3 = Instance.new("UIGradient")
					local Dis_2 = Instance.new("TextLabel")
					local UICorner_7 = Instance.new("UICorner")
					local UIGradient_4 = Instance.new("UIGradient")

					addTextbox.Name = "addTextbox"
					addTextbox.Parent = setGroupFrame
					addTextbox.BackgroundColor3 = Color3.fromRGB(20, 24, 33)
					addTextbox.BorderColor3 = Color3.fromRGB(0, 0, 0)
					addTextbox.BorderSizePixel = 0
					addTextbox.Size = UDim2.new(0, 245, 0, 144)

					Title.Name = "Title"
					Title.Parent = addTextbox
					Title.AnchorPoint = Vector2.new(0.5, 0.5)
					Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Title.BackgroundTransparency = 1.000
					Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Title.BorderSizePixel = 0
					Title.Position = UDim2.new(0.586749613, 0, 0.225353912, 0)
					Title.Size = UDim2.new(0.739100754, 0, 0.117700331, 0)
					Title.FontFace = Font.new(
						"rbxasset://fonts/families/Nunito.json",
						Enum.FontWeight.Bold,
						Enum.FontStyle.Normal
					)
					Title.Text = name
					Title.TextColor3 = Color3.fromRGB(213, 213, 213)
					Title.TextScaled = true
					Title.TextSize = 14.000
					Title.TextWrapped = true
					Title.TextXAlignment = Enum.TextXAlignment.Left

					UICorner.CornerRadius = UDim.new(0.100000001, 0)
					UICorner.Parent = addTextbox

					setDataFrame.Name = "setDataFrame"
					setDataFrame.Parent = addTextbox
					setDataFrame.AnchorPoint = Vector2.new(0.5, 0.5)
					setDataFrame.BackgroundColor3 = Color3.fromRGB(30, 35, 42)
					setDataFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
					setDataFrame.BorderSizePixel = 0
					setDataFrame.Position = UDim2.new(0.132828265, 0, 0.226702794, 0)
					setDataFrame.Size = UDim2.new(0.13615489, 0, 0.256266862, 0)

					UICorner_2.CornerRadius = UDim.new(0.200000003, 0)
					UICorner_2.Parent = setDataFrame

					IconData.Name = "IconData"
					IconData.Parent = setDataFrame
					IconData.AnchorPoint = Vector2.new(0.5, 0.5)
					IconData.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					IconData.BackgroundTransparency = 1.000
					IconData.BorderColor3 = Color3.fromRGB(0, 0, 0)
					IconData.BorderSizePixel = 0
					IconData.Position = UDim2.new(0.5, 0, 0.5, 0)
					IconData.Size = UDim2.new(0.5, 0, 0.5, 0)
					IconData.Image = "rbxassetid://82957051825102"
					IconData.ImageColor3 = Color3.fromRGB(255, 255, 97)

					if o['Icon'] and type(o['Icon']['Image']) == 'string' and not o['Icon']['Image']:find('rbxassetid://') then
						if IconGen["lucide-"..o['Icon']['Image']] then
							IconData.Image = IconGen["lucide-"..o['Icon']['Image']]
						else
							IconData.Image = "rbxassetid://".. o['Icon']['Image']
						end
					elseif o['Icon'] and type(o['Icon']) == 'number' then
						IconData.Image = "rbxassetid://".. o['Icon']['Image']
					else
						IconData.Image = o['Icon'] and o['Icon']['Image'] or "rbxassetid://82957051825102"
					end	

					setTextBox.Name = "setTextBox"
					setTextBox.Parent = addTextbox
					setTextBox.AnchorPoint = Vector2.new(0.5, 0.5)
					setTextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					setTextBox.BackgroundTransparency = 1.000
					setTextBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
					setTextBox.BorderSizePixel = 0
					setTextBox.Position = UDim2.new(0.5, 0, 0.5, 0)
					setTextBox.Size = UDim2.new(0.899999976, 0, 0.136000007, 0)

					UICorner_3.Parent = setTextBox

					local UIStroke1 = Instance.new("UIStroke")
					UIStroke1.Parent = setTextBox 
					UIStroke1.Color = Color3.fromRGB(30, 30, 30)
					UIStroke1.Thickness = 1

					TextBox.Parent = setTextBox
					TextBox.AnchorPoint = Vector2.new(0.5, 0.5)
					TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					TextBox.BackgroundTransparency = 1.000
					TextBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
					TextBox.BorderSizePixel = 0
					TextBox.Position = UDim2.new(0.5, 0, 0.5, 0)
					TextBox.Size = UDim2.new(0.899999976, 0, 0.699999988, 0)
					TextBox.FontFace = Font.new(
						"rbxasset://fonts/families/Nunito.json",
						Enum.FontWeight.Bold,
						Enum.FontStyle.Normal
					)
					TextBox.PlaceholderText = setPlaceholder or "Textbox"
					TextBox.Text = Value
					TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
					TextBox.TextScaled = true
					TextBox.TextSize = 14.000
					TextBox.TextWrapped = true

					ButtonClick.Name = "ButtonClick"
					ButtonClick.Parent = addTextbox
					ButtonClick.Text = ""
					ButtonClick.AnchorPoint = Vector2.new(0.5, 0.5)
					ButtonClick.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					ButtonClick.BorderColor3 = Color3.fromRGB(0, 0, 0)
					ButtonClick.BorderSizePixel = 0
					ButtonClick.Position = UDim2.new(0.805398226, 0, 0.777023494, 0)
					ButtonClick.Size = UDim2.new(0.295697451, 0, 0.164968848, 0)
					ButtonClick.Visible = false

					UICorner_4.CornerRadius = UDim.new(0, 20)
					UICorner_4.Parent = ButtonClick

					UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(213, 55, 102)), ColorSequenceKeypoint.new(0.73, Color3.fromRGB(229, 131, 160)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(235, 160, 182)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 255, 255))}
					UIGradient.Offset = Vector2.new(1, 0)
					UIGradient.Rotation = -73
					UIGradient.Parent = ButtonClick

					Dis.Name = "Dis"
					Dis.Parent = ButtonClick
					Dis.AnchorPoint = Vector2.new(0.5, 0.5)
					Dis.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Dis.BackgroundTransparency = 1.000
					Dis.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Dis.BorderSizePixel = 0
					Dis.Position = UDim2.new(0.5, 0, 0.5, 0)
					Dis.Size = UDim2.new(0.600000024, 0, 0.600000024, 0)
					Dis.FontFace = Font.new(
						"rbxasset://fonts/families/Nunito.json",
						Enum.FontWeight.Bold,
						Enum.FontStyle.Normal
					)
					Dis.Text = "join sever"
					Dis.TextColor3 = Color3.fromRGB(255, 255, 255)
					Dis.TextScaled = true
					Dis.TextSize = 14.000
					Dis.TextWrapped = true
					Dis.TextXAlignment = Enum.TextXAlignment.Center

					UICorner_5.CornerRadius = UDim.new(0, 20)
					UICorner_5.Parent = ButtonClick

					UIGradient_2.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(213, 55, 102)), ColorSequenceKeypoint.new(0.73, Color3.fromRGB(229, 131, 160)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(235, 160, 182)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 255, 255))}
					UIGradient_2.Offset = Vector2.new(1, 0)
					UIGradient_2.Rotation = -73
					UIGradient_2.Parent = ButtonClick

					ButtonClick_2.Name = "ButtonClick"
					ButtonClick_2.Parent = addTextbox
					ButtonClick_2.AnchorPoint = Vector2.new(0.5, 0.5)
					ButtonClick_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					ButtonClick_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
					ButtonClick_2.BorderSizePixel = 0
					ButtonClick_2.Position = UDim2.new(0.471808165, 0, 0.777023494, 0)
					ButtonClick_2.Size = UDim2.new(0.295697451, 0, 0.164968848, 0)
					ButtonClick_2.Visible = false
					ButtonClick_2.Text = "'"

					UICorner_6.CornerRadius = UDim.new(0, 20)
					UICorner_6.Parent = ButtonClick_2

					UIGradient_3.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(213, 55, 102)), ColorSequenceKeypoint.new(0.73, Color3.fromRGB(229, 131, 160)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(235, 160, 182)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 255, 255))}
					UIGradient_3.Offset = Vector2.new(1, 0)
					UIGradient_3.Rotation = -73
					UIGradient_3.Parent = ButtonClick_2

					Dis_2.Name = "Dis"
					Dis_2.Parent = ButtonClick_2
					Dis_2.AnchorPoint = Vector2.new(0.5, 0.5)
					Dis_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Dis_2.BackgroundTransparency = 1.000
					Dis_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Dis_2.BorderSizePixel = 0
					Dis_2.Position = UDim2.new(0.5, 0, 0.5, 0)
					Dis_2.Size = UDim2.new(0.600000024, 0, 0.600000024, 0)
					Dis_2.FontFace = Font.new(
						"rbxasset://fonts/families/Nunito.json",
						Enum.FontWeight.Bold,
						Enum.FontStyle.Normal
					)
					Dis_2.Text = "Copy jobid"
					Dis_2.TextColor3 = Color3.fromRGB(255, 255, 255)
					Dis_2.TextScaled = true
					Dis_2.TextSize = 14.000
					Dis_2.TextWrapped = true
					Dis_2.TextXAlignment = Enum.TextXAlignment.Center

					UICorner_7.CornerRadius = UDim.new(0, 20)
					UICorner_7.Parent = ButtonClick_2

					UIGradient_4.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(213, 55, 102)), ColorSequenceKeypoint.new(0.73, Color3.fromRGB(229, 131, 160)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(235, 160, 182)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 255, 255))}
					UIGradient_4.Offset = Vector2.new(1, 0)
					UIGradient_4.Rotation = -73
					UIGradient_4.Parent = ButtonClick_2

					if Button1 and Button1['Text'] and Button1['Callback'] then
						ButtonClick.Visible = true
						Dis.Text = Button1['Text']
						ButtonClick.MouseButton1Click:Connect(function()
							Dis.Size = UDim2.new(0, 0, 0, 0)
							Button1['Callback']()
							TweenService:Create(
								Dis,
								TweenInfo.new(0.5,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
								{Size = UDim2.new( 0.63, 0, 0.63, 0)}
							):Play()
						end)
					end
					if Button2 and Button2['Text'] and Button2['Callback'] then
						ButtonClick_2.Visible = true
						Dis_2.Text = Button2['Text']
						ButtonClick_2.MouseButton1Click:Connect(function()
							Dis_2.Size = UDim2.new(0, 0, 0, 0)
							Button2['Callback']()
							TweenService:Create(
								Dis_2,
								TweenInfo.new(0.5,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
								{Size = UDim2.new( 0.63, 0, 0.63, 0)}
							):Play()
						end)
					end

					TextBox.Changed:Connect(function()
						Callback(TextBox.Text)
					end)
				end

				self.Group.CreateDropdown = function(o : teble)
					local name = o['Title'] or "Kuy"
					local Value = o['Value'] or ""
					local List = o['List'] or {}
					local RestButton = o['RestButton'] or nil
					local Callback = o['Callback'] or function() end

					local nowValue = Value
					local addDropdown = Instance.new("Frame")
					local Title = Instance.new("TextLabel")
					local UICorner = Instance.new("UICorner")
					local setDataFrame = Instance.new("Frame")
					local UICorner_2 = Instance.new("UICorner")
					local IconData = Instance.new("ImageLabel")
					local DropdownButton = Instance.new("TextButton")
					local UICorner_3 = Instance.new("UICorner")
					local ImageLabel = Instance.new("ImageLabel")
					local Title_2 = Instance.new("TextLabel")
					local DropBar = Instance.new("Frame")
					local ScrollingFrame = Instance.new("ScrollingFrame")
					local UIListLayout = Instance.new("UIListLayout")
					local UICorner_6 = Instance.new("UICorner")
					local setTextBox = Instance.new("Frame")
					local UICorner_7 = Instance.new("UICorner")
					local TextBox = Instance.new("TextBox")
					local resetIcon = Instance.new("ImageButton")

					addDropdown.Name = "addDropdown "
					addDropdown.Parent = setGroupFrame
					addDropdown.BackgroundColor3 = Color3.fromRGB(20, 24, 33)
					addDropdown.BorderColor3 = Color3.fromRGB(0, 0, 0)
					addDropdown.BorderSizePixel = 0
					addDropdown.Size = UDim2.new(0, 245, 0, 144)

					Title.Name = "Title"
					Title.Parent = addDropdown
					Title.AnchorPoint = Vector2.new(0.5, 0.5)
					Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Title.BackgroundTransparency = 1.000
					Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Title.BorderSizePixel = 0
					Title.Position = UDim2.new(0.586749613, 0, 0.225353912, 0)
					Title.Size = UDim2.new(0.739100754, 0, 0.117700331, 0)
					Title.FontFace = Font.new(
						"rbxasset://fonts/families/Nunito.json",
						Enum.FontWeight.Bold,
						Enum.FontStyle.Normal
					)
					Title.Text = name or "Add Dropdown"
					Title.TextColor3 = Color3.fromRGB(213, 213, 213)
					Title.TextScaled = true
					Title.TextSize = 14.000
					Title.TextWrapped = true
					Title.TextXAlignment = Enum.TextXAlignment.Left

					UICorner.CornerRadius = UDim.new(0.100000001, 0)
					UICorner.Parent = addDropdown

					setDataFrame.Name = "setDataFrame"
					setDataFrame.Parent = addDropdown
					setDataFrame.AnchorPoint = Vector2.new(0.5, 0.5)
					setDataFrame.BackgroundColor3 = Color3.fromRGB(30, 35, 42)
					setDataFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
					setDataFrame.BorderSizePixel = 0
					setDataFrame.Position = UDim2.new(0.132828265, 0, 0.226702794, 0)
					setDataFrame.Size = UDim2.new(0.13615489, 0, 0.256266862, 0)

					UICorner_2.CornerRadius = UDim.new(0.200000003, 0)
					UICorner_2.Parent = setDataFrame

					IconData.Name = "IconData"
					IconData.Parent = setDataFrame
					IconData.AnchorPoint = Vector2.new(0.5, 0.5)
					IconData.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					IconData.BackgroundTransparency = 1.000
					IconData.BorderColor3 = Color3.fromRGB(0, 0, 0)
					IconData.BorderSizePixel = 0
					IconData.Position = UDim2.new(0.5, 0, 0.5, 0)
					IconData.Size = UDim2.new(0.5, 0, 0.5, 0)
					IconData.Image = "rbxassetid://82957051825102"
					IconData.ImageColor3 = Color3.fromRGB(255, 255, 97)

					if o['Icon'] and type(o['Icon']['Image']) == 'string' and not o['Icon']['Image']:find('rbxassetid://') then
						if IconGen["lucide-"..o['Icon']['Image']] then
							IconData.Image = IconGen["lucide-"..o['Icon']['Image']]
						else
							IconData.Image = "rbxassetid://".. o['Icon']['Image']
						end
					elseif o['Icon'] and type(o['Icon']) == 'number' then
						IconData.Image = "rbxassetid://".. o['Icon']['Image']
					else
						IconData.Image = o['Icon'] and o['Icon']['Image'] or "rbxassetid://82957051825102"
					end	

					DropdownButton.Name = "DropdownButton"
					DropdownButton.Parent = addDropdown
					DropdownButton.AnchorPoint = Vector2.new(0.5, 0.5)
					DropdownButton.BackgroundColor3 = Color3.fromRGB(31, 35, 44)
					DropdownButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
					DropdownButton.BorderSizePixel = 0
					DropdownButton.Position = UDim2.new(0.5, 0, 0.782000005, 0)
					DropdownButton.Size = UDim2.new(0.815200567, 0, 0.235590577, 0)
					DropdownButton.Text = ""
					DropdownButton.AutoButtonColor = false

					UICorner_3.CornerRadius = UDim.new(0, 4)
					UICorner_3.Parent = DropdownButton

					ImageLabel.Parent = DropdownButton
					ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
					ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					ImageLabel.BackgroundTransparency = 1.000
					ImageLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
					ImageLabel.BorderSizePixel = 0
					ImageLabel.Position = UDim2.new(0.938000023, 0, 0.5, 0)
					ImageLabel.Size = UDim2.new(0.0670393482, 0, 0.481909186, 0)
					ImageLabel.Image = "rbxassetid://117707133441453"
					ImageLabel.ImageColor3 = Color3.fromRGB(175, 175, 175)

					Title_2.Name = "Title"
					Title_2.Parent = DropdownButton
					Title_2.AnchorPoint = Vector2.new(0.5, 0.5)
					Title_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Title_2.BackgroundTransparency = 1.000
					Title_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Title_2.BorderSizePixel = 0
					Title_2.Position = UDim2.new(0.5, 0, 0.5, 0)
					Title_2.Size = UDim2.new(0.855000019, 0, 0.5, 0)
					Title_2.FontFace = Font.new(
						"rbxasset://fonts/families/Nunito.json",
						Enum.FontWeight.Bold,
						Enum.FontStyle.Normal
					)
					Title_2.Text = "Irem123"
					Title_2.TextColor3 = Color3.fromRGB(175, 175, 175)
					Title_2.TextScaled = true
					Title_2.TextSize = 14.000
					Title_2.TextWrapped = true
					Title_2.TextXAlignment = Enum.TextXAlignment.Left

					DropBar.Name = "DropBar"
					DropBar.Parent = addDropdown
					DropBar.AnchorPoint = Vector2.new(0.5, 0.5)
					DropBar.BackgroundColor3 = Color3.fromRGB(31, 35, 44)
					DropBar.BorderColor3 = Color3.fromRGB(0, 0, 0)
					DropBar.BorderSizePixel = 0
					DropBar.Position = UDim2.new(0.500000238, 0, 1.62226081, 0)
					DropBar.Size = UDim2.new(0.814999938, 0, 1.38476801, 0)
					DropBar.Visible = false

					ScrollingFrame.Parent = DropBar
					ScrollingFrame.Active = true
					ScrollingFrame.AnchorPoint = Vector2.new(0.5, 0.5)
					ScrollingFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					ScrollingFrame.BackgroundTransparency = 1.000
					ScrollingFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
					ScrollingFrame.BorderSizePixel = 0
					ScrollingFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
					ScrollingFrame.Size = UDim2.new(0.899999976, 0, 0.899999976, 0)
					ScrollingFrame.ScrollBarThickness = 2
					ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(213, 55, 102)

					UIListLayout.Parent = ScrollingFrame
					UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
					UIListLayout.Padding = UDim.new(0, 1)


					UICorner_6.CornerRadius = UDim.new(0, 4)
					UICorner_6.Parent = DropBar

					setTextBox.Name = "setTextBox"
					setTextBox.Parent = addDropdown
					setTextBox.AnchorPoint = Vector2.new(0.5, 0.5)
					setTextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					setTextBox.BackgroundTransparency = 1.000
					setTextBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
					setTextBox.BorderSizePixel = 0
					setTextBox.Position = UDim2.new(0.690999985, 0, 0.540000021, 0)
					setTextBox.Size = UDim2.new(0.433327824, 0, 0.136000007, 0)

					UICorner_7.Parent = setTextBox

					TextBox.Parent = setTextBox
					TextBox.AnchorPoint = Vector2.new(0.5, 0.5)
					TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					TextBox.BackgroundTransparency = 1.000
					TextBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
					TextBox.BorderSizePixel = 0
					TextBox.Position = UDim2.new(0.5, 0, 0.5, 0)
					TextBox.Size = UDim2.new(0.899999976, 0, 0.699999988, 0)
					TextBox.FontFace = Font.new(
						"rbxasset://fonts/families/Nunito.json",
						Enum.FontWeight.Bold,
						Enum.FontStyle.Normal
					)
					TextBox.PlaceholderText = "Search ..."
					TextBox.Text = ""
					TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
					TextBox.TextScaled = true
					TextBox.TextSize = 14.000
					TextBox.TextWrapped = true

					resetIcon.Name = "resetIcon"
					resetIcon.Parent = addDropdown
					resetIcon.AnchorPoint = Vector2.new(0.5, 0.5)
					resetIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					resetIcon.BackgroundTransparency = 1.000
					resetIcon.BorderColor3 = Color3.fromRGB(0, 0, 0)
					resetIcon.BorderSizePixel = 0
					resetIcon.Position = UDim2.new(0.918459475, 0, 0.133560836, 0)
					resetIcon.Size = UDim2.new(0.0710434839, 0, 0.134753793, 0)
					resetIcon.Image = "rbxassetid://117300320767102"

					if RestButton then
						resetIcon.MouseButton1Click:Connect(function()
							TweenService:Create(
								resetIcon,
								TweenInfo.new(0.5,Enum.EasingStyle.Linear,Enum.EasingDirection.Out),
								{Rotation = 360}
							):Play()
							RestButton()
							wait(.5)
							TweenService:Create(
								resetIcon,
								TweenInfo.new(0.5,Enum.EasingStyle.Linear,Enum.EasingDirection.Out),
								{Rotation = 0}
							):Play()
						end)
					end

					local UIStroke1 = Instance.new("UIStroke")
					UIStroke1.Parent = setTextBox 
					UIStroke1.Color = Color3.fromRGB(30, 30, 30)
					UIStroke1.Thickness = 1

					local UIStroke1 = Instance.new("UIStroke")
					UIStroke1.Parent = DropdownButton 
					UIStroke1.Color = Color3.fromRGB(213, 55, 102)
					UIStroke1.Thickness = 1
					UIStroke1.Transparency = 1
					UIStroke1.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

					UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
						local contentHeight = UIListLayout.AbsoluteContentSize.Y
						local parentHeight = ScrollingFrame.AbsoluteSize.Y
						local scaleHeight = contentHeight / parentHeight

						ScrollingFrame.CanvasSize = UDim2.new(0, 0, scaleHeight + 0.25, 0)
						if ScrollingFrame.CanvasSize.Y.Scale < 2 then
							ScrollingFrame.CanvasSize = UDim2.new(0, 0, 2, 0)
						end
					end)

					TextBox.Changed:Connect(function()
						if TextBox.Text ~= "" and TextBox.Text ~= "Search" then
							local InputText = string.upper(TextBox.Text)
							for _, button in pairs(ScrollingFrame:GetChildren()) do
								if button:FindFirstChild("TextLabel") then
									local TS = string.upper(button:FindFirstChild("TextLabel").Text)
									if TS:find(string.upper(TextBox.Text)) then
										button.Visible = true
									else
										button.Visible = false
									end
								end
							end
						else
							for _, button in pairs(ScrollingFrame:GetChildren()) do
								if button:FindFirstChild("TextLabel") then
									button.Visible = true
								end
							end
						end
					end)

					DropdownButton.MouseEnter:Connect(function()
						TweenService:Create(
							UIStroke1,
							TweenInfo.new(0.2,Enum.EasingStyle.Linear,Enum.EasingDirection.Out),
							{Transparency = 0.61}
						):Play()
					end)

					DropdownButton.MouseLeave:Connect(function()
						TweenService:Create(
							UIStroke1,
							TweenInfo.new(0.2,Enum.EasingStyle.Linear,Enum.EasingDirection.Out),
							{Transparency = 1}
						):Play()
					end)

					DropdownButton.MouseButton1Click
						:Connect(function()
							if DropBar.Visible then
								DropBar.Visible = false
								TweenService:Create(
									UIStroke1,
									TweenInfo.new(0.5,Enum.EasingStyle.Linear,Enum.EasingDirection.Out),
									{Transparency = 1}
								):Play()
							else
								DropBar.Visible = true
								TweenService:Create(
									UIStroke1,
									TweenInfo.new(0.5,Enum.EasingStyle.Linear,Enum.EasingDirection.Out),
									{Transparency = 0.61}
								):Play()
							end
						end)

					self.DropDownList = {}
					self.DropDownList.Clear = function(c : string)
						for i, v in next, ScrollingFrame:GetChildren() do
							if v:IsA("TextButton") then 
								v:Destroy()
							end
						end
					end
					self.DropDownList.Add = function(c : string)
						for i,v in pairs(ScrollingFrame:GetChildren()) do
							if v:IsA('TextButton') and v.TextLabel.Text == c then
								return
							end
						end
						local ButtonDrop = Instance.new("TextButton")
						local TextButton = Instance.new("TextLabel")
						local UICorner_4 = Instance.new("UICorner")

						ButtonDrop.Name = "ButtonDrop"
						ButtonDrop.Parent = ScrollingFrame
						ButtonDrop.BackgroundColor3 = Color3.fromRGB(20, 24, 33)
						ButtonDrop.BorderColor3 = Color3.fromRGB(0, 0, 0)
						ButtonDrop.Transparency = 1
						ButtonDrop.Text = ""
						ButtonDrop.BorderSizePixel = 0
						ButtonDrop.Size = UDim2.new(1, 0, 0.0719999969, 0)

						TextButton.Parent = ButtonDrop
						TextButton.AnchorPoint = Vector2.new(0.5, 0.5)
						TextButton.BackgroundColor3 = Color3.fromRGB(21, 25, 34)
						TextButton.BackgroundTransparency = 1.000
						TextButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
						TextButton.BorderSizePixel = 0
						TextButton.Position = UDim2.new(0.5, 0, 0.5, 0)
						TextButton.Size = UDim2.new(0.899999976, 0, 0.600000024, 0)
						TextButton.Font = Enum.Font.SourceSans
						TextButton.Text = c
						TextButton.TextColor3 = Color3.fromRGB(175, 175, 175)
						TextButton.TextScaled = true
						TextButton.TextSize = 14.000
						TextButton.TextWrapped = true
						TextButton.TextXAlignment = Enum.TextXAlignment.Left

						UICorner_4.CornerRadius = UDim.new(0, 5)
						UICorner_4.Parent = ButtonDrop

						ButtonDrop.MouseEnter:Connect(function()
							TweenService:Create(
								ButtonDrop,
								TweenInfo.new(0.5,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
								{Transparency = 0.5}
							):Play()
						end)

						ButtonDrop.MouseLeave:Connect(function()
							TweenService:Create(
								ButtonDrop,
								TweenInfo.new(0.5,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
								{Transparency = 1}
							):Play()
						end)

						task.spawn(function()
							while wait() do
								pcall(function()
									if TextButton.Text == nowValue then
										TweenService:Create(
											ButtonDrop,
											TweenInfo.new(0.5,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
											{Transparency = 0}
										):Play()
										Title_2.Text = c
									end
								end)
							end
						end)

						if TextButton.Text == Value then
							TweenService:Create(
								ButtonDrop,
								TweenInfo.new(0.5,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
								{Transparency = 0}
							):Play()
							Title_2.Text = c
						end

						ButtonDrop.MouseButton1Click:Connect(function()
							for i,v in pairs(ScrollingFrame:GetChildren()) do
								if v:IsA('TextButton') then
									TweenService:Create(
										v,
										TweenInfo.new(0.5,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
										{Transparency = 1}
									):Play()
								end
							end
							TweenService:Create(
								ButtonDrop,
								TweenInfo.new(0.5,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
								{Transparency = 0}
							):Play()
							Title_2.Text = c
							DropBar.Visible = false
							TweenService:Create(
								UIStroke1,
								TweenInfo.new(0.5,Enum.EasingStyle.Linear,Enum.EasingDirection.Out),
								{Transparency = 1}
							):Play()
							nowValue = c
							Callback(c)	
						end)

						local canvasSize = ScrollingFrame.CanvasSize
						local Pars = ButtonDrop.Size.Y.Scale +  ButtonDrop.Size.Y.Scale
						local function updateSize()
							canvasSize = ScrollingFrame.CanvasSize
							if canvasSize.Y.Scale >= 2 then
								ButtonDrop.Size = UDim2.new(1, 0, Pars / canvasSize.Y.Scale, 0)
							end
						end

						ButtonDrop.Size = UDim2.new(1, 0, ButtonDrop.Size.Y.Scale, 0)
						UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
							updateSize()
						end)
					end

					for i,v in next, List do
						self.DropDownList.Add(v)
					end
					if table.find(List, Value) then
						Title_2.Text = Value
					else
						Title_2.Text = 'None'
					end
					Callback(Title_2.Text ~= 'None' and Title_2.Text or nil )
					return self.DropDownList
				end

				self.Group.CreateMultiDropdown = function(o : teble)
					local name = o['Title'] or "Kuy"
					local Value = o['Value'] or ""
					local List = o['List'] or {}
					local RestButton = o['RestButton'] or nil
					local Callback = o['Callback'] or function() end
					local DropFF = Value

					local addDropdown = Instance.new("Frame")
					local Title = Instance.new("TextLabel")
					local UICorner = Instance.new("UICorner")
					local setDataFrame = Instance.new("Frame")
					local UICorner_2 = Instance.new("UICorner")
					local IconData = Instance.new("ImageLabel")
					local DropdownButton = Instance.new("TextButton")
					local UICorner_3 = Instance.new("UICorner")
					local ImageLabel = Instance.new("ImageLabel")
					local Title_2 = Instance.new("TextLabel")
					local DropBar = Instance.new("Frame")
					local ScrollingFrame = Instance.new("ScrollingFrame")
					local UIListLayout = Instance.new("UIListLayout")
					local UICorner_6 = Instance.new("UICorner")
					local setTextBox = Instance.new("Frame")
					local UICorner_7 = Instance.new("UICorner")
					local TextBox = Instance.new("TextBox")
					local resetIcon = Instance.new("ImageButton")

					addDropdown.Name = "addDropdown "
					addDropdown.Parent = setGroupFrame
					addDropdown.BackgroundColor3 = Color3.fromRGB(20, 24, 33)
					addDropdown.BorderColor3 = Color3.fromRGB(0, 0, 0)
					addDropdown.BorderSizePixel = 0
					addDropdown.Size = UDim2.new(0, 245, 0, 144)

					Title.Name = "Title"
					Title.Parent = addDropdown
					Title.AnchorPoint = Vector2.new(0.5, 0.5)
					Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Title.BackgroundTransparency = 1.000
					Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Title.BorderSizePixel = 0
					Title.Position = UDim2.new(0.586749613, 0, 0.225353912, 0)
					Title.Size = UDim2.new(0.739100754, 0, 0.117700331, 0)
					Title.FontFace = Font.new(
						"rbxasset://fonts/families/Nunito.json",
						Enum.FontWeight.Bold,
						Enum.FontStyle.Normal
					)
					Title.Text = name or "Add Dropdown"
					Title.TextColor3 = Color3.fromRGB(213, 213, 213)
					Title.TextScaled = true
					Title.TextSize = 14.000
					Title.TextWrapped = true
					Title.TextXAlignment = Enum.TextXAlignment.Left

					UICorner.CornerRadius = UDim.new(0.100000001, 0)
					UICorner.Parent = addDropdown

					setDataFrame.Name = "setDataFrame"
					setDataFrame.Parent = addDropdown
					setDataFrame.AnchorPoint = Vector2.new(0.5, 0.5)
					setDataFrame.BackgroundColor3 = Color3.fromRGB(30, 35, 42)
					setDataFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
					setDataFrame.BorderSizePixel = 0
					setDataFrame.Position = UDim2.new(0.132828265, 0, 0.226702794, 0)
					setDataFrame.Size = UDim2.new(0.13615489, 0, 0.256266862, 0)

					UICorner_2.CornerRadius = UDim.new(0.200000003, 0)
					UICorner_2.Parent = setDataFrame

					IconData.Name = "IconData"
					IconData.Parent = setDataFrame
					IconData.AnchorPoint = Vector2.new(0.5, 0.5)
					IconData.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					IconData.BackgroundTransparency = 1.000
					IconData.BorderColor3 = Color3.fromRGB(0, 0, 0)
					IconData.BorderSizePixel = 0
					IconData.Position = UDim2.new(0.5, 0, 0.5, 0)
					IconData.Size = UDim2.new(0.5, 0, 0.5, 0)
					IconData.Image = "rbxassetid://82957051825102"
					IconData.ImageColor3 = Color3.fromRGB(255, 255, 97)

					if o['Icon'] and type(o['Icon']['Image']) == 'string' and not o['Icon']['Image']:find('rbxassetid://') then
						if IconGen["lucide-"..o['Icon']['Image']] then
							IconData.Image = IconGen["lucide-"..o['Icon']['Image']]
						else
							IconData.Image = "rbxassetid://".. o['Icon']['Image']
						end
					elseif o['Icon'] and type(o['Icon']) == 'number' then
						IconData.Image = "rbxassetid://".. o['Icon']['Image']
					else
						IconData.Image = o['Icon'] and o['Icon']['Image'] or "rbxassetid://82957051825102"
					end	

					DropdownButton.Name = "DropdownButton"
					DropdownButton.Parent = addDropdown
					DropdownButton.AnchorPoint = Vector2.new(0.5, 0.5)
					DropdownButton.BackgroundColor3 = Color3.fromRGB(31, 35, 44)
					DropdownButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
					DropdownButton.BorderSizePixel = 0
					DropdownButton.Position = UDim2.new(0.5, 0, 0.782000005, 0)
					DropdownButton.Size = UDim2.new(0.815200567, 0, 0.235590577, 0)
					DropdownButton.Text = ""
					DropdownButton.AutoButtonColor = false

					UICorner_3.CornerRadius = UDim.new(0, 4)
					UICorner_3.Parent = DropdownButton

					ImageLabel.Parent = DropdownButton
					ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
					ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					ImageLabel.BackgroundTransparency = 1.000
					ImageLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
					ImageLabel.BorderSizePixel = 0
					ImageLabel.Position = UDim2.new(0.938000023, 0, 0.5, 0)
					ImageLabel.Size = UDim2.new(0.0670393482, 0, 0.481909186, 0)
					ImageLabel.Image = "rbxassetid://117707133441453"
					ImageLabel.ImageColor3 = Color3.fromRGB(175, 175, 175)

					Title_2.Name = "Title"
					Title_2.Parent = DropdownButton
					Title_2.AnchorPoint = Vector2.new(0.5, 0.5)
					Title_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Title_2.BackgroundTransparency = 1.000
					Title_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Title_2.BorderSizePixel = 0
					Title_2.Position = UDim2.new(0.5, 0, 0.5, 0)
					Title_2.Size = UDim2.new(0.855000019, 0, 0.5, 0)
					Title_2.FontFace = Font.new(
						"rbxasset://fonts/families/Nunito.json",
						Enum.FontWeight.Bold,
						Enum.FontStyle.Normal
					)
					Title_2.Text = "Irem123"
					Title_2.TextColor3 = Color3.fromRGB(175, 175, 175)
					Title_2.TextScaled = true
					Title_2.TextSize = 14.000
					Title_2.TextWrapped = true
					Title_2.TextXAlignment = Enum.TextXAlignment.Left

					DropBar.Name = "DropBar"
					DropBar.Parent = addDropdown
					DropBar.AnchorPoint = Vector2.new(0.5, 0.5)
					DropBar.BackgroundColor3 = Color3.fromRGB(31, 35, 44)
					DropBar.BorderColor3 = Color3.fromRGB(0, 0, 0)
					DropBar.BorderSizePixel = 0
					DropBar.Position = UDim2.new(0.500000238, 0, 1.62226081, 0)
					DropBar.Size = UDim2.new(0.814999938, 0, 1.38476801, 0)
					DropBar.Visible = false

					ScrollingFrame.Parent = DropBar
					ScrollingFrame.Active = true
					ScrollingFrame.AnchorPoint = Vector2.new(0.5, 0.5)
					ScrollingFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					ScrollingFrame.BackgroundTransparency = 1.000
					ScrollingFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
					ScrollingFrame.BorderSizePixel = 0
					ScrollingFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
					ScrollingFrame.Size = UDim2.new(0.899999976, 0, 0.899999976, 0)
					ScrollingFrame.ScrollBarThickness = 2
					ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(213, 55, 102)

					UIListLayout.Parent = ScrollingFrame
					UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
					UIListLayout.Padding = UDim.new(0, 1)


					UICorner_6.CornerRadius = UDim.new(0, 4)
					UICorner_6.Parent = DropBar

					setTextBox.Name = "setTextBox"
					setTextBox.Parent = addDropdown
					setTextBox.AnchorPoint = Vector2.new(0.5, 0.5)
					setTextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					setTextBox.BackgroundTransparency = 1.000
					setTextBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
					setTextBox.BorderSizePixel = 0
					setTextBox.Position = UDim2.new(0.690999985, 0, 0.540000021, 0)
					setTextBox.Size = UDim2.new(0.433327824, 0, 0.136000007, 0)

					UICorner_7.Parent = setTextBox

					TextBox.Parent = setTextBox
					TextBox.AnchorPoint = Vector2.new(0.5, 0.5)
					TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					TextBox.BackgroundTransparency = 1.000
					TextBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
					TextBox.BorderSizePixel = 0
					TextBox.Position = UDim2.new(0.5, 0, 0.5, 0)
					TextBox.Size = UDim2.new(0.899999976, 0, 0.699999988, 0)
					TextBox.FontFace = Font.new(
						"rbxasset://fonts/families/Nunito.json",
						Enum.FontWeight.Bold,
						Enum.FontStyle.Normal
					)
					TextBox.PlaceholderText = "Search ..."
					TextBox.Text = ""
					TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
					TextBox.TextScaled = true
					TextBox.TextSize = 14.000
					TextBox.TextWrapped = true

					resetIcon.Name = "resetIcon"
					resetIcon.Parent = addDropdown
					resetIcon.AnchorPoint = Vector2.new(0.5, 0.5)
					resetIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					resetIcon.BackgroundTransparency = 1.000
					resetIcon.BorderColor3 = Color3.fromRGB(0, 0, 0)
					resetIcon.BorderSizePixel = 0
					resetIcon.Position = UDim2.new(0.918459475, 0, 0.133560836, 0)
					resetIcon.Size = UDim2.new(0.0710434839, 0, 0.134753793, 0)
					resetIcon.Image = "rbxassetid://117300320767102"

					local UIStroke1 = Instance.new("UIStroke")
					UIStroke1.Parent = setTextBox 
					UIStroke1.Color = Color3.fromRGB(30, 30, 30)
					UIStroke1.Thickness = 1

					local UIStroke1 = Instance.new("UIStroke")
					UIStroke1.Parent = DropdownButton 
					UIStroke1.Color = Color3.fromRGB(213, 55, 102)
					UIStroke1.Thickness = 1
					UIStroke1.Transparency = 1
					UIStroke1.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

					UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
						local contentHeight = UIListLayout.AbsoluteContentSize.Y
						local parentHeight = ScrollingFrame.AbsoluteSize.Y
						local scaleHeight = contentHeight / parentHeight

						ScrollingFrame.CanvasSize = UDim2.new(0, 0, scaleHeight + 0.25, 0)
						if ScrollingFrame.CanvasSize.Y.Scale < 2 then
							ScrollingFrame.CanvasSize = UDim2.new(0, 0, 2, 0)
						end
					end)

					TextBox.Changed:Connect(function()
						if TextBox.Text ~= "" and TextBox.Text ~= "Search" then
							local InputText = string.upper(TextBox.Text)
							for _, button in pairs(ScrollingFrame:GetChildren()) do
								if button:FindFirstChild("TextLabel") then
									local TS = string.upper(button:FindFirstChild("TextLabel").Text)
									if TS:find(string.upper(TextBox.Text)) then
										button.Visible = true
									else
										button.Visible = false
									end
								end
							end
						else
							for _, button in pairs(ScrollingFrame:GetChildren()) do
								if button:FindFirstChild("TextLabel") then
									button.Visible = true
								end
							end
						end
					end)

					DropdownButton.MouseEnter:Connect(function()
						TweenService:Create(
							UIStroke1,
							TweenInfo.new(0.2,Enum.EasingStyle.Linear,Enum.EasingDirection.Out),
							{Transparency = 0.61}
						):Play()
					end)

					DropdownButton.MouseLeave:Connect(function()
						TweenService:Create(
							UIStroke1,
							TweenInfo.new(0.2,Enum.EasingStyle.Linear,Enum.EasingDirection.Out),
							{Transparency = 1}
						):Play()
					end)

					DropdownButton.MouseButton1Click
						:Connect(function()
							if DropBar.Visible then
								DropBar.Visible = false
								TweenService:Create(
									UIStroke1,
									TweenInfo.new(0.5,Enum.EasingStyle.Linear,Enum.EasingDirection.Out),
									{Transparency = 1}
								):Play()
							else
								DropBar.Visible = true
								TweenService:Create(
									UIStroke1,
									TweenInfo.new(0.5,Enum.EasingStyle.Linear,Enum.EasingDirection.Out),
									{Transparency = 0.61}
								):Play()
							end
						end)

					local function UpdateTextLabel()
						local maxDisplayCount = 3
						local textLabel_7_text = ""

						if #DropFF > maxDisplayCount then
							textLabel_7_text = textLabel_7_text .. table.concat(DropFF, ", ", 1, maxDisplayCount) .. ", ..."
						else
							if #DropFF < 1 then
								Title_2.Text = "None"
								return
							else
								textLabel_7_text = textLabel_7_text .. table.concat(DropFF, ", ")
							end
						end

						textLabel_7_text = textLabel_7_text
						Title_2.Text = textLabel_7_text
					end

					UpdateTextLabel()

					if RestButton then
						resetIcon.MouseButton1Click:Connect(function()
							DropFF = {}
							UpdateTextLabel()
							TweenService:Create(
								resetIcon,
								TweenInfo.new(0.5,Enum.EasingStyle.Linear,Enum.EasingDirection.Out),
								{Rotation = 360}
							):Play()
							RestButton()
							wait(.5)
							TweenService:Create(
								resetIcon,
								TweenInfo.new(0.5,Enum.EasingStyle.Linear,Enum.EasingDirection.Out),
								{Rotation = 0}
							):Play()
						end)
					end

					self.DropDownList = {}
					self.DropDownList.Clear = function(c : string)
						for i, v in next, ScrollingFrame:GetChildren() do
							if v:IsA("TextButton") then 
								v:Destroy()
							end
						end
					end
					self.DropDownList.Add = function(c : string)
						for i,v in pairs(ScrollingFrame:GetChildren()) do
							if v:IsA('TextButton') and v.TextLabel.Text == c then
								return
							end
						end
						local ButtonDrop = Instance.new("TextButton")
						local TextButton = Instance.new("TextLabel")
						local UICorner_4 = Instance.new("UICorner")

						ButtonDrop.Name = "ButtonDrop"
						ButtonDrop.Parent = ScrollingFrame
						ButtonDrop.BackgroundColor3 = Color3.fromRGB(20, 24, 33)
						ButtonDrop.BorderColor3 = Color3.fromRGB(0, 0, 0)
						ButtonDrop.Transparency = 1
						ButtonDrop.Text = ""
						ButtonDrop.BorderSizePixel = 0
						ButtonDrop.Size = UDim2.new(1, 0, 0.0719999969, 0)

						TextButton.Parent = ButtonDrop
						TextButton.AnchorPoint = Vector2.new(0.5, 0.5)
						TextButton.BackgroundColor3 = Color3.fromRGB(21, 25, 34)
						TextButton.BackgroundTransparency = 1.000
						TextButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
						TextButton.BorderSizePixel = 0
						TextButton.Position = UDim2.new(0.5, 0, 0.5, 0)
						TextButton.Size = UDim2.new(0.899999976, 0, 0.600000024, 0)
						TextButton.Font = Enum.Font.SourceSans
						TextButton.Text = c
						TextButton.TextColor3 = Color3.fromRGB(175, 175, 175)
						TextButton.TextScaled = true
						TextButton.TextSize = 14.000
						TextButton.TextWrapped = true
						TextButton.TextXAlignment = Enum.TextXAlignment.Left

						UICorner_4.CornerRadius = UDim.new(0, 5)
						UICorner_4.Parent = ButtonDrop

						if table.find(DropFF, c) then
							TweenService:Create(
								ButtonDrop,
								TweenInfo.new(0.5,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
								{Transparency = 0}
							):Play()
						end

						ButtonDrop.MouseButton1Click:Connect(function()
							if not table.find(DropFF, c) then
								table.insert(DropFF, c)
								Callback(DropFF, c)
								UpdateTextLabel()
								TweenService:Create(
									ButtonDrop,
									TweenInfo.new(0.5,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
									{Transparency = 0}
								):Play()
							else
								TweenService:Create(
									ButtonDrop,
									TweenInfo.new(0.5,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
									{Transparency = 1}
								):Play()
								for i2, v2 in ipairs(DropFF) do
									if v2 == c then
										table.remove(DropFF, i2)
										Callback(DropFF, c)
										UpdateTextLabel()
										break
									end
								end
							end
						end)

						local canvasSize = ScrollingFrame.CanvasSize
						local Pars = ButtonDrop.Size.Y.Scale +  ButtonDrop.Size.Y.Scale
						local function updateSize()
							canvasSize = ScrollingFrame.CanvasSize
							if canvasSize.Y.Scale >= 2 then
								ButtonDrop.Size = UDim2.new(1, 0, Pars / canvasSize.Y.Scale, 0)
							end
						end

						ButtonDrop.Size = UDim2.new(1, 0, ButtonDrop.Size.Y.Scale, 0)
						UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
							updateSize()
						end)
					end

					for i,v in next, List do
						self.DropDownList.Add(v)
					end

					Callback(Title_2.Text ~= 'None' and Value or nil )
					return self.DropDownList
				end

				local canvasSize = MainScrollingFrame.CanvasSize
				local Pars = setGroupFrame.Size.Y.Scale +  setGroupFrame.Size.Y.Scale
				local function updateSize()
					canvasSize = MainScrollingFrame.CanvasSize
					if canvasSize.Y.Scale >= 2 then
						setGroupFrame.Size = UDim2.new(1, 0, Pars / canvasSize.Y.Scale, 0)
					end
				end

				setGroupFrame.Size = UDim2.new(1, 0, Pars, 0)
				UIListLayout_3:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
					updateSize()
				end)
				return self.Group
			end
			return self.Tap
		end
		return self
	end
}
return library

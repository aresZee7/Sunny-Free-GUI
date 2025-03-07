local library = {}
local par = game.CoreGui
_G.ToggleUi = true

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService('RunService')
local camera = workspace.CurrentCamera
local DDX,DDY
local Mouse = game.Players.LocalPlayer:GetMouse()
local BlurFrameL = loadstring(game:HttpGet('https://raw.githubusercontent.com/aresZee7/aresLibrary/main/BlurFrame'))()

function dragify(Frame, object)
	local dragToggle = false
	local dragSpeed = 0.25
	local dragInput = nil
	local dragStart = nil
	local startPos = nil

	function updateInput(input)
		if not dragStart then
			return
		end
		local Delta = input.Position - dragStart
		if _G['ทำให้ UI ไม่ออก ขอบ'] then
			Delta = Vector2.new(math.clamp(startPos.X.Offset + Delta.X, -DDX, DDX), math.clamp(startPos.Y.Offset +  Delta.Y, -DDY, DDY))
			local Position = UDim2.new(startPos.X.Scale, Delta.X, startPos.Y.Scale, Delta.Y)
			TweenService:Create(object, TweenInfo.new(dragSpeed), {Position = Position}):Play()
		else
			Delta = input.Position - dragStart
			local Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y)
			game:GetService("TweenService"):Create(object, TweenInfo.new(dragSpeed), {Position = Position}):Play()
		end

	end

	Frame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragToggle = true
			dragStart = input.Position
			startPos = object.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragToggle = false
				end
			end)
		end
	end)

	Frame.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragToggle then
			updateInput(input)
		end
	end)
end
local MainDirectory = "Ares UI"
local AssetsDirectory = "Ares UI\\Assets"
local function CheckDirectory()
	if getgenv then
		if not isfolder(MainDirectory) then
			makefolder(MainDirectory)
		end
		if not isfolder(AssetsDirectory) then
			makefolder(AssetsDirectory)
		end
	end
end
local function GetImage(name, url)
	if getgenv then
		CheckDirectory()

		local path = string.format("%s\\%s.png", AssetsDirectory, name)
		if not isfile(path) then
			local content = game:HttpGet(url)
			writefile(path, content)
		end

		return getcustomasset(path)
	end
end

if par:FindFirstChild('Lux002') then
	par:FindFirstChild('Lux002'):Destroy()
end

local Lux002 = Instance.new("ScreenGui")
Lux002.Name = "Lux002"
Lux002.Parent = par
Lux002.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

function library.Create(options)
	local Shadown = Instance.new("ImageLabel")
	Shadown.Name = "Shadown"
	Shadown.Parent = Lux002
	Shadown.AnchorPoint = Vector2.new(0.5, 0.5)
	Shadown.BackgroundColor3 = Color3.fromRGB(48, 51, 71)
	Shadown.BackgroundTransparency = 1.000
	Shadown.Position = UDim2.new(0.5, 0, 0.5, 0)
	Shadown.Size = UDim2.new(0, options.UISize.X, 0, options.UISize.Y) -- {0, 755},{0, 425} > PC 
	Shadown.SizeConstraint = Enum.SizeConstraint.RelativeYY
	Shadown.ZIndex = 0
	Shadown.Image = "rbxassetid://7912134082"
	Shadown.ImageColor3 = options.UIColor['Shadow'] or Color3.fromRGB(48, 51, 71)
	Shadown.ImageTransparency = 0.300
	Shadown.SliceCenter = Rect.new(95, 95, 205, 205)

	local MainBackground = options.UIColor['MainBackground']
	local Background2 = options.UIColor['Background2']
	local ToggleOC = options.UIColor['ToggleO']
	local TapC = options.UIColor['TapButtonColor']
	local DropDownSelect = options.UIColor['DropDownSelect']
	local TextColorUI = options.UIColor['TextColor']

	local Main = Instance.new("Frame")
	Main.Name = "Main"
	Main.Parent = Shadown
	Main.AnchorPoint = Vector2.new(0.5, 0.5)
	Main.BackgroundColor3 = MainBackground or Color3.fromRGB(48, 51, 71)
	Main.BackgroundTransparency = 0.300
	Main.ClipsDescendants = true
	Main.Position = UDim2.new(0.5, 0, 0.5, 0)
	Main.Size = UDim2.new(0.899999976, 0, 0.899999976, 0)

	local UICorner_24 = Instance.new("UICorner")
	UICorner_24.CornerRadius = UDim.new(0, options.CornerRadius)
	UICorner_24.Parent = Main

	local Loading = Instance.new("Frame")
	local UICorner_25 = Instance.new("UICorner")
	local LoadLogo = Instance.new("ImageLabel")
	local TextLabel_6 = Instance.new("TextLabel")

	Loading.Name = "Loading"
	Loading.Parent = Main
	Loading.AnchorPoint = Vector2.new(0.5, 0.5)
	Loading.BackgroundColor3 = MainBackground or Color3.fromRGB(48, 51, 71)
	Loading.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Loading.BorderSizePixel = 0
	Loading.Position = UDim2.new(0.5, 0, 0.5, 0)
	Loading.Size = UDim2.new(1, 0, 1, 0)
	Loading.ZIndex = 9999
	Loading.Visible = false

	UICorner_25.CornerRadius = UDim.new(0, options.CornerRadius)
	UICorner_25.Parent = Loading

	LoadLogo.Name = "LoadLogo"
	LoadLogo.Parent = Loading
	LoadLogo.AnchorPoint = Vector2.new(0.5, 0.5)
	LoadLogo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	LoadLogo.BackgroundTransparency = 1.000
	LoadLogo.BorderColor3 = Color3.fromRGB(0, 0, 0)
	LoadLogo.BorderSizePixel = 0
	LoadLogo.Position = UDim2.new(0.5, 0, 0.5, 0)
	LoadLogo.Size = UDim2.new(0, 70, 0, 70)
	LoadLogo.ZIndex = 2
	if type(options.Logo) == 'string' and not options.Logo:find('rbxassetid://') then
		LoadLogo.Image = "rbxassetid://".. options.Logo
	elseif type(options.Logo) == 'number' then
		LoadLogo.Image = "rbxassetid://".. options.Logo
	else
		LoadLogo.Image = options.Logo
	end

	TextLabel_6.Parent = Loading
	TextLabel_6.AnchorPoint = Vector2.new(0.5, 0.5)
	TextLabel_6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_6.BackgroundTransparency = 1.000
	TextLabel_6.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextLabel_6.BorderSizePixel = 0
	TextLabel_6.Position = UDim2.new(0.5, 0, 0.5, 0)
	TextLabel_6.Size = UDim2.new(0, 200, 0, 50)
	TextLabel_6.ZIndex = 2
	TextLabel_6.Font = Enum.Font.FredokaOne
	TextLabel_6.Text = "Sunny Community"
	TextLabel_6.TextColor3 = Color3.fromRGB(189, 198, 212)
	TextLabel_6.TextSize = 14.000
	TextLabel_6.TextTransparency = 1.000

	local OP = false
	local function NNNF_fake_script()
		local script = Instance.new('LocalScript', Loading)

		local Type__ = 1
		delay(1, function()
			for i = 1,10 do
				script.Parent.Visible = true
				game:GetService("TweenService"):Create(
				script.Parent.LoadLogo,
				TweenInfo.new(0.5,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
				{Rotation = 90 * i}
				):Play()
				if i >= 3 then
					game:GetService("TweenService"):Create(
					script.Parent.LoadLogo,
					TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
					{Position = UDim2.new(0.5, 0, 0.5, -30)}
					):Play()
					delay(1, function()
						game:GetService("TweenService"):Create(
						script.Parent.TextLabel,
						TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
						{TextTransparency = 0}
						):Play()
						game:GetService("TweenService"):Create(
						script.Parent.TextLabel,
						TweenInfo.new(0.5,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
						{Position = UDim2.new(0.5, 0, 0.5, 30)}
						):Play()
						if i == 10 then
							OP = true
						end
					end)
				end
				wait(.002)
			end
		end)
		repeat task.wait() until OP == true
		task.delay(1, function()
			game:GetService("TweenService"):Create(
			script.Parent,
			TweenInfo.new(0.4,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
			{Size = UDim2.new(0, 0, 0, 0)}
			):Play()
			game:GetService("TweenService"):Create(
			script.Parent.TextLabel,
			TweenInfo.new(0.4,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
			{TextTransparency = 1}
			):Play()
			game:GetService("TweenService"):Create(
			script.Parent.LoadLogo,
			TweenInfo.new(0.4,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
			{ImageTransparency = 1}
			):Play()
		end)
	end
	coroutine.wrap(NNNF_fake_script)()
	repeat task.wait() until OP == true


	local Top = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	Top.Name = "Top"
	Top.Parent = Main
	Top.Active = true
	Top.BackgroundColor3 = MainBackground or Color3.fromRGB(48, 51, 71)
	Top.BackgroundTransparency = 1.000
	Top.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Top.BorderSizePixel = 0
	Top.Position = UDim2.new(0, 0, 0.0222222228, 0)
	Top.Size = UDim2.new(1, 0, 0.00999999978, 40)

	UICorner.CornerRadius = UDim.new(0, options.CornerRadius)
	UICorner.Parent = Top

	local frame,object = Top, Shadown
	local BlurFrame2 = BlurFrameL:BlurFrame(Main)
	if DDX == nil then DDX = object.AbsolutePosition.X end
	if DDY == nil then DDY = object.AbsolutePosition.Y end

	dragify(frame, object)

	local Cup = Instance.new("Frame")
	local NameHub = Instance.new("TextLabel")
	local LogoHub = Instance.new("ImageLabel")

	Cup.Name = "Cup"
	Cup.Parent = Top
	Cup.Active = true
	Cup.BackgroundColor3 = MainBackground or Color3.fromRGB(48, 51, 71)
	Cup.BackgroundTransparency = 1.000
	Cup.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Cup.BorderSizePixel = 0
	Cup.Position = UDim2.new(0, 0, 0.467185766, 0)
	Cup.Size = UDim2.new(1, 0, -0.357063383, 40)

	NameHub.Name = "NameHub"
	NameHub.Parent = Top
	NameHub.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	NameHub.BackgroundTransparency = 1.000
	NameHub.BorderColor3 = Color3.fromRGB(0, 0, 0)
	NameHub.BorderSizePixel = 0
	NameHub.ClipsDescendants = true
	NameHub.Position = UDim2.new(0.0851851851, 0, 0, 0)
	NameHub.Size = UDim2.new(0.298148155, 0, 0.986308813, 0)
	NameHub.Text = options.Title
	NameHub.TextColor3 = Color3.fromRGB(255, 255, 255)
	NameHub.TextSize = 12.000
	NameHub.TextXAlignment = Enum.TextXAlignment.Left
	NameHub.FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)

	LogoHub.Name = "Logo Hub"
	LogoHub.Parent = Top
	LogoHub.AnchorPoint = Vector2.new(0.5, 0.5)
	LogoHub.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	LogoHub.BackgroundTransparency = 1.000
	LogoHub.BorderColor3 = Color3.fromRGB(0, 0, 0)
	LogoHub.BorderSizePixel = 0
	LogoHub.Position = UDim2.new(0.053703703, 0, 0.499999881, 0)
	LogoHub.Size = UDim2.new(0, 15, 0, 15)
	if type(options.Logo) == 'string' and not options.Logo:find('rbxassetid://') then
		LogoHub.Image = "rbxassetid://".. options.Logo
	elseif type(options.Logo) == 'number' then
		LogoHub.Image = "rbxassetid://".. options.Logo
	else
		LogoHub.Image = options.Logo
	end

	local MainPage = Instance.new("Frame")
	MainPage.Name = "MainPage"
	MainPage.Parent = Main
	MainPage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	MainPage.BackgroundTransparency = 4.000
	MainPage.BorderColor3 = Color3.fromRGB(0, 0, 0)
	MainPage.BorderSizePixel = 0
	MainPage.Position = UDim2.new(0.214814797, 0, 0.141666651, 0)
	MainPage.Size = UDim2.new(0.769999981, 0, 0.850000024, 0)

	local Tap = Instance.new("Frame")
	local ScrollingFrame = Instance.new("ScrollingFrame")
	local UIPadding = Instance.new("UIPadding")
	local UIListLayout = Instance.new("UIListLayout")

	Tap.Name = "Tap"
	Tap.Parent = Main
	Tap.AnchorPoint = Vector2.new(0, 0.5)
	Tap.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Tap.BackgroundTransparency = 1.000
	Tap.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Tap.BorderSizePixel = 0
	Tap.Position = UDim2.new(0.0129999798, 0, 0.5625, 0)
	Tap.Size = UDim2.new(0.200000003, 0, 0.834686875, 0)

	ScrollingFrame.Parent = Tap
	ScrollingFrame.Active = true
	ScrollingFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ScrollingFrame.BackgroundTransparency = 1.000
	ScrollingFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ScrollingFrame.BorderSizePixel = 0
	ScrollingFrame.Size = UDim2.new(1, 0, 1, 0)
	ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0)
	ScrollingFrame.ScrollBarImageTransparency = 0.800000011920929
	ScrollingFrame.ScrollBarThickness = 1

	UIPadding.Parent = ScrollingFrame
	UIPadding.PaddingLeft = UDim.new(0, 5)

	UIListLayout.Parent = ScrollingFrame
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 5)

	local OpenUI = true
	UserInputService.InputBegan:Connect(function(input)
		if input.KeyCode == Enum.KeyCode.RightControl then
			if OpenUI then
				OpenUI = false
				Shadown.Visible = false
				for i = 1,2 do
					BlurFrame2[i]:Destroy()
				end
			else
				OpenUI = true
				Shadown.Visible = true
				BlurFrame2 = BlurFrameL:BlurFrame(Main)
			end
		end
	end)

	if _G.ToggleUi then
		local CloseUI = Instance.new("ScreenGui")
		local CloseUIMain = Instance.new("Frame")
		local Logo = Instance.new("ImageLabel")
		local UICorner = Instance.new("UICorner")
		local Use = Instance.new("TextButton")

		CloseUI.Name = "CloseUI"
		CloseUI.Parent = par
		CloseUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

		CloseUIMain.Name = "CloseUIMain"
		CloseUIMain.Parent = CloseUI
		CloseUIMain.BackgroundColor3 = MainBackground
		CloseUIMain.BorderColor3 = Color3.new(0, 0, 0)
		CloseUIMain.BorderSizePixel = 0
		CloseUIMain.Position = UDim2.new(0.0319926888, 0, 0.129, 0)
		CloseUIMain.Size = UDim2.new(0, 75, 0, 0)

		CloseUIMain:TweenSize(UDim2.new(0, 75, 0, 51),"Out","Back",3.5,false)

		Logo.Name = "Logo"
		Logo.Parent = CloseUIMain
		Logo.BackgroundColor3 = Color3.new(1, 1, 1)
		Logo.BackgroundTransparency = 1
		Logo.BorderColor3 = Color3.new(0, 0, 0)
		Logo.BorderSizePixel = 0
		Logo.Position = UDim2.new(0.323333323, 0, 0.235294119, 0)
		Logo.Size = UDim2.new(0.349999994, 0, 0.5, 0)
		if type(options.Logo) == 'string' and not options.Logo:find('rbxassetid://') then
			Logo.Image = "rbxassetid://".. options.Logo
		elseif type(options.Logo) == 'number' then
			Logo.Image = "rbxassetid://".. options.Logo
		else
			Logo.Image = options.Logo
		end


		UICorner.Parent = CloseUIMain
		UICorner.CornerRadius = UDim.new(0, 100)

		Use.Name = "Use"
		Use.Parent = CloseUIMain
		Use.BackgroundColor3 = Color3.new(1, 1, 1)
		Use.BackgroundTransparency = 1
		Use.BorderColor3 = Color3.new(0, 0, 0)
		Use.BorderSizePixel = 0
		Use.Size = UDim2.new(1, 0, 1, 0)
		Use.Font = Enum.Font.SourceSans
		Use.Text = ""
		Use.TextColor3 = Color3.new(0, 0, 0)
		Use.TextSize = 14

		Use.MouseButton1Click:Connect(function()
			if OpenUI then
				OpenUI = false
				Shadown.Visible = false
				for i = 1,2 do
					BlurFrame2[i]:Destroy()
				end
			else
				OpenUI = true
				Shadown.Visible = true
				BlurFrame2 = BlurFrameL:BlurFrame(Main)
			end
		end)
	end

	library.TapGroup = {
		Value = false
	}
	library.TapGroup.CreateTap = function(options)
		local TapTitle = options.Title or ""
		local TapIcon = options.Icon or ""

		local ButtonTap = Instance.new("TextButton")
		local UICorner_2 = Instance.new("UICorner")
		local ImageLabel = Instance.new("ImageLabel")
		local TextLabel = Instance.new("TextLabel")

		ButtonTap.Name = "ButtonTap"
		ButtonTap.Parent = ScrollingFrame
		ButtonTap.BackgroundColor3 = Color3.fromRGB(161, 155, 76)
		ButtonTap.BackgroundTransparency = 1.000
		ButtonTap.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ButtonTap.BorderSizePixel = 0
		ButtonTap.Position = UDim2.new(0, 0, 3.58570489e-08, 0)
		ButtonTap.Size = UDim2.new(0.949999988, 0, 0, 29)
		ButtonTap.Font = Enum.Font.SourceSans
		ButtonTap.Text = ""
		ButtonTap.TextColor3 = Color3.fromRGB(0, 0, 0)
		ButtonTap.TextSize = 14.000

		UICorner_2.CornerRadius = UDim.new(0, 5)
		UICorner_2.Parent = ButtonTap

		ImageLabel.Parent = ButtonTap
		ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
		ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ImageLabel.BackgroundTransparency = 1.000
		ImageLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ImageLabel.BorderSizePixel = 0
		ImageLabel.Position = UDim2.new(0.172968701, 0, 0.5, 0)
		ImageLabel.Size = UDim2.new(0, 15, 0, 15)
		if type(TapIcon) == 'string' and not TapIcon:find('rbxassetid://') then
			ImageLabel.Image = "rbxassetid://".. TapIcon
		elseif type(TapIcon) == 'number' then
			ImageLabel.Image = "rbxassetid://".. TapIcon
		else
			ImageLabel.Image = TapIcon
		end
		ImageLabel.ImageColor3 = TapC

		TextLabel.Parent = ButtonTap
		TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TextLabel.BackgroundTransparency = 1.000
		TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TextLabel.BorderSizePixel = 0
		TextLabel.Size = UDim2.new(1, 0, 1, 0)
		TextLabel.Text = TapTitle
		TextLabel.TextColor3 = TapC
		TextLabel.TextSize = 11.000
		TextLabel.TextStrokeTransparency = 0.900
		TextLabel.FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)

		local Page = Instance.new("Frame")
		local LeftMain = Instance.new("ScrollingFrame")
		local UIListLayout_2 = Instance.new("UIListLayout")
		local UIPadding_2 = Instance.new("UIPadding")

		Page.Name = "Page"
		Page.Parent = MainPage
		Page.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Page.BackgroundTransparency = 1.000
		Page.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Page.BorderSizePixel = 0
		Page.Visible = false
		Page.Size = UDim2.new(1, 0, 1, 0)

		LeftMain.Name = "LeftMain"
		LeftMain.Parent = Page
		LeftMain.Active = true
		LeftMain.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		LeftMain.BackgroundTransparency = 1.000
		LeftMain.BorderColor3 = Color3.fromRGB(0, 0, 0)
		LeftMain.BorderSizePixel = 0
		LeftMain.Position = UDim2.new(7.19754212e-08, 0, 0, 0)
		LeftMain.Size = UDim2.new(0.473118305, 0, 1, 0)
		LeftMain.ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0)
		LeftMain.ScrollBarThickness = 0

		UIListLayout_2.Parent = LeftMain
		UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder

		UIPadding_2.Parent = LeftMain

		local RightMain = Instance.new("ScrollingFrame")
		local UIListLayout_5 = Instance.new("UIListLayout")
		local UIPadding_5 = Instance.new("UIPadding")
		RightMain.Name = "RightMain"
		RightMain.Parent = Page
		RightMain.Active = true
		RightMain.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		RightMain.BackgroundTransparency = 1.000
		RightMain.BorderColor3 = Color3.fromRGB(0, 0, 0)
		RightMain.BorderSizePixel = 0
		RightMain.Position = UDim2.new(0.489209443, 0, 0, 0)
		RightMain.Size = UDim2.new(0.473118037, 0, 1, 0)
		RightMain.ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0)
		RightMain.ScrollBarThickness = 0

		UIListLayout_5.Parent = RightMain
		UIListLayout_5.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout_5.Padding = UDim.new(0, 5)

		UIPadding_5.Parent = RightMain

		UIListLayout_2:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			LeftMain.CanvasSize = UDim2.new(0, 0, 0, UIListLayout_2.AbsoluteContentSize.Y + 35)
		end)
		UIListLayout_5:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			RightMain.CanvasSize = UDim2.new(0, 0, 0, UIListLayout_5.AbsoluteContentSize.Y + 35)
		end)

		ButtonTap.MouseButton1Click:Connect(function()
			for _, v in pairs(MainPage:GetChildren()) do
				if v:IsA("Frame") then
					v.Visible = false
				end
			end
			for _, v in pairs(ScrollingFrame:GetChildren()) do
				if v:IsA("TextButton") then
					TweenService:Create(
						v.TextLabel,
						TweenInfo.new(0.9,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
						{TextColor3 = TapC}
					):Play()
					TweenService:Create(
						v.ImageLabel,
						TweenInfo.new(0.9,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
						{ImageColor3 = TapC}
					):Play()
				end
			end
			Page.Visible = true
			TweenService:Create(
				TextLabel,
				TweenInfo.new(0.9,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
				{TextColor3 = Color3.fromRGB(255, 255, 255)}
			):Play()
			TweenService:Create(
				ImageLabel,
				TweenInfo.new(0.9,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
				{ImageColor3 = Color3.fromRGB(255, 255, 255)}
			):Play()
			print("Next Tap")
		end)

		delay(1,function() 
			if not library.TapGroup.Value then 
				Page.Visible = true
				library.TapGroup.Value = true 
				TweenService:Create(
					TextLabel,
					TweenInfo.new(0.9,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
					{TextColor3 = Color3.fromRGB(255, 255, 255)}
				):Play()
				TweenService:Create(
					ImageLabel,
					TweenInfo.new(0.9,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
					{ImageColor3 = Color3.fromRGB(255, 255, 255)}
				):Play()
			end 
		end)

		local GetType = function(value)
			if value == 1 or value == "Left" then
				return LeftMain
			elseif value == 2 or value == "Right" then
				return RightMain
			else
				return LeftMain
			end
		end

		library.Sections = {}
		library.Sections.CreatePage = function(options)
			local Sections = Instance.new("Frame")
			local UICorner_3 = Instance.new("UICorner")
			local UIListLayout_3 = Instance.new("UIListLayout")
			local UIPadding_3 = Instance.new("UIPadding")

			Sections.Name = "Sections"
			Sections.Parent = GetType(options.Side)
			Sections.BackgroundColor3 = MainBackground or Color3.fromRGB(48, 51, 71)
			Sections.BackgroundTransparency = 0.500
			Sections.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Sections.BorderSizePixel = 0
			Sections.Position = UDim2.new(0, 0, -0.50857532, 0)
			Sections.Size = UDim2.new(1.00000012, 0, 0.562308431, 100)

			UICorner_3.Parent = Sections

			UIListLayout_3.Parent = Sections
			UIListLayout_3.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout_3.Padding = UDim.new(0, 5)

			UIPadding_3.Parent = Sections
			UIPadding_3.PaddingLeft = UDim.new(0, 5)
			UIPadding_3.PaddingTop = UDim.new(0, 5)

			UIListLayout_3:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
				Sections.Size = UDim2.new(1, 0, 0, UIListLayout_3.AbsoluteContentSize.Y + 35)
			end)

			library.FuncMain = {}
			library.FuncMain.CreateLable = function(options)
				local Lable = Instance.new("Frame")
				local UICorner_4 = Instance.new("UICorner")
				local TextLabel_2 = Instance.new("TextLabel")

				Lable.Name = "Lable"
				Lable.Parent = Sections
				Lable.BackgroundColor3 = Background2
				Lable.BackgroundTransparency = 0.600
				Lable.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Lable.BorderSizePixel = 0
				Lable.Size = UDim2.new(0.949999988, 0, 0, 30)

				UICorner_4.CornerRadius = UDim.new(0, 2)
				UICorner_4.Parent = Lable

				TextLabel_2.Parent = Lable
				TextLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TextLabel_2.BackgroundTransparency = 1.000
				TextLabel_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
				TextLabel_2.BorderSizePixel = 0
				TextLabel_2.Position = UDim2.new(0.0441415086, 0, 0, 0)
				TextLabel_2.Size = UDim2.new(0.955858469, 0, 1, 0)
				TextLabel_2.Text = options.Name
				TextLabel_2.TextColor3 = TextColorUI or Color3.fromRGB(142, 144, 150)
				TextLabel_2.TextSize = 12.000
				TextLabel_2.TextXAlignment = Enum.TextXAlignment.Left
				TextLabel_2.FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)

				local TextTable = {}
				function TextTable:Set(Value)
					TextLabel_2.Text = Value
				end;function TextTable:SetColor(Color)
					TextLabel_2.TextColor3 = Color or TextColorUI or Color3.fromRGB(142, 144, 150)
				end

				return TextTable
			end
			library.FuncMain.CreateToggle = function(options, Lock)
				local ToggleTable = {}
				local Name = options.Name;wait()
				local default = options.Value
				local Dis = options.Dis
				local callback = options.Callback or function() end
				local ToggleTable = {}
				local Lock = Lock or false

				local Toggle = Instance.new("Frame")
				local UICorner = Instance.new("UICorner")
				local TitleText = Instance.new("TextLabel")
				local TitleDis = Instance.new("TextLabel")
				local ToggleO = Instance.new("Frame")
				local O = Instance.new("Frame")
				local UICorner_2 = Instance.new("UICorner")
				local UICorner_3 = Instance.new("UICorner")
				local TextButton = Instance.new("TextButton")
				local LockToggle = Instance.new("Frame")
				local ToggleLocker = Instance.new("ImageLabel")
				local UICorner_4 = Instance.new("UICorner")

				Toggle.Name = "Toggle"
				Toggle.Parent = Sections
				Toggle.BackgroundColor3 = Background2
				Toggle.BackgroundTransparency = 0.600
				Toggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Toggle.BorderSizePixel = 0
				Toggle.Size = UDim2.new(0.949999988, 0, 0, 40)

				UICorner.CornerRadius = UDim.new(0, 2)
				UICorner.Parent = Toggle

				TitleText.Name = "TitleText"
				TitleText.Parent = Toggle
				TitleText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TitleText.BackgroundTransparency = 1.000
				TitleText.BorderColor3 = Color3.fromRGB(0, 0, 0)
				TitleText.BorderSizePixel = 0
				TitleText.Position = UDim2.new(0.0441415198, 0, 0, 0)
				TitleText.Size = UDim2.new(0.955858588, 0, 0.374999851, 0)
				TitleText.FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
				TitleText.Text = Name
				TitleText.TextColor3 = TextColorUI or Color3.fromRGB(142, 144, 150)
				TitleText.TextSize = 12.000
				TitleText.TextXAlignment = Enum.TextXAlignment.Left

				if Dis ~= nil and Dis ~= "" then
					TitleDis.Name = "TitleDis"
					TitleDis.Parent = Toggle
					TitleDis.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					TitleDis.BackgroundTransparency = 1.000
					TitleDis.BorderColor3 = Color3.fromRGB(0, 0, 0)
					TitleDis.BorderSizePixel = 0
					TitleDis.ClipsDescendants = true
					TitleDis.Position = UDim2.new(0.0439999998, 0, 0.449999988, 0)
					TitleDis.Size = UDim2.new(0.728003502, 0, 0.5, 0)
					TitleDis.FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
					TitleDis.Text = Dis
					TitleDis.TextColor3 = TextColorUI or Color3.fromRGB(142, 144, 150)
					TitleDis.TextSize = 10.000
					TitleDis.TextWrapped = true
					TitleDis.TextXAlignment = Enum.TextXAlignment.Left
					TitleDis.TextYAlignment = Enum.TextYAlignment.Top
				end
				if Dis == nil or  Dis == "" then
					TitleText.Text = Name
					TitleText.AnchorPoint = Vector2.new(0, 0.5)
					TitleText.Position = UDim2.new(0.0441415198, 0, .5, 0)
					Toggle.Size = UDim2.new(0.949999988, 0, 0, 30)
					print(Name)
				end

				ToggleO.Name = "ToggleO"
				ToggleO.Parent = Toggle
				ToggleO.AnchorPoint = Vector2.new(0.5, 0.5)
				ToggleO.BackgroundColor3 = MainBackground or Color3.fromRGB(48, 51, 71)
				ToggleO.BackgroundTransparency = 0.200
				ToggleO.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ToggleO.BorderSizePixel = 0
				ToggleO.Position = UDim2.new(0.855000019, 0, 0.5, 0)
				ToggleO.Size = UDim2.new(0, 35, 0, 15)

				O.Name = "O"
				O.Parent = ToggleO
				O.AnchorPoint = Vector2.new(0, 0.5)
				O.BackgroundColor3 = Background2
				O.BorderColor3 = Color3.fromRGB(0, 0, 0)
				O.BorderSizePixel = 0
				O.Position = UDim2.new(0.1, 0, 0.5, 0)
				O.Size = UDim2.new(0, 10, 0, 10)

				UICorner_2.CornerRadius = UDim.new(1, 0)
				UICorner_2.Parent = O

				UICorner_3.Parent = ToggleO

				TextButton.Parent = Toggle
				TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TextButton.BackgroundTransparency = 1.000
				TextButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
				TextButton.BorderSizePixel = 0
				TextButton.Size = UDim2.new(1, 0, 1, 0)
				TextButton.Font = Enum.Font.SourceSans
				TextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
				TextButton.TextSize = 14.000
				TextButton.TextTransparency = 1.000

				LockToggle.Name = "LockToggle"
				LockToggle.Parent = Toggle
				LockToggle.BackgroundColor3 = Background2
				LockToggle.BackgroundTransparency = 0.500
				LockToggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
				LockToggle.BorderSizePixel = 0
				LockToggle.Size = UDim2.new(1, 0, 1, 0)
				LockToggle.Visible = false

				ToggleLocker.Name = "ToggleLocker"
				ToggleLocker.Parent = LockToggle
				ToggleLocker.AnchorPoint = Vector2.new(0.5, 0.5)
				ToggleLocker.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ToggleLocker.BackgroundTransparency = 1.000
				ToggleLocker.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ToggleLocker.BorderSizePixel = 0
				ToggleLocker.Position = UDim2.new(0.5, 0, 0.5, 0)
				ToggleLocker.Size = UDim2.new(0, 20, 0, 20)
				ToggleLocker.Image = "http://www.roblox.com/asset/?id=6031082533"

				UICorner_4.CornerRadius = UDim.new(0, 2)
				UICorner_4.Parent = LockToggle

				if default == true then
					callback(default)
					TweenService:Create(
						TitleText,
						TweenInfo.new(0.9,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
						{TextColor3 = Color3.fromRGB(198, 200, 209)}
					):Play()
					TweenService:Create(
						TitleDis,
						TweenInfo.new(0.9,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
						{TextColor3 = Color3.fromRGB(198, 200, 209)}
					):Play()
					TweenService:Create(
						O,
						TweenInfo.new(0.4,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
						{Position = UDim2.new(0.6, 0, 0.5, 0)}
					):Play()
					TweenService:Create(
						O,
						TweenInfo.new(0.9,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
						{BackgroundColor3 = Background2}
					):Play()
				end

				TextButton.MouseButton1Click:Connect(function()
					if not Lock then
						if not default then
							default = true
							TweenService:Create(
								TitleText,
								TweenInfo.new(0.9,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
								{TextColor3 = Color3.fromRGB(198, 200, 209)}
							):Play()
							TweenService:Create(
								TitleDis,
								TweenInfo.new(0.9,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
								{TextColor3 = Color3.fromRGB(198, 200, 209)}
							):Play()
							TweenService:Create(
								O,
								TweenInfo.new(0.4,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
								{Position = UDim2.new(0.6, 0, 0.5, 0)}
							):Play()
							TweenService:Create(
								O,
								TweenInfo.new(0.9,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
								{BackgroundColor3 = ToggleOC}
							):Play()
						else
							default = false
							TweenService:Create(
								TitleText,
								TweenInfo.new(0.9,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
								{TextColor3 = TextColorUI or Color3.fromRGB(142, 144, 150)}
							):Play()
							TweenService:Create(
								TitleDis,
								TweenInfo.new(0.9,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
								{TextColor3 = TextColorUI or Color3.fromRGB(142, 144, 150)}
							):Play()
							TweenService:Create(
								O,
								TweenInfo.new(0.4,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
								{Position = UDim2.new(0.1, 0, 0.5, 0)}
							):Play()
							TweenService:Create(
								O,
								TweenInfo.new(0.9,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
								{BackgroundColor3 = Background2}
							):Play()
						end 
						callback(default)
					end
				end)

				function ToggleTable:Update(Value)
					if not Lock then
						if not Value then
							default = true
							TweenService:Create(
								TitleText,
								TweenInfo.new(0.9,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
								{TextColor3 = Color3.fromRGB(198, 200, 209)}
							):Play()
							TweenService:Create(
								TitleDis,
								TweenInfo.new(0.9,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
								{TextColor3 = Color3.fromRGB(198, 200, 209)}
							):Play()
							TweenService:Create(
								O,
								TweenInfo.new(0.4,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
								{Position = UDim2.new(0.6, 0, 0.5, 0)}
							):Play()
							TweenService:Create(
								O,
								TweenInfo.new(0.9,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
								{BackgroundColor3 = Color3.fromRGB(61, 65, 91)}
							):Play()
						else
							default = false
							TweenService:Create(
								TitleText,
								TweenInfo.new(0.9,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
								{TextColor3 = TextColorUI or Color3.fromRGB(142, 144, 150)}
							):Play()
							TweenService:Create(
								TitleDis,
								TweenInfo.new(0.9,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
								{TextColor3 = TextColorUI or Color3.fromRGB(142, 144, 150)}
							):Play()
							TweenService:Create(
								O,
								TweenInfo.new(0.4,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
								{Position = UDim2.new(0.1, 0, 0.5, 0)}
							):Play()
							TweenService:Create(
								O,
								TweenInfo.new(0.9,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
								{BackgroundColor3 = Background2}
							):Play()
						end 
						callback(default)
					end
				end
				function ToggleTable:UnLocker()
					Lock = false
					LockToggle.Visible = false
				end
				function ToggleTable:Locker()
					Lock = true
					LockToggle.Visible = true
				end
				function ToggleTable:UpdateNameText(Value)
					TitleText.Text = Value
				end
				function ToggleTable:UpdateDis(Value)
					TitleDis.Text = Value
				end
				return ToggleTable
			end
			library.FuncMain.CreateButton = function(options)
				local Name = options.Name or "Button";wait()
				local callback = options.Callback or function() end

				local Button = Instance.new("Frame")
				local UICorner_8 = Instance.new("UICorner")
				local TextLabel_3 = Instance.new("TextLabel")
				local TextButton_2 = Instance.new("TextButton")
				local ImageLabel_2 = Instance.new("ImageLabel")

				Button.Name = "Button"
				Button.Parent = Sections
				Button.BackgroundColor3 = MainBackground or Color3.fromRGB(48, 51, 71)
				Button.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Button.BorderSizePixel = 0
				Button.Position = UDim2.new(0, 0, 0.270586133, 0)
				Button.Size = UDim2.new(0.949999988, 0, 0, 25)

				UICorner_8.CornerRadius = UDim.new(0, 2)
				UICorner_8.Parent = Button

				TextLabel_3.Parent = Button
				TextLabel_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TextLabel_3.BackgroundTransparency = 1.000
				TextLabel_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
				TextLabel_3.BorderSizePixel = 0
				TextLabel_3.Position = UDim2.new(0.0439998619, 0, 0, 0)
				TextLabel_3.Size = UDim2.new(0.956000149, 0, 1, 0)
				TextLabel_3.FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
				TextLabel_3.Text = Name
				TextLabel_3.TextColor3 = TextColorUI or Color3.fromRGB(142, 144, 150)
				TextLabel_3.TextSize = 12.000
				TextLabel_3.TextXAlignment = Enum.TextXAlignment.Left

				TextButton_2.Parent = Button
				TextButton_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TextButton_2.BackgroundTransparency = 1.000
				TextButton_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
				TextButton_2.BorderSizePixel = 0
				TextButton_2.Size = UDim2.new(1, 0, 1, 0)
				TextButton_2.Font = Enum.Font.SourceSans
				TextButton_2.Text = ""
				TextButton_2.TextColor3 = Color3.fromRGB(0, 0, 0)
				TextButton_2.TextSize = 14.000

				ImageLabel_2.Parent = Button
				ImageLabel_2.AnchorPoint = Vector2.new(0, 0.5)
				ImageLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ImageLabel_2.BackgroundTransparency = 1.000
				ImageLabel_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ImageLabel_2.BorderSizePixel = 0
				ImageLabel_2.Position = UDim2.new(0.868354499, 0, 0.5, 0)
				ImageLabel_2.Size = UDim2.new(0, 15, 0, 15)
				ImageLabel_2.Image = "http://www.roblox.com/asset/?id=6031094687"
				ImageLabel_2.ImageColor3 = TextColorUI or Color3.fromRGB(142, 144, 150)

				TextButton_2.MouseButton1Click:Connect(function()
					TextLabel_3.TextSize = 0
					TweenService:Create(
						TextLabel_3,
						TweenInfo.new(0.4,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
						{TextSize = 12.00}
					):Play()
					callback()
				end)
			end
			library.FuncMain.CreateDropdown = function(options)
				local text = options.Name;wait()
				local default = options.Value or ""
				local list = options.List
				local callback = options.Callback

				local Dropdown = Instance.new("Frame")
				local UICorner_9 = Instance.new("UICorner")
				local Main1 = Instance.new("Frame")
				local TextLabel_4 = Instance.new("TextLabel")
				local ImageButton = Instance.new("ImageButton")
				local ImageLabel_3 = Instance.new("ImageLabel")
				local Main2 = Instance.new("Frame")
				local ScrollingFrame_2 = Instance.new("ScrollingFrame")
				local UIListLayout_4 = Instance.new("UIListLayout")
				local UIPadding_4 = Instance.new("UIPadding")


				Dropdown.Name = "Dropdown"
				Dropdown.Parent = Sections
				Dropdown.BackgroundColor3 = Background2
				Dropdown.BackgroundTransparency = 1.000
				Dropdown.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Dropdown.BorderSizePixel = 0
				Dropdown.ClipsDescendants = true
				Dropdown.Position = UDim2.new(0, 0, 0.236475766, 0)
				Dropdown.Size = UDim2.new(0.949999988, 0, 0, 30)

				UICorner_9.CornerRadius = UDim.new(0, 2)
				UICorner_9.Parent = Dropdown

				Main1.Name = "Main1"
				Main1.Parent = Dropdown
				Main1.BackgroundColor3 = Background2
				Main1.BackgroundTransparency = 0.600
				Main1.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Main1.BorderSizePixel = 0
				Main1.Size = UDim2.new(1, 0, 0, 27)

				TextLabel_4.Parent = Main1
				TextLabel_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TextLabel_4.BackgroundTransparency = 1.000
				TextLabel_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
				TextLabel_4.BorderSizePixel = 0
				TextLabel_4.Size = UDim2.new(1, 0, 1, 0)
				TextLabel_4.FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
				TextLabel_4.Text = text.." (".. default ..")"
				TextLabel_4.TextColor3 = TextColorUI or Color3.fromRGB(142, 144, 150)
				TextLabel_4.TextSize = 11.000

				ImageButton.Parent = Main1
				ImageButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ImageButton.BackgroundTransparency = 1.000
				ImageButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ImageButton.BorderSizePixel = 0
				ImageButton.Size = UDim2.new(1, 0, 1, 0)
				ImageButton.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
				ImageButton.ImageTransparency = 1.000

				ImageLabel_3.Parent = Main1
				ImageLabel_3.AnchorPoint = Vector2.new(0, 0.5)
				ImageLabel_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ImageLabel_3.BackgroundTransparency = 1.000
				ImageLabel_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ImageLabel_3.BorderSizePixel = 0
				ImageLabel_3.Position = UDim2.new(0.868354499, 0, 0.5, 0)
				ImageLabel_3.Size = UDim2.new(0, 15, 0, 15)
				ImageLabel_3.Image = "http://www.roblox.com/asset/?id=6031094687"
				ImageLabel_3.ImageColor3 = TextColorUI or Color3.fromRGB(142, 144, 150)

				Main2.Name = "Main2"
				Main2.Parent = Dropdown
				Main2.BackgroundColor3 = Background2
				Main2.BackgroundTransparency = 0.600
				Main2.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Main2.BorderSizePixel = 0
				Main2.Position = UDim2.new(0, 0, 0, 30)
				Main2.Size = UDim2.new(1, 0, 0, 92)

				ScrollingFrame_2.Parent = Main2
				ScrollingFrame_2.Active = true
				ScrollingFrame_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ScrollingFrame_2.BackgroundTransparency = 1.000
				ScrollingFrame_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ScrollingFrame_2.BorderSizePixel = 0
				ScrollingFrame_2.Size = UDim2.new(1, 0, 1, 0)
				ScrollingFrame_2.ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0)
				ScrollingFrame_2.ScrollBarThickness = 1

				UIListLayout_4.Parent = ScrollingFrame_2
				UIListLayout_4.SortOrder = Enum.SortOrder.LayoutOrder

				UIPadding_4.Parent = ScrollingFrame_2
				UIPadding_4.PaddingLeft = UDim.new(0, 5)
				UIPadding_4.PaddingTop = UDim.new(0, 5)

				local DropF = {}
				local DropG = true
				function DropF:Clear()
					for i, v in next, ScrollingFrame_2:GetChildren() do
						if v:IsA("Frame") then 
							v:Destroy()
						end
					end
				end

				TextLabel_4.Text = text.." (".. 'nil' ..")"
				function DropF:Add(Text)
					local Button_2 = Instance.new("Frame")
					local UICorner_10 = Instance.new("UICorner")
					local TextButton_3 = Instance.new("TextButton")
					local TextLabel_5 = Instance.new("TextLabel")

					Button_2.Name = "Button"
					Button_2.Parent = ScrollingFrame_2
					Button_2.BackgroundColor3 = MainBackground or Color3.fromRGB(48, 51, 71)
					Button_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Button_2.BorderSizePixel = 0
					Button_2.Position = UDim2.new(0, 0, 0.270586133, 0)
					Button_2.Size = UDim2.new(0.949999988, 0, 0, 25)

					UICorner_10.CornerRadius = UDim.new(0, 2)
					UICorner_10.Parent = Button_2

					TextButton_3.Parent = Button_2
					TextButton_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					TextButton_3.BackgroundTransparency = 1.000
					TextButton_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
					TextButton_3.BorderSizePixel = 0
					TextButton_3.Size = UDim2.new(1, 0, 1, 0)
					TextButton_3.Font = Enum.Font.SourceSans
					TextButton_3.Text = ""
					TextButton_3.TextColor3 = Color3.fromRGB(0, 0, 0)
					TextButton_3.TextSize = 14.000

					TextLabel_5.Parent = Button_2
					TextLabel_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					TextLabel_5.BackgroundTransparency = 1.000
					TextLabel_5.BorderColor3 = Color3.fromRGB(0, 0, 0)
					TextLabel_5.BorderSizePixel = 0
					TextLabel_5.Size = UDim2.new(1, 0, 1, 0)
					TextLabel_5.FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
					TextLabel_5.Text = Text
					TextLabel_5.TextColor3 = TextColorUI or Color3.fromRGB(142, 144, 150)
					TextLabel_5.TextSize = 12.000

					if TextLabel_5.Text == default then
						for i, v in next, ScrollingFrame_2:GetChildren() do
							if v:IsA("Frame") then 
								TweenService:Create(
									v,
									TweenInfo.new(0.4,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
									{BackgroundColor3 = MainBackground or Color3.fromRGB(48, 51, 71)}
								):Play()
								TweenService:Create(
									v.TextLabel,
									TweenInfo.new(0.4,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
									{TextColor3 = Color3.fromRGB(213, 213, 213)}
								):Play()
							end
						end
						TweenService:Create(
							Button_2,
							TweenInfo.new(0.4,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
							{BackgroundColor3 = DropDownSelect or Color3.fromRGB(61, 65, 90)}
						):Play()
						TweenService:Create(
							TextLabel_5,
							TweenInfo.new(0.4,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
							{TextColor3 = Color3.fromRGB(255,255,255)}
						):Play()
						TextLabel_4.Text = text.." (".. Text ..")"
						callback(default)
					end

					TextButton_3.MouseButton1Click:Connect(function()
						for i, v in next, ScrollingFrame_2:GetChildren() do
							if v:IsA("Frame") then 
								TweenService:Create(
									v,
									TweenInfo.new(0.4,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
									{BackgroundColor3 = MainBackground or Color3.fromRGB(48, 51, 71)}
								):Play()
								TweenService:Create(
									v.TextLabel,
									TweenInfo.new(0.4,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
									{TextColor3 = Color3.fromRGB(213, 213, 213)}
								):Play()
							end
						end
						TweenService:Create(
							Button_2,
							TweenInfo.new(0.4,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
							{BackgroundColor3 = DropDownSelect or Color3.fromRGB(61, 65, 90)}
						):Play()
						TweenService:Create(
							TextLabel_5,
							TweenInfo.new(0.4,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
							{TextColor3 = Color3.fromRGB(255,255,255)}
						):Play()
						TextLabel_4.Text = text.." (".. Text ..")"
						callback(Text)
					end)
				end
				UIListLayout_4:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
					ScrollingFrame_2.CanvasSize = UDim2.new(0, 0, 0, UIListLayout_4.AbsoluteContentSize.Y + 35)
				end)

				ImageButton.MouseButton1Click:Connect(function()
					if not DropG then
						DropG = true
						TweenService:Create(
							Dropdown,
							TweenInfo.new(0.4,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
							{Size = UDim2.new(0.949999988, 0, 0, 30)}
						):Play()
					else
						DropG = false
						TweenService:Create(
							Dropdown,
							TweenInfo.new(0.4,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
							{Size = UDim2.new(0.949999988, 0, 0, 130)}
						):Play()
					end
				end)

				for _, v in next,list do
					DropF:Add(v)
				end

				return DropF
			end
			library.FuncMain.CreateMultiDropdown = function(options)
				local text = options.Name;wait()
				local default = options.Value or {""}
				local list = options.List
				local callback = options.Callback

				local Dropdown = Instance.new("Frame")
				local UICorner_9 = Instance.new("UICorner")
				local Main1 = Instance.new("Frame")
				local TextLabel_4 = Instance.new("TextLabel")
				local ImageButton = Instance.new("ImageButton")
				local ImageLabel_3 = Instance.new("ImageLabel")
				local Main2 = Instance.new("Frame")
				local ScrollingFrame_2 = Instance.new("ScrollingFrame")
				local UIListLayout_4 = Instance.new("UIListLayout")
				local UIPadding_4 = Instance.new("UIPadding")
				local DropFF = default

				Dropdown.Name = "Dropdown"
				Dropdown.Parent = Sections
				Dropdown.BackgroundColor3 = Background2
				Dropdown.BackgroundTransparency = 1.000
				Dropdown.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Dropdown.BorderSizePixel = 0
				Dropdown.ClipsDescendants = true
				Dropdown.Position = UDim2.new(0, 0, 0.236475766, 0)
				Dropdown.Size = UDim2.new(0.949999988, 0, 0, 30)

				UICorner_9.CornerRadius = UDim.new(0, 2)
				UICorner_9.Parent = Dropdown

				Main1.Name = "Main1"
				Main1.Parent = Dropdown
				Main1.BackgroundColor3 = Background2
				Main1.BackgroundTransparency = 0.600
				Main1.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Main1.BorderSizePixel = 0
				Main1.Size = UDim2.new(1, 0, 0, 27)

				TextLabel_4.Parent = Main1
				TextLabel_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TextLabel_4.BackgroundTransparency = 1.000
				TextLabel_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
				TextLabel_4.BorderSizePixel = 0
				TextLabel_4.Size = UDim2.new(1, 0, 1, 0)
				TextLabel_4.FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
				TextLabel_4.TextColor3 = TextColorUI or Color3.fromRGB(142, 144, 150)
				TextLabel_4.TextSize = 11.000

				local function UpdateTextLabel()
					local maxDisplayCount = 3
					local textLabel_7_text = text .. " ("
					if #DropFF > maxDisplayCount then
						textLabel_7_text = textLabel_7_text .. table.concat(DropFF, ", ", 1, maxDisplayCount) .. ", ..."
					else
						textLabel_7_text = textLabel_7_text .. table.concat(DropFF, ", ")
					end
					textLabel_7_text = textLabel_7_text .. ")"
					TextLabel_4.Text = textLabel_7_text
				end;UpdateTextLabel()

				ImageButton.Parent = Main1
				ImageButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ImageButton.BackgroundTransparency = 1.000
				ImageButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ImageButton.BorderSizePixel = 0
				ImageButton.Size = UDim2.new(1, 0, 1, 0)
				ImageButton.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
				ImageButton.ImageTransparency = 1.000

				ImageLabel_3.Parent = Main1
				ImageLabel_3.AnchorPoint = Vector2.new(0, 0.5)
				ImageLabel_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ImageLabel_3.BackgroundTransparency = 1.000
				ImageLabel_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ImageLabel_3.BorderSizePixel = 0
				ImageLabel_3.Position = UDim2.new(0.868354499, 0, 0.5, 0)
				ImageLabel_3.Size = UDim2.new(0, 15, 0, 15)
				ImageLabel_3.Image = "http://www.roblox.com/asset/?id=6031094687"
				ImageLabel_3.ImageColor3 = TextColorUI or Color3.fromRGB(142, 144, 150)

				Main2.Name = "Main2"
				Main2.Parent = Dropdown
				Main2.BackgroundColor3 = Background2
				Main2.BackgroundTransparency = 0.600
				Main2.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Main2.BorderSizePixel = 0
				Main2.Position = UDim2.new(0, 0, 0, 30)
				Main2.Size = UDim2.new(1, 0, 0, 92)

				ScrollingFrame_2.Parent = Main2
				ScrollingFrame_2.Active = true
				ScrollingFrame_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ScrollingFrame_2.BackgroundTransparency = 1.000
				ScrollingFrame_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ScrollingFrame_2.BorderSizePixel = 0
				ScrollingFrame_2.Size = UDim2.new(1, 0, 1, 0)
				ScrollingFrame_2.ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0)
				ScrollingFrame_2.ScrollBarThickness = 1

				UIListLayout_4.Parent = ScrollingFrame_2
				UIListLayout_4.SortOrder = Enum.SortOrder.LayoutOrder

				UIPadding_4.Parent = ScrollingFrame_2
				UIPadding_4.PaddingLeft = UDim.new(0, 5)
				UIPadding_4.PaddingTop = UDim.new(0, 5)

				local DropF = {}
				local DropG = true
				function DropF:Clear()
					for i, v in next, ScrollingFrame_2:GetChildren() do
						if v:IsA("Frame") then 
							v:Destroy()
						end
					end
				end

				TextLabel_4.Text = text.." (".. 'nil' ..")"
				function DropF:Add(Text)
					local Button_2 = Instance.new("Frame")
					local UICorner_10 = Instance.new("UICorner")
					local TextButton_3 = Instance.new("TextButton")
					local TextLabel_5 = Instance.new("TextLabel")

					Button_2.Name = "Button"
					Button_2.Parent = ScrollingFrame_2
					Button_2.BackgroundColor3 = MainBackground or Color3.fromRGB(48, 51, 71)
					Button_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Button_2.BorderSizePixel = 0
					Button_2.Position = UDim2.new(0, 0, 0.270586133, 0)
					Button_2.Size = UDim2.new(0.949999988, 0, 0, 25)

					UICorner_10.CornerRadius = UDim.new(0, 2)
					UICorner_10.Parent = Button_2

					TextButton_3.Parent = Button_2
					TextButton_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					TextButton_3.BackgroundTransparency = 1.000
					TextButton_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
					TextButton_3.BorderSizePixel = 0
					TextButton_3.Size = UDim2.new(1, 0, 1, 0)
					TextButton_3.Font = Enum.Font.SourceSans
					TextButton_3.Text = ""
					TextButton_3.TextColor3 = Color3.fromRGB(0, 0, 0)
					TextButton_3.TextSize = 14.000

					TextLabel_5.Parent = Button_2
					TextLabel_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					TextLabel_5.BackgroundTransparency = 1.000
					TextLabel_5.BorderColor3 = Color3.fromRGB(0, 0, 0)
					TextLabel_5.BorderSizePixel = 0
					TextLabel_5.Size = UDim2.new(1, 0, 1, 0)
					TextLabel_5.FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
					TextLabel_5.Text = Text
					TextLabel_5.TextColor3 = TextColorUI or Color3.fromRGB(142, 144, 150)
					TextLabel_5.TextSize = 12.000

					if table.find(DropFF, TextLabel_5.Text) then
						for i, v in next, ScrollingFrame_2:GetChildren() do
							if v:IsA("Frame") then 
								TweenService:Create(
									v,
									TweenInfo.new(0.4,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
									{BackgroundColor3 = MainBackground or Color3.fromRGB(48, 51, 71)}
								):Play()
								TweenService:Create(
									v.TextLabel,
									TweenInfo.new(0.4,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
									{TextColor3 = Color3.fromRGB(213, 213, 213)}
								):Play()
							end
						end
						TweenService:Create(
							Button_2,
							TweenInfo.new(0.4,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
							{BackgroundColor3 = DropDownSelect or Color3.fromRGB(61, 65, 90)}
						):Play()
						TweenService:Create(
							TextLabel_5,
							TweenInfo.new(0.4,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
							{TextColor3 = Color3.fromRGB(255,255,255)}
						):Play()
						TextLabel_4.Text = text.." (".. Text ..")"
						callback(default)
					end

					TextButton_3.MouseButton1Click:Connect(function()
						if not table.find(DropFF, Text) then
							table.insert(DropFF, Text)
							callback(DropFF, Text)
							UpdateTextLabel()

							TweenService:Create(
								Button_2,
								TweenInfo.new(0.4,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
								{BackgroundColor3 = DropDownSelect or Color3.fromRGB(61, 65, 90)}
							):Play()
							TweenService:Create(
								TextLabel_5,
								TweenInfo.new(0.4,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
								{TextColor3 = Color3.fromRGB(255,255,255)}
							):Play()
						else
							TweenService:Create(
								Button_2,
								TweenInfo.new(0.4,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
								{BackgroundColor3 = MainBackground or Color3.fromRGB(48, 51, 71)}
							):Play()
							TweenService:Create(
								TextLabel_5,
								TweenInfo.new(0.4,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
								{TextColor3 = Color3.fromRGB(213, 213, 213)}
							):Play()
							for i2, v2 in ipairs(DropFF) do
								if v2 == Text then
									table.remove(DropFF, i2)
									callback(DropFF, Text)
									UpdateTextLabel()
									break
								end
							end
						end
					end)
				end
				UIListLayout_4:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
					ScrollingFrame_2.CanvasSize = UDim2.new(0, 0, 0, UIListLayout_4.AbsoluteContentSize.Y + 35)
				end)

				ImageButton.MouseButton1Click:Connect(function()
					if not DropG then
						DropG = true
						TweenService:Create(
							Dropdown,
							TweenInfo.new(0.4,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
							{Size = UDim2.new(0.949999988, 0, 0, 30)}
						):Play()
					else
						DropG = false
						TweenService:Create(
							Dropdown,
							TweenInfo.new(0.4,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
							{Size = UDim2.new(0.949999988, 0, 0, 130)}
						):Play()
					end
				end)

				for _, v in next,list do
					DropF:Add(v)
				end

				callback(DropFF)
				return DropF
			end
			function library.FuncMain.CreateColorpicker(options)
				local Colorpicker = Instance.new("Frame")
				local UICorner_11 = Instance.new("UICorner")
				local ColorpickerTitel = Instance.new("TextLabel")
				local NowColor = Instance.new("Frame")
				local UICorner_12 = Instance.new("UICorner")
				local ColorSelection = Instance.new("Frame")
				local Color = Instance.new("ImageLabel")
				local ColorSelection_2 = Instance.new("ImageLabel")
				local Hue = Instance.new("Frame")
				local UIGradient = Instance.new("UIGradient")
				local UICorner_13 = Instance.new("UICorner")
				local HueSelection = Instance.new("ImageLabel")
				local UICorner_14 = Instance.new("UICorner")
				local ColorpickerButton = Instance.new("TextButton")

				Colorpicker.Name = "Colorpicker"
				Colorpicker.Parent = Sections
				Colorpicker.BackgroundColor3 = Background2
				Colorpicker.BackgroundTransparency = 0.600
				Colorpicker.BorderColor3 = Color3.fromRGB(153, 153, 153)
				Colorpicker.BorderSizePixel = 0
				Colorpicker.Position = UDim2.new(0, 0, 0.553602278, 0)
				Colorpicker.Size = UDim2.new(0.950000107, 0, 0.00862091407, 27)
				Colorpicker.ZIndex = 2

				UICorner_11.CornerRadius = UDim.new(0, 2)
				UICorner_11.Parent = Colorpicker

				ColorpickerTitel.Name = "ColorpickerTitel"
				ColorpickerTitel.Parent = Colorpicker
				ColorpickerTitel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ColorpickerTitel.BackgroundTransparency = 1.000
				ColorpickerTitel.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ColorpickerTitel.BorderSizePixel = 0
				ColorpickerTitel.Position = UDim2.new(0.0294061638, 0, 0, 0)
				ColorpickerTitel.Size = UDim2.new(0.808290184, 0, 1, 0)
				ColorpickerTitel.FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
				ColorpickerTitel.Text = options.Title
				ColorpickerTitel.TextColor3 = TextColorUI
				ColorpickerTitel.TextSize = 12.000
				ColorpickerTitel.TextXAlignment = Enum.TextXAlignment.Left

				NowColor.Name = "NowColor"
				NowColor.Parent = Colorpicker
				NowColor.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
				NowColor.BorderColor3 = Color3.fromRGB(0, 0, 0)
				NowColor.BorderSizePixel = 0
				NowColor.Position = UDim2.new(0.779999971, 0, 0.159999996, 0)
				NowColor.Size = UDim2.new(0, 31, 0, 16)

				UICorner_12.CornerRadius = UDim.new(0, 2)
				UICorner_12.Parent = NowColor

				ColorSelection.Name = "ColorSelection"
				ColorSelection.Parent = Colorpicker
				ColorSelection.AnchorPoint = Vector2.new(0.5, 0.5)
				ColorSelection.BackgroundColor3 = MainBackground or Color3.fromRGB(48, 51, 71)
				ColorSelection.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ColorSelection.BorderSizePixel = 0
				ColorSelection.Position = UDim2.new(0.50000006, 0, 1.67629671, 0)
				ColorSelection.Size = UDim2.new(0, 137, 0, 106)
				ColorSelection.Visible = false
				ColorSelection.ZIndex = 2

				Color.Name = "Color"
				Color.Parent = ColorSelection
				Color.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
				Color.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Color.BorderSizePixel = 0
				Color.Position = UDim2.new(0.0656934306, 0, 0.148202568, 0)
				Color.Size = UDim2.new(0, 77, 0, 79)
				Color.ZIndex = 3
				Color.Image = "rbxassetid://4155801252"

				ColorSelection_2.Name = "ColorSelection"
				ColorSelection_2.Parent = Color
				ColorSelection_2.AnchorPoint = Vector2.new(0.5, 0.5)
				ColorSelection_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ColorSelection_2.BackgroundTransparency = 1.000
				ColorSelection_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ColorSelection_2.BorderSizePixel = 0
				ColorSelection_2.Size = UDim2.new(0, 10, 0, 10)
				ColorSelection_2.ZIndex = 3
				ColorSelection_2.Image = "http://www.roblox.com/asset/?id=4805639000"
				ColorSelection_2.ScaleType = Enum.ScaleType.Fit

				Hue.Name = "Hue"
				Hue.Parent = ColorSelection
				Hue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Hue.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Hue.BorderSizePixel = 0
				Hue.Position = UDim2.new(0.686131358, 0, 0.142243013, 0)
				Hue.Size = UDim2.new(0, 15, 0, 80)
				Hue.ZIndex = 2

				UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(0.19, Color3.fromRGB(255, 247, 0)), ColorSequenceKeypoint.new(0.38, Color3.fromRGB(34, 255, 0)), ColorSequenceKeypoint.new(0.56, Color3.fromRGB(0, 255, 247)), ColorSequenceKeypoint.new(0.74, Color3.fromRGB(0, 17, 255)), ColorSequenceKeypoint.new(0.89, Color3.fromRGB(238, 0, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 4))}
				UIGradient.Rotation = 270
				UIGradient.Parent = Hue

				UICorner_13.CornerRadius = UDim.new(0, 2)
				UICorner_13.Parent = Hue

				HueSelection.Name = "HueSelection"
				HueSelection.Parent = Hue
				HueSelection.AnchorPoint = Vector2.new(0.5, 0)
				HueSelection.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				HueSelection.BackgroundTransparency = 1.000
				HueSelection.BorderColor3 = Color3.fromRGB(0, 0, 0)
				HueSelection.BorderSizePixel = 0
				HueSelection.Position = UDim2.new(0.5, 0, 0.762499988, 0)
				HueSelection.Size = UDim2.new(0, 10, 0, 10)
				HueSelection.ZIndex = 3
				HueSelection.Image = "http://www.roblox.com/asset/?id=4805639000"

				UICorner_14.CornerRadius = UDim.new(0, 5)
				UICorner_14.Parent = ColorSelection

				ColorpickerButton.Name = "ColorpickerButton"
				ColorpickerButton.Parent = Colorpicker
				ColorpickerButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ColorpickerButton.BackgroundTransparency = 1.000
				ColorpickerButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ColorpickerButton.BorderSizePixel = 0
				ColorpickerButton.Size = UDim2.new(1, 0, 1, 0)
				ColorpickerButton.Font = Enum.Font.SourceSans
				ColorpickerButton.Text = ""
				ColorpickerButton.TextColor3 = Color3.fromRGB(0, 0, 0)
				ColorpickerButton.TextSize = 14.000

				local HHHHH = false
				local OldToggleColor = Color3.fromRGB(0, 0, 0)
				local OldColor = Color3.fromRGB(0, 0, 0)
				local OldColorSelectionPosition = nil
				local OldHueSelectionPosition = nil
				local ColorH, ColorS, ColorV = 1, 1, 1
				local RainbowColorPicker = false
				local ColorPickerInput = nil
				local ColorInput = nil
				local HueInput = nil
				local RunService = game:GetService("RunService")

				local function UpdateColorPicker(nope)
					NowColor.BackgroundColor3 = Color3.fromHSV(ColorH, ColorS, ColorV)
					Color.BackgroundColor3 = Color3.fromHSV(ColorH, 1, 1)
					pcall(options.Callback, NowColor.BackgroundColor3)
				end

				ColorH = 1 - (math.clamp(HueSelection.AbsolutePosition.Y - Hue.AbsolutePosition.Y, 0, Hue.AbsoluteSize.Y) / Hue.AbsoluteSize.Y)
				ColorS = (math.clamp(ColorSelection_2.AbsolutePosition.X - Color.AbsolutePosition.X, 0, Color.AbsoluteSize.X) / Color.AbsoluteSize.X)
				ColorV = 1 - (math.clamp(ColorSelection_2.AbsolutePosition.Y - Color.AbsolutePosition.Y, 0, Color.AbsoluteSize.Y) / Color.AbsoluteSize.Y)

				NowColor.BackgroundColor3 = options.Preset
				Color.BackgroundColor3 = options.Preset
				pcall(options.Callback, NowColor.BackgroundColor3)

				ColorpickerButton.MouseButton1Click:Connect(function()
					ColorSelection.Visible = not HHHHH
					HHHHH = not HHHHH
				end)

				Color.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						if ColorInput then
							ColorInput:Disconnect()
						end

						ColorInput = RunService.RenderStepped:Connect(function()
							local ColorX = (math.clamp(Mouse.X - Color.AbsolutePosition.X, 0, Color.AbsoluteSize.X) / Color.AbsoluteSize.X)
							local ColorY = (math.clamp(Mouse.Y - Color.AbsolutePosition.Y, 0, Color.AbsoluteSize.Y) / Color.AbsoluteSize.Y)
							ColorSelection_2.Position = UDim2.new(ColorX, 0, ColorY, 0)
							ColorS = ColorX
							ColorV = 1 - ColorY

							UpdateColorPicker(true)
						end)
					end
				end)

				Color.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						if ColorInput then
							ColorInput:Disconnect()
						end
					end
				end)

				Hue.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						if HueInput then
							HueInput:Disconnect()
						end

						HueInput = RunService.RenderStepped:Connect(function()
							local HueY = (math.clamp(Mouse.Y - Hue.AbsolutePosition.Y, 0, Hue.AbsoluteSize.Y) / Hue.AbsoluteSize.Y)
							HueSelection.Position = UDim2.new(0.48, 0, HueY, 0)
							ColorH = 1 - HueY

							UpdateColorPicker(true)
						end)
					end
				end)

				Hue.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						if HueInput then
							HueInput:Disconnect()
						end
					end
				end)
			end

			function library.FuncMain.CreateInput(options)
				local Name = options.Name;wait()
				local default = options.Value or ''
				local Placeholder = options.Placeholder
				local callback = options.Callback

				local Input = Instance.new("Frame")
				local UICorner_15 = Instance.new("UICorner")
				local Main_2 = Instance.new("Frame")
				local TextBox = Instance.new("TextBox")
				local UICorner_16 = Instance.new("UICorner")
				local InputTitle = Instance.new("TextLabel")

				Input.Name = "Input"
				Input.Parent = Sections
				Input.BackgroundColor3 = Background2
				Input.BackgroundTransparency = 0.600
				Input.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Input.BorderSizePixel = 0
				Input.ClipsDescendants = true
				Input.Position = UDim2.new(0, 0, 0.638990283, 0)
				Input.Size = UDim2.new(0.950000107, 0, 0.0111752702, 35)

				UICorner_15.CornerRadius = UDim.new(0, 2)
				UICorner_15.Parent = Input

				Main_2.Name = "Main"
				Main_2.Parent = Input
				Main_2.BackgroundColor3 = Background2
				Main_2.BackgroundTransparency = 0.600
				Main_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Main_2.BorderSizePixel = 0
				Main_2.ClipsDescendants = true
				Main_2.Size = UDim2.new(1, 0, 1, 0)

				TextBox.Parent = Main_2
				TextBox.AnchorPoint = Vector2.new(0.5, 0.5)
				TextBox.BackgroundColor3 = MainBackground or Color3.fromRGB(48, 51, 71)
				TextBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
				TextBox.BorderSizePixel = 0
				TextBox.Position = UDim2.new(0.5, 0, 0.699999988, 0)
				TextBox.Size = UDim2.new(0.800000012, 0, 0.459695935, 0)
				TextBox.Font = Enum.Font.SourceSansBold
				TextBox.PlaceholderColor3 = Color3.fromRGB(178, 178, 178)
				TextBox.PlaceholderText = Placeholder
				TextBox.Text = default
				TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
				TextBox.TextSize = 12.000

				UICorner_16.CornerRadius = UDim.new(0, 2)
				UICorner_16.Parent = Main_2

				InputTitle.Name = "InputTitle"
				InputTitle.Parent = Main_2
				InputTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				InputTitle.BackgroundTransparency = 1.000
				InputTitle.BorderColor3 = Color3.fromRGB(0, 0, 0)
				InputTitle.BorderSizePixel = 0
				InputTitle.Position = UDim2.new(0.0292273257, 0, 0.107466936, 0)
				InputTitle.Size = UDim2.new(0.949801564, 0, 0.340152115, 0)
				InputTitle.FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
				InputTitle.Text = Name
				InputTitle.TextColor3 = TextColorUI
				InputTitle.TextSize = 10.000
				InputTitle.TextXAlignment = Enum.TextXAlignment.Left

				TextBox.FocusLost:Connect(function(ep)
					if #TextBox.Text > 0 then
						callback(TextBox.Text)
						TextBox.Text = TextBox.Text
					end
				end)
				callback(default)
			end
			function library.FuncMain.CreateSlider(options)
				local text = options.Name;wait()
				local callback = options.Format or function() end

				local Slider = Instance.new("Frame")
				local UICorner_17 = Instance.new("UICorner")
				local ButtonText = Instance.new("TextLabel")
				local TextBox_2 = Instance.new("TextBox")
				local UICorner_18 = Instance.new("UICorner")
				local ValueFrame2 = Instance.new("Frame")
				local UICorner_19 = Instance.new("UICorner")
				local ValueFrame = Instance.new("Frame")
				local UICorner_20 = Instance.new("UICorner")
				local Frame = Instance.new("Frame")
				local UICorner_21 = Instance.new("UICorner")

				Slider.Name = "Slider"
				Slider.Parent = Sections
				Slider.BackgroundColor3 = Background2
				Slider.BackgroundTransparency = 0.600
				Slider.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Slider.BorderSizePixel = 0
				Slider.Position = UDim2.new(0, 0, 0.745725453, 0)
				Slider.Size = UDim2.new(0.950000107, 0, 0.00989808794, 31)

				UICorner_17.CornerRadius = UDim.new(0, 2)
				UICorner_17.Parent = Slider

				ButtonText.Name = "ButtonText"
				ButtonText.Parent = Slider
				ButtonText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ButtonText.BackgroundTransparency = 1.000
				ButtonText.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ButtonText.BorderSizePixel = 0
				ButtonText.Position = UDim2.new(0.0462909453, 0, 0.191856131, 0)
				ButtonText.Size = UDim2.new(0, 148, 0, 9)
				ButtonText.FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
				ButtonText.Text = text
				ButtonText.TextColor3 = TextColorUI
				ButtonText.TextSize = 12.000
				ButtonText.TextXAlignment = Enum.TextXAlignment.Left

				TextBox_2.Parent = Slider
				TextBox_2.BackgroundColor3 = MainBackground or Color3.fromRGB(48, 51, 71)
				TextBox_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
				TextBox_2.BorderSizePixel = 0
				TextBox_2.Position = UDim2.new(0.747350395, 0, 0.175377965, 0)
				TextBox_2.Size = UDim2.new(0, 36, 0, 10)
				TextBox_2.Font = Enum.Font.Ubuntu
				TextBox_2.Text = "70"
				TextBox_2.TextColor3 = TextColorUI
				TextBox_2.TextSize = 9.000

				UICorner_18.CornerRadius = UDim.new(0, 2)
				UICorner_18.Parent = TextBox_2

				ValueFrame2.Name = "ValueFrame2"
				ValueFrame2.Parent = Slider
				ValueFrame2.AnchorPoint = Vector2.new(0.5, 0.5)
				ValueFrame2.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
				ValueFrame2.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ValueFrame2.BorderSizePixel = 0
				ValueFrame2.Position = UDim2.new(0.5, 0, 0.800000012, 0)
				ValueFrame2.Size = UDim2.new(0.949999988, 0, 0, 2)

				UICorner_19.CornerRadius = UDim.new(0, 5)
				UICorner_19.Parent = ValueFrame2

				ValueFrame.Name = "ValueFrame"
				ValueFrame.Parent = ValueFrame2
				ValueFrame.BackgroundColor3 = MainBackground or Color3.fromRGB(48, 51, 71)
				ValueFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ValueFrame.BorderSizePixel = 0
				ValueFrame.Size = UDim2.new(0.827310622, 0, 1, 0)

				UICorner_20.CornerRadius = UDim.new(0, 5)
				UICorner_20.Parent = ValueFrame

				Frame.Parent = ValueFrame
				Frame.AnchorPoint = Vector2.new(0.5, 0.5)
				Frame.BackgroundColor3 = MainBackground or Color3.fromRGB(48, 51, 71)
				Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Frame.BorderSizePixel = 0
				Frame.Position = UDim2.new(1, 0, 0, 0)
				Frame.Size = UDim2.new(0, 10, 0, 10)

				UICorner_21.CornerRadius = UDim.new(1, 8)
				UICorner_21.Parent = Frame

				ValueFrame:TweenSize(UDim2.new((options.Value or 0) / options.Max, 0, 1, 0), "Out", "Back", 0.2, true)
				callback(options.Value)
				TextBox_2.Text = options.Value
				TextBox_2.FocusLost:Connect(function()
					if TextBox_2.Text == "" then
						TextBox_2.Text = options.Value
					end
					if  tonumber(TextBox_2.Text) > options.Max then
						TextBox_2.Text  = options.Max
					end;if  tonumber(TextBox_2.Text) <= options.Min then
						TextBox_2.Text  = options.Min
					end

					ValueFrame:TweenSize(UDim2.new((TextBox_2.Text or 0) / options.Max, 0, 1, 0), "Out", "Back", 0.2, true)
					TextBox_2.Text = tostring(TextBox_2.Text)
					pcall(callback, tonumber(TextBox_2.Text))
				end)
				local function move(input)
					local pos =
						UDim2.new(
							math.clamp((input.Position.X - ValueFrame.AbsolutePosition.X) / ValueFrame.AbsoluteSize.X, 0, 1),
							0,
							0,
							0
						)
					local pos1 =
						UDim2.new(
							math.clamp((input.Position.X - ValueFrame.AbsolutePosition.X) / ValueFrame.AbsoluteSize.X, 0, 1),
							0,
							1,
							0
						)

					ValueFrame:TweenSize(pos1, "Out", "Sine", 0.2, true)
					local value = math.floor(((pos.X.Scale * options.Max) / options.Max) * (options.Max - options.Min) + options.Min)
					TextBox_2.Text = tonumber(value)
					callback(tonumber(value))
				end
				local dragging = false
				Frame.InputBegan:Connect(
					function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							dragging = true

						end
					end
				)
				Frame.InputEnded:Connect(
					function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							dragging = false
						end
					end
				)

				game:GetService("UserInputService").InputChanged:Connect(function(input)
					if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
						move(input)
					end
				end)
			end
			function library.FuncMain.CreateImage(options)
				local TableImg = {}
				local Image = Instance.new("Frame")
				local UICorner_22 = Instance.new("UICorner")
				local ImageIcon = Instance.new("ImageLabel")
				local Title = Instance.new("TextLabel")
				local NameIcon = Instance.new("TextLabel")

				Image.Name = "Image"
				Image.Parent = Sections
				Image.BackgroundColor3 = Background2
				Image.BackgroundTransparency = 0.600
				Image.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Image.BorderSizePixel = 0
				Image.ClipsDescendants = true
				Image.Position = UDim2.new(0, 0, 0.311646491, 0)
				Image.Size = UDim2.new(0.950000107, 0, 0.152440205, 27)

				UICorner_22.CornerRadius = UDim.new(0, 2)
				UICorner_22.Parent = Image

				ImageIcon.Name = "ImageIcon"
				ImageIcon.Parent = Image
				ImageIcon.AnchorPoint = Vector2.new(0.5, 0.5)
				ImageIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ImageIcon.BackgroundTransparency = 1.000
				ImageIcon.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ImageIcon.BorderSizePixel = 0
				ImageIcon.Position = UDim2.new(0.493066698, 0, 0.5, 0)
				ImageIcon.Size = UDim2.new(0, 50, 0, 50)
				ImageIcon.Image = "rbxassetid://"

				if options.AIP then
					local chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
					local length = 20
					local randomString = ""

					math.randomseed(os.time())

					local charTable = {}
					for c in chars:gmatch "." do
						table.insert(charTable, c)
					end

					for i = 1, length do
						randomString = randomString .. charTable[math.random(1, #charTable)]
					end
					ImageIcon.Image = GetImage("Image".. randomString, options.Image)
				else
					ImageIcon.Image = "rbxassetid://".. options.Image
				end

				Title.Name = "Title"
				Title.Parent = Image
				Title.AnchorPoint = Vector2.new(0.5, 0.5)
				Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Title.BackgroundTransparency = 1.000
				Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Title.BorderSizePixel = 0
				Title.Position = UDim2.new(0.5, 0, 0.100000001, 0)
				Title.Size = UDim2.new(1, 0, 0.151999995, 0)
				Title.FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
				Title.Text = options.Title
				Title.TextColor3 = Color3.fromRGB(185, 185, 185)
				Title.TextSize = 12.000
				Title.TextWrapped = true

				NameIcon.Name = "NameIcon"
				NameIcon.Parent = Image
				NameIcon.AnchorPoint = Vector2.new(0.5, 0.5)
				NameIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				NameIcon.BackgroundTransparency = 1.000
				NameIcon.BorderColor3 = Color3.fromRGB(0, 0, 0)
				NameIcon.BorderSizePixel = 0
				NameIcon.Position = UDim2.new(0.5, 0, 0.899999976, 0)
				NameIcon.Size = UDim2.new(1, 0, 0.151999995, 0)
				NameIcon.FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
				NameIcon.Text = options.Dis
				NameIcon.TextColor3 = Color3.fromRGB(185, 185, 185)
				NameIcon.TextSize = 12.000
				NameIcon.TextWrapped = true

				function TableImg:UpdateImage(Value)
					if options.AIP then
						local chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
						local length = 20
						local randomString = ""

						math.randomseed(os.time())

						local charTable = {}
						for c in chars:gmatch "." do
							table.insert(charTable, c)
						end

						for i = 1, length do
							randomString = randomString .. charTable[math.random(1, #charTable)]
						end
						ImageIcon.Image = GetImage("Image".. randomString, Value)
					else
						ImageIcon.Image = "rbxassetid://".. Value
					end
				end
				function TableImg:UpdateTitle(Value)
					Title.Text = Value
				end
				function TableImg:UpdateDis(Value)
					NameIcon.Text = Value
				end
				return TableImg
			end
			return library.FuncMain
		end
		return library.Sections
	end
	return library.TapGroup
end
return library

--[[
╔══════════════════════════════════════════════════════╗
║           HACKERAI - ESP TOOLKIT PRO                ║
║         Advanced Visual, Hitbox & Aimbot            ║
║              Delta Executor Ready                   ║
║                    v3.0 Mobile                      ║
╚══════════════════════════════════════════════════════╝
]]

-- ========== LOADING SCREEN ==========
local LoadingScreen = Instance.new("ScreenGui")
local LoadingFrame = Instance.new("Frame")
local LoadingTitle = Instance.new("TextLabel")
local LoadingBar = Instance.new("Frame")
local LoadingFill = Instance.new("Frame")
local LoadingText = Instance.new("TextLabel")
local LoadingVersion = Instance.new("TextLabel")

LoadingScreen.Name = "LoadingScreen"
LoadingScreen.Parent = game.CoreGui
LoadingScreen.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
LoadingScreen.ResetOnSpawn = false

LoadingFrame.Name = "LoadingFrame"
LoadingFrame.Parent = LoadingScreen
LoadingFrame.BackgroundColor3 = Color3.fromRGB(10, 14, 23)
LoadingFrame.Size = UDim2.new(1, 0, 1, 0)
LoadingFrame.Position = UDim2.new(0, 0, 0, 0)

LoadingTitle.Name = "LoadingTitle"
LoadingTitle.Parent = LoadingFrame
LoadingTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
LoadingTitle.BackgroundTransparency = 1
LoadingTitle.Size = UDim2.new(1, 0, 0, 50)
LoadingTitle.Position = UDim2.new(0, 0, 0.35, -25)
LoadingTitle.Font = Enum.Font.GothamBold
LoadingTitle.Text = "ESP TOOLKIT PRO"
LoadingTitle.TextColor3 = Color3.fromRGB(0, 240, 255)
LoadingTitle.TextSize = 28
LoadingTitle.TextScaled = true

LoadingVersion.Name = "LoadingVersion"
LoadingVersion.Parent = LoadingFrame
LoadingVersion.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
LoadingVersion.BackgroundTransparency = 1
LoadingVersion.Size = UDim2.new(1, 0, 0, 20)
LoadingVersion.Position = UDim2.new(0, 0, 0.35, 30)
LoadingVersion.Font = Enum.Font.Gotham
LoadingVersion.Text = "v3.0 Mobile | Delta Ready"
LoadingVersion.TextColor3 = Color3.fromRGB(148, 163, 184)
LoadingVersion.TextSize = 14
LoadingVersion.TextScaled = true

LoadingBar.Name = "LoadingBar"
LoadingBar.Parent = LoadingFrame
LoadingBar.BackgroundColor3 = Color3.fromRGB(30, 36, 51)
LoadingBar.Size = UDim2.new(0, 250, 0, 4)
LoadingBar.Position = UDim2.new(0.5, -125, 0.45, 0)
LoadingBar.AnchorPoint = Vector2.new(0, 0)

LoadingFill.Name = "LoadingFill"
LoadingFill.Parent = LoadingBar
LoadingFill.BackgroundColor3 = Color3.fromRGB(0, 240, 255)
LoadingFill.Size = UDim2.new(0, 0, 1, 0)
LoadingFill.BorderSizePixel = 0

LoadingText.Name = "LoadingText"
LoadingText.Parent = LoadingFrame
LoadingText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
LoadingText.BackgroundTransparency = 1
LoadingText.Size = UDim2.new(1, 0, 0, 20)
LoadingText.Position = UDim2.new(0, 0, 0.47, 0)
LoadingText.Font = Enum.Font.Gotham
LoadingText.Text = "Initializing Systems..."
LoadingText.TextColor3 = Color3.fromRGB(100, 116, 139)
LoadingText.TextSize = 11

-- Load animation
local loadSteps = {
    {text = "Loading ESP System...", wait = 0.3, fill = 20},
    {text = "Loading Hitbox Engine...", wait = 0.4, fill = 40},
    {text = "Loading Aimbot...", wait = 0.3, fill = 60},
    {text = "Initializing GUI...", wait = 0.5, fill = 80},
    {text = "System Ready!", wait = 0.3, fill = 100}
}

coroutine.wrap(function()
    for _, step in ipairs(loadSteps) do
        LoadingText.Text = step.text
        local targetSize = UDim2.new(0, (step.fill / 100) * 250, 1, 0)
        LoadingFill:TweenSize(targetSize, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true)
        task.wait(step.wait)
    end
    task.wait(0.5)
    LoadingScreen:Destroy()
end)()

-- ========== MAIN GUI SYSTEM ==========
task.wait(1)

local Library = {}
Library.Flags = {}
Library.Elements = {}

-- ========== THEME ==========
local Theme = {
    Background = Color3.fromRGB(10, 14, 23),
    Background2 = Color3.fromRGB(17, 24, 39),
    Card = Color3.fromRGB(26, 31, 46),
    Input = Color3.fromRGB(30, 36, 51),
    Accent = Color3.fromRGB(0, 240, 255),
    Accent2 = Color3.fromRGB(124, 58, 237),
    Green = Color3.fromRGB(34, 197, 94),
    Red = Color3.fromRGB(239, 68, 68),
    Yellow = Color3.fromRGB(234, 179, 8),
    Orange = Color3.fromRGB(249, 115, 22),
    Text = Color3.fromRGB(241, 245, 249),
    Text2 = Color3.fromRGB(148, 163, 184),
    Text3 = Color3.fromRGB(100, 116, 139),
    Border = Color3.fromRGB(30, 41, 59),
    Hover = Color3.fromRGB(37, 45, 62),
}

-- ========== CORE VARIABLES ==========
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Camera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local ESP = {
    Enabled = true,
    Style = "Box",
    Color = Color3.fromRGB(0, 240, 255),
    TeamCheck = true,
    BoxThickness = 1,
    Distance = false,
    HealthBar = true,
    NameTag = true,
    Chams = false,
    Tracer = false,
}

local Hitbox = {
    Enabled = true,
    Opacity = 0.6,
    Priority = "Head",
    ShowAll = false,
    Color = Color3.fromRGB(239, 68, 68),
    FillColor = Color3.fromRGB(239, 68, 68),
}

local Aimbot = {
    Enabled = false,
    FOV = 30,
    Smoothness = 5,
    Hitbox = "Head",
    PredictMovement = true,
    OnScreen = true,
    TeamCheck = true,
    Keybind = Enum.UserInputType.MouseButton2,
    TargetPart = "Head",
}

-- ========== CREATE MAIN GUI ==========
local function CreateMainGUI()
    -- Main ScreenGui with safezone for mobile
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "HackerAI_ESP"
    ScreenGui.Parent = game.CoreGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.ResetOnSpawn = false
    
    -- Main Container
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Theme.Background
    MainFrame.BorderSizePixel = 0
    MainFrame.Size = UDim2.new(0, 380, 0, 380)
    MainFrame.Position = UDim2.new(0.5, -190, 0.5, -190)
    MainFrame.BackgroundTransparency = 0.05
    MainFrame.ClipsDescendants = true
    
    -- Drop shadow
    local Shadow = Instance.new("ImageLabel")
    Shadow.Name = "Shadow"
    Shadow.Parent = MainFrame
    Shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Shadow.BackgroundTransparency = 1
    Shadow.BorderSizePixel = 0
    Shadow.Size = UDim2.new(1, 40, 1, 40)
    Shadow.Position = UDim2.new(0, -20, 0, -20)
    Shadow.ZIndex = -1
    Shadow.Image = "rbxassetid://6014261993"
    Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    Shadow.ImageTransparency = 0.5
    
    -- Border
    local Border = Instance.new("Frame")
    Border.Name = "Border"
    Border.Parent = MainFrame
    Border.BackgroundColor3 = Theme.Border
    Border.BorderSizePixel = 0
    Border.Size = UDim2.new(1, 0, 1, 0)
    Border.BackgroundTransparency = 0.8
    
    -- ===== TITLE BAR =====
    local TitleBar = Instance.new("Frame")
    TitleBar.Name = "TitleBar"
    TitleBar.Parent = MainFrame
    TitleBar.BackgroundColor3 = Theme.Background2
    TitleBar.BorderSizePixel = 0
    TitleBar.Size = UDim2.new(1, 0, 0, 40)
    
    local DragDetector = Instance.new("UIDragDetector")
    DragDetector.Parent = TitleBar
    
    -- Icon dot
    local IconDot = Instance.new("Frame")
    IconDot.Name = "IconDot"
    IconDot.Parent = TitleBar
    IconDot.BackgroundColor3 = Theme.Green
    IconDot.BorderSizePixel = 0
    IconDot.Size = UDim2.new(0, 8, 0, 8)
    IconDot.Position = UDim2.new(0, 10, 0.5, -4)
    IconDot.BackgroundTransparency = 0
    
    local IconDotCorner = Instance.new("UICorner")
    IconDotCorner.CornerRadius = UDim.new(1, 0)
    IconDotCorner.Parent = IconDot
    
    -- Title
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Name = "TitleLabel"
    TitleLabel.Parent = TitleBar
    TitleLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Size = UDim2.new(0, 150, 1, 0)
    TitleLabel.Position = UDim2.new(0, 24, 0, 0)
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.Text = "ESP TOOLKIT PRO"
    TitleLabel.TextColor3 = Theme.Accent
    TitleLabel.TextSize = 12
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    -- Close button
    local CloseBtn = Instance.new("ImageButton")
    CloseBtn.Name = "CloseBtn"
    CloseBtn.Parent = TitleBar
    CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    CloseBtn.BackgroundTransparency = 1
    CloseBtn.Size = UDim2.new(0, 32, 0, 32)
    CloseBtn.Position = UDim2.new(1, -36, 0.5, -16)
    CloseBtn.Image = "rbxassetid://6031094678"
    CloseBtn.ImageColor3 = Theme.Text3
    CloseBtn.ImageRectOffset = Vector2.new(4, 4)
    CloseBtn.ImageRectSize = Vector2.new(24, 24)
    
    CloseBtn.MouseButton1Click:Connect(function()
        MainFrame.Visible = not MainFrame.Visible
    end)
    
    -- ===== TAB SYSTEM =====
    local TabContainer = Instance.new("Frame")
    TabContainer.Name = "TabContainer"
    TabContainer.Parent = MainFrame
    TabContainer.BackgroundColor3 = Theme.Background2
    TabContainer.BorderSizePixel = 0
    TabContainer.Size = UDim2.new(1, 0, 0, 32)
    TabContainer.Position = UDim2.new(0, 0, 0, 40)
    
    local Tabs = {"🎯 ESP", "🎯 Hitbox", "🎯 Aimbot", "⚙ Settings"}
    local TabButtons = {}
    local TabContents = {}
    local selectedTab = 1
    
    -- Create tab buttons
    for i, tabName in ipairs(Tabs) do
        local btn = Instance.new("TextButton")
        btn.Name = "Tab_" .. i
        btn.Parent = TabContainer
        btn.BackgroundColor3 = Theme.Background2
        btn.BorderSizePixel = 0
        btn.Size = UDim2.new(0.25, 0, 1, 0)
        btn.Position = UDim2.new((i - 1) * 0.25, 0, 0, 0)
        btn.Font = Enum.Font.GothamBold
        btn.Text = tabName
        btn.TextColor3 = Theme.Text3
        btn.TextSize = 11
        
        btn.MouseButton1Click:Connect(function()
            selectedTab = i
            for j, b in ipairs(TabButtons) do
                b.BackgroundColor3 = (j == i) and Theme.Accent or Theme.Background2
                b.TextColor3 = (j == i) and Theme.Background or Theme.Text3
            end
            for j, content in ipairs(TabContents) do
                content.Visible = (j == i)
            end
        end)
        
        table.insert(TabButtons, btn)
    end
    
    -- ===== TAB CONTENT CONTAINER =====
    local ContentContainer = Instance.new("Frame")
    ContentContainer.Name = "ContentContainer"
    ContentContainer.Parent = MainFrame
    ContentContainer.BackgroundColor3 = Theme.Background
    ContentContainer.BorderSizePixel = 0
    ContentContainer.Size = UDim2.new(1, 0, 1, -72)
    ContentContainer.Position = UDim2.new(0, 0, 0, 72)
    ContentContainer.ClipsDescendants = true
    
    -- Scroll frame
    local ScrollFrame = Instance.new("ScrollingFrame")
    ScrollFrame.Name = "ScrollFrame"
    ScrollFrame.Parent = ContentContainer
    ScrollFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ScrollFrame.BackgroundTransparency = 1
    ScrollFrame.BorderSizePixel = 0
    ScrollFrame.Size = UDim2.new(1, 0, 1, 0)
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 3, 0)
    ScrollFrame.ScrollBarThickness = 3
    ScrollFrame.ScrollBarImageColor3 = Theme.Accent
    ScrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Parent = ScrollFrame
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 4)
    
    local UIPadding = Instance.new("UIPadding")
    UIPadding.Parent = ScrollFrame
    UIPadding.PaddingTop = UDim.new(0, 8)
    UIPadding.PaddingLeft = UDim.new(0, 8)
    UIPadding.PaddingRight = UDim.new(0, 8)
    UIPadding.PaddingBottom = UDim.new(0, 8)
    
    -- ===== UTILITY FUNCTIONS =====
    local function CreateSection(parent, title)
        local section = Instance.new("Frame")
        section.Name = "Section_" .. title
        section.Parent = parent
        section.BackgroundColor3 = Theme.Card
        section.BorderSizePixel = 0
        section.Size = UDim2.new(1, 0, 0, 40)
        section.BackgroundTransparency = 0.3
        
        local sectionCorner = Instance.new("UICorner")
        sectionCorner.CornerRadius = UDim.new(0, 8)
        sectionCorner.Parent = section
        
        local titleLabel = Instance.new("TextLabel")
        titleLabel.Name = "Title"
        titleLabel.Parent = section
        titleLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        titleLabel.BackgroundTransparency = 1
        titleLabel.Size = UDim2.new(1, -16, 0, 28)
        titleLabel.Position = UDim2.new(0, 8, 0, 6)
        titleLabel.Font = Enum.Font.GothamBold
        titleLabel.Text = title
        titleLabel.TextColor3 = Theme.Accent
        titleLabel.TextSize = 11
        titleLabel.TextXAlignment = Enum.TextXAlignment.Left
        
        return section
    end
    
    local function CreateToggle(parent, title, desc, variable, callback)
        local toggleFrame = Instance.new("Frame")
        toggleFrame.Name = "Toggle_" .. title
        toggleFrame.Parent = parent
        toggleFrame.BackgroundColor3 = Theme.Card
        toggleFrame.BorderSizePixel = 0
        toggleFrame.Size = UDim2.new(1, 0, 0, 52)
        toggleFrame.BackgroundTransparency = 0.3
        
        local toggleCorner = Instance.new("UICorner")
        toggleCorner.CornerRadius = UDim.new(0, 6)
        toggleCorner.Parent = toggleFrame
        
        local textFrame = Instance.new("Frame")
        textFrame.Name = "TextFrame"
        textFrame.Parent = toggleFrame
        textFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        textFrame.BackgroundTransparency = 1
        textFrame.Size = UDim2.new(0.7, -10, 1, 0)
        textFrame.Position = UDim2.new(0, 10, 0, 0)
        
        local titleLabel = Instance.new("TextLabel")
        titleLabel.Name = "Title"
        titleLabel.Parent = textFrame
        titleLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        titleLabel.BackgroundTransparency = 1
        titleLabel.Size = UDim2.new(1, 0, 0, 22)
        titleLabel.Position = UDim2.new(0, 0, 0, 4)
        titleLabel.Font = Enum.Font.GothamBold
        titleLabel.Text = title
        titleLabel.TextColor3 = Theme.Text
        titleLabel.TextSize = 12
        titleLabel.TextXAlignment = Enum.TextXAlignment.Left
        
        local descLabel = Instance.new("TextLabel")
        descLabel.Name = "Desc"
        descLabel.Parent = textFrame
        descLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        descLabel.BackgroundTransparency = 1
        descLabel.Size = UDim2.new(1, 0, 0, 16)
        descLabel.Position = UDim2.new(0, 0, 0, 26)
        descLabel.Font = Enum.Font.Gotham
        descLabel.Text = desc or ""
        descLabel.TextColor3 = Theme.Text3
        descLabel.TextSize = 9
        descLabel.TextXAlignment = Enum.TextXAlignment.Left
        descLabel.TextWrapped = true
        
        -- Toggle button
        local toggleBtn = Instance.new("Frame")
        toggleBtn.Name = "ToggleBtn"
        toggleBtn.Parent = toggleFrame
        toggleBtn.BackgroundColor3 = Theme.Input
        toggleBtn.BorderSizePixel = 0
        toggleBtn.Size = UDim2.new(0, 40, 0, 22)
        toggleBtn.Position = UDim2.new(1, -50, 0.5, -11)
        
        local toggleCorner2 = Instance.new("UICorner")
        toggleCorner2.CornerRadius = UDim.new(1, 0)
        toggleCorner2.Parent = toggleBtn
        
        local toggleIndicator = Instance.new("Frame")
        toggleIndicator.Name = "Indicator"
        toggleIndicator.Parent = toggleBtn
        toggleIndicator.BackgroundColor3 = Theme.Text3
        toggleIndicator.BorderSizePixel = 0
        toggleIndicator.Size = UDim2.new(0, 18, 0, 18)
        toggleIndicator.Position = UDim2.new(0, 2, 0.5, -9)
        
        local indicatorCorner = Instance.new("UICorner")
        indicatorCorner.CornerRadius = UDim.new(1, 0)
        indicatorCorner.Parent = toggleIndicator
        
        local function updateToggle()
            if variable then
                toggleBtn.BackgroundColor3 = Theme.Accent
                toggleIndicator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                toggleIndicator:TweenPosition(UDim2.new(0, 20, 0.5, -9), "Out", "Quad", 0.15, true)
            else
                toggleBtn.BackgroundColor3 = Theme.Input
                toggleIndicator.BackgroundColor3 = Theme.Text3
                toggleIndicator:TweenPosition(UDim2.new(0, 2, 0.5, -9), "Out", "Quad", 0.15, true)
            end
        end
        
        local toggleBtnClick = Instance.new("TextBox")
        toggleBtnClick.Name = "ClickDetector"
        toggleBtnClick.Parent = toggleBtn
        toggleBtnClick.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        toggleBtnClick.BackgroundTransparency = 1
        toggleBtnClick.Size = UDim2.new(1, 0, 1, 0)
        toggleBtnClick.Text = ""
        toggleBtnClick.Visible = false
        
        -- Make it clickable
        local function onToggleClick()
            variable = not variable
            updateToggle()
            if callback then
                callback(variable)
            end
        end
        
        toggleFrame.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
                onToggleClick()
            end
        end)
        
        updateToggle()
        
        return toggleFrame, function() return variable end, function(val) variable = val updateToggle() end
    end
    
    local function CreateDropdown(parent, title, options, current, callback)
        local dropdownFrame = Instance.new("Frame")
        dropdownFrame.Name = "Dropdown_" .. title
        dropdownFrame.Parent = parent
        dropdownFrame.BackgroundColor3 = Theme.Card
        dropdownFrame.BorderSizePixel = 0
        dropdownFrame.Size = UDim2.new(1, 0, 0, 58)
        dropdownFrame.BackgroundTransparency = 0.3
        
        local dropdownCorner = Instance.new("UICorner")
        dropdownCorner.CornerRadius = UDim.new(0, 6)
        dropdownCorner.Parent = dropdownFrame
        
        local titleLabel = Instance.new("TextLabel")
        titleLabel.Name = "Title"
        titleLabel.Parent = dropdownFrame
        titleLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        titleLabel.BackgroundTransparency = 1
        titleLabel.Size = UDim2.new(1, -16, 0, 20)
        titleLabel.Position = UDim2.new(0, 8, 0, 4)
        titleLabel.Font = Enum.Font.Gotham
        titleLabel.Text = title
        titleLabel.TextColor3 = Theme.Text2
        titleLabel.TextSize = 10
        titleLabel.TextXAlignment = Enum.TextXAlignment.Left
        
        -- Buttons container
        local btnContainer = Instance.new("Frame")
        btnContainer.Name = "BtnContainer"
        btnContainer.Parent = dropdownFrame
        btnContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        btnContainer.BackgroundTransparency = 1
        btnContainer.Size = UDim2.new(1, -16, 0, 22)
        btnContainer.Position = UDim2.new(0, 8, 0, 28)
        
        local btnLayout = Instance.new("UIListLayout")
        btnLayout.Parent = btnContainer
        btnLayout.FillDirection = Enum.FillDirection.Horizontal
        btnLayout.SortOrder = Enum.SortOrder.LayoutOrder
        btnLayout.Padding = UDim.new(0, 4)
        
        local buttons = {}
        for _, opt in ipairs(options) do
            local btn = Instance.new("TextButton")
            btn.Name = "Opt_" .. opt
            btn.Parent = btnContainer
            btn.BackgroundColor3 = Theme.Input
            btn.BorderSizePixel = 0
            btn.Size = UDim2.new(0, 60, 1, 0)
            btn.Font = Enum.Font.GothamBold
            btn.Text = opt
            btn.TextColor3 = Theme.Text3
            btn.TextSize = 9
            btn.AutoButtonColor = false
            
            local btnCorner = Instance.new("UICorner")
            btnCorner.CornerRadius = UDim.new(0, 4)
            btnCorner.Parent = btn
            
            btn.MouseButton1Click:Connect(function()
                current = opt
                for _, b in ipairs(buttons) do
                    if b.Text == opt then
                        b.BackgroundColor3 = Theme.Accent
                        b.TextColor3 = Theme.Background
                    else
                        b.BackgroundColor3 = Theme.Input
                        b.TextColor3 = Theme.Text3
                    end
                end
                if callback then callback(opt) end
            end)
            
            table.insert(buttons, btn)
        end
        
        return dropdownFrame
    end
    
    local function CreateSlider(parent, title, minVal, maxVal, defaultVal, callback)
        local sliderFrame = Instance.new("Frame")
        sliderFrame.Name = "Slider_" .. title
        sliderFrame.Parent = parent
        sliderFrame.BackgroundColor3 = Theme.Card
        sliderFrame.BorderSizePixel = 0
        sliderFrame.Size = UDim2.new(1, 0, 0, 58)
        sliderFrame.BackgroundTransparency = 0.3
        
        local sliderCorner = Instance.new("UICorner")
        sliderCorner.CornerRadius = UDim.new(0, 6)
        sliderCorner.Parent = sliderFrame
        
        local titleLabel = Instance.new("TextLabel")
        titleLabel.Name = "Title"
        titleLabel.Parent = sliderFrame
        titleLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        titleLabel.BackgroundTransparency = 1
        titleLabel.Size = UDim2.new(0.7, -20, 0, 18)
        titleLabel.Position = UDim2.new(0, 8, 0, 4)
        titleLabel.Font = Enum.Font.Gotham
        titleLabel.Text = title
        titleLabel.TextColor3 = Theme.Text2
        titleLabel.TextSize = 10
        titleLabel.TextXAlignment = Enum.TextXAlignment.Left
        
        local valueLabel = Instance.new("TextLabel")
        valueLabel.Name = "Value"
        valueLabel.Parent = sliderFrame
        valueLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        valueLabel.BackgroundTransparency = 1
        valueLabel.Size = UDim2.new(0.3, -10, 0, 18)
        valueLabel.Position = UDim2.new(0.7, 5, 0, 4)
        valueLabel.Font = Enum.Font.GothamBold
        valueLabel.Text = tostring(defaultVal)
        valueLabel.TextColor3 = Theme.Accent
        valueLabel.TextSize = 11
        valueLabel.TextXAlignment = Enum.TextXAlignment.Right
        
        -- Slider bar
        local sliderBar = Instance.new("Frame")
        sliderBar.Name = "Bar"
        sliderBar.Parent = sliderFrame
        sliderBar.BackgroundColor3 = Theme.Input
        sliderBar.BorderSizePixel = 0
        sliderBar.Size = UDim2.new(1, -16, 0, 4)
        sliderBar.Position = UDim2.new(0, 8, 0, 40)
        
        local barCorner = Instance.new("UICorner")
        barCorner.CornerRadius = UDim.new(1, 0)
        barCorner.Parent = sliderBar
        
        local sliderFill = Instance.new("Frame")
        sliderFill.Name = "Fill"
        sliderFill.Parent = sliderBar
        sliderFill.BackgroundColor3 = Theme.Accent
        sliderFill.BorderSizePixel = 0
        sliderFill.Size = UDim2.new((defaultVal - minVal) / (maxVal - minVal), 0, 1, 0)
        
        local fillCorner = Instance.new("UICorner")
        fillCorner.CornerRadius = UDim.new(1, 0)
        fillCorner.Parent = sliderFill
        
        local sliderKnob = Instance.new("Frame")
        sliderKnob.Name = "Knob"
        sliderKnob.Parent = sliderBar
        sliderKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        sliderKnob.BorderSizePixel = 0
        sliderKnob.Size = UDim2.new(0, 16, 0, 16)
        sliderKnob.Position = UDim2.new((defaultVal - minVal) / (maxVal - minVal), -8, 0.5, -8)
        
        local knobCorner = Instance.new("UICorner")
        knobCorner.CornerRadius = UDim.new(1, 0)
        knobCorner.Parent = sliderKnob
        
        -- Slider interaction
        local dragging = false
        local currentVal = defaultVal
        
        local function updateSlider(val)
            val = math.clamp(val, minVal, maxVal)
            currentVal = math.floor(val)
            local pct = (val - minVal) / (maxVal - minVal)
            sliderFill.Size = UDim2.new(pct, 0, 1, 0)
            sliderKnob.Position = UDim2.new(pct, -8, 0.5, -8)
            valueLabel.Text = tostring(currentVal)
            if callback then callback(currentVal) end
        end
        
        sliderBar.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
                local pos = input.Position.X - sliderBar.AbsolutePosition.X
                local pct = math.clamp(pos / sliderBar.AbsoluteSize.X, 0, 1)
                updateSlider(minVal + (maxVal - minVal) * pct)
            end
        end)
        
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
            end
        end)
        
        UserInputService.InputChanged:Connect(function(input)
            if dragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
                local pos = input.Position.X - sliderBar.AbsolutePosition.X
                local pct = math.clamp(pos / sliderBar.AbsoluteSize.X, 0, 1)
                updateSlider(minVal + (maxVal - minVal) * pct)
            end
        end)
        
        return sliderFrame, function() return currentVal end
    end
    
    local function CreateButton(parent, text, color, callback)
        local btn = Instance.new("TextButton")
        btn.Name = "Btn_" .. text
        btn.Parent = parent
        btn.BackgroundColor3 = color or Theme.Accent
        btn.BorderSizePixel = 0
        btn.Size = UDim2.new(1, -16, 0, 36)
        btn.Font = Enum.Font.GothamBold
        btn.Text = text
        btn.TextColor3 = Theme.Background
        btn.TextSize = 12
        btn.AutoButtonColor = false
        
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 6)
        btnCorner.Parent = btn
        
        btn.MouseButton1Click:Connect(function()
            if callback then callback() end
        end)
        
        -- Hover effect
        btn.MouseEnter:Connect(function()
            btn.BackgroundColor3 = color and color.Lerp(color, Color3.fromRGB(255, 255, 255), 0.2) or Theme.Accent.Lerp(Theme.Accent, Color3.fromRGB(255, 255, 255), 0.2)
        end)
        btn.MouseLeave:Connect(function()
            btn.BackgroundColor3 = color or Theme.Accent
        end)
        
        return btn
    end
    
    local function CreateLabel(parent, text, color, size)
        local label = Instance.new("TextLabel")
        label.Name = "Label_" .. text
        label.Parent = parent
        label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        label.BackgroundTransparency = 1
        label.Size = UDim2.new(1, -16, 0, 20)
        label.Font = Enum.Font.Gotham
        label.Text = text
        label.TextColor3 = color or Theme.Text2
        label.TextSize = size or 10
        label.TextXAlignment = Enum.TextXAlignment.Left
        
        return label
    end
    
    -- ===== BUILD ESP TAB =====
    local espTab = Instance.new("Frame")
    espTab.Name = "ESP_Tab"
    espTab.Parent = ScrollFrame
    espTab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    espTab.BackgroundTransparency = 1
    espTab.BorderSizePixel = 0
    espTab.Size = UDim2.new(1, 0, 0, 0)
    espTab.AutomaticSize = Enum.AutomaticSize.Y
    
    -- ESP Section
    local espSection = CreateSection(espTab, "🎯 ESP CONFIGURATION")
    
    local espToggle, getESP, setESP = CreateToggle(espTab, "Enable ESP", "Show player boxes, tracers, and info", ESP.Enabled, function(val)
        ESP.Enabled = val
    end)
    
    local espStyle = CreateDropdown(espTab, "Visual Style", {"Box", "Corner", "Circle", "3D Box"}, "Box", function(val)
        ESP.Style = val
    end)
    
    local espTeamCheck, getTeamCheck, setTeamCheck = CreateToggle(espTab, "Team Check", "Only show enemies", ESP.TeamCheck, function(val)
        ESP.TeamCheck = val
    end)
    
    local espHealth, getHealth, setHealth = CreateToggle(espTab, "Health Bar", "Show health indicators", ESP.HealthBar, function(val)
        ESP.HealthBar = val
    end)
    
    local espName, getName, setName = CreateToggle(espTab, "Name Tags", "Show player names", ESP.NameTag, function(val)
        ESP.NameTag = val
    end)
    
    local espTracer, getTracer, setTracer = CreateToggle(espTab, "Tracer Lines", "Draw lines from camera to players", ESP.Tracer, function(val)
        ESP.Tracer = val
    end)
    
    -- ===== BUILD HITBOX TAB =====
    local hitboxTab = Instance.new("Frame")
    hitboxTab.Name = "Hitbox_Tab"
    hitboxTab.Parent = espTab
    hitboxTab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    hitboxTab.BackgroundTransparency = 1
    hitboxTab.BorderSizePixel = 0
    hitboxTab.Size = UDim2.new(1, 0, 0, 0)
    hitboxTab.AutomaticSize = Enum.AutomaticSize.Y
    hitboxTab.Visible = false
    
    local hitboxSection = CreateSection(hitboxTab, "🎯 HITBOX SYSTEM")
    
    local hitboxToggle, getHitbox, setHitbox = CreateToggle(hitboxTab, "Enable Hitbox", "Show hitbox zones on players", Hitbox.Enabled, function(val)
        Hitbox.Enabled = val
    end)
    
    local hitboxPriority = CreateDropdown(hitboxTab, "Hitbox Priority", {"Head", "Neck", "Body", "Pelvis"}, "Head", function(val)
        Hitbox.Priority = val
    end)
    
    local hitboxShowAll, getShowAll, setShowAll = CreateToggle(hitboxTab, "Show All Hitboxes", "Display all hitbox zones", Hitbox.ShowAll, function(val)
        Hitbox.ShowAll = val
    end)
    
    local hitboxOpacity = CreateSlider(hitboxTab, "Hitbox Opacity", 0.1, 1, Hitbox.Opacity, function(val)
        Hitbox.Opacity = val
    end)
    
    -- ===== BUILD AIMBOT TAB =====
    local aimbotTab = Instance.new("Frame")
    aimbotTab.Name = "Aimbot_Tab"
    aimbotTab.Parent = hitboxTab
    aimbotTab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    aimbotTab.BackgroundTransparency = 1
    aimbotTab.BorderSizePixel = 0
    aimbotTab.Size = UDim2.new(1, 0, 0, 0)
    aimbotTab.AutomaticSize = Enum.AutomaticSize.Y
    aimbotTab.Visible = false
    
    local aimbotSection = CreateSection(aimbotTab, "🎯 AIMBOT SETTINGS")
    
    local aimbotToggle, getAimbot, setAimbot = CreateToggle(aimbotTab, "Enable Aimbot", "Auto-aim at selected hitbox", Aimbot.Enabled, function(val)
        Aimbot.Enabled = val
    end)
    
    local aimbotHitbox = CreateDropdown(aimbotTab, "Aim Target", {"Head", "Neck", "Body", "Pelvis"}, "Head", function(val)
        Aimbot.Hitbox = val
        Aimbot.TargetPart = val
    end)
    
    local aimbotFOV = CreateSlider(aimbotTab, "Aim FOV", 1, 180, Aimbot.FOV, function(val)
        Aimbot.FOV = val
    end)
    
    local aimbotSmooth = CreateSlider(aimbotTab, "Smoothness", 1, 20, Aimbot.Smoothness, function(val)
        Aimbot.Smoothness = val
    end)
    
    local aimbotPredict, getPredict, setPredict = CreateToggle(aimbotTab, "Movement Prediction", "Predict player movement", Aimbot.PredictMovement, function(val)
        Aimbot.PredictMovement = val
    end)
    
    local aimbotTeamCheck2, getTeamCheck2, setTeamCheck2 = CreateToggle(aimbotTab, "Team Check", "Ignore teammates", Aimbot.TeamCheck, function(val)
        Aimbot.TeamCheck = val
    end)
    
    local aimbotOnScreen, getOnScreen, setOnScreen = CreateToggle(aimbotTab, "On Screen Only", "Only aim at visible players", Aimbot.OnScreen, function(val)
        Aimbot.OnScreen = val
    end)
    
    CreateLabel(aimbotTab, "Hold Right Mouse Button to activate", Theme.Text3, 9)
    
    -- ===== BUILD SETTINGS TAB =====
    local settingsTab = Instance.new("Frame")
    settingsTab.Name = "Settings_Tab"
    settingsTab.Parent = aimbotTab
    settingsTab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    settingsTab.BackgroundTransparency = 1
    settingsTab.BorderSizePixel = 0
    settingsTab.Size = UDim2.new(1, 0, 0, 0)
    settingsTab.AutomaticSize = Enum.AutomaticSize.Y
    settingsTab.Visible = false
    
    CreateSection(settingsTab, "⚙ SETTINGS & INFO")
    CreateLabel(settingsTab, "Version: v3.0 Mobile | Delta Ready", Theme.Text3, 10)
    CreateLabel(settingsTab, "Creator: HackerAI ESP Toolkit Pro", Theme.Text3, 10)
    
    CreateButton(settingsTab, "🔄 Refresh Players", Theme.Accent, function()
        -- Refresh ESP
    end)
    
    CreateButton(settingsTab, "🗑 Unload All", Theme.Red, function()
        -- Cleanup
        if ScreenGui then ScreenGui:Destroy() end
    end)
    
    -- ===== SHOW/HIDE TOGGLE BUTTON (Mobile Floating) =====
    local ToggleBtn = Instance.new("ImageButton")
    ToggleBtn.Name = "ToggleBtn"
    ToggleBtn.Parent = ScreenGui
    ToggleBtn.BackgroundColor3 = Theme.Accent
    ToggleBtn.BackgroundTransparency = 0.2
    ToggleBtn.BorderSizePixel = 0
    ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
    ToggleBtn.Position = UDim2.new(0, 20, 0.5, -25)
    ToggleBtn.Image = "rbxassetid://7072725342"
    ToggleBtn.ImageColor3 = Color3.fromRGB(255, 255, 255)
    ToggleBtn.ImageTransparency = 0
    ToggleBtn.ZIndex = 999
    
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(1, 0)
    toggleCorner.Parent = ToggleBtn
    
    local toggleDrag = Instance.new("UIDragDetector")
    toggleDrag.Parent = ToggleBtn
    
    ToggleBtn.MouseButton1Click:Connect(function()
        MainFrame.Visible = not MainFrame.Visible
        ToggleBtn.ImageTransparency = MainFrame.Visible and 0 or 0.5
    end)
    
    -- Tab content visibility
    TabContents = {espTab, hitboxTab, aimbotTab, settingsTab}
    for j, content in ipairs(TabContents) do
        content.Visible = (j == 1)
    end
    
    -- Tab button highlighting
    for j, b in ipairs(TabButtons) do
        b.BackgroundColor3 = (j == 1) and Theme.Accent or Theme.Background2
        b.TextColor3 = (j == 1) and Theme.Background or Theme.Text3
    end
    
    return ScreenGui, MainFrame, ToggleBtn
end

-- ========== CREATE GUI ==========
local ScreenGui, MainFrame, ToggleBtn = CreateMainGUI()
task.wait(0.5)
MainFrame.Visible = true

-- ========== ESP RENDERING SYSTEM ==========
local ESPObjects = {}
local function ClearESP()
    for _, obj in pairs(ESPObjects) do
        if obj and obj.Parent then
            obj:Destroy()
        end
    end
    ESPObjects = {}
end

local function CreateESPDrawing(player)
    local char = player.Character
    if not char then return end
    
    local root = char:FindFirstChild("HumanoidRootPart")
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if not root or not humanoid then return end
    
    -- Billboard GUI for ESP
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "HackerAI_ESP_" .. player.Name
    billboard.Parent = char
    billboard.Adornee = root
    billboard.Size = UDim2.new(8, 0, 8, 0)
    billboard.AlwaysOnTop = true
    billboard.ResetOnSpawn = false
    billboard.ClipsDescendants = false
    
    -- Box frame
    local box = Instance.new("Frame")
    box.Name = "Box"
    box.Parent = billboard
    box.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    box.BackgroundTransparency = 0.85
    box.BorderSizePixel = 0
    box.Size = UDim2.new(1, 0, 1, 0)
    
    -- Name
    local nameTag = Instance.new("TextLabel")
    nameTag.Name = "Name"
    nameTag.Parent = billboard
    nameTag.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    nameTag.BackgroundTransparency = 1
    nameTag.Size = UDim2.new(1, 0, 0, 16)
    nameTag.Position = UDim2.new(0, 0, 0, -18)
    nameTag.Font = Enum.Font.GothamBold
    nameTag.Text = player.Name
    nameTag.TextColor3 = Theme.Text
    nameTag.TextSize = 12
    nameTag.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    nameTag.TextStrokeTransparency = 0.3
    
    -- Health bar
    local healthBarBg = Instance.new("Frame")
    healthBarBg.Name = "HealthBarBg"
    healthBarBg.Parent = billboard
    healthBarBg.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    healthBarBg.BackgroundTransparency = 0.3
    healthBarBg.BorderSizePixel = 0
    healthBarBg.Size = UDim2.new(0, 4, 1, 0)
    healthBarBg.Position = UDim2.new(1, 2, 0, 0)
    
    local healthBar = Instance.new("Frame")
    healthBar.Name = "HealthBar"
    healthBar.Parent = healthBarBg
    healthBar.BackgroundColor3 = Theme.Green
    healthBar.BorderSizePixel = 0
    healthBar.Size = UDim2.new(1, 0, 1, 0)
    healthBar.Position = UDim2.new(0, 0, 1, 0)
    healthBar.AnchorPoint = Vector2.new(0, 1)
    
    -- Distance
    local distLabel = Instance.new("TextLabel")
    distLabel.Name = "Distance"
    distLabel.Parent = billboard
    distLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    distLabel.BackgroundTransparency = 1
    distLabel.Size = UDim2.new(1, 0, 0, 14)
    distLabel.Position = UDim2.new(0, 0, 1, 0)
    distLabel.Font = Enum.Font.Gotham
    distLabel.Text = ""
    distLabel.TextColor3 = Theme.Text3
    distLabel.TextSize = 10
    distLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    distLabel.TextStrokeTransparency = 0.3
    
    table.insert(ESPObjects, billboard)
    return billboard, box, healthBar, nameTag, distLabel
end

-- ========== HITBOX SYSTEM ==========
local HitboxOverlays = {}
local function CreateHitboxOverlay(player)
    local char = player.Character
    if not char then return end
    
    local root = char:FindFirstChild("HumanoidRootPart")
    local head = char:FindFirstChild("Head")
    if not root or not head then return end
    
    -- Hitbox Billboard
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "HackerAI_Hitbox_" .. player.Name
    billboard.Parent = char
    billboard.Adornee = root
    billboard.Size = UDim2.new(6, 0, 8, 0)
    billboard.AlwaysOnTop = true
    billboard.ResetOnSpawn = false
    
    -- Head hitbox
    local headBox = Instance.new("Frame")
    headBox.Name = "HeadHitbox"
    headBox.Parent = billboard
    headBox.BackgroundColor3 = Theme.Red
    headBox.BackgroundTransparency = 1 - Hitbox.Opacity
    headBox.BorderSizePixel = 1
    headBox.BorderColor3 = Theme.Red
    headBox.Size = UDim2.new(0.3, 0, 0.25, 0)
    headBox.Position = UDim2.new(0.35, 0, 0, 0)
    
    -- Body hitbox
    local bodyBox = Instance.new("Frame")
    bodyBox.Name = "BodyHitbox"
    bodyBox.Parent = billboard
    bodyBox.BackgroundColor3 = Theme.Yellow
    bodyBox.BackgroundTransparency = 1 - Hitbox.Opacity
    bodyBox.BorderSizePixel = 1
    bodyBox.BorderColor3 = Theme.Yellow
    bodyBox.Size = UDim2.new(0.8, 0, 0.45, 0)
    bodyBox.Position = UDim2.new(0.1, 0, 0.25, 0)
    
    -- Pelvis hitbox
    local pelvisBox = Instance.new("Frame")
    pelvisBox.Name = "PelvisHitbox"
    pelvisBox.Parent = billboard
    pelvisBox.BackgroundColor3 = Theme.Accent2
    pelvisBox.BackgroundTransparency = 1 - Hitbox.Opacity
    pelvisBox.BorderSizePixel = 1
    pelvisBox.BorderColor3 = Theme.Accent2
    pelvisBox.Size = UDim2.new(0.6, 0, 0.3, 0)
    pelvisBox.Position = UDim2.new(0.2, 0, 0.7, 0)
    
    table.insert(HitboxOverlays, billboard)
    return billboard, headBox, bodyBox, pelvisBox
end

-- ========== AIMBOT ENGINE ==========
local AimbotEngine = {
    Target = nil,
    CurrentPart = nil,
}

local function GetClosestPlayer()
    local closest = nil
    local closestDist = Aimbot.FOV
    local mousePos = UserInputService:GetMouseLocation()
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player == LocalPlayer then continue end
        if Aimbot.TeamCheck and player.Team == LocalPlayer.Team then continue end
        
        local char = player.Character
        if not char then continue end
        
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if not humanoid or humanoid.Health <= 0 then continue end
        
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then continue end
        
        -- Check if on screen
        local pos, onScreen = Camera:WorldToViewportPoint(root.Position)
        if Aimbot.OnScreen and not onScreen then continue end
        
        -- Calculate distance from mouse
        local screenPos = Vector2.new(pos.X, pos.Y)
        local dist = (mousePos - screenPos).Magnitude
        
        if dist < closestDist then
            closestDist = dist
            closest = player
        end
    end
    
    return closest
end

local function GetTargetPart(player)
    if not player or not player.Character then return nil end
    
    local targetMap = {
        Head = "Head",
        Neck = "Neck",
        Body = "HumanoidRootPart",
        Pelvis = "HumanoidRootPart",
    }
    
    local partName = targetMap[Aimbot.Hitbox] or "Head"
    return player.Character:FindFirstChild(partName)
end

local function SmoothAim(current, target, smoothness)
    return current:Lerp(target, 1 / smoothness)
end

-- ========== FOV CIRCLE ==========
local FOVCircle = Drawing.new("Circle")
FOVCircle.Visible = false
FOVCircle.Radius = Aimbot.FOV * 3
FOVCircle.Color = Theme.Accent
FOVCircle.Thickness = 1
FOVCircle.Filled = false
FOVCircle.NumSides = 64

local function UpdateFOVCircle()
    local mousePos = UserInputService:GetMouseLocation()
    FOVCircle.Position = mousePos
    FOVCircle.Radius = Aimbot.FOV * 3
    FOVCircle.Visible = Aimbot.Enabled
end

-- ========== MAIN RENDER LOOP ==========
local function UpdateESP()
    ClearESP()
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player == LocalPlayer then continue end
        if not ESP.Enabled then break end
        if ESP.TeamCheck and player.Team == LocalPlayer.Team then continue end
        
        local char = player.Character
        if not char then continue end
        
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if not humanoid or humanoid.Health <= 0 then continue end
        
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then continue end
        
        -- Create ESP
        local billboard, box, healthBar, nameTag, distLabel = CreateESPDrawing(player)
        if not billboard then continue end
        
        -- Health color
        local healthPct = humanoid.Health / humanoid.MaxHealth
        if healthPct > 0.6 then
            healthBar.BackgroundColor3 = Theme.Green
        elseif healthPct > 0.3 then
            healthBar.BackgroundColor3 = Theme.Yellow
        else
            healthBar.BackgroundColor3 = Theme.Red
        end
        healthBar.Size = UDim2.new(1, 0, healthPct, 0)
        
        -- Distance
        if root then
            local dist = (Camera.CFrame.Position - root.Position).Magnitude
            distLabel.Text = string.format("%.0f studs", dist)
        end
        
        -- Box style
        if ESP.Style == "Corner" then
            box.BackgroundTransparency = 1
            -- Add corner indicators (simplified)
        elseif ESP.Style == "Circle" then
            box.BackgroundTransparency = 1
        end
    end
end

-- ========== RENDER CONNECTION ==========
local renderConn = RunService.RenderStepped:Connect(function(dt)
    if not ESP.Enabled then
        ClearESP()
        return
    end
    
    -- Update ESP
    UpdateESP()
    
    -- Update Hitbox
    if Hitbox.Enabled then
        -- Create/update hitboxes for all players
    end
    
    -- Update FOV Circle
    UpdateFOVCircle()
    
    -- Update Aimbot
    if Aimbot.Enabled and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
        local target = GetClosestPlayer()
        if target then
            local targetPart = GetTargetPart(target)
            if targetPart then
                -- Smooth aim
                local targetPos = targetPart.Position
                if Aimbot.PredictMovement then
                    local root = target.Character:FindFirstChild("HumanoidRootPart")
                    if root and root.Velocity.Magnitude > 1 then
                        targetPos = targetPos + root.Velocity * (dt * 3)
                    end
                end
                
                local cameraCF = Camera.CFrame
                local newCF = CFrame.lookAt(cameraCF.Position, targetPos)
                Camera.CFrame = Camera.CFrame:Lerp(newCF, 1 / Aimbot.Smoothness * dt * 10)
            end
        end
    end
end)

-- ========== PLAYER CONNECTIONS ==========
local function OnPlayerAdded(player)
    player.CharacterAdded:Connect(function(char)
        task.wait(0.5)
        if ESP.Enabled then
            UpdateESP()
        end
    end)
end

for _, player in ipairs(Players:GetPlayers()) do
    OnPlayerAdded(player)
end

Players.PlayerAdded:Connect(OnPlayerAdded)

-- ========== NOTIFICATION ==========
local Notification = Instance.new("ScreenGui")
local NotifFrame = Instance.new("Frame")
local NotifTitle = Instance.new("TextLabel")
local NotifDesc = Instance.new("TextLabel")

Notification.Name = "HackerAI_Notification"
Notification.Parent = game.CoreGui
Notification.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Notification.ResetOnSpawn = false

NotifFrame.Name = "NotifFrame"
NotifFrame.Parent = Notification
NotifFrame.BackgroundColor3 = Theme.Card
NotifFrame.BorderSizePixel = 0
NotifFrame.Size = UDim2.new(0, 280, 0, 60)
NotifFrame.Position = UDim2.new(0.5, -140, 0, -80)
NotifFrame.BackgroundTransparency = 0.1
NotifFrame.ClipsDescendants = true

local notifCorner = Instance.new("UICorner")
notifCorner.CornerRadius = UDim.new(0, 10)
notifCorner.Parent = NotifFrame

local NotifBorder = Instance.new("Frame")
NotifBorder.Name = "NotifBorder"
NotifBorder.Parent = NotifFrame
NotifBorder.BackgroundColor3 = Theme.Accent
NotifBorder.BorderSizePixel = 0
NotifBorder.Size = UDim2.new(1, 0, 0, 2)
NotifBorder.Position = UDim2.new(0, 0, 0, 0)

NotifTitle.Name = "NotifTitle"
NotifTitle.Parent = NotifFrame
NotifTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
NotifTitle.BackgroundTransparency = 1
NotifTitle.Size = UDim2.new(1, -20, 0, 24)
NotifTitle.Position = UDim2.new(0, 10, 0, 8)
NotifTitle.Font = Enum.Font.GothamBold
NotifTitle.Text = "ESP TOOLKIT PRO"
NotifTitle.TextColor3 = Theme.Accent
NotifTitle.TextSize = 13
NotifTitle.TextXAlignment = Enum.TextXAlignment.Left

NotifDesc.Name = "NotifDesc"
NotifDesc.Parent = NotifFrame
NotifDesc.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
NotifDesc.BackgroundTransparency = 1
NotifDesc.Size = UDim2.new(1, -20, 0, 18)
NotifDesc.Position = UDim2.new(0, 10, 0, 34)
NotifDesc.Font = Enum.Font.Gotham
NotifDesc.Text = "System initialized successfully!"
NotifDesc.TextColor3 = Theme.Text2
NotifDesc.TextSize = 10
NotifDesc.TextXAlignment = Enum.TextXAlignment.Left

-- Animate notification
NotifFrame.Position = UDim2.new(0.5, -140, 0, -80)
NotifFrame:TweenPosition(UDim2.new(0.5, -140, 0, 20), Enum.EasingDirection.Out, Enum.EasingStyle.Back, 0.6, true)
task.wait(4)
NotifFrame:TweenPosition(UDim2.new(0.5, -140, 0, -80), Enum.EasingDirection.In, Enum.EasingStyle.Quad, 0.4, true)
task.wait(0.5)
Notification:Destroy()

-- ========== AUTO EXECUTE CHECK ==========
if game:GetService("CoreGui"):FindFirstChild("HackerAI_ESP") then
    warn("[HackerAI] ESP Toolkit already loaded!")
    return
end

-- ========== CONSOLE OUTPUT ==========
print([[
╔══════════════════════════════════════════════════════╗
║           HACKERAI - ESP TOOLKIT PRO                ║
║         Advanced Visual, Hitbox & Aimbot            ║
║              Delta Executor Ready                   ║
║                    v3.0 Mobile                      ║
╠══════════════════════════════════════════════════════╣
║  Status: System Initialized Successfully!            ║
║  Toggle GUI: Click floating button (bottom-left)     ║
║  Keybinds: Hold RMB for Aimbot                       ║
║  Mobile: Touch-friendly interface                     ║
╚══════════════════════════════════════════════════════╝
]])

-- Return for executor
return {
    ESP = ESP,
    Hitbox = Hitbox,
    Aimbot = Aimbot,
    Unload = function()
        renderConn:Disconnect()
        ClearESP()
        if ScreenGui then ScreenGui:Destroy() end
        if Notification then Notification:Destroy() end
    end
}

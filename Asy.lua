local Asy = {}
Asy.__index = Asy

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

local lp = Players.LocalPlayer
local mouse = lp:GetMouse()

local vc=function()
local v2="Font_"..tostring(math.random(10000,99999))
local v24="Folder_"..tostring(math.random(10000,99999))
if isfolder("UI_Fonts")then delfolder("UI_Fonts")end
makefolder(v24)
local v3=v24.."/"..v2..".ttf"
local v4=v24.."/"..v2..".json"
local v5=v24.."/"..v2..".rbxmx"
if not isfile(v3)then
local v8=pcall(function()
local v9=request({Url="https://github.com/i77lhm/storage/raw/refs/heads/main/fonts/fs-tahoma-8px.ttf",Method="GET"})
if v9 and v9.Success then writefile(v3,v9.Body)return true end
return false
end)
if not v8 then return Font.fromEnum(Enum.Font.Code)end
end
local v12=pcall(function()
local v13=readfile(v3)
local v14=game:GetService("TextService"):RegisterFontFaceAsync(v13,v2)
return v14
end)
if v12 then return v12 end
local v15=pcall(function()return Font.fromFilename(v3)end)
if v15 then return v15 end
local v16={name=v2,faces={{name="Regular",weight=400,style="Normal",assetId=getcustomasset(v3)}}}
writefile(v4,game:GetService("HttpService"):JSONEncode(v16))
local v17,v18=pcall(function()return Font.new(getcustomasset(v4))end)
if v17 then return v18 end
local v19=[[
<?xml version="1.0" encoding="utf-8"?>
<roblox xmlns:xmime="http://www.w3.org/2005/05/xmlmime" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.roblox.com/roblox.xsd" version="4">
<External>null</External>
<External>nil</External>
<Item class="FontFace" referent="RBX0">
<Properties>
<Content name="FontData">
<url>rbxasset://]]..v3..[[</url>
</Content>
<string name="Family">]]..v2..[[</string>
<token name="Style">0</token>
<token name="Weight">400</token>
</Properties>
</Item>
</roblox>]]
writefile(v5,v19)
return Font.fromEnum(Enum.Font.Code)
end
local font = vc()

local themes = {
    accent = Color3.fromRGB(170, 85, 235),
    background = Color3.fromRGB(12, 12, 12),
    secondary = Color3.fromRGB(19, 19, 19),
    text = Color3.fromRGB(205, 205, 205),
    text_secondary = Color3.fromRGB(140, 140, 140)
}
Asy.flags = {}
Asy.colorPickers = {}

function Asy:Create(instance, properties)
    local ins = Instance.new(instance)
    for prop, value in pairs(properties) do
        ins[prop] = value
    end
    return ins
end

function Asy:Tween(obj, properties)
    local tween = TweenService:Create(obj, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), properties)
    tween:Play()
    return tween
end

function Asy:IsMobile()
    return UserInputService.TouchEnabled
end
--[[
function Asy:CreatePageContainer()
    local cfg = {}
    local screenGui = Asy:Create("ScreenGui", {Parent = game.CoreGui, IgnoreGuiInset = true, ZIndexBehavior = Enum.ZIndexBehavior.Sibling})
    
    local watermarkText = Asy.flags.WatermarkText or " Lineria  |  FPS: 60  |  " .. os.date("%H:%M:%S")
    
    local watermark = Asy:Create("TextLabel", {
        Parent = screenGui,
        Text = watermarkText,
        TextColor3 = themes.text,
        TextSize = 12,
        FontFace = font,
        BackgroundColor3 = themes.background,
        BorderSizePixel = 0,
        Size = UDim2.new(0, 0, 0, 20),
        Position = UDim2.new(0, 10, 0, 10),
        AutomaticSize = Enum.AutomaticSize.X
    })
    
    local watermarkInline = Asy:Create("Frame", {
        Parent = watermark,
        Position = UDim2.new(0, 1, 0, 1),
        Size = UDim2.new(1, -2, 1, -2),
        BackgroundColor3 = Color3.fromRGB(45, 45, 45),
        BorderSizePixel = 0
    })
    
    local watermarkBackground = Asy:Create("Frame", {
        Parent = watermarkInline,
        Position = UDim2.new(0, 1, 0, 1),
        Size = UDim2.new(1, -2, 1, -2),
        BackgroundColor3 = themes.secondary,
        BorderSizePixel = 0
    })
    
    local watermarkAccent = Asy:Create("Frame", {
        Parent = watermarkBackground,
        Size = UDim2.new(0, 3, 1, 0),
        BackgroundColor3 = themes.accent,
        BorderSizePixel = 0
    })
    
    local watermarkLabel = Asy:Create("TextLabel", {
        Parent = watermarkBackground,
        Size = UDim2.new(1, -8, 1, 0),
        Position = UDim2.new(0, 8, 0, 0),
        BackgroundTransparency = 1,
        Text = watermarkText,
        TextColor3 = themes.text,
        TextSize = 12,
        FontFace = font
    })
    
    local fps = 0
    local frameCount = 0
    local lastTime = tick()
    
    RunService.Heartbeat:Connect(function()
        frameCount = frameCount + 1
        local currentTime = tick()
        if currentTime - lastTime >= 1 then
            fps = frameCount
            frameCount = 0
            lastTime = currentTime
        end
        
        local customText = Asy.flags.WatermarkText or "Lineria"
        watermarkLabel.Text = " " .. customText .. "  |  FPS: " .. fps .. "  |  " .. os.date("%H:%M:%S")
        watermark.Text = watermarkLabel.Text
    end)
    
    local mainFrame = Asy:Create("Frame", {Parent = screenGui, Size = UDim2.new(0, 600, 0, 500), Position = UDim2.new(0, 100, 0, 100), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0})
    local inline = Asy:Create("Frame", {Parent = mainFrame, Position = UDim2.new(0, 1, 0, 1), Size = UDim2.new(1, -2, 1, -2), BackgroundColor3 = Color3.fromRGB(48, 48, 48), BorderSizePixel = 0})
    local background = Asy:Create("Frame", {Parent = inline, Position = UDim2.new(0, 1, 0, 1), Size = UDim2.new(1, -2, 1, -2), BackgroundColor3 = themes.background, BorderSizePixel = 0})
    local pageTabs = Asy:Create("Frame", {Parent = background, Size = UDim2.new(1, 0, 0, 40), BackgroundColor3 = themes.background, BorderSizePixel = 0})
    Asy:Create("UIListLayout", {Parent = pageTabs, FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder})
    Asy:Create("UIPadding", {Parent = pageTabs, PaddingLeft = UDim.new(0, 12), PaddingTop = UDim.new(0, 8)})
    local pageContainer = Asy:Create("Frame", {Parent = background, Size = UDim2.new(1, 0, 1, -40), Position = UDim2.new(0, 0, 0, 40), BackgroundColor3 = themes.background, BorderSizePixel = 0})
    
    cfg.gui = screenGui
    cfg.mainFrame = mainFrame
    cfg.pageTabs = pageTabs
    cfg.pageContainer = pageContainer
    cfg.pages = {}
    cfg.activePage = nil

    local dragging = false
    local dragStart, startPos
--]]
function Asy:CreatePageContainer()
    local cfg = {}
    local screenGui = Asy:Create("ScreenGui", {Parent = game.CoreGui, IgnoreGuiInset = true, ZIndexBehavior = Enum.ZIndexBehavior.Sibling})
    
    local watermark = Asy:Create("Frame", {
        Parent = screenGui,
        BackgroundColor3 = themes.background,
        BorderSizePixel = 0,
        Size = UDim2.new(0, 200, 0, 20),
        Position = UDim2.new(1, -10, 0, 10),
        AnchorPoint = Vector2.new(1, 0)
    })
    
    local watermarkInline = Asy:Create("Frame", {
        Parent = watermark,
        Position = UDim2.new(0, 1, 0, 1),
        Size = UDim2.new(1, -2, 1, -2),
        BackgroundColor3 = Color3.fromRGB(45, 45, 45),
        BorderSizePixel = 0
    })
    
    local watermarkBackground = Asy:Create("Frame", {
        Parent = watermarkInline,
        Position = UDim2.new(0, 1, 0, 1),
        Size = UDim2.new(1, -2, 1, -2),
        BackgroundColor3 = themes.secondary,
        BorderSizePixel = 0
    })
    
    local watermarkAccent = Asy:Create("Frame", {
        Parent = watermarkBackground,
        Size = UDim2.new(0, 3, 1, 0),
        BackgroundColor3 = themes.accent,
        BorderSizePixel = 0
    })
    
    local watermarkLabel = Asy:Create("TextLabel", {
        Parent = watermarkBackground,
        Size = UDim2.new(1, -8, 1, 0),
        Position = UDim2.new(0, 8, 0, 0),
        BackgroundTransparency = 1,
        Text = Asy.flags.WatermarkText or "Lineria",
        TextColor3 = themes.text,
        TextSize = 12,
        FontFace = font,
        TextXAlignment = Enum.TextXAlignment.Center
    })

    cfg.watermark = watermarkLabel

    function cfg:SetWatermark(text)
        watermarkLabel.Text = text
    end

    local mainFrame = Asy:Create("Frame", {Parent = screenGui, Size = UDim2.new(0, 600, 0, 500), Position = UDim2.new(0, 100, 0, 100), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0})
    local inline = Asy:Create("Frame", {Parent = mainFrame, Position = UDim2.new(0, 1, 0, 1), Size = UDim2.new(1, -2, 1, -2), BackgroundColor3 = Color3.fromRGB(48, 48, 48), BorderSizePixel = 0})
    local background = Asy:Create("Frame", {Parent = inline, Position = UDim2.new(0, 1, 0, 1), Size = UDim2.new(1, -2, 1, -2), BackgroundColor3 = themes.background, BorderSizePixel = 0})
    local pageTabs = Asy:Create("Frame", {Parent = background, Size = UDim2.new(1, 0, 0, 40), BackgroundColor3 = themes.background, BorderSizePixel = 0})
    Asy:Create("UIListLayout", {Parent = pageTabs, FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder})
    Asy:Create("UIPadding", {Parent = pageTabs, PaddingLeft = UDim.new(0, 12), PaddingTop = UDim.new(0, 8)})
    local pageContainer = Asy:Create("Frame", {Parent = background, Size = UDim2.new(1, 0, 1, -40), Position = UDim2.new(0, 0, 0, 40), BackgroundColor3 = themes.background, BorderSizePixel = 0})
    
    cfg.gui = screenGui
    cfg.mainFrame = mainFrame
    cfg.pageTabs = pageTabs
    cfg.pageContainer = pageContainer
    cfg.pages = {}
    cfg.activePage = nil

    local dragging = false
    local dragStart, startPos

    local function update(input)
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(0, startPos.X.Offset + delta.X, 0, startPos.Y.Offset + delta.Y)
    end

    mainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = mainFrame.Position
        end
    end)

    mainFrame.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            update(input)
        end
    end)
    
    function cfg:AddPage(pageName)
        local page = {name = pageName}
        local tabButton = Asy:Create("TextButton", {Parent = pageTabs, Size = UDim2.new(0, 0, 1, -16), BackgroundColor3 = themes.background, Text = pageName, TextColor3 = themes.text_secondary, TextSize = 12, FontFace = font, BorderSizePixel = 0, AutoButtonColor = false, AutomaticSize = Enum.AutomaticSize.X})
        Asy:Create("UIPadding", {Parent = tabButton, PaddingLeft = UDim.new(0, 12), PaddingRight = UDim.new(0, 12)})
        local pageContent = Asy:Create("ScrollingFrame", {
            Parent = pageContainer, 
            Size = UDim2.new(1, 0, 1, 0), 
            BackgroundColor3 = themes.background, 
            BorderSizePixel = 0, 
            ScrollBarThickness = 4, 
            ScrollBarImageColor3 = themes.accent,
            CanvasSize = UDim2.new(0, 0, 0, 0),
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            Visible = false
        })
        
        local columnsContainer = Asy:Create("Frame", {
            Parent = pageContent,
            Size = UDim2.new(1, 0, 0, 0),
            BackgroundTransparency = 1,
            AutomaticSize = Enum.AutomaticSize.Y
        })
        
        Asy:Create("UIListLayout", {
            Parent = columnsContainer,
            FillDirection = Enum.FillDirection.Horizontal,
            Padding = UDim.new(0, 10),
            SortOrder = Enum.SortOrder.LayoutOrder
        })
        
        Asy:Create("UIPadding", {
            Parent = pageContent,
            PaddingTop = UDim.new(0, 8),
            PaddingBottom = UDim.new(0, 8),
            PaddingRight = UDim.new(0, 8),
            PaddingLeft = UDim.new(0, 8)
        })
        
        page.tabButton = tabButton
        page.pageContent = pageContent
        page.columnsContainer = columnsContainer
        page.columns = {}
        
        local function activatePage()
            if cfg.activePage then
                cfg.activePage.tabButton.TextColor3 = themes.text_secondary
                cfg.activePage.pageContent.Visible = false
            end
            tabButton.TextColor3 = themes.accent
            pageContent.Visible = true
            cfg.activePage = page
        end
        
        if #cfg.pages == 0 then activatePage() end
        
        tabButton.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                activatePage()
            end
        end)
        
        table.insert(cfg.pages, page)
        
        function page:AddColumn(side)
            local column = {}
            local columnWidth = side == "left" and 280 or 280
            local columnFrame = Asy:Create("Frame", {
                Parent = columnsContainer,
                BackgroundTransparency = 1,
                Size = UDim2.new(0, columnWidth, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y
            })
            
            Asy:Create("UIListLayout", {
                Parent = columnFrame,
                Padding = UDim.new(0, 8),
                SortOrder = Enum.SortOrder.LayoutOrder
            })
            
            column.columnFrame = columnFrame
            column.sections = {}
            
            function column:AddSection(options)
                local section = {name = options.name or "Section"}
                local sectionFrame = Asy:Create("Frame", {
                    Parent = columnFrame,
                    BackgroundColor3 = themes.background,
                    Size = UDim2.new(1, 0, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    BorderSizePixel = 0
                })
                
                local inline = Asy:Create("Frame", {
                    Parent = sectionFrame,
                    Position = UDim2.new(0, 1, 0, 1),
                    Size = UDim2.new(1, -2, 1, -2),
                    BackgroundColor3 = Color3.fromRGB(45, 45, 45),
                    BorderSizePixel = 0
                })
                
                local background = Asy:Create("Frame", {
                    Parent = inline,
                    Position = UDim2.new(0, 1, 0, 1),
                    Size = UDim2.new(1, -2, 1, -2),
                    BackgroundColor3 = themes.secondary,
                    BorderSizePixel = 0
                })
                
                local elements = Asy:Create("Frame", {
                    Parent = background,
                    Position = UDim2.new(0, 8, 0, 20),
                    Size = UDim2.new(1, -16, 1, -24),
                    BackgroundTransparency = 1
                })
                
                Asy:Create("UIListLayout", {
                    Parent = elements,
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    HorizontalAlignment = Enum.HorizontalAlignment.Center,
                    Padding = UDim.new(0, 6)
                })
                
                local sectionTitle = Asy:Create("TextLabel", {
                    Parent = sectionFrame,
                    FontFace = font,
                    TextColor3 = themes.text,
                    Text = section.name,
                    AutomaticSize = Enum.AutomaticSize.XY,
                    AnchorPoint = Vector2.new(0, 0.5),
                    Position = UDim2.new(0, 14, 0, 3),
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextSize = 12,
                    BackgroundColor3 = themes.secondary,
                    ZIndex = 2
                })
                
                local sectionFiller = Asy:Create("Frame", {
                    Parent = sectionFrame,
                    AnchorPoint = Vector2.new(0, 0.5),
                    Position = UDim2.new(0, 13, 0, 1),
                    Size = UDim2.new(0, sectionTitle.TextBounds.X, 0, 3),
                    BackgroundColor3 = themes.secondary,
                    BorderSizePixel = 0
                })
                
                section.elements = elements
                
                function section:AddButton(options)
                    local button = Asy:Create("TextButton", {
                        Parent = elements,
                        Size = UDim2.new(1, 0, 0, 25),
                        BackgroundColor3 = themes.background,
                        Text = options.text or "Button",
                        TextColor3 = themes.text,
                        TextSize = 12,
                        FontFace = font,
                        BorderSizePixel = 0,
                        AutoButtonColor = false
                    })
                    
                    local accent = Asy:Create("Frame", {
                        Parent = button,
                        Size = UDim2.new(0, 3, 1, 0),
                        BackgroundColor3 = themes.accent,
                        BorderSizePixel = 0
                    })
                    
                    button.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                            if options.callback then options.callback() end
                        end
                    end)
                    
                    if not Asy:IsMobile() then
                        button.MouseEnter:Connect(function() Asy:Tween(button, {BackgroundColor3 = Color3.fromRGB(25, 25, 25)}) end)
                        button.MouseLeave:Connect(function() Asy:Tween(button, {BackgroundColor3 = themes.background}) end)
                    end
                    return button
                end
                
                function section:AddToggle(options)
                    local toggle = {value = options.default or false, flag = options.flag}
                    local toggleFrame = Asy:Create("TextLabel", {
                        Parent = elements,
                        Size = UDim2.new(1, 0, 0, 12),
                        BackgroundTransparency = 1,
                        Text = "",
                        TextXAlignment = Enum.TextXAlignment.Left,
                        AutomaticSize = Enum.AutomaticSize.Y
                    })
                    
                    local leftComponents = Asy:Create("Frame", {
                        Parent = toggleFrame,
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 3, 0, 1),
                        Size = UDim2.new(0, 0, 0, 14)
                    })
                    
                    Asy:Create("UIListLayout", {
                        Parent = leftComponents,
                        Padding = UDim.new(0, 8),
                        FillDirection = Enum.FillDirection.Horizontal
                    })
                    
                    local toggleButton = Asy:Create("TextButton", {
                        Parent = leftComponents,
                        Text = "",
                        Position = UDim2.new(0, 0, 0, 2),
                        Size = UDim2.new(0, 8, 0, 8),
                        BackgroundColor3 = Color3.fromRGB(2, 2, 2),
                        BorderSizePixel = 0,
                        AutoButtonColor = false
                    })
                    
                    local toggleInline = Asy:Create("Frame", {
                        Parent = toggleButton,
                        Position = UDim2.new(0, 1, 0, 1),
                        Size = UDim2.new(1, -2, 1, -2),
                        BackgroundColor3 = Color3.fromRGB(63, 63, 63),
                        BorderSizePixel = 0
                    })
                    
                    local toggleAccent = Asy:Create("Frame", {
                        Parent = toggleInline,
                        Visible = false,
                        BackgroundColor3 = themes.accent,
                        Size = UDim2.new(1, 0, 1, 0),
                        BorderSizePixel = 0
                    })
                    
                    local toggleText = Asy:Create("TextButton", {
                        Parent = leftComponents,
                        FontFace = font,
                        TextColor3 = themes.text_secondary,
                        Text = options.text or "Toggle",
                        BackgroundTransparency = 1,
                        Size = UDim2.new(0, 0, 1, -1),
                        BorderSizePixel = 0,
                        AutomaticSize = Enum.AutomaticSize.X,
                        TextSize = 11
                    })
                    
                    local function updateToggle()
                        toggleAccent.Visible = toggle.value
                        if options.callback then options.callback(toggle.value) end
                        if toggle.flag then Asy.flags[toggle.flag] = toggle.value end
                    end
                    
                    local function onToggle()
                        toggle.value = not toggle.value
                        updateToggle()
                    end
                    
                    toggleButton.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                            onToggle()
                        end
                    end)
                    
                    toggleText.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                            onToggle()
                        end
                    end)
                    
                    updateToggle()
                    
                    function toggle:Set(value)
                        toggle.value = value
                        updateToggle()
                    end
                    return toggle
                end
                
                function section:AddSlider(options)
                    local slider = {value = options.default or options.min, min = options.min or 0, max = options.max or 100, flag = options.flag}
                    local sliderFrame = Asy:Create("TextLabel", {
                        Parent = elements,
                        Size = UDim2.new(1, 0, 0, 45),
                        BackgroundTransparency = 1,
                        Text = "",
                        TextXAlignment = Enum.TextXAlignment.Left,
                        AutomaticSize = Enum.AutomaticSize.None
                    })
                    
                    local bottomComponents = Asy:Create("Frame", {
                        Parent = sliderFrame,
                        Position = UDim2.new(0, 15, 0, 20),
                        Size = UDim2.new(1, -6, 0, 20),
                        BackgroundTransparency = 1
                    })
                    
                    local sliderDragger = Asy:Create("TextButton", {
                        Parent = bottomComponents,
                        AutoButtonColor = false,
                        Text = "",
                        Position = UDim2.new(0, 0, 0, 2),
                        Size = UDim2.new(1, -40, 1, 0),
                        BackgroundColor3 = Color3.fromRGB(1, 1, 1),
                        BorderSizePixel = 0
                    })
                    
                    local sliderBackground = Asy:Create("Frame", {
                        Parent = sliderDragger,
                        Position = UDim2.new(0, 1, 0, 1),
                        Size = UDim2.new(1, -2, 1, -2),
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BorderSizePixel = 0
                    })
                    
                    local sliderFill = Asy:Create("Frame", {
                        Parent = sliderBackground,
                        BackgroundColor3 = themes.accent,
                        Size = UDim2.new(0, 0, 1, 0),
                        BorderSizePixel = 0
                    })
                    
                    local sliderText = Asy:Create("TextLabel", {
                        Parent = bottomComponents,
                        FontFace = font,
                        TextColor3 = themes.text_secondary,
                        Text = "0",
                        AnchorPoint = Vector2.new(1, 0),
                        BackgroundTransparency = 1,
                        Position = UDim2.new(1, 0, 0, 0),
                        BorderSizePixel = 0,
                        AutomaticSize = Enum.AutomaticSize.X,
                        TextSize = 11
                    })
                    
                    Asy:Create("UIGradient", {
                        Parent = sliderBackground,
                        Rotation = 90,
                        Color = ColorSequence.new({
                            ColorSequenceKeypoint.new(0, Color3.fromRGB(63, 63, 63)),
                            ColorSequenceKeypoint.new(1, Color3.fromRGB(42, 42, 42))
                        })
                    })
                    
                    local leftComponents = Asy:Create("Frame", {
                        Parent = sliderFrame,
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 16, 0, 1),
                        Size = UDim2.new(0, 0, 0, 16)
                    })
                    
                    local text = Asy:Create("TextLabel", {
                        Parent = leftComponents,
                        FontFace = font,
                        TextColor3 = themes.text_secondary,
                        Text = options.text or "Slider",
                        BackgroundTransparency = 1,
                        Size = UDim2.new(0, 0, 1, -1),
                        BorderSizePixel = 0,
                        AutomaticSize = Enum.AutomaticSize.X,
                        TextSize = 11
                    })
                    
                    local function updateSlider()
                        local percentage = (slider.value - slider.min) / (slider.max - slider.min)
                        sliderFill.Size = UDim2.new(percentage, 0, 1, 0)
                        sliderText.Text = tostring(slider.value) .. (options.suffix or "")
                        if options.callback then options.callback(slider.value) end
                        if slider.flag then Asy.flags[slider.flag] = slider.value end
                    end
                    
                    local function onSliderInput(input)
                        local sliderPos = sliderDragger.AbsolutePosition
                        local sliderSize = sliderDragger.AbsoluteSize
                        local inputPos = input.Position
                        local relativeX = (inputPos.X - sliderPos.X) / sliderSize.X
                        relativeX = math.clamp(relativeX, 0, 1)
                        slider.value = math.floor(slider.min + (slider.max - slider.min) * relativeX)
                        updateSlider()
                    end
                    
                    sliderDragger.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                            onSliderInput(input)
                        end
                    end)
                    
                    sliderDragger.InputChanged:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                            onSliderInput(input)
                        end
                    end)
                    
                    updateSlider()
                    
                    function slider:Set(value)
                        slider.value = math.clamp(value, slider.min, slider.max)
                        updateSlider()
                    end
                    return slider
                end

                function section:AddTextBox(options)
                    local textbox = {value = options.default or "", flag = options.flag}
                    local textboxFrame = Asy:Create("TextLabel", {
                        Parent = elements,
                        Size = UDim2.new(1, 0, 0, 45),
                        BackgroundTransparency = 1,
                        Text = "",
                        TextXAlignment = Enum.TextXAlignment.Left,
                        AutomaticSize = Enum.AutomaticSize.None
                    })
                    
                    local bottomComponents = Asy:Create("Frame", {
                        Parent = textboxFrame,
                        Position = UDim2.new(0, 15, 0, 20),
                        Size = UDim2.new(1, -6, 0, 25),
                        BackgroundTransparency = 1
                    })
                    
                    local textboxOutline = Asy:Create("Frame", {
                        Parent = bottomComponents,
                        Size = UDim2.new(1, 0, 1, 0),
                        BackgroundColor3 = Color3.fromRGB(1, 1, 1),
                        BorderSizePixel = 0
                    })
                    
                    local textboxInline = Asy:Create("Frame", {
                        Parent = textboxOutline,
                        Position = UDim2.new(0, 1, 0, 1),
                        Size = UDim2.new(1, -2, 1, -2),
                        BackgroundColor3 = Color3.fromRGB(45, 45, 45),
                        BorderSizePixel = 0
                    })
                    
                    local textboxBackground = Asy:Create("Frame", {
                        Parent = textboxInline,
                        Position = UDim2.new(0, 1, 0, 1),
                        Size = UDim2.new(1, -2, 1, -2),
                        BackgroundColor3 = themes.secondary,
                        BorderSizePixel = 0
                    })
                    
                    local textboxInput = Asy:Create("TextBox", {
                        Parent = textboxBackground,
                        Size = UDim2.new(1, -8, 1, 0),
                        Position = UDim2.new(0, 4, 0, 0),
                        BackgroundTransparency = 1,
                        Text = textbox.value,
                        TextColor3 = themes.text,
                        TextSize = 11,
                        FontFace = font,
                        PlaceholderText = options.placeholder or "Enter text...",
                        PlaceholderColor3 = themes.text_secondary,
                        ClearTextOnFocus = false
                    })
                    
                    local leftComponents = Asy:Create("Frame", {
                        Parent = textboxFrame,
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 16, 0, 1),
                        Size = UDim2.new(0, 0, 0, 16)
                    })
                    
                    local text = Asy:Create("TextLabel", {
                        Parent = leftComponents,
                        FontFace = font,
                        TextColor3 = themes.text_secondary,
                        Text = options.text or "Text Box",
                        BackgroundTransparency = 1,
                        Size = UDim2.new(0, 0, 1, -1),
                        BorderSizePixel = 0,
                        AutomaticSize = Enum.AutomaticSize.X,
                        TextSize = 11
                    })
                    
                    textboxInput.FocusLost:Connect(function()
                        textbox.value = textboxInput.Text
                        if options.callback then options.callback(textbox.value) end
                        if textbox.flag then Asy.flags[textbox.flag] = textbox.value end
                    end)
                    
                    function textbox:Set(value)
                        textbox.value = value
                        textboxInput.Text = value
                        if options.callback then options.callback(value) end
                        if textbox.flag then Asy.flags[textbox.flag] = value end
                    end
                    
                    return textbox
                end

                function section:AddList(options)
                    local list = {value = options.default or options.items[1], items = options.items, flag = options.flag}
                    local listFrame = Asy:Create("TextLabel", {
                        Parent = elements,
                        Size = UDim2.new(1, 0, 0, 0),
                        BackgroundTransparency = 1,
                        Text = "",
                        TextXAlignment = Enum.TextXAlignment.Left,
                        AutomaticSize = Enum.AutomaticSize.Y
                    })
                    
                    local listTitle = Asy:Create("TextLabel", {
                        Parent = listFrame,
                        FontFace = font,
                        TextColor3 = themes.text_secondary,
                        Text = options.text or "List",
                        BackgroundTransparency = 1,
                        Size = UDim2.new(1, 0, 0, 16),
                        Position = UDim2.new(0, 0, 0, 0),
                        TextXAlignment = Enum.TextXAlignment.Left,
                        TextSize = 11
                    })
                    
                    local listContainer = Asy:Create("ScrollingFrame", {
                        Parent = listFrame,
                        Size = UDim2.new(1, 0, 0, 175),
                        Position = UDim2.new(0, 0, 0, 20),
                        BackgroundColor3 = themes.secondary,
                        BorderSizePixel = 0,
                        ScrollBarThickness = 4,
                        ScrollBarImageColor3 = themes.accent,
                        CanvasSize = UDim2.new(0, 0, 0, 0),
                        AutomaticCanvasSize = Enum.AutomaticSize.Y
                    })
                    
                    local listOutline = Asy:Create("Frame", {
                        Parent = listContainer,
                        Position = UDim2.new(0, 1, 0, 1),
                        Size = UDim2.new(1, -2, 1, -2),
                        BackgroundColor3 = Color3.fromRGB(45, 45, 45),
                        BorderSizePixel = 0
                    })
                    
                    local listBackground = Asy:Create("Frame", {
                        Parent = listOutline,
                        Position = UDim2.new(0, 1, 0, 1),
                        Size = UDim2.new(1, -2, 1, -2),
                        BackgroundColor3 = themes.secondary,
                        BorderSizePixel = 0
                    })
                    
                    local itemsContainer = Asy:Create("Frame", {
                        Parent = listBackground,
                        Size = UDim2.new(1, -8, 1, -8),
                        Position = UDim2.new(0, 4, 0, 4),
                        BackgroundTransparency = 1
                    })
                    
                    Asy:Create("UIListLayout", {
                        Parent = itemsContainer,
                        SortOrder = Enum.SortOrder.LayoutOrder,
                        Padding = UDim.new(0, 2)
                    })
                    
                    local function updateList()
                        if options.callback then 
                            options.callback(list.value) 
                        end
                        if list.flag then 
                            Asy.flags[list.flag] = list.value 
                        end
                    end
                    
                    local function populateList()
                        for _, child in ipairs(itemsContainer:GetChildren()) do
                            if child:IsA("TextButton") then
                                child:Destroy()
                            end
                        end
                        
                        for _, item in ipairs(list.items) do
                            local isSelected = list.value == item
                            
                            local itemButton = Asy:Create("TextButton", {
                                Parent = itemsContainer,
                                Size = UDim2.new(1, 0, 0, 25),
                                BackgroundColor3 = isSelected and themes.accent or themes.background,
                                Text = item,
                                TextColor3 = isSelected and themes.background or themes.text,
                                TextSize = 11,
                                FontFace = font,
                                AutoButtonColor = false,
                                BorderSizePixel = 0
                            })
                            
                            local function onItemSelect()
                                list.value = item
                                updateList()
                                populateList()
                            end
                            
                            itemButton.MouseButton1Down:Connect(onItemSelect)
                            
                            if Asy:IsMobile() then
                                itemButton.TouchTap:Connect(onItemSelect)
                            end
                            
                            if not Asy:IsMobile() then
                                itemButton.MouseEnter:Connect(function()
                                    if not isSelected then
                                        Asy:Tween(itemButton, {BackgroundColor3 = Color3.fromRGB(35, 35, 35)})
                                    end
                                end)
                                
                                itemButton.MouseLeave:Connect(function()
                                    if not isSelected then
                                        Asy:Tween(itemButton, {BackgroundColor3 = themes.background})
                                    end
                                end)
                            end
                        end
                    end
                    
                    populateList()
                    updateList()
                    
                    function list:Set(value)
                        if table.find(list.items, value) then
                            list.value = value
                            populateList()
                            updateList()
                        end
                    end
                    
                    return list
                end

                function section:AddColorPicker(options)
                    local colorPicker = {color = options.default or Color3.new(1, 1, 1), flag = options.flag}
                    local colorPickerFrame = Asy:Create("TextLabel", {
                        Parent = elements,
                        Size = UDim2.new(1, 0, 0, 45),
                        BackgroundTransparency = 1,
                        Text = "",
                        TextXAlignment = Enum.TextXAlignment.Left,
                        AutomaticSize = Enum.AutomaticSize.None
                    })
                    
                    local bottomComponents = Asy:Create("Frame", {
                        Parent = colorPickerFrame,
                        Position = UDim2.new(0, 15, 0, 20),
                        Size = UDim2.new(1, -6, 0, 25),
                        BackgroundTransparency = 1
                    })
                    
                    local colorButton = Asy:Create("TextButton", {
                        Parent = bottomComponents,
                        Size = UDim2.new(0, 40, 1, 0),
                        BackgroundColor3 = colorPicker.color,
                        BorderSizePixel = 0,
                        AutoButtonColor = false
                    })
                    
                    local colorOutline = Asy:Create("Frame", {
                        Parent = colorButton,
                        Position = UDim2.new(0, 1, 0, 1),
                        Size = UDim2.new(1, -2, 1, -2),
                        BackgroundColor3 = Color3.fromRGB(45, 45, 45),
                        BorderSizePixel = 0
                    })
                    
                    local colorDisplay = Asy:Create("Frame", {
                        Parent = colorOutline,
                        Position = UDim2.new(0, 1, 0, 1),
                        Size = UDim2.new(1, -2, 1, -2),
                        BackgroundColor3 = colorPicker.color,
                        BorderSizePixel = 0
                    })
                    
                    local leftComponents = Asy:Create("Frame", {
                        Parent = colorPickerFrame,
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 16, 0, 1),
                        Size = UDim2.new(0, 0, 0, 16)
                    })
                    
                    local text = Asy:Create("TextLabel", {
                        Parent = leftComponents,
                        FontFace = font,
                        TextColor3 = themes.text_secondary,
                        Text = options.text or "Color Picker",
                        BackgroundTransparency = 1,
                        Size = UDim2.new(0, 0, 1, -1),
                        BorderSizePixel = 0,
                        AutomaticSize = Enum.AutomaticSize.X,
                        TextSize = 11
                    })
                    
                    local colorPickerWindow = Asy:Create("Frame", {
                        Parent = screenGui,
                        Size = UDim2.new(0, 200, 0, 180),
                        Position = UDim2.new(0, colorButton.AbsolutePosition.X, 0, colorButton.AbsolutePosition.Y + colorButton.AbsoluteSize.Y),
                        BackgroundColor3 = themes.background,
                        BorderSizePixel = 0,
                        Visible = false,
                        ZIndex = 10
                    })
                    
                    local colorWheel = Asy:Create("Frame", {
                        Parent = colorPickerWindow,
                        Size = UDim2.new(0, 120, 0, 120),
                        Position = UDim2.new(0, 10, 0, 10),
                        BackgroundColor3 = Color3.new(1, 1, 1),
                        BorderSizePixel = 0
                    })
                    
                    local hueGradient = Asy:Create("UIGradient", {
                        Parent = colorWheel,
                        Rotation = 0,
                        Color = ColorSequence.new({
                            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
                            ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 255, 0)),
                            ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)),
                            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
                            ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 0, 255)),
                            ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 0, 255)),
                            ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
                        })
                    })
                    
                    local colorSelector = Asy:Create("Frame", {
                        Parent = colorWheel,
                        Size = UDim2.new(0, 6, 0, 6),
                        BackgroundColor3 = Color3.new(1, 1, 1),
                        BorderSizePixel = 1,
                        BorderColor3 = Color3.new(0, 0, 0),
                        ZIndex = 2
                    })
                    
                    local brightnessSlider = Asy:Create("Frame", {
                        Parent = colorPickerWindow,
                        Size = UDim2.new(0, 15, 0, 120),
                        Position = UDim2.new(0, 140, 0, 10),
                        BackgroundColor3 = Color3.new(1, 1, 1),
                        BorderSizePixel = 0
                    })
                    
                    local brightnessGradient = Asy:Create("UIGradient", {
                        Parent = brightnessSlider,
                        Rotation = 90,
                        Color = ColorSequence.new({
                            ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
                            ColorSequenceKeypoint.new(1, Color3.new(0, 0, 0))
                        })
                    })
                    
                    local brightnessSelector = Asy:Create("Frame", {
                        Parent = brightnessSlider,
                        Size = UDim2.new(1, 0, 0, 2),
                        BackgroundColor3 = Color3.new(1, 1, 1),
                        BorderSizePixel = 1,
                        BorderColor3 = Color3.new(0, 0, 0),
                        ZIndex = 2
                    })
                    
                    local hexInput = Asy:Create("TextBox", {
                        Parent = colorPickerWindow,
                        Size = UDim2.new(0, 80, 0, 20),
                        Position = UDim2.new(0, 10, 0, 140),
                        BackgroundColor3 = themes.secondary,
                        TextColor3 = themes.text,
                        TextSize = 11,
                        FontFace = font,
                        Text = "#FFFFFF",
                        PlaceholderText = "Hex Color",
                        ClearTextOnFocus = false
                    })
                    
                    local previewColor = Asy:Create("Frame", {
                        Parent = colorPickerWindow,
                        Size = UDim2.new(0, 50, 0, 20),
                        Position = UDim2.new(0, 100, 0, 140),
                        BackgroundColor3 = colorPicker.color,
                        BorderSizePixel = 0
                    })
                    
                    Asy.colorPickers[colorPickerWindow] = true
                    
                    local function updateColorFromWheel(position)
                        local wheelSize = colorWheel.AbsoluteSize
                        local wheelPos = colorWheel.AbsolutePosition
                        local x = (position.X - wheelPos.X) / wheelSize.X
                        local y = (position.Y - wheelPos.Y) / wheelSize.Y
                        x = math.clamp(x, 0, 1)
                        y = math.clamp(y, 0, 1)
                        
                        local h = (1 - y) * 360
                        local s = x
                        local v = 1
                        
                        local newColor = Color3.fromHSV(h/360, s, v)
                        colorPicker:Set(newColor)
                        hexInput.Text = "#" .. newColor:ToHex()
                        previewColor.BackgroundColor3 = newColor
                        
                        colorSelector.Position = UDim2.new(x, -3, y, -3)
                    end
                    
                    local function updateColorFromBrightness(position)
                        local sliderSize = brightnessSlider.AbsoluteSize
                        local sliderPos = brightnessSlider.AbsolutePosition
                        local y = (position.Y - sliderPos.Y) / sliderSize.Y
                        y = math.clamp(y, 0, 1)
                        
                        local currentColor = colorPicker.color
                        local h, s, _ = currentColor:ToHSV()
                        local newColor = Color3.fromHSV(h, s, 1-y)
                        colorPicker:Set(newColor)
                        hexInput.Text = "#" .. newColor:ToHex()
                        previewColor.BackgroundColor3 = newColor
                        
                        brightnessSelector.Position = UDim2.new(0, 0, y, -1)
                    end
                    
                    colorButton.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                            for picker, _ in pairs(Asy.colorPickers) do
                                if picker:IsA("Frame") and picker ~= colorPickerWindow then
                                    picker.Visible = false
                                end
                            end
                            colorPickerWindow.Visible = not colorPickerWindow.Visible
                        end
                    end)
                    
                    colorWheel.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                            updateColorFromWheel(input.Position)
                        end
                    end)
                    
                    colorWheel.InputChanged:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                            updateColorFromWheel(input.Position)
                        end
                    end)
                    
                    brightnessSlider.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                            updateColorFromBrightness(input.Position)
                        end
                    end)
                    
                    brightnessSlider.InputChanged:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                            updateColorFromBrightness(input.Position)
                        end
                    end)
                    
                    hexInput.FocusLost:Connect(function()
                        local hex = hexInput.Text:gsub("#", "")
                        if #hex == 6 then
                            local success, color = pcall(function()
                                return Color3.fromHex(hex)
                            end)
                            if success then
                                colorPicker:Set(color)
                                previewColor.BackgroundColor3 = color
                            end
                        end
                    end)
                    
                    function colorPicker:Set(color)
                        colorPicker.color = color
                        colorDisplay.BackgroundColor3 = color
                        colorButton.BackgroundColor3 = color
                        previewColor.BackgroundColor3 = color
                        hexInput.Text = "#" .. color:ToHex()
                        if options.callback then options.callback(color) end
                        if colorPicker.flag then Asy.flags[colorPicker.flag] = color end
                    end
                    
                    return colorPicker
                end
                
                return section
            end
            return column
        end
        return page
    end
    return cfg
end

return Asy

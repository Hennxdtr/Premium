--[[
    HennHub
    Compact Custom UI
    Auto Farm + Auto Collect
    Fully custom UI, no external UI library
]]

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local old = playerGui:FindFirstChild("HennHubCustom")
if old then old:Destroy() end

local C = {
    bg = Color3.fromRGB(25,27,33),
    panel = Color3.fromRGB(32,35,43),
    panel2 = Color3.fromRGB(39,42,51),
    border = Color3.fromRGB(65,69,80),
    outline = Color3.fromRGB(220,223,230),
    text = Color3.fromRGB(230,232,238),
    muted = Color3.fromRGB(145,150,163),
    green = Color3.fromRGB(75,145,112),
    red = Color3.fromRGB(180,75,78),
    blue = Color3.fromRGB(75,115,155),
    grid = Color3.fromRGB(45,48,58)
}

local gui = Instance.new("ScreenGui")
gui.Name = "HennHubCustom"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = playerGui

local status = Instance.new("TextLabel")
status.Name = "InternalStatus"
status.Visible = false
status.Parent = gui

local function corner(obj,radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0,radius or 8)
    c.Parent = obj
end

local function stroke(obj,color)
    local s = Instance.new("UIStroke")
    s.Color = color or C.border
    s.Thickness = 1
    s.Parent = obj
end

local function label(parent,text,size,pos,textSize,color)
    local l = Instance.new("TextLabel")
    l.BackgroundTransparency = 1
    l.Size = size
    l.Position = pos
    l.Font = Enum.Font.Gotham
    l.Text = text
    l.TextSize = textSize or 12
    l.TextColor3 = color or C.text
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = parent
    return l
end

local function button(parent,text,size,pos,bg)
    local b = Instance.new("TextButton")
    b.Size = size
    b.Position = pos
    b.BackgroundColor3 = bg or C.panel2
    b.BorderSizePixel = 0
    b.AutoButtonColor = false
    b.Text = text
    b.TextColor3 = C.text
    b.TextSize = 12
    b.Font = Enum.Font.GothamMedium
    b.Parent = parent
    corner(b,7)
    return b
end

-- MAIN WINDOW
local main = Instance.new("Frame")
main.Name = "Main"
main.AnchorPoint = Vector2.new(.5,.5)
main.Position = UDim2.fromScale(.5,.5)
main.Size = UDim2.new(.92,0,.76,0)
main.BackgroundColor3 = C.bg
main.BorderSizePixel = 0
main.Parent = gui
corner(main,12)
stroke(main,C.border)

local constraint = Instance.new("UISizeConstraint")
constraint.MinSize = Vector2.new(300,340)
constraint.MaxSize = Vector2.new(500,440)
constraint.Parent = main

-- HEADER
local header = Instance.new("Frame")
header.Size = UDim2.new(1,0,0,42)
header.BackgroundColor3 = C.panel
header.BorderSizePixel = 0
header.Parent = main
corner(header,12)

local title = label(
    header,"HennHub",
    UDim2.new(0,100,1,0),
    UDim2.fromOffset(13,0),15,C.text
)
title.Font = Enum.Font.GothamBold

-- GROWBLOX TITLE REMOVED

local minimize = button(
    header,"-",UDim2.fromOffset(26,24),
    UDim2.new(1,-60,0,9)
)

local close = button(
    header,"×",UDim2.fromOffset(26,24),
    UDim2.new(1,-30,0,9),C.red
)

-- SINGLE TAB SIDEBAR
local sidebar = Instance.new("Frame")
sidebar.Position = UDim2.fromOffset(8,49)
sidebar.Size = UDim2.new(0,112,1,-57)
sidebar.BackgroundColor3 = C.panel
sidebar.BorderSizePixel = 0
sidebar.Parent = main
corner(sidebar,9)

label(
    sidebar,"MENU",
    UDim2.new(1,-16,0,25),
    UDim2.fromOffset(9,5),10,C.muted
)

local tab = button(
    sidebar,"Auto PnB",
    UDim2.new(1,-10,0,32),
    UDim2.fromOffset(5,33),C.blue
)
tab.TextSize = 10

local plantTab = button(sidebar,"Auto Farm",UDim2.new(1,-10,0,32),UDim2.fromOffset(5,70),C.panel2)
plantTab.TextSize = 10

local dfTab = button(
    sidebar,"Auto DF",
    UDim2.new(1,-10,0,32),
    UDim2.fromOffset(5,107),C.panel2
)
dfTab.TextSize = 10

local miscTab = button(
    sidebar,"Misc",
    UDim2.new(1,-10,0,32),
    UDim2.fromOffset(5,144),C.panel2
)
miscTab.TextSize = 10

local settingTab = button(sidebar,"Setting",UDim2.new(1,-10,0,32),UDim2.fromOffset(5,181),C.panel2)
settingTab.TextSize = 10

-- CONTENT
local content = Instance.new("Frame")
content.Position = UDim2.new(0,128,0,49)
content.Size = UDim2.new(1,-136,1,-57)
content.BackgroundColor3 = C.panel
content.BorderSizePixel = 0
content.Parent = main
corner(content,9)

local pageTitle = label(
    content,"AUTO PNB",
    UDim2.new(1,-18,0,29),
    UDim2.fromOffset(10,5),13,C.text
)
pageTitle.Font = Enum.Font.GothamBold

local page = Instance.new("ScrollingFrame")
page.Position = UDim2.fromOffset(7,37)
page.Size = UDim2.new(1,-14,1,-44)
page.BackgroundTransparency = 1
page.BorderSizePixel = 0
page.ScrollBarThickness = 3
page.ScrollBarImageColor3 = C.border
page.CanvasSize = UDim2.new(0,0,0,0)
page.Parent = content
local pnbPage = page

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0,7)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = page

layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    page.CanvasSize = UDim2.new(
        0,0,0,layout.AbsoluteContentSize.Y+8
    )
end)

local dfPage = Instance.new("ScrollingFrame")
dfPage.Position = UDim2.fromOffset(7,37)
dfPage.Size = UDim2.new(1,-14,1,-44)
dfPage.BackgroundTransparency = 1
dfPage.BorderSizePixel = 0
dfPage.ScrollBarThickness = 3
dfPage.ScrollBarImageColor3 = C.border
dfPage.CanvasSize = UDim2.new(0,0,0,0)
dfPage.Visible = false
dfPage.Parent = content

local dfLayout = Instance.new("UIListLayout")
dfLayout.Padding = UDim.new(0,7)
dfLayout.SortOrder = Enum.SortOrder.LayoutOrder
dfLayout.Parent = dfPage

dfLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    dfPage.CanvasSize = UDim2.new(0,0,0,dfLayout.AbsoluteContentSize.Y+8)
end)

local miscPage = Instance.new("ScrollingFrame")
miscPage.Position = UDim2.fromOffset(7,37)
miscPage.Size = UDim2.new(1,-14,1,-44)
miscPage.BackgroundTransparency = 1
miscPage.BorderSizePixel = 0
miscPage.ScrollBarThickness = 3
miscPage.ScrollBarImageColor3 = C.border
miscPage.CanvasSize = UDim2.new(0,0,0,0)
miscPage.Visible = false
miscPage.Parent = content

local miscLayout = Instance.new("UIListLayout")
miscLayout.Padding = UDim.new(0,7)
miscLayout.SortOrder = Enum.SortOrder.LayoutOrder
miscLayout.Parent = miscPage
miscLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    miscPage.CanvasSize = UDim2.new(0,0,0,miscLayout.AbsoluteContentSize.Y+8)
end)

local function newScrollPage()
    local f = Instance.new("ScrollingFrame")
    f.Position = UDim2.fromOffset(7,37)
    f.Size = UDim2.new(1,-14,1,-44)
    f.BackgroundTransparency = 1
    f.BorderSizePixel = 0
    f.ScrollBarThickness = 3
    f.ScrollBarImageColor3 = C.border
    f.CanvasSize = UDim2.new(0,0,0,0)
    f.Visible = false
    f.Parent = content
    local l = Instance.new("UIListLayout")
    l.Padding = UDim.new(0,7)
    l.SortOrder = Enum.SortOrder.LayoutOrder
    l.Parent = f
    l:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        f.CanvasSize = UDim2.new(0,0,0,l.AbsoluteContentSize.Y+8)
    end)
    return f
end
local plantPage = newScrollPage()
local settingPage = newScrollPage()

local function switchPage(which)
    local pages = {
        pnb = pnbPage, plant = plantPage, df = dfPage,
        misc = miscPage, setting = settingPage
    }
    for key, frame in pairs(pages) do frame.Visible = key == which end
    local names = {pnb="AUTO PNB", plant="AUTO FARM", df="AUTO DF", misc="MISC", setting="SETTING"}
    pageTitle.Text = names[which] or "HENNHUB"
    tab.BackgroundColor3 = which == "pnb" and C.blue or C.panel2
    plantTab.BackgroundColor3 = which == "plant" and C.blue or C.panel2
    dfTab.BackgroundColor3 = which == "df" and C.blue or C.panel2
    miscTab.BackgroundColor3 = which == "misc" and C.blue or C.panel2
    settingTab.BackgroundColor3 = which == "setting" and C.blue or C.panel2
end

tab.Activated:Connect(function() switchPage("pnb") end)
plantTab.Activated:Connect(function() switchPage("plant") end)
dfTab.Activated:Connect(function() switchPage("df") end)
miscTab.Activated:Connect(function() switchPage("misc") end)
settingTab.Activated:Connect(function() switchPage("setting") end)

-- SECTION: CENTERED TITLE, NO GRAY BACKGROUND
local function section(text)
    local box = Instance.new("Frame")
    box.Size = UDim2.new(1,-2,0,27)
    box.BackgroundTransparency = 1
    box.BorderSizePixel = 0
    box:SetAttribute("HennHubSection", true)
    box.Parent = page

    local heading = label(
        box,text,
        UDim2.new(1,-15,1,0),
        UDim2.fromOffset(9,0),10,C.text
    )
    heading.Font = Enum.Font.GothamBold
    heading.TextXAlignment = Enum.TextXAlignment.Center
end

local function makeInput(placeholder)
    local box = Instance.new("TextBox")
    box.Size = UDim2.new(1,-2,0,34)
    box.BackgroundColor3 = C.panel2
    box.BorderSizePixel = 0
    box.Text = ""
    box.PlaceholderText = placeholder
    box.PlaceholderColor3 = C.muted
    box.TextColor3 = C.text
    box.TextSize = 12
    box.Font = Enum.Font.Gotham
    box.ClearTextOnFocus = false
    box.Parent = page
    corner(box,7)
    stroke(box,C.outline)
    return box
end

local function makeToggle(name, callback)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1,-2,0,36)
    row.BackgroundColor3 = C.panel2
    row.BorderSizePixel = 0
    row.Parent = page
    corner(row,7)
    stroke(row,C.outline)

    label(
        row,name,
        UDim2.new(1,-60,1,0),
        UDim2.fromOffset(9,0),11,C.text
    )

    local state = false
    local btn = button(
        row,"OFF",
        UDim2.fromOffset(43,22),
        UDim2.new(1,-49,.5,-11),C.red
    )
    btn.TextSize = 10

    local function setState(on)
        state = on and true or false
        btn.Text = state and "ON" or "OFF"
        btn.BackgroundColor3 = state and C.green or C.red
        if callback then callback(state) end
    end

    btn.Activated:Connect(function()
        setState(not state)
    end)
    return setState
end

-- GRID 5x5
section("GRID")

local gridFrame = Instance.new("Frame")
gridFrame.Size = UDim2.new(1,-2,0,190)
gridFrame.BackgroundColor3 = C.panel2
gridFrame.BorderSizePixel = 0
gridFrame.Parent = page
corner(gridFrame,8)
    stroke(gridFrame,C.outline)

local gridHolder = Instance.new("Frame")
gridHolder.AnchorPoint = Vector2.new(.5,.5)
gridHolder.Position = UDim2.fromScale(.5,.5)
gridHolder.Size = UDim2.new(.85,0,.85,0)
gridHolder.BackgroundTransparency = 1
gridHolder.Parent = gridFrame

local gridLayout = Instance.new("UIGridLayout")
gridLayout.CellSize = UDim2.new(.18,0,.18,0)
gridLayout.CellPadding = UDim2.new(.02,0,.02,0)
gridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
gridLayout.VerticalAlignment = Enum.VerticalAlignment.Center
gridLayout.Parent = gridHolder

local selectedCells = {}

for row = -2,2 do
    for col = -2,2 do
        local cell = Instance.new("TextButton")
        cell.Name = "Cell_"..row.."_"..col
        -- Kunci urutan tampilan: kiri ke kanan, atas ke bawah.
        cell.LayoutOrder = (row + 2) * 5 + (col + 2) + 1
        cell.BorderSizePixel = 0
        cell.AutoButtonColor = false
        cell.Font = Enum.Font.GothamBold
        cell.TextSize = 10
        cell.Parent = gridHolder
        corner(cell,6)

        if row == 0 and col == 0 then
            cell.BackgroundColor3 = C.blue
            cell.Text = "KAMU"
            cell.TextColor3 = Color3.new(1,1,1)
            cell.Active = false
        else
            cell.BackgroundColor3 = C.grid
            cell.Text = ""
            selectedCells[row..","..col] = false

            cell.Activated:Connect(function()
                local key = row..","..col
                selectedCells[key] = not selectedCells[key]

                cell.BackgroundColor3 =
                    selectedCells[key] and C.green or C.grid
            end)
        end
    end
end

-- BLOCK ID
section("BLOCK")
local blockInput = makeInput("Block ID")

-- ATTACK SPEED
section("SPEED")

local speedRow = Instance.new("Frame")
speedRow.Size = UDim2.new(1,-2,0,45)
speedRow.BackgroundColor3 = C.panel2
speedRow.BorderSizePixel = 0
speedRow.Parent = page
corner(speedRow,7)
    stroke(speedRow,C.outline)

local speed = 0.22

label(
    speedRow,"DELAY",
    UDim2.new(0,65,0,18),
    UDim2.fromOffset(9,2),10,C.muted
)

local speedText = label(
    speedRow,"0.22s",
    UDim2.new(0,55,0,18),
    UDim2.new(1,-64,0,2),10,C.text
)
speedText.TextXAlignment = Enum.TextXAlignment.Right

local slider = Instance.new("TextButton")
slider.Size = UDim2.new(1,-18,0,7)
slider.Position = UDim2.fromOffset(9,29)
slider.BackgroundColor3 = C.border
slider.Text = ""
slider.Parent = speedRow
corner(slider,5)

local fill = Instance.new("Frame")
fill.Size = UDim2.new(.18,0,1,0)
fill.BackgroundColor3 = C.green
fill.BorderSizePixel = 0
fill.Parent = slider
corner(fill,5)

local draggingSlider = false

local function updateSpeed(x)
    local width = slider.AbsoluteSize.X
    if width <= 0 then return end

    local value = math.clamp(
        (x-slider.AbsolutePosition.X)/width,
        0,1
    )

    speed = math.floor((.05+value*.95)*100)/100
    fill.Size = UDim2.new(value,0,1,0)
    speedText.Text = string.format("%.2fs",speed)
end

slider.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        draggingSlider = true
        updateSpeed(input.Position.X)
    end
end)

UIS.InputChanged:Connect(function(input)
    if draggingSlider and (
        input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch
    ) then
        updateSpeed(input.Position.X)
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        draggingSlider = false
    end
end)

-- AUTO FARM
section("AUTO PNB")

local farmEnabled = false
local collectEnabled = false
local setCollectToggle

local farmRow = Instance.new("Frame")
farmRow.Size = UDim2.new(1,-2,0,36)
farmRow.BackgroundColor3 = C.panel2
farmRow.BorderSizePixel = 0
farmRow.Parent = page
corner(farmRow,7)
    stroke(farmRow,C.outline)

label(
    farmRow,"Auto Farm",
    UDim2.new(1,-60,1,0),
    UDim2.fromOffset(9,0),11,C.text
)

local farmButton = button(
    farmRow,"OFF",
    UDim2.fromOffset(43,22),
    UDim2.new(1,-49,.5,-11),C.red
)
farmButton.TextSize = 10

local function setFarmEnabled(on)
    farmEnabled = on and true or false
    farmButton.Text = farmEnabled and "ON" or "OFF"
    farmButton.BackgroundColor3 = farmEnabled and C.green or C.red
    if not farmEnabled and setCollectToggle then setCollectToggle(false) end
end
farmButton.Activated:Connect(function() setFarmEnabled(not farmEnabled) end)

-- AUTO COLLECT
section("COLLECT")
setCollectToggle = makeToggle("Auto Collect", function(on)
    if on and not farmEnabled then
        collectEnabled = false
        if setCollectToggle then setCollectToggle(false) end
    else
        collectEnabled = on
    end
end)

-- AUTO PLANT / HARVEST: controls live in the dedicated Auto Farm tab.
page = plantPage
section("AUTO PLANT")
local seedInput = makeInput("Seed ID")
local plantEnabled, harvestEnabled = false, false
local setPlantToggle, setHarvestToggle
setPlantToggle = makeToggle("Auto Plant", function(on)
    plantEnabled = on
end)
section("HARVEST")
local harvestInput = makeInput("Harvest ID")
setHarvestToggle = makeToggle("Harvest", function(on)
    harvestEnabled = on
end)
page = pnbPage

-- AUTO DF UI (separate tab)
local function dfSection(text)
    local box = Instance.new("Frame")
    box.Size = UDim2.new(1,-2,0,27)
    box.BackgroundTransparency = 1
    box.BorderSizePixel = 0
    box:SetAttribute("HennHubSection", true)
    box.Parent = dfPage
    local heading = label(box,text,UDim2.new(1,-15,1,0),UDim2.fromOffset(9,0),10,C.text)
    heading.Font = Enum.Font.GothamBold
    heading.TextXAlignment = Enum.TextXAlignment.Center
end

local function dfInfoRow(titleText)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1,-2,0,38)
    row.BackgroundColor3 = C.panel2
    row.BorderSizePixel = 0
    row.Parent = dfPage
    corner(row,7)
    label(row,titleText,UDim2.new(.5,0,1,0),UDim2.fromOffset(9,0),11,C.muted)
    local value = label(row,"--",UDim2.new(.5,-12,1,0),UDim2.new(.5,0,0,0),12,C.text)
    value.TextXAlignment = Enum.TextXAlignment.Right
    value.Font = Enum.Font.GothamBold
    stroke(row,C.outline)
    return value
end

dfSection("POSITION")
local dfXValue = dfInfoRow("X")
local dfYValue = dfInfoRow("Y")
dfSection("DIRT")
local dfDescription = Instance.new("TextLabel")
dfDescription.Size = UDim2.new(1,-2,0,54)
dfDescription.BackgroundColor3 = C.panel2
dfDescription.BorderSizePixel = 0
dfDescription.Font = Enum.Font.Gotham
dfDescription.TextSize = 10
dfDescription.TextColor3 = C.muted
dfDescription.TextWrapped = true
dfDescription.Text = "Area X: 1-98 | Lane Y: 38, 40, 42... sampai bawah. Arah lane bergantian kanan-kiri."
dfDescription.Parent = dfPage
corner(dfDescription,7)
    stroke(dfDescription,C.outline)
local dfStatus = dfInfoRow("STATUS")
local dfEnabled = false
local dfButton = button(dfPage,"START",UDim2.new(1,-2,0,36),UDim2.new(),C.green)
dfButton.TextSize = 11
local dfStopHint = label(dfPage,"Matikan tombol untuk menghentikan proses.",UDim2.new(1,-4,0,22),UDim2.new(),10,C.muted)
dfStopHint.TextXAlignment = Enum.TextXAlignment.Center

-- MISC: Anti Lava, GrowScan toggle + item ID lookup
-- Forward declarations agar callback UI mengakses local function yang benar.
local antiLavaOn = false
local startAntiLava, stopAntiLava

local function miscSection(text)
    local box = Instance.new("Frame")
    box.Size = UDim2.new(1,-2,0,27)
    box.BackgroundTransparency = 1
    box.BorderSizePixel = 0
    box:SetAttribute("HennHubSection", true)
    box.Parent = miscPage
    local heading = label(box,text,UDim2.new(1,-15,1,0),UDim2.fromOffset(9,0),10,C.text)
    heading.Font = Enum.Font.GothamBold
    heading.TextXAlignment = Enum.TextXAlignment.Center
end

miscSection("ANTI LAVA")
local antiLavaButton = button(miscPage,"LAVA: OFF",UDim2.new(1,-2,0,36),UDim2.new(),C.green)
antiLavaButton.TextSize = 11
local antiLavaHint = label(miscPage,"Mencegah efek hazard seperti lava, spike, dan api.",UDim2.new(1,-4,0,27),UDim2.new(),10,C.muted)
antiLavaHint.TextXAlignment = Enum.TextXAlignment.Center

local function refreshAntiLavaButton()
    antiLavaButton.Text = antiLavaOn and "LAVA: ON" or "LAVA: OFF"
    antiLavaButton.BackgroundColor3 = antiLavaOn and C.red or C.green
end

antiLavaButton.Activated:Connect(function()
    if antiLavaOn then
        stopAntiLava()
        antiLavaHint.Text = "Anti Lava dimatikan. Pengaturan hazard dipulihkan."
    else
        local ok, reason = startAntiLava()
        if ok then
            antiLavaHint.Text = "Aktif: perlindungan hazard lokal dinyalakan."
        else
            antiLavaHint.Text = reason or "Anti Lava gagal diaktifkan."
        end
    end
    refreshAntiLavaButton()
end)

miscSection("GROWSCAN")
local growScanButton = button(miscPage,"OPEN GROWSCAN",UDim2.new(1,-2,0,36),UDim2.new(),C.green)
growScanButton.TextSize = 11
local growScanHint = label(miscPage,"Buka atau tutup UI GrowScan bawaan game.",UDim2.new(1,-4,0,24),UDim2.new(),10,C.muted)
growScanHint.TextXAlignment = Enum.TextXAlignment.Center
miscSection("ITEM ID")
local miscItemInput = Instance.new("TextBox")
miscItemInput.Size = UDim2.new(1,-2,0,34)
miscItemInput.BackgroundColor3 = C.panel2
miscItemInput.BorderSizePixel = 0
miscItemInput.Text = ""
miscItemInput.PlaceholderText = "Masukkan nama item, contoh: dirt"
miscItemInput.PlaceholderColor3 = C.muted
miscItemInput.TextColor3 = C.text
miscItemInput.TextSize = 11
miscItemInput.Font = Enum.Font.Gotham
miscItemInput.ClearTextOnFocus = false
miscItemInput.Parent = miscPage
corner(miscItemInput,7)
stroke(miscItemInput,C.outline)
local checkIdButton = button(miscPage,"ITEM ID",UDim2.new(1,-2,0,34),UDim2.new(),C.blue)
checkIdButton.TextSize = 11
local itemIdResult = Instance.new("TextLabel")
itemIdResult.Size = UDim2.new(1,-2,0,48)
itemIdResult.BackgroundColor3 = C.panel2
itemIdResult.BorderSizePixel = 0
itemIdResult.Font = Enum.Font.Gotham
itemIdResult.Text = "Hasil ID akan muncul di sini."
itemIdResult.TextColor3 = C.muted
itemIdResult.TextSize = 11
itemIdResult.TextWrapped = true
itemIdResult.Parent = miscPage
corner(itemIdResult,7)
    stroke(itemIdResult,C.outline)

-- SETTING: named configs with persistent storage (executor file APIs)
local function settingSection(text)
    local h = label(settingPage,text,UDim2.new(1,-4,0,25),UDim2.new(),10,C.text)
    h:SetAttribute("HennHubSection", true)
    h.Font = Enum.Font.GothamBold
    h.TextXAlignment = Enum.TextXAlignment.Center
end
local function settingInput(placeholder)
    local box = Instance.new("TextBox")
    box.Size = UDim2.new(1,-2,0,34)
    box.BackgroundColor3 = C.panel2
    box.BorderSizePixel = 0
    box.Text = ""
    box.PlaceholderText = placeholder
    box.PlaceholderColor3 = C.muted
    box.TextColor3 = C.text
    box.TextSize = 11
    box.Font = Enum.Font.Gotham
    box.ClearTextOnFocus = false
    box.Parent = settingPage
    corner(box,7); stroke(box,C.outline)
    return box
end
settingSection("CONFIGURATION MANAGER")
local configNameInput = settingInput("Nama config, contoh: Farm-01")
local configLoadInput = settingInput("Nama config yang ingin di-load")
local configStatus = label(settingPage,"Config belum disimpan.",UDim2.new(1,-4,0,32),UDim2.new(),10,C.muted)
configStatus.TextWrapped = true
local saveConfigButton = button(settingPage,"SAVE",UDim2.new(1,-2,0,34),UDim2.new(),C.blue)
local loadConfigButton = button(settingPage,"LOAD",UDim2.new(1,-2,0,34),UDim2.new(),C.green)
local autoLoadButton = button(settingPage,"AUTO LOAD: OFF",UDim2.new(1,-2,0,34),UDim2.new(),C.red)
local autoLoadEnabled = false
local CONFIG_DIR = "HennHub/Configs"
local AUTO_FILE = "HennHub/auto-load.json"
local HttpService = game:GetService("HttpService")
local function storageReady()
    return type(makefolder)=="function" and type(writefile)=="function"
        and type(readfile)=="function" and type(isfile)=="function"
end
local function ensureConfigFolder()
    if type(isfolder)=="function" then
        if not isfolder("HennHub") then pcall(makefolder,"HennHub") end
        if not isfolder(CONFIG_DIR) then pcall(makefolder,CONFIG_DIR) end
    else
        pcall(makefolder,"HennHub")
        pcall(makefolder,CONFIG_DIR)
    end
end
local function cleanConfigName(name)
    name = tostring(name or ""):gsub("[^%w%-%_ ]", ""):gsub("^%s+", ""):gsub("%s+$", "")
    return name:sub(1,32)
end
local function configPath(name) return CONFIG_DIR.."/"..name..".json" end
local function captureConfig()
    local grid = {}
    for key, enabled in pairs(selectedCells) do if enabled then grid[#grid+1] = key end end
    return {
        blockId=blockInput.Text, seedId=seedInput.Text, harvestId=harvestInput.Text,
        speed=speed, selectedCells=grid,
        farmEnabled=farmEnabled, collectEnabled=collectEnabled,
        plantEnabled=plantEnabled, harvestEnabled=harvestEnabled
    }
end
local function applyConfig(data)
    if type(data)~="table" then return false,"Format config tidak valid" end
    blockInput.Text = tostring(data.blockId or "")
    seedInput.Text = tostring(data.seedId or "")
    harvestInput.Text = tostring(data.harvestId or "")
    if type(data.speed)=="number" then
        speed = math.clamp(data.speed,0.05,1)
        speedText.Text = string.format("%.2fs",speed)
        local ratio = math.clamp((speed-0.05)/0.95,0,1)
        fill.Size = UDim2.new(ratio,0,1,0)
    end
    for key in pairs(selectedCells) do selectedCells[key] = false end
    for _, key in ipairs(type(data.selectedCells)=="table" and data.selectedCells or {}) do
        if selectedCells[key] ~= nil then selectedCells[key] = true end
    end
    for _, cell in ipairs(gridHolder:GetChildren()) do
        if cell:IsA("TextButton") and cell.Name:match("^Cell_") then
            local row,col = cell.Name:match("Cell_([^_]+)_([^_]+)")
            local key = tostring(row)..","..tostring(col)
            if selectedCells[key] ~= nil then cell.BackgroundColor3 = selectedCells[key] and C.green or C.grid end
        end
    end
    if setFarmEnabled then setFarmEnabled(data.farmEnabled == true) end
    if setCollectToggle then setCollectToggle(data.collectEnabled == true) end
    if setPlantToggle then setPlantToggle(data.plantEnabled == true) end
    if setHarvestToggle then setHarvestToggle(data.harvestEnabled == true) end
    return true
end
local function loadNamedConfig(name)
    if not storageReady() then return false,"Executor tidak menyediakan file API" end
    name = cleanConfigName(name)
    if name == "" then return false,"Masukkan nama config" end
    local path = configPath(name)
    if not isfile(path) then return false,"Config tidak ditemukan: "..name end
    local ok, data = pcall(function() return HttpService:JSONDecode(readfile(path)) end)
    if not ok then return false,"File config rusak" end
    local applied, reason = applyConfig(data)
    if applied then configLoadInput.Text = name end
    return applied, reason
end
saveConfigButton.Activated:Connect(function()
    if not storageReady() then configStatus.Text = "Executor tidak mendukung writefile/readfile/makefolder." return end
    local name = cleanConfigName(configNameInput.Text)
    if name == "" then configStatus.Text = "Isi nama config terlebih dahulu." return end
    local ok, err = pcall(function()
        ensureConfigFolder()
        writefile(configPath(name),HttpService:JSONEncode(captureConfig()))
    end)
    configStatus.Text = ok and ("Tersimpan: "..name) or ("Gagal save: "..tostring(err))
    if ok then configLoadInput.Text = name end
end)
loadConfigButton.Activated:Connect(function()
    local ok, reason = loadNamedConfig(configLoadInput.Text)
    configStatus.Text = ok and ("Berhasil load: "..cleanConfigName(configLoadInput.Text)) or tostring(reason)
end)
autoLoadButton.Activated:Connect(function()
    if not storageReady() then configStatus.Text = "Executor tidak mendukung penyimpanan file." return end
    autoLoadEnabled = not autoLoadEnabled
    autoLoadButton.Text = autoLoadEnabled and "AUTO LOAD: ON" or "AUTO LOAD: OFF"
    autoLoadButton.BackgroundColor3 = autoLoadEnabled and C.green or C.red
    pcall(function()
        ensureConfigFolder()
        if autoLoadEnabled then
            local name = cleanConfigName(configLoadInput.Text ~= "" and configLoadInput.Text or configNameInput.Text)
            if name == "" then error("Pilih nama config untuk Auto Load") end
            writefile(AUTO_FILE,HttpService:JSONEncode({name=name,enabled=true}))
            configStatus.Text = "Auto Load aktif untuk: "..name
        else
            writefile(AUTO_FILE,HttpService:JSONEncode({enabled=false}))
            configStatus.Text = "Auto Load dimatikan."
        end
    end)
end)
-- Restore selected config on each script execution. The executor must still auto-execute this script.
task.defer(function()
    if not storageReady() then return end
    pcall(function()
        ensureConfigFolder()
        if isfile(AUTO_FILE) then
            local state = HttpService:JSONDecode(readfile(AUTO_FILE))
            if type(state)=="table" and state.enabled and state.name then
                autoLoadEnabled = true
                autoLoadButton.Text = "AUTO LOAD: ON"
                autoLoadButton.BackgroundColor3 = C.green
                local ok, reason = loadNamedConfig(state.name)
                configStatus.Text = ok and ("Auto-loaded: "..state.name) or tostring(reason)
            end
        end
    end)
end)

-- HANDMADE GROUPBOX LAYOUT (no external UI library)
-- Rebuilds each tab into rounded cards and balanced left/right columns.
local function makeGroupCard(parent, titleText, items, width)
    local card = Instance.new("Frame")
    card.Name = "Group_" .. tostring(titleText):gsub("%W+", "")
    card.Size = width or UDim2.new(1, -6, 0, 0)
    card.AutomaticSize = Enum.AutomaticSize.Y
    card.BackgroundColor3 = Color3.fromRGB(30, 34, 43)
    card.BorderSizePixel = 0
    card.Parent = parent
    corner(card, 9)
    stroke(card, C.outline)

    local pad = Instance.new("UIPadding")
    pad.PaddingTop = UDim.new(0, 8)
    pad.PaddingBottom = UDim.new(0, 8)
    pad.PaddingLeft = UDim.new(0, 8)
    pad.PaddingRight = UDim.new(0, 8)
    pad.Parent = card

    local cardLayout = Instance.new("UIListLayout")
    cardLayout.Padding = UDim.new(0, 6)
    cardLayout.SortOrder = Enum.SortOrder.LayoutOrder
    cardLayout.Parent = card

    local heading = Instance.new("TextLabel")
    heading.Name = "GroupTitle"
    heading.Size = UDim2.new(1, -16, 0, 18)
    heading.BackgroundTransparency = 1
    heading.Font = Enum.Font.GothamBold
    heading.Text = tostring(titleText):upper()
    heading.TextSize = 10
    heading.TextColor3 = C.blue
    heading.TextXAlignment = Enum.TextXAlignment.Left
    heading.Parent = card

    local body = Instance.new("Frame")
    body.Name = "GroupContent"
    body.Size = UDim2.new(1, -16, 0, 0)
    body.AutomaticSize = Enum.AutomaticSize.Y
    body.BackgroundTransparency = 1
    body.Parent = card

    local bodyLayout = Instance.new("UIListLayout")
    bodyLayout.Padding = UDim.new(0, 5)
    bodyLayout.SortOrder = Enum.SortOrder.LayoutOrder
    bodyLayout.Parent = body

    for index, item in ipairs(items) do
        item.LayoutOrder = index
        item.Parent = body
        if item:IsA("GuiObject") then
            item.Position = UDim2.new(0, 0, 0, 0)
            item.Size = UDim2.new(1, 0, item.Size.Y.Scale, item.Size.Y.Offset)
        end
    end
    return card
end

local function rebuildAsGroupboxes(scroll, pageName)
    local original = scroll:GetChildren()
    local groups, current = {}, nil

    -- Remove the old single-column list layout before moving controls.
    for _, child in ipairs(original) do
        if child:IsA("UIListLayout") then child:Destroy() end
    end

    for _, child in ipairs(original) do
        if child.Parent == scroll and child:GetAttribute("HennHubSection") then
            local titleText = child:IsA("TextLabel") and child.Text or "SECTION"
            if child:IsA("Frame") then
                local titleLabel = child:FindFirstChildWhichIsA("TextLabel")
                if titleLabel then titleText = titleLabel.Text end
            end
            current = {title = titleText, items = {}}
            table.insert(groups, current)
            child:Destroy()
        elseif child.Parent == scroll and child:IsA("GuiObject") then
            if not current then
                current = {title = "GENERAL", items = {}}
                table.insert(groups, current)
            end
            table.insert(current.items, child)
        end
    end

    local rootLayout = Instance.new("UIListLayout")
    rootLayout.Padding = UDim.new(0, 7)
    rootLayout.SortOrder = Enum.SortOrder.LayoutOrder
    rootLayout.Parent = scroll

    local fullWidthGroups = {}
    local columnGroups = {}
    for _, group in ipairs(groups) do
        if #group.items > 0 then
            if #groups == 1 or group.title:upper() == "GRID" then
                table.insert(fullWidthGroups, group)
            else
                table.insert(columnGroups, group)
            end
        end
    end

    local order = 0
    for _, group in ipairs(fullWidthGroups) do
        order += 1
        local card = makeGroupCard(scroll, group.title, group.items)
        card.LayoutOrder = order
    end

    if #columnGroups > 0 then
        local holder = Instance.new("Frame")
        holder.Name = "GroupboxColumns"
        holder.Size = UDim2.new(1, -6, 0, 0)
        holder.BackgroundTransparency = 1
        holder.BorderSizePixel = 0
        holder.LayoutOrder = order + 1
        holder.Parent = scroll

        local left = Instance.new("Frame")
        left.Name = "LeftColumn"
        left.Position = UDim2.new(0, 0, 0, 0)
        left.Size = UDim2.new(0.5, -5, 0, 0)
        left.AutomaticSize = Enum.AutomaticSize.Y
        left.BackgroundTransparency = 1
        left.Parent = holder

        local right = Instance.new("Frame")
        right.Name = "RightColumn"
        right.Position = UDim2.new(0.5, 5, 0, 0)
        right.Size = UDim2.new(0.5, -5, 0, 0)
        right.AutomaticSize = Enum.AutomaticSize.Y
        right.BackgroundTransparency = 1
        right.Parent = holder

        local leftLayout = Instance.new("UIListLayout")
        leftLayout.Padding = UDim.new(0, 7)
        leftLayout.SortOrder = Enum.SortOrder.LayoutOrder
        leftLayout.Parent = left
        local rightLayout = Instance.new("UIListLayout")
        rightLayout.Padding = UDim.new(0, 7)
        rightLayout.SortOrder = Enum.SortOrder.LayoutOrder
        rightLayout.Parent = right

        for index, group in ipairs(columnGroups) do
            local target = (index % 2 == 1) and left or right
            local card = makeGroupCard(target, group.title, group.items, UDim2.new(1, 0, 0, 0))
            card.LayoutOrder = math.ceil(index / 2)
        end

        local function updateColumns()
            local height = math.max(leftLayout.AbsoluteContentSize.Y, rightLayout.AbsoluteContentSize.Y)
            holder.Size = UDim2.new(1, -6, 0, height)
            scroll.CanvasSize = UDim2.new(0, 0, 0, rootLayout.AbsoluteContentSize.Y + 10)
        end
        leftLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateColumns)
        rightLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateColumns)
        holder:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateColumns)
    end

    rootLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        scroll.CanvasSize = UDim2.new(0, 0, 0, rootLayout.AbsoluteContentSize.Y + 10)
    end)
    task.defer(function()
        scroll.CanvasSize = UDim2.new(0, 0, 0, rootLayout.AbsoluteContentSize.Y + 10)
    end)
end

rebuildAsGroupboxes(pnbPage, "Auto PnB")
rebuildAsGroupboxes(plantPage, "Auto Farm")
rebuildAsGroupboxes(dfPage, "Auto DF")
rebuildAsGroupboxes(miscPage, "Misc")
rebuildAsGroupboxes(settingPage, "Setting")

-- FLOATING BUTTON
local openButton = button(
    gui,"H",
    UDim2.fromOffset(43,43),
    UDim2.new(0,14,.5,-20),
    C.panel
)

openButton.Visible = false
openButton.TextColor3 = C.green
openButton.TextSize = 20
openButton.Font = Enum.Font.GothamBold
corner(openButton,50)
stroke(openButton,C.green)

local function hideWindow()
    main.Visible = false
    openButton.Visible = true
end

local function showWindow()
    main.Visible = true
    openButton.Visible = false
end

minimize.Activated:Connect(hideWindow)
close.Activated:Connect(hideWindow)

-- DRAG HELPER
local function makeDraggable(target, handle)
    local dragging = false
    local dragStart, startPosition, activeInput

    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPosition = target.Position
            activeInput = input
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if dragging and (
            input == activeInput
            or input.UserInputType == Enum.UserInputType.MouseMovement
        ) then
            local delta = input.Position - dragStart
            target.Position = UDim2.new(
                startPosition.X.Scale, startPosition.X.Offset + delta.X,
                startPosition.Y.Scale, startPosition.Y.Offset + delta.Y
            )
        end
    end)

    UIS.InputEnded:Connect(function(input)
        if input == activeInput
        or input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
end

makeDraggable(main, header)
makeDraggable(openButton, openButton)

openButton.Activated:Connect(function()
    showWindow()
end)

----------------------------------------------------------------------
-- FUNGSI AUTO FARM + AUTO COLLECT
----------------------------------------------------------------------
local RS = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local gc = getgc or (debug and debug.getgc)
local getup = (debug and debug.getupvalue) or getupvalue

local function upvalues(fn)
    local t = {}
    if type(getup) ~= "function" or type(fn) ~= "function" then return t end
    for i = 1, 255 do
        local ok, v = pcall(getup, fn, i)
        if not ok then break end
        t[i] = v
    end
    return t
end

local cache = {}
local function scan(name, check)
    local c = cache[name]
    if c and check(c) then return c end
    if not gc then return nil end
    for _, o in ipairs(gc(true)) do
        if type(o) == "table" then
            local ok, valid = pcall(check, o)
            if ok and valid then cache[name] = o return o end
        end
    end
    return nil
end

local function getInventory()
    return scan("inv", function(t)
        return type(rawget(t, "onDrop")) == "function"
            and type(rawget(t, "canDrop")) == "function"
            and type(rawget(t, "isWorn")) == "function"
    end)
end

local function getWorld()
    return scan("world", function(t)
        return type(rawget(t, "enter")) == "function"
            and type(rawget(t, "dropOk")) == "function"
    end)
end

local itemDB
local function getDB()
    if itemDB then return itemDB end
    local ok, r = pcall(function()
        return require(RS:WaitForChild("Shared", 5):WaitForChild("ItemDB", 5))
    end)
    if ok and type(r) == "table" then itemDB = r end
    return itemDB
end

----------------------------------------------------------------------
-- ANTI LAVA / GOD MODE (mekanisme yang diadaptasi dari CIT)
-- Menonaktifkan flag bahaya pada ItemDB dan menahan handler Burned lokal.
----------------------------------------------------------------------
local antiLavaSaved = {}
local antiLavaConnections = {}

stopAntiLava = function()
    if not antiLavaOn then return false end

    for _, saved in ipairs(antiLavaSaved) do
        pcall(function()
            if saved.readonly and setreadonly then setreadonly(saved.item, false) end
            rawset(saved.item, saved.key, saved.value)
            if saved.readonly and setreadonly then setreadonly(saved.item, true) end
        end)
    end
    table.clear(antiLavaSaved)

    for _, connection in ipairs(antiLavaConnections) do
        pcall(function() connection:Enable() end)
    end
    table.clear(antiLavaConnections)

    antiLavaOn = false
    return true
end

startAntiLava = function()
    if antiLavaOn then return true end

    local db = getDB()
    if not db then
        return false, "ItemDB game tidak ditemukan."
    end

    table.clear(antiLavaSaved)
    table.clear(antiLavaConnections)

    for _, item in pairs(db) do
        if type(item) == "table" then
            for _, key in ipairs({ "hurts", "deadly" }) do
                local oldValue = rawget(item, key)
                if oldValue then
                    local wasReadonly = false
                    if type(isreadonly) == "function" then
                        local okReadonly, value = pcall(isreadonly, item)
                        wasReadonly = okReadonly and value == true
                    end
                    table.insert(antiLavaSaved, {
                        item = item,
                        key = key,
                        value = oldValue,
                        readonly = wasReadonly,
                    })
                    pcall(function()
                        if setreadonly then setreadonly(item, false) end
                        rawset(item, key, false)
                        if wasReadonly and setreadonly then setreadonly(item, true) end
                    end)
                end
            end
        end
    end

    local remotes = RS:FindFirstChild("WorldRemotes")
    local burned = remotes and remotes:FindFirstChild("Burned")
    if burned and type(getconnections) == "function" then
        local ok, connections = pcall(getconnections, burned.OnClientEvent)
        if ok and type(connections) == "table" then
            for _, connection in ipairs(connections) do
                if pcall(function() connection:Disable() end) then
                    table.insert(antiLavaConnections, connection)
                end
            end
        end
    end

    antiLavaOn = true
    return true
end

-- posisi tile pemain
local function getGrid()
    local inv = getInventory()
    if not inv or type(inv.canDrop) ~= "function" or type(inv.onDrop) ~= "function" then
        return nil
    end

    local okA, cd = pcall(upvalues, inv.canDrop)
    local okB, od = pcall(upvalues, inv.onDrop)
    if not okA or not okB or type(cd) ~= "table" or type(od) ~= "table" then
        return nil
    end

    local x, facing = cd[2], cd[3]
    if type(x) ~= "number" or type(facing) ~= "number" then return nil end

    local nums = {}
    for _, v in ipairs(od) do
        if type(v) == "number" then table.insert(nums, v) end
    end
    local y = nums[3]
    if type(y) ~= "number" then return nil end
    return x, y, (facing >= 0) and 1 or -1
end

local function getTile()
    local x, y = getGrid()
    if not x then return nil end
    return math.floor(x), math.floor(y - 0.475)
end

-- Posisi karakter untuk panel Auto DF, diperbarui berkala.
task.spawn(function()
    while gui.Parent do
        local x, y = getTile()
        dfXValue.Text = x and tostring(x) or "--"
        dfYValue.Text = y and tostring(y) or "--"
        task.wait(0.12)
    end
end)

local function worldName()
    local w = getWorld()
    local n = w and rawget(w, "name")
    return type(n) == "string" and n or ""
end

-- fungsi hit / setTile milik game
local gameFns = {}
local function findGameFn(name)
    if gameFns[name] then return gameFns[name] end
    local world = getWorld()
    if not world or not gc or not (debug and debug.info) then return nil end
    for _, fn in ipairs(gc(true)) do
        if type(fn) == "function" then
            local ok, n = pcall(debug.info, fn, "n")
            if ok and n == name then
                for _, v in pairs(upvalues(fn)) do
                    if v == world then gameFns[name] = fn return fn end
                end
            end
        end
    end
    return nil
end

local function getBag()
    local world = getWorld()
    if not world or type(rawget(world, "backpackNow")) ~= "function" then return nil end
    for _, v in pairs(upvalues(world.backpackNow)) do
        if type(v) == "table" and type(v.slots) == "table" then return v end
    end
    return nil
end

local function countItem(id)
    local bag = getBag()
    if not bag then return nil end
    local total = 0
    for _, s in pairs(bag.slots) do
        if type(s) == "table" and s.id == id then total += s.n or 0 end
    end
    return total
end

local function tileValue(world, layer, x, y)
    local grid = rawget(world, layer)
    local row = grid and grid[y]
    return row and row[x] or nil
end

local function inBounds(world, x, y)
    return type(world) == "table"
        and type(world.w) == "number"
        and type(world.h) == "number"
        and type(x) == "number" and type(y) == "number"
        and x >= 0 and y >= 0 and x < world.w and y < world.h
end

local function layerOf(id)
    local db = getDB()
    local item = db and db[id]
    if type(item) == "table" and item.background then return "bg" end
    return "fg"
end

-- Block ID: angka atau nama
local function resolveId(text)
    text = tostring(text):gsub("^%s+", ""):gsub("%s+$", ""):lower()
    if text == "" then return nil end
    local n = tonumber(text)
    local db = getDB()
    if not db then return nil end
    if n then
        local it = db[n]
        return (type(it) == "table" and type(it.name) == "string") and n or nil
    end
    local best, bestRank
    for id, it in pairs(db) do
        if type(id) == "number" and type(it) == "table" and type(it.name) == "string"
            and type(it.slot) ~= "string" then
            local nm = it.name:lower()
            local rank = (nm == text and 1) or (nm:sub(1, #text) == text and 2) or (nm:find(text, 1, true) and 3)
            if rank and (not bestRank or rank < bestRank) then best, bestRank = id, rank end
        end
    end
    return best
end

-- GrowScan bawaan game: tombol Misc men-toggle UI, bukan menjalankan chat command.
local growScanUiRef = nil
local growScanIsOpen = false
local function findGrowScanGui()
    local roots = { playerGui }
    local core = game:GetService("CoreGui")
    pcall(function() table.insert(roots, core) end)
    for _, root in ipairs(roots) do
        for _, obj in ipairs(root:GetDescendants()) do
            if obj:IsA("ScreenGui") then
                local n = obj.Name:lower()
                if n:find("grow", 1, true) or n:find("scan", 1, true) then
                    return obj
                end
            end
        end
    end
    return nil
end

local function setGrowScanOpen(wantOpen)
    local world = getWorld()
    local native = world and rawget(world, "growScan")
    if type(native) ~= "table" or type(native.open) ~= "function" then
        itemIdResult.Text = "GrowScan bawaan game belum tersedia."
        return false
    end

    if wantOpen then
        local beforeGuis = {}
        local rootsBefore = { playerGui }
        pcall(function() table.insert(rootsBefore, game:GetService("CoreGui")) end)
        for _, root in ipairs(rootsBefore) do
            pcall(function()
                for _, obj in ipairs(root:GetDescendants()) do
                    if obj:IsA("ScreenGui") then beforeGuis[obj] = true end
                end
            end)
        end

        local ok, err = pcall(native.open, {
            item = (function()
                local db = getDB()
                if db then
                    for id, item in pairs(db) do
                        if type(id) == "number" and type(item) == "table" and item.growscan then
                            return id
                        end
                    end
                end
                return 0
            end)(),
            owner = true,
            blocksPublic = false,
            floatingPublic = false,
        }, function() end)
        if not ok then
            warn("[HennHub] GrowScan open error: " .. tostring(err))
            return false
        end
        task.wait(0.25)
        local rootsAfter = { playerGui }
        pcall(function() table.insert(rootsAfter, game:GetService("CoreGui")) end)
        for _, root in ipairs(rootsAfter) do
            pcall(function()
                for _, obj in ipairs(root:GetDescendants()) do
                    if obj:IsA("ScreenGui") and not beforeGuis[obj] then
                        growScanUiRef = obj
                    end
                end
            end)
        end
        growScanUiRef = growScanUiRef or findGrowScanGui()
        if growScanUiRef then
            pcall(function() growScanUiRef.Enabled = true end)
        end
        growScanIsOpen = true
        growScanButton.Text = "CLOSE GROWSCAN"
        growScanButton.BackgroundColor3 = C.red
        return true
    end

    local closed = false
    for _, methodName in ipairs({"close", "hide"}) do
        local method = rawget(native, methodName)
        if type(method) == "function" then
            local ok = pcall(method)
            if ok then closed = true break end
        end
    end
    local guiRef = (growScanUiRef and growScanUiRef.Parent and growScanUiRef) or findGrowScanGui()
    if guiRef then
        pcall(function() guiRef.Enabled = false end)
        closed = true
    end
    if not closed then
        growScanHint.Text = "Tombol close GrowScan tidak ditemukan. Tutup lewat tombol X di UI game."
        return false
    end
    growScanIsOpen = false
    growScanButton.Text = "OPEN GROWSCAN"
    growScanButton.BackgroundColor3 = C.green
    return true
end

growScanButton.Activated:Connect(function()
    if growScanIsOpen then
        setGrowScanOpen(false)
    else
        if not setGrowScanOpen(true) then
            growScanHint.Text = "UI GrowScan tidak ditemukan / gagal dibuka."
        else
            growScanHint.Text = "GrowScan sedang terbuka. Tekan tombol untuk menutup."
        end
    end
end)

local function checkMiscItemId()
    local query = tostring(miscItemInput.Text or ""):gsub("^%s+", ""):gsub("%s+$", "")
    if query == "" then
        itemIdResult.Text = "Masukkan nama item terlebih dahulu."
        itemIdResult.TextColor3 = C.muted
        return
    end
    local id = resolveId(query)
    if not id then
        itemIdResult.Text = "Item tidak ditemukan: " .. query
        itemIdResult.TextColor3 = C.red
        return
    end
    local db = getDB()
    local item = db and db[id]
    local name = type(item) == "table" and tostring(item.name or query) or query
    itemIdResult.Text = name .. "  |  ID: " .. tostring(id)
    itemIdResult.TextColor3 = C.green
end

checkIdButton.Activated:Connect(checkMiscItemId)
miscItemInput.FocusLost:Connect(function(enterPressed)
    if enterPressed then checkMiscItemId() end
end)

-- jangkauan: naikkan otomatis kalau target grid lebih jauh dari range game
local longhandOriginal
local function ensureReach(reach)
    local inv = getInventory()
    if not inv then return end
    local needed = reach + 0.05
    local ok, range = pcall(inv.buildRange)
    if ok and type(range) == "number" and range < needed then
        if not longhandOriginal then
            longhandOriginal = { build = inv.buildRange, punch = inv.punchRange }
        end
        local target = math.clamp(math.ceil(needed - 2.5), 1, 20) + 2.5
        inv.buildRange = function() return math.max(longhandOriginal.build(), target) end
        inv.punchRange = function() return math.max(longhandOriginal.punch(), target) end
    end
end

----------------------------------------------------------------------
-- PATHFINDING (jalan lewat tile kosong; tidak memakai mode melayang)
----------------------------------------------------------------------
local Nav = {}
local NAV_SPEED = 1 -- satu tile per langkah agar tidak terlalu cepat
local NAV_STEP_DELAY = 0.16 -- jeda konservatif antar-tile untuk mengurangi rollback

local function passable(db, world, x, y)
    if not inBounds(world, x, y) then return false end
    local id = tileValue(world, "fg", x, y)
    if id == nil then return false end
    if id == 0 then return true end
    local item = db and db[id]
    if type(item) ~= "table" then return false end
    if item.entrance or item.combiner then return false end
    return not item.solid
end

local function nearestPassable(db, world, tx, ty)
    if passable(db, world, tx, ty) then return tx, ty end
    for r = 1, 3 do
        local best, bestD
        for dy = -r, r do
            for dx = -r, r do
                if math.max(math.abs(dx), math.abs(dy)) == r and passable(db, world, tx + dx, ty + dy) then
                    local d = math.abs(dx) + math.abs(dy)
                    if not bestD or d < bestD then best, bestD = { tx + dx, ty + dy }, d end
                end
            end
        end
        if best then return best[1], best[2] end
    end
    return nil
end

local function findPath(sx, sy, tx, ty)
    local world, db = getWorld(), getDB()
    if not world or type(rawget(world, "w")) ~= "number"
        or type(rawget(world, "h")) ~= "number"
        or not inBounds(world, sx, sy) then return nil end
    tx, ty = nearestPassable(db, world, tx, ty)
    if not tx then return nil end
    if sx == tx and sy == ty then return {} end
    local W = world.w
    local startKey, goalKey = sy * W + sx, ty * W + tx
    local parent = { [startKey] = -1 }
    local queue, head, found = { startKey }, 1, false
    while head <= #queue do
        local key = queue[head]; head += 1
        if key == goalKey then found = true break end
        local x, y = key % W, key // W
        for _, n in ipairs({ { x, y - 1 }, { x, y + 1 }, { x - 1, y }, { x + 1, y } }) do
            local nk = n[2] * W + n[1]
            if parent[nk] == nil and passable(db, world, n[1], n[2]) then
                parent[nk] = key
                table.insert(queue, nk)
            end
        end
        if head % 800 == 0 then task.wait() end
    end
    if not found then return nil end
    local path, key = {}, goalKey
    while key ~= startKey do
        table.insert(path, 1, { x = key % W, y = key // W })
        key = parent[key]
    end
    return path
end

function Nav.Walk(tx, ty, cancel)
    local world = getWorld()
    local sx, sy = getTile()
    if not world or not sx or not inBounds(world, tx, ty) then return false end

    local path = findPath(sx, sy, tx, ty)
    if not path then return false end

    local count = 0
    for _, node in ipairs(path) do
        if cancel and cancel() then return false end
        local ok = pcall(world.goTo, node.x, node.y)
        if not ok then return false end
        count += 1
        if count >= NAV_SPEED then
            count = 0
            task.wait(NAV_STEP_DELAY)
        end
    end
    return true
end

-- Fly sengaja dinonaktifkan agar navigasi tidak mengubah ghost atau memindahkan
-- karakter secara paksa saat jalur jalan kaki gagal.
function Nav.Fly(tx, ty, cancel)
    return false
end

function Nav.To(tx, ty, cancel)
    if cancel and cancel() then return false end
    return Nav.Walk(tx, ty, cancel)
end

----------------------------------------------------------------------
-- DROP (item jatuh)
----------------------------------------------------------------------
local function dropSet(world)
    local set = {}
    local ok, list = pcall(world.dropList)
    if ok and type(list) == "table" then
        for _, d in ipairs(list) do set[d] = true end
    end
    return set
end

-- Ambil drop dengan perpindahan khusus item saja.
-- Beri jeda antar-target agar perpindahan tidak bertubi-tubi.
local DROP_TP_DELAY = 0.55
local DROP_WAIT = 0.25
local DROP_RETURN_DELAY = 0.35

local function pickDrops(world, before, cancel, allowedCells)
    local ok, list = pcall(world.dropList)
    if not ok or type(list) ~= "table" then return end

    -- Collect dibatasi ke koordinat kotak grid yang dipilih saja.
    local allowed = {}
    if type(allowedCells) == "table" then
        for _, cell in ipairs(allowedCells) do
            allowed[tostring(cell.x) .. "," .. tostring(cell.y)] = true
        end
    end

    local targets = {}
    for _, d in ipairs(list) do
        local inSelectedGrid = type(d.x) == "number" and type(d.y) == "number"
            and allowed[tostring(math.floor(d.x)) .. "," .. tostring(math.floor(d.y))] == true
        if (before == nil or not before[d]) and inSelectedGrid and not d.pending then
            table.insert(targets, d)
        end
    end

    for _, d in ipairs(targets) do
        if cancel and cancel() then return end
        if table.find(list, d) then
            -- Simpan posisi sebelum mengejar drop agar TP tidak menggeser
            -- titik pusat Auto Farm ke lokasi item.
            local returnX, returnY = getTile()
            local tx, ty = math.floor(d.x), math.floor(d.y)

            if returnX and returnY and inBounds(world, tx, ty)
                and type(world.goTo) == "function" then
                local moved, result = pcall(world.goTo, tx, ty)
                if moved and result ~= false then
                    task.wait(DROP_WAIT)
                    local t0 = os.clock()
                    while not (cancel and cancel())
                        and table.find(list, d) and os.clock() - t0 < 0.8 do
                        task.wait(0.05)
                    end

                    -- Kembali ke tile tempat pemain berada sebelum TP item.
                    if inBounds(world, returnX, returnY) then
                        pcall(world.goTo, returnX, returnY)
                        task.wait(DROP_RETURN_DELAY)
                    end
                end
            end

            if cancel and cancel() then return end
            task.wait(DROP_TP_DELAY)
        end
    end
end

----------------------------------------------------------------------
-- AUTO FARM
----------------------------------------------------------------------
local farmToken, farmRunning = 0, false

local function setFarmUI(on, text)
    farmEnabled = on
    if not on and setCollectToggle then setCollectToggle(false) end
    farmButton.Text = on and "ON" or "OFF"
    farmButton.BackgroundColor3 = on and C.green or C.red
    status.Text = text or (on and "ON" or "IDLE")
    status.TextColor3 = on and C.green or C.red
end

-- grid UI: key "baris,kolom" -> dy = baris (atas negatif), dx = kolom (kanan positif)
local function farmCells(world, anchor)
    local cells = {}
    for key, on in pairs(selectedCells) do
        if on then
            local r, c = key:match("^(-?%d+),(-?%d+)$")
            local dy, dx = tonumber(r), tonumber(c)
            if dx and dy then
                -- Kolom grid mengikuti arah hadap pemain.
                -- Koreksi dari video: pulihkan arah horizontal dan geser
                -- seluruh mapping satu tile ke bawah untuk menghilangkan
                -- offset vertikal yang terlihat terlalu tinggi.
                local x, y = anchor.x + (dx * (anchor.facing or 1)), anchor.y + dy + 1
                if inBounds(world, x, y) then table.insert(cells, { x = x, y = y }) end
            end
        end
    end
    table.sort(cells, function(p, q)
        if p.y ~= q.y then return p.y < q.y end
        return p.x < q.x
    end)
    return cells
end

local function placeCell(id, cell, facing)
    local setTile = findGameFn("setTile")
    if not setTile then return false end
    if not pcall(setTile, layerOf(id), cell.x, cell.y, id, false, facing < 0) then return false end
    local bag = getBag()
    if bag and type(bag.remove) == "function" then pcall(bag.remove, bag, id, 1) end
    return true
end

local function breakCell(world, id, cell, cancel, delay)
    local hit = findGameFn("hit")
    if not hit then return false end
    local layer = layerOf(id)
    if layer == "bg" and tileValue(world, "fg", cell.x, cell.y) ~= 0 then return false end
    local t0 = os.clock()
    while not cancel() and tileValue(world, layer, cell.x, cell.y) == id do
        if os.clock() - t0 > 10 then return false end
        pcall(hit, cell.x, cell.y, true)
        task.wait(math.max(0.03, delay or speed))
    end
    return tileValue(world, layer, cell.x, cell.y) ~= id
end

-- AUTO DF: pinggir dibuka dari posisi X=1 / X=98,
-- lalu target lane mencakup Dirt, Cave Background, Lava, dan Rock.
local dfToken = 0

local function findBlockIds(db, keyword)
    local found = {}
    if type(db) ~= "table" then return found end
    keyword = tostring(keyword):lower()
    for id, item in pairs(db) do
        local numericId = tonumber(id)
        if numericId and type(item) == "table" then
            local name = tostring(item.name or ""):lower()
            if name:find(keyword, 1, true) then
                table.insert(found, numericId)
            end
        end
    end
    table.sort(found)
    return found
end

local function idInList(id, list)
    if type(id) ~= "number" then return false end
    for _, candidate in ipairs(list) do
        if id == candidate then return true end
    end
    return false
end

local function runAutoDF(token)
    local world, db = getWorld(), getDB()
    if not world or not db or type(world.goTo) ~= "function" then
        dfStatus.Text = "WORLD / NAV ERROR"
        if token == dfToken then
            dfEnabled = false
            dfButton.Text = "START"
            dfButton.BackgroundColor3 = C.green
        end
        return
    end

    -- Dirt dan Cave dicari dari ItemDB; Lava/Rock memakai ID yang sudah dikonfirmasi.
    -- Pemeriksaan target tetap mencakup foreground dan background.
    local dirtIds = findBlockIds(db, "dirt")
    local caveIds = findBlockIds(db, "cave")
    -- ID Lava dan Rock dikonfirmasi langsung: Lava=4, Rock=10.
    local lavaIds = { 4 }
    local rockIds = { 10 }
    local hit = findGameFn("hit")
    if #dirtIds == 0 or not hit then
        dfStatus.Text = "DIRT / HIT NOT FOUND"
        if token == dfToken then
            dfEnabled = false
            dfButton.Text = "START"
            dfButton.BackgroundColor3 = C.green
        end
        return
    end

    local currentX, currentY = getTile()
    if not currentX or not currentY then
        dfStatus.Text = "PLAYER POSITION NOT FOUND"
        return
    end

    local minX, maxX = 1, math.min(98, world.w - 2)
    local leftEdgeX, rightEdgeX = 0, math.min(99, world.w - 1)
    local startY = math.max(0, math.floor(currentY))
    if maxX < minX or startY >= world.h then
        dfStatus.Text = "AREA INVALID"
        return
    end

    local function cancelled()
        return token ~= dfToken or not dfEnabled
    end

    local function isLaneTarget(x, y)
        local fg = tileValue(world, "fg", x, y)
        local bg = tileValue(world, "bg", x, y)
        return idInList(fg, dirtIds) or idInList(fg, caveIds)
            or idInList(fg, lavaIds) or idInList(fg, rockIds)
            or idInList(bg, dirtIds) or idInList(bg, caveIds)
            or idInList(bg, lavaIds) or idInList(bg, rockIds)
    end

    local function hasTargetOnLane(y)
        for x = minX, maxX do
            if isLaneTarget(x, y) then return true end
        end
        return false
    end

    dfStatus.Text = string.format("ID D:%d C:%d L:%d R:%d", #dirtIds, #caveIds, #lavaIds, #rockIds)
    local DF_STEP_DELAY = 0.25
    local DF_TP_COOLDOWN = 0.45

    -- Pecahkan beberapa tile berdekatan secara paralel agar pojok lebih cepat terbuka.
    -- Background baru dipukul setelah foreground pada koordinat itu kosong.
    local function breakTargetAt(x, y)
        if cancelled() or y < 0 or y >= world.h or x < 0 or x >= world.w then return end
        local fg = tileValue(world, "fg", x, y)
        if idInList(fg, dirtIds) or idInList(fg, caveIds)
            or idInList(fg, lavaIds) or idInList(fg, rockIds) then
            breakCell(world, fg, { x = x, y = y }, cancelled, DF_STEP_DELAY)
        end
        if cancelled() or tileValue(world, "fg", x, y) ~= 0 then return end
        local bg = tileValue(world, "bg", x, y)
        if idInList(bg, dirtIds) or idInList(bg, caveIds)
            or idInList(bg, lavaIds) or idInList(bg, rockIds) then
            breakCell(world, bg, { x = x, y = y }, cancelled, DF_STEP_DELAY)
        end
    end

    local function breakBatch(cells)
        local running = 0
        for _, cell in ipairs(cells) do
            if cancelled() then break end
            if cell.y >= 0 and cell.y < world.h and cell.x >= 0 and cell.x < world.w then
                running += 1
                local batchX, batchY = cell.x, cell.y
                task.spawn(function()
                    pcall(breakTargetAt, batchX, batchY)
                    running -= 1
                end)
            end
        end
        while running > 0 and not cancelled() do task.wait(0.03) end
        return not cancelled()
    end

    -- Lane pair memakai worker per koordinat yang bisa terus berjalan saat player maju.
    -- Batch menargetkan dua kolom, tetapi player cukup menunggu kolom terdekat selesai.
    -- Kolom kedua tetap diproses di background dan dipakai lagi sebagai kolom pertama
    -- pada langkah berikutnya (overlap 1), tanpa membuat worker duplikat.
    local activeLaneWorkers = {}

    local function laneTargetIdAt(x, y)
        local fg = tileValue(world, "fg", x, y)
        if idInList(fg, dirtIds) or idInList(fg, caveIds)
            or idInList(fg, lavaIds) or idInList(fg, rockIds) then
            return fg
        end
        if fg == 0 then
            local bg = tileValue(world, "bg", x, y)
            if idInList(bg, dirtIds) or idInList(bg, caveIds)
                or idInList(bg, lavaIds) or idInList(bg, rockIds) then
                return bg
            end
        end
        return nil
    end

    local function ensureLaneWorker(x, y)
        local key = tostring(x) .. ":" .. tostring(y)
        if activeLaneWorkers[key] then return end
        if not laneTargetIdAt(x, y) then return end

        activeLaneWorkers[key] = true
        task.spawn(function()
            local startedAt = os.clock()
            while not cancelled() do
                local targetId = laneTargetIdAt(x, y)
                if not targetId then break end
                if os.clock() - startedAt > 10 then break end
                pcall(hit, x, y, true)
                task.wait(DF_STEP_DELAY)
            end
            activeLaneWorkers[key] = nil
        end)
    end

    local function breakLanePair(cells, leadingCell)
        for _, cell in ipairs(cells) do
            if not cancelled() and cell.x >= 0 and cell.x < world.w
                and cell.y >= 0 and cell.y < world.h then
                ensureLaneWorker(cell.x, cell.y)
            end
        end

        -- Jangan tunggu kolom kedua. Begitu kolom terdekat (misalnya X=9)
        -- kosong, player maju satu tile; worker X=8 tetap berjalan dan digunakan
        -- lagi bersama target X=7 pada batch berikutnya.
        if leadingCell then
            while not cancelled() and laneTargetIdAt(leadingCell.x, leadingCell.y) do
                task.wait(0.03)
            end
        end
        return not cancelled()
    end

    -- Awal lane: buka dua tile di sisi start. Setelah lane selesai,
    -- buka tiga tile vertikal di pojok seberang untuk jalur lane berikutnya.
    local function clearEdge(edgeX, y, count)
        local cells = {}
        for offset = 0, (count or 2) - 1 do
            local targetY = y + offset
            if targetY >= 0 and targetY < world.h then
                table.insert(cells, { x = edgeX, y = targetY })
            end
        end
        return breakBatch(cells)
    end

    local nextFromRight = (currentX - minX) >= (maxX - currentX)
    -- Tandai setiap lane yang sudah dilewati agar tidak pernah diproses ulang.
    -- Start berada di Y karakter; buka pojok 5 tile lebih dulu, lalu buka
    -- tile masuk pada Y+2 sebelum karakter turun dan mulai farming lane itu.
    local completedLanes = {}

    local initialFromRight = nextFromRight
    local initialStandX = initialFromRight and maxX or minX
    local initialEdgeX = initialFromRight and rightEdgeX or leftEdgeX
    dfStatus.Text = string.format("MOVE TO CORNER X=%d Y=%d", initialStandX, startY)
    local ix, iy = getTile()
    if not ix or ix ~= initialStandX or iy ~= startY then
        local moved = Nav.Walk(initialStandX, startY, cancelled)
        if not moved and not cancelled() then
            task.wait(DF_TP_COOLDOWN)
            local ok, result = pcall(world.goTo, initialStandX, startY)
            if not ok or result == false then
                dfStatus.Text = "MOVE TO INITIAL CORNER FAILED"
                return
            end
            task.wait(DF_TP_COOLDOWN)
        end
    end
    if cancelled() then return end

    local initialCornerY = math.max(0, startY - 2)
    dfStatus.Text = string.format("CHECK CORNER X=%d Y=%d..%d", initialEdgeX, initialCornerY, math.min(world.h - 1, startY + 2))
    if not clearEdge(initialEdgeX, initialCornerY, 5) then return end

    local firstFarmY = startY + 2
    dfStatus.Text = string.format("CLEAR ENTRY X=%d Y=%d", initialStandX, firstFarmY)
    breakTargetAt(initialStandX, firstFarmY)
    if cancelled() then return end
    dfStatus.Text = string.format("MOVE DOWN X=%d Y=%d", initialStandX, firstFarmY)
    local downOk = Nav.Walk(initialStandX, firstFarmY, cancelled)
    if not downOk and not cancelled() then
        task.wait(DF_TP_COOLDOWN)
        local ok, result = pcall(world.goTo, initialStandX, firstFarmY)
        if not ok or result == false then
            dfStatus.Text = "MOVE DOWN TO FIRST LANE FAILED"
            return
        end
        task.wait(DF_TP_COOLDOWN)
    end
    if cancelled() then return end

    for y = firstFarmY, world.h - 1, 2 do
        if cancelled() then break end

        if completedLanes[y] then
            continue
        end

        if not hasTargetOnLane(y) then
            completedLanes[y] = true
            dfStatus.Text = string.format("SKIP Y=%d (ALREADY CLEAR)", y)
            task.wait(0.04)
            continue
        end

        local fromRight = nextFromRight
        local standX = fromRight and maxX or minX
        local edgeX = fromRight and rightEdgeX or leftEdgeX
        dfStatus.Text = string.format("MOVE TO X=%d Y=%d", standX, y)

        local px, py = getTile()
        if not px or px ~= standX or py ~= y then
            local moved = Nav.Walk(standX, y, cancelled)
            if not moved and not cancelled() then
                task.wait(DF_TP_COOLDOWN)
                local ok, result = pcall(world.goTo, standX, y)
                if not ok or result == false then
                    dfStatus.Text = "MOVE TO INNER EDGE FAILED"
                    break
                end
                task.wait(DF_TP_COOLDOWN)
            end
        end
        if cancelled() then break end

        dfStatus.Text = string.format("FARMING Y=%d", y)
        local x = standX
        while (fromRight and x >= minX) or ((not fromRight) and x <= maxX) do
            if cancelled() then break end

            local cx, cy = getTile()
            if not cx or cx ~= x or cy ~= y then
                local moved = Nav.Walk(x, y, cancelled)
                if not moved and not cancelled() then
                    task.wait(DF_TP_COOLDOWN)
                    local ok, result = pcall(world.goTo, x, y)
                    if not ok or result == false then
                        dfStatus.Text = "LANE MOVE ERROR"
                        break
                    end
                    task.wait(DF_TP_COOLDOWN)
                end
            end
            if cancelled() then break end

            -- Targetkan dua kolom DI SAMPING/depan player, bukan tile tempat player berdiri.
            -- Kedua koordinat dipukul pada siklus yang sama. Saat player bergeser 1 tile,
            -- batch berikutnya berbagi satu kolom dengan batch sebelumnya (overlap 1).
            local direction = fromRight and -1 or 1
            local firstX = x + direction
            local secondX = x + (direction * 2)
            local batchCells = {}
            if firstX >= minX and firstX <= maxX then
                table.insert(batchCells, { x = firstX, y = y })
            end
            if secondX >= minX and secondX <= maxX then
                table.insert(batchCells, { x = secondX, y = y })
            end

            -- Kirim hit ke dua kolom samping secara bersamaan.
            if #batchCells > 0 then
                local leadingCell = batchCells[1]
                if not breakLanePair(batchCells, leadingCell) then break end
            end
            -- Geser player satu tile; dua kolom target berikutnya overlap satu kolom.
            x += direction
            task.wait(DF_STEP_DELAY)
        end

        if cancelled() then break end

        -- Di ujung lane (X=1/98), bersihkan kolom pojok di sisi luar.
        -- Lima tile vertikal: dua di atas Y, Y itu sendiri, dan dua di bawahnya.
        -- Ini membuka ruang di samping karakter agar tidak rollback saat pindah lane.
        local oppositeEdgeX = fromRight and leftEdgeX or rightEdgeX
        local cornerStartY = math.max(0, y - 2)
        dfStatus.Text = string.format("CHECK CORNER X=%d Y=%d..%d", oppositeEdgeX, cornerStartY, math.min(world.h - 1, y + 2))
        if not clearEdge(oppositeEdgeX, cornerStartY, 5) then break end

        -- Setelah 5 tile pojok selesai, buka tile masuk di sisi dalam untuk
        -- lane Y berikutnya. Karakter turun ke sana pada iterasi berikutnya.
        local nextInnerX = fromRight and minX or maxX
        local nextLaneY = y + 2
        dfStatus.Text = string.format("CLEAR NEXT ENTRY X=%d Y=%d", nextInnerX, nextLaneY)
        breakTargetAt(nextInnerX, nextLaneY)
        if cancelled() then break end

        -- Lane ini selesai. Jangan kembali ke Y ini walaupun ada perubahan tile
        -- di pojok saat membuka jalur untuk lane berikutnya.
        completedLanes[y] = true
        nextFromRight = not nextFromRight
        task.wait(0.05)
    end

    if token == dfToken then
        dfEnabled = false
        dfButton.Text = "START"
        dfButton.BackgroundColor3 = C.green
        dfStatus.Text = cancelled() and "STOPPED" or "COMPLETE"
    end
end

dfButton.Activated:Connect(function()
    if dfEnabled then
        dfEnabled = false
        dfToken += 1
        dfButton.Text = "START"
        dfButton.BackgroundColor3 = C.green
        dfStatus.Text = "STOPPED"
    else
        dfEnabled = true
        dfToken += 1
        local token = dfToken
        dfButton.Text = "STOP"
        dfButton.BackgroundColor3 = C.red
        dfStatus.Text = "STARTING"
        task.spawn(function()
            local ok, err = pcall(runAutoDF, token)
            if not ok then
                warn("[HennHub] Auto DF error: " .. tostring(err))
                if token == dfToken then
                    dfEnabled = false
                    dfButton.Text = "START"
                    dfButton.BackgroundColor3 = C.green
                    dfStatus.Text = "ERROR"
                end
            end
        end)
    end
end)

-- Auto Plant/Harvest hanya bekerja pada kotak grid yang dipilih.
-- Koordinat yang berhasil ditanami disimpan, sehingga Harvest tidak
-- menyentuh tanaman lain di world.
local plantHarvestToken = 0
local plantedCells = {}

local function serpentineCells(world, anchor)
    local cells = farmCells(world, anchor)
    local rows = {}
    for _, cell in ipairs(cells) do
        rows[cell.y] = rows[cell.y] or {}
        table.insert(rows[cell.y], cell)
    end
    local ys = {}
    for y in pairs(rows) do table.insert(ys, y) end
    table.sort(ys)
    local result = {}
    for index, y in ipairs(ys) do
        table.sort(rows[y], function(a,b)
            if index % 2 == 1 then return a.x < b.x end
            return a.x > b.x
        end)
        for _, cell in ipairs(rows[y]) do table.insert(result, cell) end
    end
    return result
end

local function isDirtTile(world, cell)
    local id = tileValue(world, "bg", cell.x, cell.y)
    if type(id) ~= "number" or id == 0 then return false end
    local db = getDB()
    local item = db and db[id]
    local name = type(item) == "table" and tostring(item.name or ""):lower() or ""
    return name:find("dirt", 1, true) ~= nil
end

local function plantHarvestLoop(token, anchor)
    local function cancel()
        return plantHarvestToken ~= token or (not plantEnabled and not harvestEnabled)
    end
    while not cancel() do
        local world = getWorld()
        if not world or worldName() ~= anchor.world then return "WORLD?" end
        local cells = serpentineCells(world, anchor)
        if #cells == 0 then return "GRID?" end

        local seedId = tonumber(seedInput.Text)
        local harvestId = tonumber(harvestInput.Text)
        local hit = findGameFn("hit")

        for _, cell in ipairs(cells) do
            if cancel() then break end
            local key = tostring(cell.x) .. "," .. tostring(cell.y)
            local fg = tileValue(world, "fg", cell.x, cell.y)

            -- Tanam seed hanya pada dirt kosong di grid pilihan.
            if plantEnabled and seedId and seedId > 0 and not plantedCells[key]
                and fg == 0 and isDirtTile(world, cell) then
                local have = countItem(seedId)
                if have == nil or have > 0 then
                    if placeCell(seedId, cell, anchor.facing) then
                        plantedCells[key] = { x = cell.x, y = cell.y, seed = seedId }
                        task.wait(0.12)
                    end
                end
            end

            -- Panen hanya koordinat yang ditanami oleh loop ini,
            -- dan hanya ketika foreground sudah berubah menjadi Harvest ID.
            if harvestEnabled and harvestId and harvestId > 0 and plantedCells[key]
                and fg == harvestId and hit then
                breakCell(world, harvestId, cell, cancel)
                if tileValue(world, "fg", cell.x, cell.y) == 0 then
                    plantedCells[key] = nil
                end
                task.wait(0.12)
            end
        end
        task.wait(0.25)
    end
    return nil
end

local function startPlantHarvest()
    local seedId = tonumber(seedInput.Text)
    local harvestId = tonumber(harvestInput.Text)
    if plantEnabled and (not seedId or seedId <= 0) then
        if setPlantToggle then setPlantToggle(false) end
        warn("[HennHub] Masukkan Seed ID yang valid")
        return
    end
    if harvestEnabled and (not harvestId or harvestId <= 0) then
        if setHarvestToggle then setHarvestToggle(false) end
        warn("[HennHub] Masukkan Harvest ID yang valid")
        return
    end
    local selected = 0
    for _, on in pairs(selectedCells) do if on then selected += 1 end end
    if selected == 0 then
        if setPlantToggle then setPlantToggle(false) end
        if setHarvestToggle then setHarvestToggle(false) end
        warn("[HennHub] Pilih kotak grid untuk Auto Plant/Harvest")
        return
    end
    local x, y, facing = getGrid()
    if not x then
        warn("[HennHub] Posisi karakter tidak terdeteksi")
        if setPlantToggle then setPlantToggle(false) end
        if setHarvestToggle then setHarvestToggle(false) end
        return
    end
    local anchor = { x = math.floor(x), y = math.floor(y - 0.475), facing = facing, world = worldName() }
    plantHarvestToken += 1
    local token = plantHarvestToken
    task.spawn(function()
        local ok, reason = pcall(plantHarvestLoop, token, anchor)
        if not ok then warn("[HennHub] Auto Plant/Harvest error: " .. tostring(reason)) end
        if plantHarvestToken == token then
            if setPlantToggle then setPlantToggle(false) end
            if setHarvestToggle then setHarvestToggle(false) end
            if reason then warn("[HennHub] Auto Plant/Harvest berhenti: " .. tostring(reason)) end
        end
    end)
end

task.spawn(function()
    local wasEnabled = false
    while true do
        local enabled = plantEnabled or harvestEnabled
        if enabled and not wasEnabled then
            startPlantHarvest()
        elseif not enabled and wasEnabled then
            plantHarvestToken += 1
        end
        wasEnabled = enabled
        task.wait(0.1)
    end
end)

-- return: alasan berhenti (string) atau nil kalau dihentikan manual
local function farmLoop(token, anchor, id)
    local function cancel() return farmToken ~= token end
    while not cancel() do
        local world = getWorld()
        if not world then return "NO WORLD" end
        if worldName() ~= anchor.world then return "PINDAH WORLD" end

        -- Anchor karakter dikunci saat Auto Farm ON.
        -- Grid, PLACE, dan BREAK selalu memakai anchor ini.
        -- Perpindahan karakter tidak menggeser area farming.

        local layer = layerOf(id)
        local cells = farmCells(world, anchor)
        if #cells == 0 then return "GRID?" end

        -- 1) PLACE. Gunakan grid yang dikunci saat Auto Farm dinyalakan.
        status.Text = "PLACE"
        local outOfItem = false
        for _, cell in ipairs(cells) do
            if cancel() then break end
            if tileValue(world, layer, cell.x, cell.y) == 0 then
                local have = countItem(id)
                if have ~= nil and have <= 0 then outOfItem = true break end
                placeCell(id, cell, anchor.facing)
                task.wait(0.1)
            end
        end
        if cancel() then break end
        task.wait(0.35)

        -- 2) BREAK
        status.Text = "BREAK"
        local before = dropSet(world)
        for _, cell in ipairs(cells) do
            if cancel() then break end
            if tileValue(world, layer, cell.x, cell.y) == id then
                breakCell(world, id, cell, function()
                    return cancel()
                end)
            end
        end
        if cancel() then break end

        -- 3) AUTO COLLECT. Navigasi hanya berjalan kaki, tidak ada teleport/fly.
        if collectEnabled then
            status.Text = "COLLECT"
            task.wait(0.3)
            pickDrops(world, before, cancel, cells)
            -- pickDrops mengembalikan pemain ke tile sebelum mengambil item;
            -- anchor Auto Farm tetap terkunci pada posisi awal.
        end

        if outOfItem then return "HABIS" end
        task.wait(0.1)
    end
    return nil
end

local function startFarm()
    local id = resolveId(blockInput.Text)
    if not id then
        warn("[HennHub] Block ID tidak valid / ItemDB tidak ditemukan")
        setFarmUI(false, "ID?") return
    end

    local reach, selected = 0, 0
    for key, on in pairs(selectedCells) do
        if on then
            local r, c = key:match("^(-?%d+),(-?%d+)$")
            selected += 1
            reach = math.max(reach, math.abs(tonumber(r)), math.abs(tonumber(c)))
        end
    end
    if selected < 1 then
        warn("[HennHub] Pilih minimal 1 kotak di grid")
        setFarmUI(false, "GRID?") return
    end
    if not (findGameFn("hit") and findGameFn("setTile")) then
        warn("[HennHub] Fungsi hit/setTile tidak ditemukan (executor perlu getgc + debug.info)")
        setFarmUI(false, "NO FUNC") return
    end
    ensureReach(reach)

    -- Ambil posisi karakter tepat ketika Auto Farm mulai ON.
    -- Semua koordinat grid, PLACE, dan BREAK memakai anchor yang sama
    -- sampai Auto Farm dimatikan. Tidak mengikuti perpindahan karakter
    -- selama proses masih ON.
    local x, y, facing = getGrid()
    if not x then
        warn("[HennHub] Posisi karakter tidak terdeteksi")
        setFarmUI(false, "NO POS") return
    end

    local anchor = {
        x = math.floor(x),
        y = math.floor(y - 0.475),
        facing = facing,
        world = worldName(),
    }
    farmToken += 1
    local token = farmToken
    farmRunning = true

    task.spawn(function()
        local ok, reason = pcall(farmLoop, token, anchor, id)
        if not ok then
            warn("[HennHub] Auto Farm error: " .. tostring(reason))
            reason = "ERROR"
        end
        farmRunning = false
        if farmToken == token then setFarmUI(false, reason) end -- berhenti sendiri
    end)
end

-- Pantau toggle Auto Farm. startFarm() menangkap anchor baru setiap ON.
task.spawn(function()
    while true do
        if farmEnabled and not farmRunning then
            startFarm()
        elseif not farmEnabled and farmRunning then
            farmToken += 1 -- hentikan loop
        end
        task.wait(0.1)
    end
end)

----------------------------------------------------------------------
-- AUTO COLLECT berjalan hanya di dalam loop Auto Farm dan hanya pada
-- koordinat grid yang dipilih. Saat Auto Farm OFF, toggle ikut OFF.
----------------------------------------------------------------------


print("HennHub loaded | Misc: Anti Lava + GrowScan + Check Item ID")

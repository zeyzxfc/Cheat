-- ====================================================================
-- SAVAS CHEAT v7.0 - ULTIMATE UI ENGINE [FULL & COMPLETED EDITION]
-- Key: savas.lua (KGT ESP Engine Entegre Edilmiş Versiyon)
-- ====================================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local Stats = game:GetService("Stats")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local DefaultAmbient = Lighting.Ambient
local DefaultOutdoorAmbient = Lighting.OutdoorAmbient

-- Dil & Çeviri Sistemi
local CurrentLang = "TR"
local UIObjectsToTranslate = {}

local Translations = {
    TR = {
        Tab_Aimbot = "🎯 Aimbot", Tab_ESP = "👁️ ESP", Tab_Player = "👤 Oyuncu",
        Tab_PlrMgmt = "👥 Oyuncular", Tab_Weapon = "⚔️ Silah / Kill", Tab_Troll = "🌀 Troll",
        Tab_Visuals = "🎨 Görsel", Tab_Teleport = "📍 Teleport", Tab_Config = "⚙️ Ayarlar",

        Sec_AimGen = "Aimbot Temel Ayarları", Sec_AimFilter = "Filtreleme & FOV",
        Sec_Hitbox = "Hitbox & Auto Fire", Sec_ESPMain = "ESP Ana Sistemler",
        Sec_ESPOpt = "ESP Özel Renkler & Mesafe", Sec_Movement = "Temel Hareket Ayarları",
        Sec_AdvancedPlr = "Gelişmiş Hareket & Fizik", Sec_PlrTarget = "Hedef Oyuncu İşlemleri",
        Sec_KillAll = "Kill All Gelişmiş Engine", Sec_TrollAction = "Troll & Physics Fonksiyonları",
        Sec_ScreenCam = "Ekran, Kamera & Aydınlatma", Sec_Crosshair = "Özel Crosshair",
        Sec_PosSave = "Çoklu Konum Kayıt", Sec_ServerTP = "Sunucu & Işınlanma",
        Sec_SysLang = "Sistem & Dil", Sec_CfgFile = "Config Yönetimi",

        Aimbot = "Aimbot Aktivasyonu", AimPart = "Hedef Bölge", Smoothness = "Yumuşaklık (Smooth)",
        TeamCheck = "Takım Kontrolü", WallCheck = "Duvar Kontrolü", ShowFOV = "FOV Çamberi Göster",
        FOVSize = "FOV Çapı", Triggerbot = "Triggerbot (Auto Fire)", Prediction = "Tahminleme (Prediction)",
        HitboxExpander = "Hitbox Büyütücü", HitboxSize = "Hitbox Boyutu",
        
        ESP = "Düşman ESP Aktivasyonu", TeamESP = "Takım ESP Aktivasyonu", Box3D = "3D Chams ESP (Kutu)", Tracer = "Tracer Çizgisi",
        Name = "İsim Göster", Distance = "Mesafe Göster", ESPColor = "ESP Rengi", MaxDistance = "Maksimum ESP Mesafesi",
        
        WalkSpeed = "Hız Hilesi", SpeedValue = "Hız Limiti", JumpPower = "Zıplama Hilesi", JumpValue = "Zıplama Limiti",
        InfJump = "Sınırsız Zıplama", Noclip = "Noclip (Duvardan Geçme)", Fly = "Fly Mode (Uçma)",
        FlySpeed = "Uçma Hızı", Spinbot = "Spinbot", SpinSpeed = "Spin Hızı", CustomGravity = "Özel Yerçekimi", GravityVal = "Yerçekimi Değeri",
        
        SelectPlayer = "  Oyuncu Seçiniz...", RefreshList = "🔄 Listeyi Yenile", TPToPlayer = "Yanına TP Ol",
        SpectatePlr = "Kamerayı Oyuncuya Bağla", ResetCam = "Kamerayı Sıfırla", ExplodePlayer = "Oyuncuyu Patlat", ExplodeAll = "Herkesi Patlat",
        
        KillAllOnce = "☠️ Kill All (Başlat)", KillAllOnScreen = "Ekrana Hızlı Kill Butonu", KillAllDist = "Kill All Mesafesi", KillAllTeamCheck = "Takım Arkadaşlarını Vurma",
        
        FlingAll = "🚀 Fling All", FlingStop = "🛑 Fling Durdur", BringPlayers = "Herkesi Çek",
        HolePlayers = "Yere Göm", BringVehicles = "Araçları Çek", BringEverything = "Her Şeyi Çek", Blackhole = "Karadelik",
        
        Fullbright = "Gece Görüşü (Fullbright)", LockDay = "Sürekli Gündüz Yap", CamFOV = "Kamera FOV",
        Crosshair = "Özel Crosshair", CrossType = "Crosshair Tipi", CrossColor = "Crosshair Rengi", CrossSize = "Crosshair Boyutu", CrossThick = "Çizgi Kalınlığı",
        
        SavePos1 = "Konum 1 Kaydet", TPPos1 = "Konum 1'e Git", SavePos2 = "Konum 2 Kaydet", TPPos2 = "Konum 2'ye Git",
        TPMapCenter = "Harita Merkezine Git", AntiAFK = "Anti AFK (Atılmayı Önle)", ServerHop = "Sunucu Değiştir",
        Rejoin = "Tekrar Katıl", SaveConfig = "⚙️ Config Kaydet", LoadConfig = "📂 Config Yükle", Language = "Arayüz Dili"
    },
    EN = {
        Tab_Aimbot = "🎯 Aimbot", Tab_ESP = "👁️ ESP", Tab_Player = "👤 Player",
        Tab_PlrMgmt = "👥 Players", Tab_Weapon = "⚔️ Weapon / Kill", Tab_Troll = "🌀 Troll",
        Tab_Visuals = "🎨 Visuals", Tab_Teleport = "📍 Teleport", Tab_Config = "⚙️ Settings",

        Sec_AimGen = "Aimbot General Settings", Sec_AimFilter = "Filtering & FOV",
        Sec_Hitbox = "Hitbox & Auto Fire", Sec_ESPMain = "ESP Core Systems",
        Sec_ESPOpt = "ESP Custom Colors & Distance", Sec_Movement = "Movement Settings",
        Sec_AdvancedPlr = "Advanced Physics", Sec_PlrTarget = "Target Player Options",
        Sec_KillAll = "Kill All Engine", Sec_TrollAction = "Troll & Physics Actions",
        Sec_ScreenCam = "Screen, Camera & Lighting", Sec_Crosshair = "Custom Crosshair",
        Sec_PosSave = "Multi-Position Storage", Sec_ServerTP = "Server & Teleport",
        Sec_SysLang = "System & Language", Sec_CfgFile = "Config Management",

        Aimbot = "Enable Aimbot", AimPart = "Target Bone", Smoothness = "Smoothness",
        TeamCheck = "Team Check", WallCheck = "Wall Check", ShowFOV = "Show FOV Circle",
        FOVSize = "FOV Radius", Triggerbot = "Triggerbot", Prediction = "Prediction Engine",
        HitboxExpander = "Hitbox Expander", HitboxSize = "Hitbox Size",
        
        ESP = "Enable Enemy ESP", TeamESP = "Enable Team ESP", Box3D = "3D Chams ESP (Box)", Tracer = "Tracer Lines",
        Name = "Show Name", Distance = "Show Distance", ESPColor = "ESP Color", MaxDistance = "Max ESP Distance",
        
        WalkSpeed = "WalkSpeed Hack", SpeedValue = "Speed Limit", JumpPower = "JumpPower Hack", JumpValue = "Jump Limit",
        InfJump = "Infinite Jump", Noclip = "Noclip", Fly = "Fly Mode",
        FlySpeed = "Fly Speed", Spinbot = "Spinbot", SpinSpeed = "Spin Speed", CustomGravity = "Custom Gravity", GravityVal = "Gravity Value",
        
        SelectPlayer = "  Select Player...", RefreshList = "🔄 Refresh List", TPToPlayer = "Teleport To",
        SpectatePlr = "Spectate Player", ResetCam = "Reset Camera", ExplodePlayer = "Explode Player", ExplodeAll = "Explode All",
        
        KillAllOnce = "☠️ Kill All (Start)", KillAllOnScreen = "Kill All Floating Button", KillAllDist = "Kill All Range", KillAllTeamCheck = "Don't Attack Teammates",
        
        FlingAll = "🚀 Fling All", FlingStop = "🛑 Stop Fling", BringPlayers = "Bring Players",
        HolePlayers = "Bury Players", BringVehicles = "Bring Vehicles", BringEverything = "Bring Everything", Blackhole = "Blackhole Unanchored",
        
        Fullbright = "Fullbright", LockDay = "Lock Daylight", CamFOV = "Camera FOV",
        Crosshair = "Custom Crosshair", CrossType = "Crosshair Style", CrossColor = "Crosshair Color", CrossSize = "Crosshair Size", CrossThick = "Line Thickness",
        
        SavePos1 = "Save Pos 1", TPPos1 = "TP to Pos 1", SavePos2 = "Save Pos 2", TPPos2 = "TP to Pos 2",
        TPMapCenter = "TP to Map Center", AntiAFK = "Anti AFK", ServerHop = "Server Hop",
        Rejoin = "Rejoin Server", SaveConfig = "⚙️ Save Config", LoadConfig = "📂 Load Config", Language = "UI Language"
    }
}

local function RegisterTranslation(instance, key)
    table.insert(UIObjectsToTranslate, {Instance = instance, Key = key})
    if Translations[CurrentLang] and Translations[CurrentLang][key] then
        instance.Text = Translations[CurrentLang][key]
    end
end

local function UpdateAllTranslations()
    for _, item in ipairs(UIObjectsToTranslate) do
        if item.Instance and item.Instance.Parent and Translations[CurrentLang] and Translations[CurrentLang][item.Key] then
            item.Instance.Text = Translations[CurrentLang][item.Key]
        end
    end
end

-- Global Config Setup
local ConfigData = {
    AimbotEnabled = false, AimPart = "Head", AimbotSmoothness = 0.5, AimbotFOV = 80,
    ShowFOV = false, TeamCheck = false, WallCheck = false, Triggerbot = false,
    Prediction = false, HitboxExpander = false, HitboxSize = 2,

    ESPEnabled = false, ESPTeam = false, ESPBox = false, ESPTracer = false, ESPName = false,
    ESPDistance = false, ESPMaxDistance = 1000,
    ESPColorVal = Color3.fromRGB(255, 205, 0),

    SpeedHack = false, SpeedVal = 16, JumpHack = false, JumpVal = 50, InfJump = false, Noclip = false,
    Fly = false, FlySpeed = 50, Spinbot = false, SpinSpeed = 45,
    CustomGravity = false, GravityVal = 196.2,

    Fullbright = false, LockDay = false, CamFOVVal = 70,
    KillAllMaxDistance = 200, KillAllTeamCheck = true, KillAllSpeed = "Normal",

    CustomCrosshair = false, CrosshairType = "Dolgu Yuvarlak", CrosshairSize = 6,
    CrosshairThickness = 1.5, AntiAFK = false
}

local ColorPalette = {
    ["Sarı"] = Color3.fromRGB(255, 205, 0),
    ["Kırmızı"] = Color3.fromRGB(235, 45, 45),
    ["Yeşil"] = Color3.fromRGB(50, 255, 50),
    ["Mavi"] = Color3.fromRGB(0, 150, 255),
    ["Mor"] = Color3.fromRGB(180, 50, 255),
    ["Cyan"] = Color3.fromRGB(0, 255, 255),
    ["Beyaz"] = Color3.fromRGB(255, 255, 255)
}

-- v7.0 Tema Renkleri
local C_BG           = Color3.fromRGB(14, 14, 14)
local C_Card         = Color3.fromRGB(24, 24, 24)
local C_CardLight    = Color3.fromRGB(34, 34, 34)
local C_Sidebar      = Color3.fromRGB(18, 18, 18)
local C_AccentYellow = Color3.fromRGB(255, 205, 0)
local C_BorderGrey   = Color3.fromRGB(50, 50, 50)
local C_Text         = Color3.fromRGB(255, 255, 255)
local C_TextDim      = Color3.fromRGB(150, 150, 150)

local BringPlayersLoop, HolePlayersLoop, BringVehiclesLoop = false, false, false
local BringEverythingLoop, BlackholeLoop, FlingAllActive, KillAllActive = false, false, false, false
local SavedPos1, SavedPos2, SelectedPlayerObj = nil, nil, nil
local CrosshairColor = Color3.fromRGB(255, 205, 0)

-- Drawings (FOV & Crosshair)
local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 1.8 FOVCircle.NumSides = 60 FOVCircle.Radius = ConfigData.AimbotFOV
FOVCircle.Filled = false FOVCircle.Visible = false FOVCircle.Color = C_AccentYellow

local CrossCircle = Drawing.new("Circle")
CrossCircle.NumSides = 30 CrossCircle.Visible = false

local CrossLines = {
    Top = Drawing.new("Line"), Bottom = Drawing.new("Line"),
    Left = Drawing.new("Line"), Right = Drawing.new("Line")
}

-- Safe Parent GUI Setup
local function GetSafeParent()
    local parent
    pcall(function()
        if gethui then parent = gethui()
        elseif game:GetService("CoreGui") then parent = game:GetService("CoreGui") end
    end)
    if not parent then parent = LocalPlayer:WaitForChild("PlayerGui") end
    return parent
end

local ParentGui = GetSafeParent()
if ParentGui:FindFirstChild("SavasCheatGui") then ParentGui.SavasCheatGui:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SavasCheatGui" ScreenGui.ResetOnSpawn = false ScreenGui.DisplayOrder = 999 ScreenGui.Parent = ParentGui

-- Dragging Helper
local function MakeDraggable(frame, dragHandle)
    local dragging, dragStart, startPos
    dragHandle = dragHandle or frame
    dragHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true dragStart = input.Position startPos = frame.Position
            input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

local function ApplyBorder(instance, color, thickness)
    local stroke = Instance.new("UIStroke")
    stroke.Thickness = thickness or 1
    stroke.Color = color or C_BorderGrey
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = instance
    return stroke
end

-- Floating Toggle Button
local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "Savas_MobileToggle"
ToggleButton.Size = UDim2.new(0, 52, 0, 52)
ToggleButton.Position = UDim2.new(0.02, 0, 0.2, 0)
ToggleButton.BackgroundColor3 = C_Card
ToggleButton.Text = "SAVAS" ToggleButton.TextColor3 = C_AccentYellow ToggleButton.TextSize = 11
ToggleButton.Font = Enum.Font.GothamBold ToggleButton.Visible = false ToggleButton.Parent = ScreenGui

local ToggleCorner = Instance.new("UICorner") ToggleCorner.CornerRadius = UDim.new(0, 10) ToggleCorner.Parent = ToggleButton
ApplyBorder(ToggleButton, C_AccentYellow, 1.5)
MakeDraggable(ToggleButton)

-- Quick Kill All Button
local KillAllQuickBtn = Instance.new("TextButton")
KillAllQuickBtn.Name = "Savas_KillAllQuickBtn"
KillAllQuickBtn.Size = UDim2.new(0, 58, 0, 58)
KillAllQuickBtn.Position = UDim2.new(0.88, -20, 0.5, 0)
KillAllQuickBtn.BackgroundColor3 = C_Card
KillAllQuickBtn.Text = "☠️\nKILL ALL" KillAllQuickBtn.TextColor3 = C_AccentYellow KillAllQuickBtn.TextSize = 10
KillAllQuickBtn.Font = Enum.Font.GothamBold KillAllQuickBtn.Visible = false KillAllQuickBtn.Parent = ScreenGui

local QuickBtnCorner = Instance.new("UICorner") QuickBtnCorner.CornerRadius = UDim.new(0, 12) QuickBtnCorner.Parent = KillAllQuickBtn
ApplyBorder(KillAllQuickBtn, C_AccentYellow, 1.5)
MakeDraggable(KillAllQuickBtn)

-- Main Frame
local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.new(0, 560, 0, 370)
Main.Position = UDim2.new(0.5, -280, 0.5, -185)
Main.BackgroundColor3 = C_BG Main.ClipsDescendants = true Main.Visible = false Main.Parent = ScreenGui

local MainUICorner = Instance.new("UICorner") MainUICorner.CornerRadius = UDim.new(0, 8) MainUICorner.Parent = Main
ApplyBorder(Main, C_BorderGrey, 1)

ToggleButton.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible end)

-- Topbar
local Topbar = Instance.new("Frame") Topbar.Name = "Topbar" Topbar.Size = UDim2.new(1, 0, 0, 34) Topbar.BackgroundColor3 = C_Sidebar Topbar.BorderSizePixel = 0 Topbar.Parent = Main
ApplyBorder(Topbar, C_BorderGrey, 1)

local Title = Instance.new("TextLabel") Title.Size = UDim2.new(0, 260, 1, 0) Title.Position = UDim2.new(0, 12, 0, 0) Title.BackgroundTransparency = 1
Title.Text = "SAVAS CHEAT // <font color=\"rgb(255,205,0)\">ULTIMATE v7.0</font>" Title.RichText = true Title.TextColor3 = C_Text Title.TextSize = 11 Title.Font = Enum.Font.GothamBold Title.TextXAlignment = Enum.TextXAlignment.Left Title.Parent = Topbar

local StatsLabel = Instance.new("TextLabel") StatsLabel.Size = UDim2.new(0, 180, 1, 0) StatsLabel.Position = UDim2.new(1, -210, 0, 0) StatsLabel.BackgroundTransparency = 1
StatsLabel.Text = "FPS: -- | PING: --ms" StatsLabel.TextColor3 = C_TextDim StatsLabel.TextSize = 10 StatsLabel.Font = Enum.Font.GothamSemibold StatsLabel.TextXAlignment = Enum.TextXAlignment.Right StatsLabel.Parent = Topbar

local CloseBtn = Instance.new("TextButton") CloseBtn.Size = UDim2.new(0, 34, 1, 0) CloseBtn.Position = UDim2.new(1, -34, 0, 0) CloseBtn.BackgroundTransparency = 1 CloseBtn.Text = "✕" CloseBtn.TextColor3 = C_TextDim CloseBtn.TextSize = 12 CloseBtn.Font = Enum.Font.GothamBold CloseBtn.Parent = Topbar
CloseBtn.MouseButton1Click:Connect(function() Main.Visible = false end)
MakeDraggable(Main, Topbar)

local frameCount, lastFpsTick = 0, tick()
RunService.RenderStepped:Connect(function()
    frameCount = frameCount + 1
    if tick() - lastFpsTick >= 1 then
        local fps = frameCount frameCount = 0 lastFpsTick = tick() local ping = 0
        pcall(function() ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue()) end)
        StatsLabel.Text = string.format("FPS: %d | PING: %dms", fps, ping)
    end
end)

---------------------------------------------------------
-- KEY SYSTEM INTEGRATION (Key: savas.lua)
---------------------------------------------------------
local CorrectKey = "savas.lua"

local KeyFrame = Instance.new("Frame")
KeyFrame.Name = "KeyFrame"
KeyFrame.Size = UDim2.new(0, 340, 0, 170)
KeyFrame.Position = UDim2.new(0.5, -170, 0.5, -85)
KeyFrame.BackgroundColor3 = C_BG
KeyFrame.Parent = ScreenGui

local KeyCorner = Instance.new("UICorner") KeyCorner.CornerRadius = UDim.new(0, 8) KeyCorner.Parent = KeyFrame
ApplyBorder(KeyFrame, C_AccentYellow, 1.5)
MakeDraggable(KeyFrame)

local KeyTitle = Instance.new("TextLabel")
KeyTitle.Size = UDim2.new(1, 0, 0, 32) KeyTitle.Position = UDim2.new(0, 0, 0, 10) KeyTitle.BackgroundTransparency = 1
KeyTitle.Text = "SAVAS CHEAT // <font color=\"rgb(255,205,0)\">KEY SYSTEM</font>" KeyTitle.RichText = true KeyTitle.TextColor3 = C_Text KeyTitle.TextSize = 12 KeyTitle.Font = Enum.Font.GothamBold KeyTitle.Parent = KeyFrame

local KeyInput = Instance.new("TextBox")
KeyInput.Size = UDim2.new(0.85, 0, 0, 32) KeyInput.Position = UDim2.new(0.075, 0, 0.35, 0) KeyInput.BackgroundColor3 = C_Card
KeyInput.PlaceholderText = "Key Giriniz (savas.lua)..." KeyInput.Text = "" KeyInput.TextColor3 = C_Text KeyInput.TextSize = 11 KeyInput.Font = Enum.Font.Gotham KeyInput.ClearTextOnFocus = false KeyInput.Parent = KeyFrame
local InputCorner = Instance.new("UICorner") InputCorner.CornerRadius = UDim.new(0, 6) InputCorner.Parent = KeyInput
ApplyBorder(KeyInput, C_BorderGrey, 1)

local SubmitBtn = Instance.new("TextButton")
SubmitBtn.Size = UDim2.new(0.85, 0, 0, 32) SubmitBtn.Position = UDim2.new(0.075, 0, 0.65, 0) SubmitBtn.BackgroundColor3 = C_AccentYellow
SubmitBtn.Text = "GİRİŞ YAP" SubmitBtn.TextColor3 = Color3.fromRGB(0, 0, 0) SubmitBtn.TextSize = 11 SubmitBtn.Font = Enum.Font.GothamBold SubmitBtn.Parent = KeyFrame
local BtnCorner = Instance.new("UICorner") BtnCorner.CornerRadius = UDim.new(0, 6) BtnCorner.Parent = SubmitBtn

local function ValidateKey()
    if KeyInput.Text == CorrectKey then
        KeyFrame:Destroy()
        Main.Visible = true
        ToggleButton.Visible = true
    else
        KeyInput.Text = ""
        KeyInput.PlaceholderText = "❌ Hatalı Key! Tekrar Deneyin."
    end
end

SubmitBtn.MouseButton1Click:Connect(ValidateKey)
KeyInput.FocusLost:Connect(function(enterPressed)
    if enterPressed then ValidateKey() end
end)

---------------------------------------------------------
-- UI SCENERY & NAVIGATION SETUP
---------------------------------------------------------
local Sidebar = Instance.new("Frame") Sidebar.Name = "Sidebar" Sidebar.Size = UDim2.new(0, 125, 1, -34) Sidebar.Position = UDim2.new(0, 0, 0, 34) Sidebar.BackgroundColor3 = C_Sidebar Sidebar.BorderSizePixel = 0 Sidebar.Parent = Main
local SidebarList = Instance.new("UIListLayout") SidebarList.SortOrder = Enum.SortOrder.LayoutOrder SidebarList.Padding = UDim.new(0, 3) SidebarList.Parent = Sidebar
local SidebarPad = Instance.new("UIPadding") SidebarPad.PaddingTop = UDim.new(0, 6) SidebarPad.PaddingLeft = UDim.new(0, 5) SidebarPad.PaddingRight = UDim.new(0, 5) SidebarPad.Parent = Sidebar

local Content = Instance.new("Frame") Content.Name = "Content" Content.Size = UDim2.new(1, -130, 1, -38) Content.Position = UDim2.new(0, 128, 0, 36) Content.BackgroundTransparency = 1 Content.Parent = Main

local Tabs, TabButtons = {}, {}

local function CreateTab(name, transKey)
    local TabBtn = Instance.new("TextButton")
    TabBtn.Size = UDim2.new(1, 0, 0, 26) TabBtn.BackgroundColor3 = C_Card TabBtn.BackgroundTransparency = 0.5 TabBtn.TextColor3 = C_TextDim TabBtn.TextSize = 10 TabBtn.Font = Enum.Font.GothamSemibold TabBtn.Parent = Sidebar
    RegisterTranslation(TabBtn, transKey)
    local bCorn = Instance.new("UICorner") bCorn.CornerRadius = UDim.new(0, 5) bCorn.Parent = TabBtn

    local Scroll = Instance.new("ScrollingFrame")
    Scroll.Size = UDim2.new(1, 0, 1, 0) Scroll.BackgroundTransparency = 1 Scroll.ScrollBarThickness = 2 Scroll.ScrollBarImageColor3 = C_AccentYellow Scroll.Visible = false Scroll.Parent = Content
    local Layout = Instance.new("UIListLayout") Layout.SortOrder = Enum.SortOrder.LayoutOrder Layout.Padding = UDim.new(0, 6) Layout.Parent = Scroll
    local Pad = Instance.new("UIPadding") Pad.PaddingTop = UDim.new(0, 2) Pad.PaddingBottom = UDim.new(0, 10) Pad.PaddingRight = UDim.new(0, 6) Pad.Parent = Scroll

    Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        Scroll.CanvasSize = UDim2.new(0, 0, 0, Layout.AbsoluteContentSize.Y + 15)
    end)

    Tabs[name] = Scroll
    TabButtons[name] = TabBtn

    TabBtn.MouseButton1Click:Connect(function()
        for tName, tabObj in pairs(Tabs) do
            local isCurrent = (tName == name)
            tabObj.Visible = isCurrent
            TabButtons[tName].BackgroundColor3 = isCurrent and C_AccentYellow or C_Card
            TabButtons[tName].TextColor3 = isCurrent and Color3.fromRGB(0, 0, 0) or C_TextDim
            TabButtons[tName].BackgroundTransparency = isCurrent and 0 or 0.5
        end
    end)

    return Scroll
end

local function AddSection(parent, transKey)
    local SecLabel = Instance.new("TextLabel")
    SecLabel.Size = UDim2.new(1, 0, 0, 18) SecLabel.BackgroundTransparency = 1 SecLabel.TextColor3 = C_AccentYellow SecLabel.TextSize = 10 SecLabel.Font = Enum.Font.GothamBold SecLabel.TextXAlignment = Enum.TextXAlignment.Left SecLabel.Parent = parent
    RegisterTranslation(SecLabel, transKey)
end

local function AddToggle(parent, transKey, default, callback)
    local Frame = Instance.new("Frame") Frame.Size = UDim2.new(1, 0, 0, 28) Frame.BackgroundColor3 = C_Card Frame.Parent = parent
    local Corner = Instance.new("UICorner") Corner.CornerRadius = UDim.new(0, 5) Corner.Parent = Frame
    ApplyBorder(Frame, C_BorderGrey, 1)

    local Label = Instance.new("TextLabel") Label.Size = UDim2.new(1, -40, 1, 0) Label.Position = UDim2.new(0, 8, 0, 0) Label.BackgroundTransparency = 1 Label.TextColor3 = C_Text Label.TextSize = 10 Label.Font = Enum.Font.Gotham Label.TextXAlignment = Enum.TextXAlignment.Left Label.Parent = Frame
    RegisterTranslation(Label, transKey)

    local ToggleBox = Instance.new("TextButton") ToggleBox.Size = UDim2.new(0, 18, 0, 18) ToggleBox.Position = UDim2.new(1, -24, 0.5, -9) ToggleBox.BackgroundColor3 = default and C_AccentYellow or C_CardLight ToggleBox.Text = default and "✓" or "" ToggleBox.TextColor3 = Color3.fromRGB(0, 0, 0) ToggleBox.TextSize = 10 ToggleBox.Font = Enum.Font.GothamBold ToggleBox.Parent = Frame
    local BoxCorner = Instance.new("UICorner") BoxCorner.CornerRadius = UDim.new(0, 4) BoxCorner.Parent = ToggleBox

    local state = default
    ToggleBox.MouseButton1Click:Connect(function()
        state = not state
        ToggleBox.BackgroundColor3 = state and C_AccentYellow or C_CardLight
        ToggleBox.Text = state and "✓" or ""
        callback(state)
    end)
end

local function AddSlider(parent, transKey, min, max, default, callback)
    local Frame = Instance.new("Frame") Frame.Size = UDim2.new(1, 0, 0, 36) Frame.BackgroundColor3 = C_Card Frame.Parent = parent
    local Corner = Instance.new("UICorner") Corner.CornerRadius = UDim.new(0, 5) Corner.Parent = Frame
    ApplyBorder(Frame, C_BorderGrey, 1)

    local Label = Instance.new("TextLabel") Label.Size = UDim2.new(1, -55, 0, 16) Label.Position = UDim2.new(0, 8, 0, 2) Label.BackgroundTransparency = 1 Label.TextColor3 = C_Text Label.TextSize = 10 Label.Font = Enum.Font.Gotham Label.TextXAlignment = Enum.TextXAlignment.Left Label.Parent = Frame
    RegisterTranslation(Label, transKey)

    local ValInput = Instance.new("TextBox") ValInput.Size = UDim2.new(0, 45, 0, 16) ValInput.Position = UDim2.new(1, -50, 0, 2) ValInput.BackgroundTransparency = 1 ValInput.Text = tostring(default) ValInput.TextColor3 = C_AccentYellow ValInput.TextSize = 10 ValInput.Font = Enum.Font.GothamBold ValInput.TextXAlignment = Enum.TextXAlignment.Right ValInput.ClearTextOnFocus = false ValInput.Parent = Frame

    local BarBG = Instance.new("Frame") BarBG.Size = UDim2.new(1, -16, 0, 6) BarBG.Position = UDim2.new(0, 8, 0, 22) BarBG.BackgroundColor3 = C_CardLight BarBG.Parent = Frame
    local BarCorner = Instance.new("UICorner") BarCorner.CornerRadius = UDim.new(0, 3) BarCorner.Parent = BarBG

    local initialPos = math.clamp((default - min) / (max - min), 0, 1)
    local Fill = Instance.new("Frame") Fill.Size = UDim2.new(initialPos, 0, 1, 0) Fill.BackgroundColor3 = C_AccentYellow Fill.Parent = BarBG
    local FillCorner = Instance.new("UICorner") FillCorner.CornerRadius = UDim.new(0, 3) FillCorner.Parent = Fill

    local function updateValue(val)
        val = math.clamp(val, min, max)
        local pos = (val - min) / (max - min)
        Fill.Size = UDim2.new(pos, 0, 1, 0)
        ValInput.Text = tostring(val)
        callback(val)
    end

    ValInput.FocusLost:Connect(function()
        local num = tonumber(ValInput.Text)
        if num then updateValue(math.floor(num)) else ValInput.Text = tostring(default) end
    end)

    local sliding = false
    local function updateFromInput(input)
        local pos = math.clamp((input.Position.X - BarBG.AbsolutePosition.X) / BarBG.AbsoluteSize.X, 0, 1)
        local val = math.floor(min + ((max - min) * pos))
        Fill.Size = UDim2.new(pos, 0, 1, 0)
        ValInput.Text = tostring(val)
        callback(val)
    end

    BarBG.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then sliding = true updateFromInput(input) end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then sliding = false end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if sliding and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then updateFromInput(input) end
    end)
end

local function AddButton(parent, transKey, callback)
    local Btn = Instance.new("TextButton") Btn.Size = UDim2.new(1, 0, 0, 26) Btn.BackgroundColor3 = C_Card Btn.TextColor3 = C_Text Btn.TextSize = 10 Btn.Font = Enum.Font.GothamSemibold Btn.Parent = parent
    RegisterTranslation(Btn, transKey)
    local Corner = Instance.new("UICorner") Corner.CornerRadius = UDim.new(0, 5) Corner.Parent = Btn
    ApplyBorder(Btn, C_BorderGrey, 1)

    Btn.MouseButton1Click:Connect(function()
        Btn.BackgroundColor3 = C_AccentYellow Btn.TextColor3 = Color3.fromRGB(0, 0, 0)
        task.delay(0.12, function() Btn.BackgroundColor3 = C_Card Btn.TextColor3 = C_Text end)
        callback()
    end)
end

local function AddDropdown(parent, transKey, options, default, callback)
    local Frame = Instance.new("Frame") Frame.Size = UDim2.new(1, 0, 0, 28) Frame.BackgroundColor3 = C_Card Frame.Parent = parent
    local Corner = Instance.new("UICorner") Corner.CornerRadius = UDim.new(0, 5) Corner.Parent = Frame
    ApplyBorder(Frame, C_BorderGrey, 1)

    local Label = Instance.new("TextLabel") Label.Size = UDim2.new(0, 110, 1, 0) Label.Position = UDim2.new(0, 8, 0, 0) Label.BackgroundTransparency = 1 Label.TextColor3 = C_Text Label.TextSize = 10 Label.Font = Enum.Font.Gotham Label.TextXAlignment = Enum.TextXAlignment.Left Label.Parent = Frame
    RegisterTranslation(Label, transKey)

    local DropBtn = Instance.new("TextButton") DropBtn.Size = UDim2.new(0, 110, 0, 20) DropBtn.Position = UDim2.new(1, -114, 0.5, -10) DropBtn.BackgroundColor3 = C_CardLight DropBtn.Text = default DropBtn.TextColor3 = C_AccentYellow DropBtn.TextSize = 10 DropBtn.Font = Enum.Font.GothamBold DropBtn.Parent = Frame
    local DropCorner = Instance.new("UICorner") DropCorner.CornerRadius = UDim.new(0, 4) DropCorner.Parent = DropBtn

    local currentIndex = 1
    for i, v in ipairs(options) do if v == default then currentIndex = i break end end

    DropBtn.MouseButton1Click:Connect(function()
        currentIndex = (currentIndex % #options) + 1
        DropBtn.Text = options[currentIndex]
        callback(options[currentIndex])
    end)
end

local function AddPlayerSelector(parent)
    local Frame = Instance.new("Frame") Frame.Size = UDim2.new(1, 0, 0, 28) Frame.BackgroundColor3 = C_Card Frame.ClipsDescendants = true Frame.Parent = parent
    local Corner = Instance.new("UICorner") Corner.CornerRadius = UDim.new(0, 5) Corner.Parent = Frame
    ApplyBorder(Frame, C_BorderGrey, 1)

    local DropBtn = Instance.new("TextButton") DropBtn.Size = UDim2.new(1, 0, 0, 28) DropBtn.BackgroundTransparency = 1 DropBtn.TextColor3 = C_AccentYellow DropBtn.TextSize = 10 DropBtn.Font = Enum.Font.GothamBold DropBtn.TextXAlignment = Enum.TextXAlignment.Left DropBtn.Parent = Frame
    RegisterTranslation(DropBtn, "SelectPlayer")

    local ListScroll = Instance.new("ScrollingFrame") ListScroll.Size = UDim2.new(1, -10, 0, 90) ListScroll.Position = UDim2.new(0, 5, 0, 30) ListScroll.BackgroundTransparency = 1 ListScroll.ScrollBarThickness = 2 ListScroll.ScrollBarImageColor3 = C_AccentYellow ListScroll.Parent = Frame
    local ListLayout = Instance.new("UIListLayout") ListLayout.SortOrder = Enum.SortOrder.LayoutOrder ListLayout.Padding = UDim.new(0, 2) ListLayout.Parent = ListScroll

    local isOpen = false
    local function RefreshPlayers()
        for _, child in pairs(ListScroll:GetChildren()) do if child:IsA("TextButton") then child:Destroy() end end
        local refBtn = Instance.new("TextButton") refBtn.Size = UDim2.new(1, 0, 0, 20) refBtn.BackgroundColor3 = C_AccentYellow refBtn.TextColor3 = Color3.fromRGB(0, 0, 0) refBtn.TextSize = 10 refBtn.Font = Enum.Font.GothamBold refBtn.Parent = ListScroll
        RegisterTranslation(refBtn, "RefreshList")
        local refCorner = Instance.new("UICorner") refCorner.CornerRadius = UDim.new(0, 3) refCorner.Parent = refBtn
        refBtn.MouseButton1Click:Connect(RefreshPlayers)

        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer then
                local distStr = "?"
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    distStr = math.floor((LocalPlayer.Character.HumanoidRootPart.Position - p.Character.HumanoidRootPart.Position).Magnitude) .. "m"
                end
                local nameToShow = p.DisplayName ~= "" and p.DisplayName or p.Name
                local btn = Instance.new("TextButton") btn.Size = UDim2.new(1, 0, 0, 20) btn.BackgroundColor3 = C_CardLight btn.Text = nameToShow .. " (" .. distStr .. ")" btn.TextColor3 = C_Text btn.TextSize = 10 btn.Font = Enum.Font.Gotham btn.Parent = ListScroll
                local bCorner = Instance.new("UICorner") bCorner.CornerRadius = UDim.new(0, 3) bCorner.Parent = btn

                btn.MouseButton1Click:Connect(function()
                    SelectedPlayerObj = p
                    DropBtn.Text = "  " .. nameToShow
                    isOpen = false
                    Frame.Size = UDim2.new(1, 0, 0, 28)
                end)
            end
        end
    end

    DropBtn.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        if isOpen then RefreshPlayers() Frame.Size = UDim2.new(1, 0, 0, 125) else Frame.Size = UDim2.new(1, 0, 0, 28) end
    end)
end

-- Create Tabs
local TabAimbot  = CreateTab("Aimbot", "Tab_Aimbot")
local TabESP     = CreateTab("ESP", "Tab_ESP")
local TabPlayer  = CreateTab("Player", "Tab_Player")
local TabPlrMgmt = CreateTab("Player Mgmt", "Tab_PlrMgmt")
local TabWeapon  = CreateTab("Weapon", "Tab_Weapon")
local TabTroll   = CreateTab("Troll", "Tab_Troll")
local TabVisuals = CreateTab("Visuals", "Tab_Visuals")
local TabTeleport= CreateTab("Teleport", "Tab_Teleport")
local TabConfig  = CreateTab("Config", "Tab_Config")

-- Active Tab Initial
Tabs["Aimbot"].Visible = true
TabButtons["Aimbot"].BackgroundColor3 = C_AccentYellow
TabButtons["Aimbot"].TextColor3 = Color3.fromRGB(0, 0, 0)
TabButtons["Aimbot"].BackgroundTransparency = 0

---------------------------------------------------------
-- TAB CONTROLS BINDING
---------------------------------------------------------
-- 1. AIMBOT
AddSection(TabAimbot, "Sec_AimGen")
AddToggle(TabAimbot, "Aimbot", false, function(v) ConfigData.AimbotEnabled = v end)
AddDropdown(TabAimbot, "AimPart", {"Head", "HumanoidRootPart", "Torso"}, "Head", function(v) ConfigData.AimPart = v end)
AddSlider(TabAimbot, "Smoothness", 1, 20, 5, function(v) ConfigData.AimbotSmoothness = v / 10 end)

AddSection(TabAimbot, "Sec_AimFilter")
AddToggle(TabAimbot, "TeamCheck", false, function(v) ConfigData.TeamCheck = v end)
AddToggle(TabAimbot, "WallCheck", false, function(v) ConfigData.WallCheck = v end)
AddToggle(TabAimbot, "ShowFOV", false, function(v) ConfigData.ShowFOV = v end)
AddSlider(TabAimbot, "FOVSize", 30, 400, 80, function(v) ConfigData.AimbotFOV = v FOVCircle.Radius = v end)

AddSection(TabAimbot, "Sec_Hitbox")
AddToggle(TabAimbot, "Triggerbot", false, function(v) ConfigData.Triggerbot = v end)
AddToggle(TabAimbot, "Prediction", false, function(v) ConfigData.Prediction = v end)
AddToggle(TabAimbot, "HitboxExpander", false, function(v) ConfigData.HitboxExpander = v end)
AddSlider(TabAimbot, "HitboxSize", 2, 20, 2, function(v) ConfigData.HitboxSize = v end)

-- 2. ESP
AddSection(TabESP, "Sec_ESPMain")
AddToggle(TabESP, "ESP", false, function(v) ConfigData.ESPEnabled = v end)
AddToggle(TabESP, "TeamESP", false, function(v) ConfigData.ESPTeam = v end)
AddToggle(TabESP, "Box3D", false, function(v) ConfigData.ESPBox = v end)
AddToggle(TabESP, "Tracer", false, function(v) ConfigData.ESPTracer = v end)
AddToggle(TabESP, "Name", false, function(v) ConfigData.ESPName = v end)
AddToggle(TabESP, "Distance", false, function(v) ConfigData.ESPDistance = v end)

AddSection(TabESP, "Sec_ESPOpt")
AddDropdown(TabESP, "ESPColor", {"Sarı", "Kırmızı", "Yeşil", "Mavi", "Mor", "Cyan", "Beyaz"}, "Sarı", function(v)
    ConfigData.ESPColorVal = ColorPalette[v] or C_AccentYellow
end)
AddSlider(TabESP, "MaxDistance", 100, 5000, 1000, function(v) ConfigData.ESPMaxDistance = v end)

-- 3. PLAYER
AddSection(TabPlayer, "Sec_Movement")
AddToggle(TabPlayer, "WalkSpeed", false, function(v) ConfigData.SpeedHack = v end)
AddSlider(TabPlayer, "SpeedValue", 16, 250, 16, function(v) ConfigData.SpeedVal = v end)
AddToggle(TabPlayer, "JumpPower", false, function(v) ConfigData.JumpHack = v end)
AddSlider(TabPlayer, "JumpValue", 50, 300, 50, function(v) ConfigData.JumpVal = v end)

AddSection(TabPlayer, "Sec_AdvancedPlr")
AddToggle(TabPlayer, "InfJump", false, function(v) ConfigData.InfJump = v end)
AddToggle(TabPlayer, "Noclip", false, function(v) ConfigData.Noclip = v end)
AddToggle(TabPlayer, "Fly", false, function(v) ConfigData.Fly = v end)
AddSlider(TabPlayer, "FlySpeed", 10, 200, 50, function(v) ConfigData.FlySpeed = v end)
AddToggle(TabPlayer, "Spinbot", false, function(v) ConfigData.Spinbot = v end)
AddSlider(TabPlayer, "SpinSpeed", 10, 100, 45, function(v) ConfigData.SpinSpeed = v end)
AddToggle(TabPlayer, "CustomGravity", false, function(v) ConfigData.CustomGravity = v end)
AddSlider(TabPlayer, "GravityVal", 0, 300, 196, function(v) ConfigData.GravityVal = v end)

-- 4. PLAYER MGMT
AddSection(TabPlrMgmt, "Sec_PlrTarget")
AddPlayerSelector(TabPlrMgmt)
AddButton(TabPlrMgmt, "TPToPlayer", function()
    if SelectedPlayerObj and SelectedPlayerObj.Character and SelectedPlayerObj.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = SelectedPlayerObj.Character.HumanoidRootPart.CFrame
    end
end)
AddButton(TabPlrMgmt, "SpectatePlr", function()
    if SelectedPlayerObj and SelectedPlayerObj.Character and SelectedPlayerObj.Character:FindFirstChildOfClass("Humanoid") then
        Camera.CameraSubject = SelectedPlayerObj.Character:FindFirstChildOfClass("Humanoid")
    end
end)
AddButton(TabPlrMgmt, "ResetCam", function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        Camera.CameraSubject = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    end
end)
AddButton(TabPlrMgmt, "ExplodePlayer", function()
    if SelectedPlayerObj and SelectedPlayerObj.Character and SelectedPlayerObj.Character:FindFirstChild("HumanoidRootPart") then
        local exp = Instance.new("Explosion") exp.Position = SelectedPlayerObj.Character.HumanoidRootPart.Position exp.BlastRadius = 10 exp.Parent = workspace
    end
end)
AddButton(TabPlrMgmt, "ExplodeAll", function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local exp = Instance.new("Explosion") exp.Position = p.Character.HumanoidRootPart.Position exp.BlastRadius = 10 exp.Parent = workspace
        end
    end
end)

-- 5. WEAPON & KILL ALL
AddSection(TabWeapon, "Sec_KillAll")
local function StartKillAll()
    if KillAllActive then return end
    KillAllActive = true
    task.spawn(function()
        local char = LocalPlayer.Character if not char then KillAllActive = false return end
        local hrp = char:FindFirstChild("HumanoidRootPart") local hum = char:FindFirstChildOfClass("Humanoid")
        if not hrp or not hum then KillAllActive = false return end
        local savedCF = hrp.CFrame

        local tool = char:FindFirstChildOfClass("Tool") or LocalPlayer.Backpack:FindFirstChildOfClass("Tool")
        if tool then hum:EquipTool(tool) end

        for _, v in pairs(Players:GetPlayers()) do
            if not KillAllActive then break end
            if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChildOfClass("Humanoid") then
                if ConfigData.KillAllTeamCheck and v.Team == LocalPlayer.Team then continue end
                local targetHrp = v.Character.HumanoidRootPart
                local targetHum = v.Character:FindFirstChildOfClass("Humanoid")

                if (hrp.Position - targetHrp.Position).Magnitude <= ConfigData.KillAllMaxDistance and targetHum.Health > 0 then
                    local startTime = tick()
                    while KillAllActive and targetHum and targetHum.Health > 0 and v.Character and v.Character.Parent do
                        if (tick() - startTime) > 1.2 then break end
                        hrp.CFrame = targetHrp.CFrame * CFrame.new(0, 0, 1.5)
                        if tool and tool.Parent == char then
                            tool:Activate()
                            local handle = tool:FindFirstChild("Handle") or tool:FindFirstChildOfClass("BasePart")
                            if handle then
                                for _, part in pairs(v.Character:GetChildren()) do
                                    if part:IsA("BasePart") and firetouchinterest then
                                        pcall(function() firetouchinterest(handle, part, 0) firetouchinterest(handle, part, 1) end)
                                    end
                                end
                            end
                        end
                        RunService.Heartbeat:Wait()
                    end
                end
            end
        end
        if hrp then hrp.CFrame = savedCF end
        KillAllActive = false
    end)
end

KillAllQuickBtn.MouseButton1Click:Connect(StartKillAll)
AddButton(TabWeapon, "KillAllOnce", StartKillAll)
AddToggle(TabWeapon, "KillAllOnScreen", false, function(v) KillAllQuickBtn.Visible = v end)
AddSlider(TabWeapon, "KillAllDist", 50, 1000, 200, function(v) ConfigData.KillAllMaxDistance = v end)
AddToggle(TabWeapon, "KillAllTeamCheck", true, function(v) ConfigData.KillAllTeamCheck = v end)

-- 6. TROLL TAB
AddSection(TabTroll, "Sec_TrollAction")
local function StartFlingAll()
    if FlingAllActive then return end FlingAllActive = true
    task.spawn(function()
        local myChar = LocalPlayer.Character local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
        if not myHRP then FlingAllActive = false return end
        local oldCF = myHRP.CFrame

        for _, target in pairs(Players:GetPlayers()) do
            if not FlingAllActive then break end
            if target ~= LocalPlayer and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                local targetHRP = target.Character.HumanoidRootPart
                local startTime = tick()
                while FlingAllActive and targetHRP and targetHRP.Parent do
                    if (tick() - startTime) > 2.5 then break end
                    myHRP.CFrame = targetHRP.CFrame * CFrame.Angles(math.rad(math.random(-360, 360)), math.rad(math.random(-360, 360)), 0)
                    myHRP.AssemblyLinearVelocity = Vector3.new(999999, 999999, 999999)
                    RunService.Heartbeat:Wait()
                end
            end
        end
        if myHRP then myHRP.AssemblyLinearVelocity = Vector3.new(0, 0, 0) myHRP.CFrame = oldCF end
        FlingAllActive = false
    end)
end

AddButton(TabTroll, "FlingAll", StartFlingAll)
AddButton(TabTroll, "FlingStop", function() FlingAllActive = false end)
AddToggle(TabTroll, "BringPlayers", false, function(v) BringPlayersLoop = v end)
AddToggle(TabTroll, "HolePlayers", false, function(v) HolePlayersLoop = v end)
AddToggle(TabTroll, "BringVehicles", false, function(v) BringVehiclesLoop = v end)
AddToggle(TabTroll, "BringEverything", false, function(v) BringEverythingLoop = v end)
AddToggle(TabTroll, "Blackhole", false, function(v) BlackholeLoop = v end)

-- 7. VISUALS
AddSection(TabVisuals, "Sec_ScreenCam")
AddToggle(TabVisuals, "Fullbright", false, function(v) ConfigData.Fullbright = v end)
AddToggle(TabVisuals, "LockDay", false, function(v) ConfigData.LockDay = v end)
AddSlider(TabVisuals, "CamFOV", 30, 120, 70, function(v) ConfigData.CamFOVVal = v end)

AddSection(TabVisuals, "Sec_Crosshair")
AddToggle(TabVisuals, "Crosshair", false, function(v) ConfigData.CustomCrosshair = v end)
AddDropdown(TabVisuals, "CrossType", {"Dolgu Yuvarlak", "Boş Yuvarlak", "PUBG / Artı (+)"}, "Dolgu Yuvarlak", function(v) ConfigData.CrosshairType = v end)
AddDropdown(TabVisuals, "CrossColor", {"Sarı", "Kırmızı", "Yeşil", "Mavi", "Beyaz"}, "Sarı", function(v) CrosshairColor = ColorPalette[v] or C_AccentYellow end)
AddSlider(TabVisuals, "CrossSize", 2, 30, 6, function(v) ConfigData.CrosshairSize = v end)
AddSlider(TabVisuals, "CrossThick", 1, 10, 2, function(v) ConfigData.CrosshairThickness = v end)

-- 8. TELEPORT
AddSection(TabTeleport, "Sec_PosSave")
AddButton(TabTeleport, "SavePos1", function() if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then SavedPos1 = LocalPlayer.Character.HumanoidRootPart.CFrame end end)
AddButton(TabTeleport, "TPPos1", function() if SavedPos1 and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then LocalPlayer.Character.HumanoidRootPart.CFrame = SavedPos1 end end)
AddButton(TabTeleport, "SavePos2", function() if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then SavedPos2 = LocalPlayer.Character.HumanoidRootPart.CFrame end end)
AddButton(TabTeleport, "TPPos2", function() if SavedPos2 and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then LocalPlayer.Character.HumanoidRootPart.CFrame = SavedPos2 end end)

AddSection(TabTeleport, "Sec_ServerTP")
AddButton(TabTeleport, "TPMapCenter", function() if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 50, 0) end end)
AddToggle(TabTeleport, "AntiAFK", false, function(v) ConfigData.AntiAFK = v end)
AddButton(TabTeleport, "ServerHop", function() TeleportService:Teleport(game.PlaceId, LocalPlayer) end)
AddButton(TabTeleport, "Rejoin", function() TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer) end)

-- 9. CONFIG (KAYDETME & YÜKLEME SİSTEMİ)
AddSection(TabConfig, "Sec_SysLang")
AddDropdown(TabConfig, "Language", {"TR", "EN"}, "TR", function(v) CurrentLang = v UpdateAllTranslations() end)

AddSection(TabConfig, "Sec_CfgFile")
local function SaveConfigFile()
    pcall(function()
        if writefile then
            local exportData = {}
            for k, v in pairs(ConfigData) do
                if typeof(v) == "Color3" then
                    exportData[k] = {r = v.R, g = v.G, b = v.B, isColor = true}
                else
                    exportData[k] = v
                end
            end
            writefile("SavasCheat_Config.json", HttpService:JSONEncode(exportData))
        end
    end)
end

local function LoadConfigFile()
    pcall(function()
        if readfile and isfile and isfile("SavasCheat_Config.json") then
            local decoded = HttpService:JSONDecode(readfile("SavasCheat_Config.json"))
            for k, v in pairs(decoded) do
                if type(v) == "table" and v.isColor then
                    ConfigData[k] = Color3.new(v.r, v.g, v.b)
                else
                    ConfigData[k] = v
                end
            end
            FOVCircle.Radius = ConfigData.AimbotFOV
        end
    end)
end

AddButton(TabConfig, "SaveConfig", SaveConfigFile)
AddButton(TabConfig, "LoadConfig", LoadConfigFile)

---------------------------------------------------------
-- KGT ESP ENGINE
---------------------------------------------------------
local ESPTable = {}

local function CreateESP(p)
    if p == LocalPlayer then return end

    local hl = Instance.new("Highlight")
    hl.FillTransparency = 1
    hl.OutlineColor = ConfigData.ESPColorVal
    hl.Enabled = false

    local bb = Instance.new("BillboardGui")
    bb.AlwaysOnTop = true
    bb.Size = UDim2.new(0, 120, 0, 30)
    bb.StudsOffset = Vector3.new(0, 3, 0)
    bb.Enabled = false

    local lbl = Instance.new("TextLabel")
    lbl.Parent = bb
    lbl.Size = UDim2.new(1, 0, 1, 0)
    lbl.BackgroundTransparency = 1
    lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    lbl.TextStrokeTransparency = 0
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 11

    local line = Drawing.new("Line")
    line.Visible = false
    line.Color = ConfigData.ESPColorVal
    line.Thickness = 1.5

    ESPTable[p] = {Highlight = hl, Billboard = bb, Label = lbl, Tracer = line}
end

local function RemoveESP(p)
    if ESPTable[p] then
        pcall(function()
            if ESPTable[p].Highlight then ESPTable[p].Highlight:Destroy() end
            if ESPTable[p].Billboard then ESPTable[p].Billboard:Destroy() end
            if ESPTable[p].Tracer then ESPTable[p].Tracer:Remove() end
        end)
        ESPTable[p] = nil
    end
end

for _, p in pairs(Players:GetPlayers()) do CreateESP(p) end
Players.PlayerAdded:Connect(CreateESP)
Players.PlayerRemoving:Connect(RemoveESP)

RunService.RenderStepped:Connect(function()
    for p, esp in pairs(ESPTable) do
        local isTeammate = (p.Team and LocalPlayer.Team and p.Team == LocalPlayer.Team)
        local shouldShow = ConfigData.ESPEnabled and (not isTeammate or ConfigData.ESPTeam)

        if shouldShow and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character:FindFirstChildOfClass("Humanoid") and p.Character.Humanoid.Health > 0 then
            local hrp = p.Character.HumanoidRootPart
            local myHRP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            local dist = myHRP and (myHRP.Position - hrp.Position).Magnitude or 0

            if dist <= ConfigData.ESPMaxDistance then
                esp.Highlight.OutlineColor = ConfigData.ESPColorVal
                esp.Tracer.Color = ConfigData.ESPColorVal

                esp.Highlight.Parent = ConfigData.ESPBox and p.Character or nil
                esp.Highlight.Enabled = ConfigData.ESPBox

                if ConfigData.ESPName or ConfigData.ESPDistance then
                    esp.Billboard.Parent = p.Character:FindFirstChild("Head") or hrp
                    esp.Billboard.Enabled = true
                    local str = ""
                    if ConfigData.ESPName then str = str .. p.Name end
                    if ConfigData.ESPDistance then str = (str ~= "" and str .. "\n" or str) .. "[" .. math.floor(dist) .. "m]" end
                    esp.Label.Text = str
                else
                    esp.Billboard.Enabled = false
                end

                if ConfigData.ESPTracer then
                    local screenPos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
                    if onScreen then
                        esp.Tracer.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                        esp.Tracer.To = Vector2.new(screenPos.X, screenPos.Y)
                        esp.Tracer.Visible = true
                    else
                        esp.Tracer.Visible = false
                    end
                else
                    esp.Tracer.Visible = false
                end
            else
                esp.Highlight.Enabled = false esp.Billboard.Enabled = false esp.Tracer.Visible = false
            end
        else
            esp.Highlight.Enabled = false esp.Billboard.Enabled = false esp.Tracer.Visible = false
        end
    end
end)

---------------------------------------------------------
-- CORE RUN LOOPS & ENGINE LOGIC
---------------------------------------------------------
-- Key Binds
UserInputService.InputBegan:Connect(function(input, gpe)
    if not gpe and (input.KeyCode == Enum.KeyCode.Insert or input.KeyCode == Enum.KeyCode.RightShift) then
        Main.Visible = not Main.Visible
    end
end)

-- Aimbot Target Finder & WallCheck Engine
local function GetAimPart(character)
    if not character then return nil end
    if character:FindFirstChild(ConfigData.AimPart) then return character[ConfigData.AimPart] end
    return character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Head")
end

local function GetClosestTarget()
    local Closest = nil
    local ShortestDist = ConfigData.AimbotFOV
    local Center = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)

    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChildOfClass("Humanoid") then
            if ConfigData.TeamCheck and p.Team == LocalPlayer.Team then continue end
            if p.Character:FindFirstChildOfClass("Humanoid").Health > 0 then
                local part = GetAimPart(p.Character)
                if part then
                    -- WallCheck Raycast
                    if ConfigData.WallCheck then
                        local rayParams = RaycastParams.new()
                        rayParams.FilterType = Enum.RaycastFilterType.Exclude
                        rayParams.FilterDescendantsInstances = {LocalPlayer.Character, Camera}
                        local rayResult = workspace:Raycast(Camera.CFrame.Position, part.Position - Camera.CFrame.Position, rayParams)
                        if rayResult and not rayResult.Instance:IsDescendantOf(p.Character) then
                            continue
                        end
                    end

                    local screenPos, onScreen = Camera:WorldToViewportPoint(part.Position)
                    if onScreen then
                        local dist = (Vector2.new(screenPos.X, screenPos.Y) - Center).Magnitude
                        if dist < ShortestDist then ShortestDist = dist Closest = p end
                    end
                end
            end
        end
    end
    return Closest
end

-- RenderStepped Main Loop
local lastTriggerTick = 0
RunService.RenderStepped:Connect(function()
    local Center = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    FOVCircle.Position = Center
    FOVCircle.Visible = ConfigData.ShowFOV and ConfigData.AimbotEnabled

    -- Custom Crosshair
    if ConfigData.CustomCrosshair then
        if ConfigData.CrosshairType == "Dolgu Yuvarlak" or ConfigData.CrosshairType == "Boş Yuvarlak" then
            CrossCircle.Position = Center CrossCircle.Radius = ConfigData.CrosshairSize CrossCircle.Thickness = ConfigData.CrosshairThickness
            CrossCircle.Filled = (ConfigData.CrosshairType == "Dolgu Yuvarlak") CrossCircle.Color = CrosshairColor CrossCircle.Visible = true
            for _, line in pairs(CrossLines) do line.Visible = false end
        elseif ConfigData.CrosshairType == "PUBG / Artı (+)" then
            CrossCircle.Visible = false
            local gap = math.floor(ConfigData.CrosshairSize / 2)
            local length = ConfigData.CrosshairSize * 2
            CrossLines.Top.From = Vector2.new(Center.X, Center.Y - gap) CrossLines.Top.To = Vector2.new(Center.X, Center.Y - gap - length)
            CrossLines.Bottom.From = Vector2.new(Center.X, Center.Y + gap) CrossLines.Bottom.To = Vector2.new(Center.X, Center.Y + gap + length)
            CrossLines.Left.From = Vector2.new(Center.X - gap, Center.Y) CrossLines.Left.To = Vector2.new(Center.X - gap - length, Center.Y)
            CrossLines.Right.From = Vector2.new(Center.X + gap, Center.Y) CrossLines.Right.To = Vector2.new(Center.X + gap + length, Center.Y)
            for _, line in pairs(CrossLines) do line.Color = CrosshairColor line.Thickness = ConfigData.CrosshairThickness line.Visible = true end
        end
    else
        CrossCircle.Visible = false
        for _, line in pairs(CrossLines) do line.Visible = false end
    end

    -- Lighting & Visuals
    if Camera.FieldOfView ~= ConfigData.CamFOVVal then Camera.FieldOfView = ConfigData.CamFOVVal end
    if ConfigData.Fullbright then
        Lighting.Ambient = Color3.fromRGB(255, 255, 255) Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
    else
        Lighting.Ambient = DefaultAmbient Lighting.OutdoorAmbient = DefaultOutdoorAmbient
    end
    if ConfigData.LockDay then Lighting.TimeOfDay = "12:00:00" end

    -- Aimbot Execution
    if ConfigData.AimbotEnabled and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
        local target = GetClosestTarget()
        if target and target.Character then
            local part = GetAimPart(target.Character)
            if part then
                local pos = part.Position
                if ConfigData.Prediction and target.Character:FindFirstChild("HumanoidRootPart") then
                    pos = pos + (target.Character.HumanoidRootPart.AssemblyLinearVelocity * 0.165)
                end
                local curCF = Camera.CFrame
                local targetCF = CFrame.new(curCF.Position, pos)
                Camera.CFrame = curCF:Lerp(targetCF, math.clamp(1 / (ConfigData.AimbotSmoothness * 10), 0.01, 1))
            end
        end
    end

    -- Triggerbot Engine
    if ConfigData.Triggerbot and (tick() - lastTriggerTick > 0.08) then
        local mousePos = UserInputService:GetMouseLocation()
        local unitRay = Camera:ViewportPointToRay(mousePos.X, mousePos.Y)
        local rayParams = RaycastParams.new()
        rayParams.FilterType = Enum.RaycastFilterType.Exclude
        if LocalPlayer.Character then rayParams.FilterDescendantsInstances = {LocalPlayer.Character} end

        local result = workspace:Raycast(unitRay.Origin, unitRay.Direction * 1000, rayParams)
        if result and result.Instance then
            local model = result.Instance:FindFirstAncestorOfClass("Model")
            if model then
                local plr = Players:GetPlayerFromCharacter(model)
                if plr and plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChildOfClass("Humanoid") and plr.Character:FindFirstChildOfClass("Humanoid").Health > 0 then
                    if not (ConfigData.TeamCheck and plr.Team == LocalPlayer.Team) then
                        lastTriggerTick = tick()
                        if mouse1press and mouse1release then
                            mouse1press() task.wait(0.01) mouse1release()
                        else
                            local tool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")
                            if tool then tool:Activate() end
                        end
                    end
                end
            end
        end
    end
end)

-- Stepped Loop (Movement, Physics & Custom Gravity)
RunService.Stepped:Connect(function()
    if LocalPlayer.Character then
        local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then
            if ConfigData.SpeedHack then hum.WalkSpeed = ConfigData.SpeedVal end
            if ConfigData.JumpHack then hum.UseJumpPower = true hum.JumpPower = ConfigData.JumpVal end
        end

        if ConfigData.Noclip or FlingAllActive or KillAllActive then
            for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        end

        if ConfigData.Fly and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = LocalPlayer.Character.HumanoidRootPart
            hrp.AssemblyLinearVelocity = Vector3.new(0, 0.1, 0)
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then hrp.CFrame = hrp.CFrame + (Camera.CFrame.LookVector * (ConfigData.FlySpeed / 10)) end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then hrp.CFrame = hrp.CFrame - (Camera.CFrame.LookVector * (ConfigData.FlySpeed / 10)) end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then hrp.CFrame = hrp.CFrame + Vector3.new(0, ConfigData.FlySpeed / 10, 0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then hrp.CFrame = hrp.CFrame - Vector3.new(0, ConfigData.FlySpeed / 10, 0) end
        end

        if ConfigData.Spinbot and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(ConfigData.SpinSpeed), 0)
        end
    end

    -- Custom Gravity Control
    if ConfigData.CustomGravity then
        workspace.Gravity = ConfigData.GravityVal
    else
        workspace.Gravity = 196.2
    end

    -- Hitbox Expander Engine & Resetter
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = p.Character.HumanoidRootPart
            if ConfigData.HitboxExpander then
                if not (ConfigData.TeamCheck and p.Team == LocalPlayer.Team) then
                    hrp.Size = Vector3.new(ConfigData.HitboxSize, ConfigData.HitboxSize, ConfigData.HitboxSize)
                    hrp.Transparency = 0.7
                    hrp.CanCollide = false
                end
            else
                if hrp.Transparency == 0.7 and hrp.Size ~= Vector3.new(2, 2, 1) then
                    hrp.Size = Vector3.new(2, 2, 1)
                    hrp.Transparency = 1
                end
            end
        end
    end
end)

-- Heartbeat Troll Loops
RunService.Heartbeat:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local myCF = LocalPlayer.Character.HumanoidRootPart.CFrame

        if BringPlayersLoop then
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    p.Character.HumanoidRootPart.CFrame = myCF * CFrame.new(0, 0, -3)
                end
            end
        end

        if HolePlayersLoop then
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    p.Character.HumanoidRootPart.CFrame = CFrame.new(p.Character.HumanoidRootPart.Position.X, -300, p.Character.HumanoidRootPart.Position.Z)
                end
            end
        end

        if BringVehiclesLoop then
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("VehicleSeat") or v:IsA("DriveSeat") then
                    local model = v:FindFirstAncestorOfClass("Model")
                    if model then model:PivotTo(myCF * CFrame.new(0, 3, -8)) end
                end
            end
        end

        if BringEverythingLoop or BlackholeLoop then
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("BasePart") and not v.Anchored and not v:IsDescendantOf(LocalPlayer.Character) then
                    v.CFrame = myCF * CFrame.new(math.random(-5, 5), 3, math.random(-5, 5))
                end
            end
        end
    end
end)

-- Extra Events
UserInputService.JumpRequest:Connect(function()
    if ConfigData.InfJump and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

LocalPlayer.Idled:Connect(function()
    if ConfigData.AntiAFK then VirtualUser:CaptureController() VirtualUser:ClickButton2(Vector2.new()) end
end)

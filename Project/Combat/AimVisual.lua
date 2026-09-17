-- ====================================================================
-- SAVAS CHEAT v7.0 - ULTIMATE UI ENGINE [FULL & ENHANCED EDITION]
-- Key: savas.lua
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
local Mouse = LocalPlayer:GetMouse()

local DefaultAmbient = Lighting.Ambient
local DefaultOutdoorAmbient = Lighting.OutdoorAmbient

-- TAKIM KONTROL FONKSİYONU
local function IsTeammate(p)
    if not p or p == LocalPlayer then return true end
    if LocalPlayer.Neutral or p.Neutral then return false end
    if LocalPlayer.Team and p.Team then
        return LocalPlayer.Team == p.Team
    end
    if LocalPlayer.TeamColor and p.TeamColor then
        return LocalPlayer.TeamColor == p.TeamColor
    end
    return false
end

-- Dil & Çeviri Sistemi
local CurrentLang = "TR"
local UIObjectsToTranslate = {}

local Translations = {
    TR = {
        Tab_Aimbot = "🎯 Aimbot", Tab_ESP = "👁️ ESP", Tab_Player = "👤 Oyuncu",
        Tab_PlrMgmt = "👥 Oyuncular", Tab_Weapon = "⚔️ Silah / Kill", Tab_Troll = "🌀 Troll",
        Tab_Simulator = "⚡ Simulator", Tab_Visuals = "🎨 Görsel", Tab_Teleport = "📍 Teleport", Tab_Config = "⚙️ Ayarlar",

        Sec_AimGen = "Aimbot Temel Ayarları", Sec_AimFilter = "Filtreleme & FOV",
        Sec_Hitbox = "Hitbox & Silent Aim", Sec_ESPMain = "ESP Ana Sistemler",
        Sec_ESPOpt = "ESP Özel Renkler & Mesafe", Sec_Movement = "Temel Hareket Ayarları",
        Sec_AdvancedPlr = "Gelişmiş Hareket & Fake Lag", Sec_PlrTarget = "Hedef Oyuncu İşlemleri",
        Sec_KillAll = "Kill All Engine", Sec_TrollAction = "Troll & Physics Fonksiyonları",
        Sec_BringLimit = "Mesafe Sınırlayıcı (Çekme / Fling)", Sec_AutoClick = "Otomatik Tıklama (Auto Clicker)",
        Sec_ScreenCam = "Ekran & Kamera", Sec_Crosshair = "Özel Crosshair", Sec_PosSave = "Konum Kayıt",
        Sec_ServerTP = "Sunucu & TP", Sec_SysLang = "Sistem & Dil", Sec_CfgFile = "Config Yönetimi",

        Aimbot = "Aimbot Aktivasyonu", AimPart = "Hedef Bölge", Smoothness = "Yumuşaklık (Smooth)",
        TeamCheck = "Takım Kontrolü", WallCheck = "Duvar Kontrolü", ShowFOV = "FOV Çemberi Göster",
        FOVSize = "FOV Çapı", Triggerbot = "Triggerbot (Auto Fire)", Prediction = "Tahminleme (Prediction)",
        HitboxExpander = "Hitbox Büyütücü", HitboxSize = "Hitbox Boyutu", SilentAim = "Silent Aim (Sessiz Aim)",
        
        ESP = "Düşman ESP Aktivasyonu", TeamESP = "Takım ESP Aktivasyonu", Box3D = "3D Chams ESP (Kutu)", Tracer = "Tracer Çizgisi",
        FootstepESP = "Trail", Name = "İsim Göster", Distance = "Mesafe Göster", ESPColor = "ESP Rengi", MaxDistance = "Maksimum ESP Mesafesi",
        
        WalkSpeed = "Hız Hilesi", SpeedValue = "Hız Limiti", JumpPower = "Zıplama Hilesi", JumpValue = "Zıplama Limiti",
        InfJump = "Sınırsız Zıplama", Noclip = "Noclip (Duvardan Geçme)", Fly = "Fly Mode (Uçma)", FakeLag = "Fake Lag (Rakibe Laglı Görün)",
        FlySpeed = "Uçma Hızı", Spinbot = "Spinbot", SpinSpeed = "Spin Hızı", CustomGravity = "Özel Yerçekimi", GravityVal = "Yerçekimi Değeri",
        
        SelectPlayer = "  Oyuncu Seçiniz...", RefreshList = "🔄 Listeyi Yenile", TPToPlayer = "Yanına TP Ol",
        SpectatePlr = "Kamerayı Oyuncuya Bağla", ResetCam = "Kamerayı Sıfırla", ExplodePlayer = "Oyuncuyu Patlat", ExplodeAll = "Herkesi Patlat",
        
        KillAllOnce = "☠️ Kill All (Başlat/Durdur)", KillAllOnScreen = "Ekrana Hızlı Kill Butonu", KillAllDist = "Kill All Mesafesi", KillAllTeamCheck = "Takım Arkadaşlarını Vurma",
        
        StopAllTroll = "🛑 TÜM TROLL / ÇEKMELERİ DURDUR", BringMaxDist = "Max Çekme Mesafesi", FlingAll = "🚀 Fling All", FlingStop = "🛑 Fling Durdur", BringPlayers = "Herkesi Çek",
        HolePlayers = "Yere Göm", BringVehicles = "Araçları Çek", BringEverything = "Her Şeyi Çek", Blackhole = "Karadelik",
        TrollOrbit = "Hedef Etrafında Dön", TrollAttach = "Hedefe Yapış", TrollHeadSpin = "Kafa Döndürme Troll", TrollSpam = "Chat Spam Troll",
        
        AutoClicker = "Auto Clicker Aktivasyonu", ClickDelay = "Tıklama Gecikmesi (sn)",

        Fullbright = "Gece Görüşü (Fullbright)", LockDay = "Sürekli Gündüz Yap", CamFOV = "Kamera FOV",
        Crosshair = "Özel Crosshair", CrossType = "Crosshair Tipi", CrossColor = "Crosshair Rengi", CrossSize = "Crosshair Boyutu", CrossThick = "Çizgi Kalınlığı",
        
        SavePos1 = "Konum 1 Kaydet", TPPos1 = "Konum 1'e Git", SavePos2 = "Konum 2 Kaydet", TPPos2 = "Konum 2'ye Git",
        TPMapCenter = "Harita Merkezine Git", AntiAFK = "Anti AFK", ServerHop = "Sunucu Değiştir",
        Rejoin = "Tekrar Katıl", SaveConfig = "⚙️ Config Kaydet", LoadConfig = "📂 Config Yükle", Language = "Arayüz Dili"
    }
}

local function RegisterTranslation(instance, key)
    table.insert(UIObjectsToTranslate, {Instance = instance, Key = key})
    if Translations[CurrentLang] and Translations[CurrentLang][key] then
        instance.Text = Translations[CurrentLang][key]
    end
end

-- Global Config Setup
local ConfigData = {
    AimbotEnabled = false, AimPart = "Head", AimbotSmoothness = 0.5, AimbotFOV = 120,
    ShowFOV = false, TeamCheck = false, WallCheck = false, Triggerbot = false,
    Prediction = false, HitboxExpander = false, HitboxSize = 2, SilentAim = false,

    ESPEnabled = false, ESPTeam = false, ESPBox = false, ESPTracer = false,
    ESPFootstep = false, ESPName = false, ESPDistance = false, ESPMaxDistance = 1000,
    ESPColorVal = Color3.fromRGB(0, 150, 255),

    SpeedHack = false, SpeedVal = 16, JumpHack = false, JumpVal = 50, InfJump = false, Noclip = false,
    Fly = false, FlySpeed = 50, Spinbot = false, SpinSpeed = 45, FakeLag = false,
    CustomGravity = false, GravityVal = 196.2,

    BringMaxDistance = 500,

    AutoClicker = false, ClickDelay = 0.1,

    Fullbright = false, LockDay = false, CamFOVVal = 70,
    KillAllMaxDistance = 200, KillAllTeamCheck = true, KillAllSpeed = "Normal",

    CustomCrosshair = false, CrosshairType = "Dolgu Yuvarlak", CrosshairSize = 6,
    CrosshairThickness = 1.5, AntiAFK = false
}

local ColorPalette = {
    ["Mavi"] = Color3.fromRGB(0, 150, 255), ["Sarı"] = Color3.fromRGB(255, 205, 0),
    ["Kırmızı"] = Color3.fromRGB(235, 45, 45), ["Yeşil"] = Color3.fromRGB(50, 255, 50),
    ["Mor"] = Color3.fromRGB(180, 50, 255), ["Cyan"] = Color3.fromRGB(0, 255, 255),
    ["Beyaz"] = Color3.fromRGB(255, 255, 255)
}

-- Tema Renkleri
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
local TrollOrbitActive, TrollAttachActive, TrollHeadSpinActive, TrollSpamActive = false, false, false, false
local SavedPos1, SavedPos2, SelectedPlayerObj = nil, nil, nil

-- Drawings (FOV & Crosshair)
local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 1.8 FOVCircle.NumSides = 60 FOVCircle.Radius = ConfigData.AimbotFOV
FOVCircle.Filled = false FOVCircle.Visible = false FOVCircle.Color = C_AccentYellow

-- GUI Setup
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
ApplyBorder(ToggleButton, C_AccentYellow, 1.5) MakeDraggable(ToggleButton)

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

-- KEY SYSTEM
local CorrectKey = "savas.lua"
local KeyFrame = Instance.new("Frame") KeyFrame.Size = UDim2.new(0, 340, 0, 170) KeyFrame.Position = UDim2.new(0.5, -170, 0.5, -85) KeyFrame.BackgroundColor3 = C_BG KeyFrame.Parent = ScreenGui
local KeyCorner = Instance.new("UICorner") KeyCorner.CornerRadius = UDim.new(0, 8) KeyCorner.Parent = KeyFrame
ApplyBorder(KeyFrame, C_AccentYellow, 1.5) MakeDraggable(KeyFrame)

local KeyTitle = Instance.new("TextLabel") KeyTitle.Size = UDim2.new(1, 0, 0, 32) KeyTitle.Position = UDim2.new(0, 0, 0, 10) KeyTitle.BackgroundTransparency = 1
KeyTitle.Text = "SAVAS CHEAT // <font color=\"rgb(255,205,0)\">KEY SYSTEM</font>" KeyTitle.RichText = true KeyTitle.TextColor3 = C_Text KeyTitle.TextSize = 12 KeyTitle.Font = Enum.Font.GothamBold KeyTitle.Parent = KeyFrame

local KeyInput = Instance.new("TextBox") KeyInput.Size = UDim2.new(0.85, 0, 0, 32) KeyInput.Position = UDim2.new(0.075, 0, 0.35, 0) KeyInput.BackgroundColor3 = C_Card
KeyInput.PlaceholderText = "Key Giriniz (savas.lua)..." KeyInput.Text = "" KeyInput.TextColor3 = C_Text KeyInput.TextSize = 11 KeyInput.Font = Enum.Font.Gotham KeyInput.ClearTextOnFocus = false KeyInput.Parent = KeyFrame
local InputCorner = Instance.new("UICorner") InputCorner.CornerRadius = UDim.new(0, 6) InputCorner.Parent = KeyInput
ApplyBorder(KeyInput, C_BorderGrey, 1)

local SubmitBtn = Instance.new("TextButton") SubmitBtn.Size = UDim2.new(0.85, 0, 0, 32) SubmitBtn.Position = UDim2.new(0.075, 0, 0.65, 0) SubmitBtn.BackgroundColor3 = C_AccentYellow
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
KeyInput.FocusLost:Connect(function(e) if e then ValidateKey() end end)

-- UI NAVIGATION SETUP
local Sidebar = Instance.new("Frame") Sidebar.Name = "Sidebar" Sidebar.Size = UDim2.new(0, 125, 1, -34) Sidebar.Position = UDim2.new(0, 0, 0, 34) Sidebar.BackgroundColor3 = C_Sidebar Sidebar.BorderSizePixel = 0 Sidebar.Parent = Main
local SidebarList = Instance.new("UIListLayout") SidebarList.SortOrder = Enum.SortOrder.LayoutOrder SidebarList.Padding = UDim.new(0, 3) SidebarList.Parent = Sidebar
local SidebarPad = Instance.new("UIPadding") SidebarPad.PaddingTop = UDim.new(0, 6) SidebarPad.PaddingLeft = UDim.new(0, 5) SidebarPad.PaddingRight = UDim.new(0, 5) SidebarPad.Parent = Sidebar

local Content = Instance.new("Frame") Content.Name = "Content" Content.Size = UDim2.new(1, -130, 1, -38) Content.Position = UDim2.new(0, 128, 0, 36) Content.BackgroundTransparency = 1 Content.Parent = Main

local Tabs, TabButtons = {}, {}

local function CreateTab(name, transKey)
    local TabBtn = Instance.new("TextButton") TabBtn.Size = UDim2.new(1, 0, 0, 26) TabBtn.BackgroundColor3 = C_Card TabBtn.BackgroundTransparency = 0.5 TabBtn.TextColor3 = C_TextDim TabBtn.TextSize = 10 TabBtn.Font = Enum.Font.GothamSemibold TabBtn.Parent = Sidebar
    RegisterTranslation(TabBtn, transKey)
    local bCorn = Instance.new("UICorner") bCorn.CornerRadius = UDim.new(0, 5) bCorn.Parent = TabBtn

    local Scroll = Instance.new("ScrollingFrame") Scroll.Size = UDim2.new(1, 0, 1, 0) Scroll.BackgroundTransparency = 1 Scroll.ScrollBarThickness = 2 Scroll.ScrollBarImageColor3 = C_AccentYellow Scroll.Visible = false Scroll.Parent = Content
    local Layout = Instance.new("UIListLayout") Layout.SortOrder = Enum.SortOrder.LayoutOrder Layout.Padding = UDim.new(0, 6) Layout.Parent = Scroll
    local Pad = Instance.new("UIPadding") Pad.PaddingTop = UDim.new(0, 2) Pad.PaddingBottom = UDim.new(0, 10) Pad.PaddingRight = UDim.new(0, 6) Pad.Parent = Scroll

    Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        Scroll.CanvasSize = UDim2.new(0, 0, 0, Layout.AbsoluteContentSize.Y + 15)
    end)

    Tabs[name] = Scroll TabButtons[name] = TabBtn

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
    local SecLabel = Instance.new("TextLabel") SecLabel.Size = UDim2.new(1, 0, 0, 18) SecLabel.BackgroundTransparency = 1 SecLabel.TextColor3 = C_AccentYellow SecLabel.TextSize = 10 SecLabel.Font = Enum.Font.GothamBold SecLabel.TextXAlignment = Enum.TextXAlignment.Left SecLabel.Parent = parent
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

local function AddSlider(parent, transKey, min, max, default, unitSuffix, callback)
    unitSuffix = unitSuffix or "m"
    local Frame = Instance.new("Frame") Frame.Size = UDim2.new(1, 0, 0, 36) Frame.BackgroundColor3 = C_Card Frame.Parent = parent
    local Corner = Instance.new("UICorner") Corner.CornerRadius = UDim.new(0, 5) Corner.Parent = Frame
    ApplyBorder(Frame, C_BorderGrey, 1)

    local Label = Instance.new("TextLabel") Label.Size = UDim2.new(1, -75, 0, 16) Label.Position = UDim2.new(0, 8, 0, 2) Label.BackgroundTransparency = 1 Label.TextColor3 = C_Text Label.TextSize = 10 Label.Font = Enum.Font.Gotham Label.TextXAlignment = Enum.TextXAlignment.Left Label.Parent = Frame
    RegisterTranslation(Label, transKey)

    local ValInput = Instance.new("TextBox") ValInput.Size = UDim2.new(0, 65, 0, 16) ValInput.Position = UDim2.new(1, -70, 0, 2) ValInput.BackgroundTransparency = 1 ValInput.Text = tostring(default) .. unitSuffix ValInput.TextColor3 = C_AccentYellow ValInput.TextSize = 10 ValInput.Font = Enum.Font.GothamBold ValInput.TextXAlignment = Enum.TextXAlignment.Right ValInput.ClearTextOnFocus = false ValInput.Parent = Frame

    local BarBG = Instance.new("Frame") BarBG.Size = UDim2.new(1, -16, 0, 6) BarBG.Position = UDim2.new(0, 8, 0, 22) BarBG.BackgroundColor3 = C_CardLight BarBG.Parent = Frame
    local BarCorner = Instance.new("UICorner") BarCorner.CornerRadius = UDim.new(0, 3) BarCorner.Parent = BarBG

    local initialPos = math.clamp((default - min) / (max - min), 0, 1)
    local Fill = Instance.new("Frame") Fill.Size = UDim2.new(initialPos, 0, 1, 0) Fill.BackgroundColor3 = C_AccentYellow Fill.Parent = BarBG
    local FillCorner = Instance.new("UICorner") FillCorner.CornerRadius = UDim.new(0, 3) FillCorner.Parent = Fill

    local function updateValue(val)
        val = math.clamp(val, min, 100000)
        local pos = math.clamp((val - min) / (max - min), 0, 1)
        Fill.Size = UDim2.new(pos, 0, 1, 0)
        if val >= 10000 then
            ValInput.Text = "Sınırsız"
        else
            ValInput.Text = tostring(val) .. unitSuffix
        end
        callback(val)
    end

    ValInput.FocusLost:Connect(function()
        local cleanText = ValInput.Text:gsub("%D+", "")
        local num = tonumber(cleanText)
        if num then
            updateValue(num)
        else
            ValInput.Text = tostring(default) .. unitSuffix
        end
    end)

    local sliding = false
    local function updateFromInput(input)
        local pos = math.clamp((input.Position.X - BarBG.AbsolutePosition.X) / BarBG.AbsoluteSize.X, 0, 1)
        local val = math.floor(min + ((max - min) * pos))
        updateValue(val)
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
local TabAimbot    = CreateTab("Aimbot", "Tab_Aimbot")
local TabESP       = CreateTab("ESP", "Tab_ESP")
local TabPlayer    = CreateTab("Player", "Tab_Player")
local TabPlrMgmt   = CreateTab("Player Mgmt", "Tab_PlrMgmt")
local TabWeapon    = CreateTab("Weapon", "Tab_Weapon")
local TabTroll     = CreateTab("Troll", "Tab_Troll")
local TabSimulator = CreateTab("Simulator", "Tab_Simulator")
local TabVisuals   = CreateTab("Visuals", "Tab_Visuals")
local TabTeleport  = CreateTab("Teleport", "Tab_Teleport")
local TabConfig    = CreateTab("Config", "Tab_Config")

Tabs["Aimbot"].Visible = true
TabButtons["Aimbot"].BackgroundColor3 = C_AccentYellow
TabButtons["Aimbot"].TextColor3 = Color3.fromRGB(0, 0, 0)
TabButtons["Aimbot"].BackgroundTransparency = 0

---------------------------------------------------------
-- TAB DOLDURMA
---------------------------------------------------------
-- 1. AIMBOT
AddSection(TabAimbot, "Sec_AimGen")
AddToggle(TabAimbot, "Aimbot", false, function(v) ConfigData.AimbotEnabled = v end)
AddDropdown(TabAimbot, "AimPart", {"Head", "HumanoidRootPart", "Torso"}, "Head", function(v) ConfigData.AimPart = v end)
AddSlider(TabAimbot, "Smoothness", 1, 20, 5, "", function(v) ConfigData.AimbotSmoothness = v / 10 end)

AddSection(TabAimbot, "Sec_AimFilter")
AddToggle(TabAimbot, "TeamCheck", false, function(v) ConfigData.TeamCheck = v end)
AddToggle(TabAimbot, "WallCheck", false, function(v) ConfigData.WallCheck = v end)
AddToggle(TabAimbot, "ShowFOV", false, function(v) ConfigData.ShowFOV = v end)
AddSlider(TabAimbot, "FOVSize", 30, 400, 120, "px", function(v) ConfigData.AimbotFOV = v FOVCircle.Radius = v end)

AddSection(TabAimbot, "Sec_Hitbox")
AddToggle(TabAimbot, "SilentAim", false, function(v) ConfigData.SilentAim = v end)
AddToggle(TabAimbot, "Triggerbot", false, function(v) ConfigData.Triggerbot = v end)
AddToggle(TabAimbot, "Prediction", false, function(v) ConfigData.Prediction = v end)
AddToggle(TabAimbot, "HitboxExpander", false, function(v) ConfigData.HitboxExpander = v end)
AddSlider(TabAimbot, "HitboxSize", 2, 20, 2, "m", function(v) ConfigData.HitboxSize = v end)

-- 2. ESP
AddSection(TabESP, "Sec_ESPMain")
AddToggle(TabESP, "ESP", false, function(v) ConfigData.ESPEnabled = v end)
AddToggle(TabESP, "TeamESP", false, function(v) ConfigData.ESPTeam = v end)
AddToggle(TabESP, "Box3D", false, function(v) ConfigData.ESPBox = v end)
AddToggle(TabESP, "Tracer", false, function(v) ConfigData.ESPTracer = v end)
AddToggle(TabESP, "FootstepESP", false, function(v) ConfigData.ESPFootstep = v end)
AddToggle(TabESP, "Name", false, function(v) ConfigData.ESPName = v end)
AddToggle(TabESP, "Distance", false, function(v) ConfigData.ESPDistance = v end)

AddSection(TabESP, "Sec_ESPOpt")
AddDropdown(TabESP, "ESPColor", {"Mavi", "Sarı", "Kırmızı", "Yeşil", "Mor", "Cyan", "Beyaz"}, "Mavi", function(v)
    ConfigData.ESPColorVal = ColorPalette[v] or Color3.fromRGB(0, 150, 255)
end)
AddSlider(TabESP, "MaxDistance", 100, 5000, 1000, "m", function(v) ConfigData.ESPMaxDistance = v end)

-- 3. PLAYER
AddSection(TabPlayer, "Sec_Movement")
AddToggle(TabPlayer, "WalkSpeed", false, function(v) ConfigData.SpeedHack = v end)
AddSlider(TabPlayer, "SpeedValue", 16, 250, 16, "", function(v) ConfigData.SpeedVal = v end)
AddToggle(TabPlayer, "JumpPower", false, function(v) ConfigData.JumpHack = v end)
AddSlider(TabPlayer, "JumpValue", 50, 300, 50, "", function(v) ConfigData.JumpVal = v end)

AddSection(TabPlayer, "Sec_AdvancedPlr")
AddToggle(TabPlayer, "FakeLag", false, function(v) ConfigData.FakeLag = v end)
AddToggle(TabPlayer, "InfJump", false, function(v) ConfigData.InfJump = v end)
AddToggle(TabPlayer, "Noclip", false, function(v) ConfigData.Noclip = v end)
AddToggle(TabPlayer, "Fly", false, function(v) ConfigData.Fly = v end)
AddSlider(TabPlayer, "FlySpeed", 10, 200, 50, "", function(v) ConfigData.FlySpeed = v end)
AddToggle(TabPlayer, "Spinbot", false, function(v) ConfigData.Spinbot = v end)
AddSlider(TabPlayer, "SpinSpeed", 10, 100, 45, "", function(v) ConfigData.SpinSpeed = v end)
AddToggle(TabPlayer, "CustomGravity", false, function(v) ConfigData.CustomGravity = v end)
AddSlider(TabPlayer, "GravityVal", 0, 500, 196, "", function(v) ConfigData.GravityVal = v end)

-- 4. PLAYER MGMT
AddSection(TabPlrMgmt, "Sec_PlrTarget")
AddPlayerSelector(TabPlrMgmt)
AddButton(TabPlrMgmt, "TPToPlayer", function()
    if SelectedPlayerObj and SelectedPlayerObj.Character and SelectedPlayerObj.Character:FindFirstChild("HumanoidRootPart") then
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = SelectedPlayerObj.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -3)
        end
    end
end)
AddButton(TabPlrMgmt, "SpectatePlr", function()
    if SelectedPlayerObj and SelectedPlayerObj.Character and SelectedPlayerObj.Character:FindFirstChild("Humanoid") then
        Camera.CameraSubject = SelectedPlayerObj.Character.Humanoid
    end
end)
AddButton(TabPlrMgmt, "ResetCam", function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        Camera.CameraSubject = LocalPlayer.Character.Humanoid
    end
end)

-- 5. WEAPON & KILL
AddSection(TabWeapon, "Sec_KillAll")
AddButton(TabWeapon, "KillAllOnce", function()
    KillAllActive = not KillAllActive
end)
AddSlider(TabWeapon, "KillAllDist", 50, 1000, 200, "m", function(v) ConfigData.KillAllMaxDistance = v end)
AddToggle(TabWeapon, "KillAllTeamCheck", true, function(v) ConfigData.KillAllTeamCheck = v end)

-- 6. TROLL
AddSection(TabTroll, "Sec_BringLimit")
AddSlider(TabTroll, "BringMaxDist", 100, 5000, 500, "m", function(v)
    ConfigData.BringMaxDistance = v
end)

AddSection(TabTroll, "Sec_TrollAction")

AddButton(TabTroll, "StopAllTroll", function()
    BringPlayersLoop = false
    HolePlayersLoop = false
    BringVehiclesLoop = false
    BringEverythingLoop = false
    BlackholeLoop = false
    FlingAllActive = false
    TrollOrbitActive = false
    TrollAttachActive = false
    TrollHeadSpinActive = false
    TrollSpamActive = false
end)

AddButton(TabTroll, "FlingAll", function() FlingAllActive = not FlingAllActive end)
AddButton(TabTroll, "BringPlayers", function() BringPlayersLoop = not BringPlayersLoop end)
AddButton(TabTroll, "HolePlayers", function() HolePlayersLoop = not HolePlayersLoop end)
AddButton(TabTroll, "BringVehicles", function() BringVehiclesLoop = not BringVehiclesLoop end)
AddButton(TabTroll, "BringEverything", function() BringEverythingLoop = not BringEverythingLoop end)
AddButton(TabTroll, "Blackhole", function() BlackholeLoop = not BlackholeLoop end)

AddButton(TabTroll, "TrollOrbit", function() TrollOrbitActive = not TrollOrbitActive end)
AddButton(TabTroll, "TrollAttach", function() TrollAttachActive = not TrollAttachActive end)
AddButton(TabTroll, "TrollHeadSpin", function() TrollHeadSpinActive = not TrollHeadSpinActive end)
AddButton(TabTroll, "TrollSpam", function()
    TrollSpamActive = not TrollSpamActive
    if TrollSpamActive then
        task.spawn(function()
            while TrollSpamActive do
                pcall(function()
                    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("SAVAS CHEAT v7.0 ON TOP!", "All")
                end)
                task.wait(2.5)
            end
        end)
    end
end)

-- 7. SIMULATOR
AddSection(TabSimulator, "Sec_AutoClick")
AddToggle(TabSimulator, "AutoClicker", false, function(v) ConfigData.AutoClicker = v end)
AddSlider(TabSimulator, "ClickDelay", 1, 10, 1, "s", function(v) ConfigData.ClickDelay = v / 10 end)

-- 8. VISUALS
AddSection(TabVisuals, "Sec_ScreenCam")
AddToggle(TabVisuals, "Fullbright", false, function(v)
    ConfigData.Fullbright = v
    if not v then Lighting.Ambient = DefaultAmbient Lighting.OutdoorAmbient = DefaultOutdoorAmbient end
end)
AddToggle(TabVisuals, "LockDay", false, function(v) ConfigData.LockDay = v end)
AddSlider(TabVisuals, "CamFOV", 50, 120, 70, "", function(v) Camera.FieldOfView = v end)

-- 9. TELEPORT
AddSection(TabTeleport, "Sec_PosSave")
AddButton(TabTeleport, "SavePos1", function() if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then SavedPos1 = LocalPlayer.Character.HumanoidRootPart.CFrame end end)
AddButton(TabTeleport, "TPPos1", function() if SavedPos1 and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then LocalPlayer.Character.HumanoidRootPart.CFrame = SavedPos1 end end)
AddButton(TabTeleport, "SavePos2", function() if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then SavedPos2 = LocalPlayer.Character.HumanoidRootPart.CFrame end end)
AddButton(TabTeleport, "TPPos2", function() if SavedPos2 and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then LocalPlayer.Character.HumanoidRootPart.CFrame = SavedPos2 end end)

AddSection(TabTeleport, "Sec_ServerTP")
AddButton(TabTeleport, "AntiAFK", function()
    LocalPlayer.Idled:Connect(function()
        VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end)
end)
AddButton(TabTeleport, "Rejoin", function() TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer) end)

-- 10. CONFIG
AddSection(TabConfig, "Sec_SysLang")
AddDropdown(TabConfig, "Language", {"TR", "EN"}, "TR", function(v)
    CurrentLang = v
    for _, item in ipairs(UIObjectsToTranslate) do
        if item.Instance and Translations[CurrentLang] and Translations[CurrentLang][item.Key] then
            item.Instance.Text = Translations[CurrentLang][item.Key]
        end
    end
end)

---------------------------------------------------------
-- CORE ENGINE LOGIC & MISSING LOOPS
---------------------------------------------------------

-- AUTO CLICKER ENGINE
task.spawn(function()
    while true do
        task.wait(ConfigData.ClickDelay or 0.1)
        if ConfigData.AutoClicker then
            pcall(function()
                if mouse1click then
                    mouse1click()
                else
                    VirtualUser:Button1Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
                    task.wait(0.02)
                    VirtualUser:Button1Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
                end
            end)
        end
    end
end)

-- 1. FOV CIRCLE FIXATION
RunService.RenderStepped:Connect(function()
    local viewportSize = Camera.ViewportSize
    FOVCircle.Position = Vector2.new(viewportSize.X / 2, viewportSize.Y / 2)
    FOVCircle.Visible = ConfigData.ShowFOV
end)

-- EN YAKIN HEDEF BULUCU
local function GetClosestTarget()
    local center = Camera.ViewportSize / 2
    local closest, minDist = nil, ConfigData.AimbotFOV

    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
            if not (ConfigData.TeamCheck and IsTeammate(p)) then
                local part = p.Character:FindFirstChild(ConfigData.AimPart) or p.Character:FindFirstChild("Head")
                if part then
                    local screenPos, onScreen = Camera:WorldToViewportPoint(part.Position)
                    if onScreen then
                        local dist = (Vector2.new(screenPos.X, screenPos.Y) - center).Magnitude
                        if dist < minDist then
                            closest = part
                            minDist = dist
                        end
                    end
                end
            end
        end
    end
    return closest
end

-- 2. AIMBOT & TRIGGERBOT ENGINE
RunService.RenderStepped:Connect(function()
    if ConfigData.AimbotEnabled and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
        local targetPart = GetClosestTarget()
        if targetPart then
            local currentCF = Camera.CFrame
            local targetCF = CFrame.new(currentCF.Position, targetPart.Position)
            Camera.CFrame = currentCF:Lerp(targetCF, ConfigData.AimbotSmoothness)
        end
    end

    if ConfigData.Triggerbot and Mouse.Target then
        local model = Mouse.Target:FindFirstAncestorOfClass("Model")
        if model then
            local plr = Players:GetPlayerFromCharacter(model)
            if plr and plr ~= LocalPlayer and not (ConfigData.TeamCheck and IsTeammate(plr)) then
                pcall(function()
                    if mouse1click then
                        mouse1click()
                    else
                        VirtualUser:Button1Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
                        task.wait(0.05)
                        VirtualUser:Button1Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
                    end
                end)
            end
        end
    end
end)

-- 3. SILENT AIM HOOK (GELİŞTİRİLDİ)
local rawmt = getrawmetatable(game)
if rawmt and setreadonly then
    setreadonly(rawmt, false)
    local oldNamecall = rawmt.__namecall
    rawmt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        if ConfigData.SilentAim then
            local targetPart = GetClosestTarget()
            if targetPart then
                local args = {...}
                if method == "Raycast" then
                    args[2] = (targetPart.Position - args[1]).Unit * 1000
                    return oldNamecall(self, unpack(args))
                elseif method == "FindPartOnRayWithIgnoreList" or method == "FindPartOnRay" then
                    local origin = args[1].Origin
                    local direction = (targetPart.Position - origin).Unit * 1000
                    args[1] = Ray.new(origin, direction)
                    return oldNamecall(self, unpack(args))
                end
            end
        end
        return oldNamecall(self, ...)
    end)
    setreadonly(rawmt, true)
end

-- 4. HITBOX EXPANDING ENGINE
RunService.RenderStepped:Connect(function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = p.Character.HumanoidRootPart
            if ConfigData.HitboxExpander and not (ConfigData.TeamCheck and IsTeammate(p)) then
                hrp.Size = Vector3.new(ConfigData.HitboxSize, ConfigData.HitboxSize, ConfigData.HitboxSize)
                hrp.Transparency = 0.7
                hrp.CanCollide = false
            else
                hrp.Size = Vector3.new(2, 2, 1)
                hrp.Transparency = 1
            end
        end
    end
end)

-- 5. FLY ENGINE
local flyBV, flyBG = nil, nil
RunService.RenderStepped:Connect(function()
    if ConfigData.Fly and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = LocalPlayer.Character.HumanoidRootPart
        if not flyBV or not flyBV.Parent then
            flyBV = Instance.new("BodyVelocity")
            flyBV.MaxForce = Vector3.new(1e9, 1e9, 1e9)
            flyBV.Parent = hrp
        end
        if not flyBG or not flyBG.Parent then
            flyBG = Instance.new("BodyGyro")
            flyBG.MaxTorque = Vector3.new(1e9, 1e9, 1e9)
            flyBG.P = 9e4
            flyBG.Parent = hrp
        end

        flyBG.CFrame = Camera.CFrame
        local moveDir = Vector3.zero
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + Camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - Camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - Camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + Camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDir = moveDir + Vector3.new(0, 1, 0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then moveDir = moveDir - Vector3.new(0, 1, 0) end

        flyBV.Velocity = moveDir.Magnitude > 0 and (moveDir.Unit * ConfigData.FlySpeed) or Vector3.zero
    else
        if flyBV then flyBV:Destroy() flyBV = nil end
        if flyBG then flyBG:Destroy() flyBG = nil end
    end
end)

-- 6. NOCLIP ENGINE
RunService.Stepped:Connect(function()
    if ConfigData.Noclip and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

-- 7. VISUALS ENFORCER (LIGHTING & GRAVITY)
RunService.RenderStepped:Connect(function()
    if ConfigData.Fullbright then
        Lighting.Ambient = Color3.fromRGB(255, 255, 255)
        Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
        Lighting.Brightness = 2
        Lighting.FogEnd = 100000
    end
    if ConfigData.LockDay then
        Lighting.ClockTime = 12
    end
    if ConfigData.CustomGravity then
        workspace.Gravity = ConfigData.GravityVal
    else
        workspace.Gravity = 196.2
    end
end)

-- 8. FAKE LAG ENGINE
local fakeLagTimer = tick()
RunService.Heartbeat:Connect(function()
    if ConfigData.FakeLag and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = LocalPlayer.Character.HumanoidRootPart
        if tick() - fakeLagTimer >= 0.15 then
            hrp.Anchored = true
            task.wait(0.08)
            hrp.Anchored = false
            fakeLagTimer = tick()
        end
    end
end)

-- 9. ESP ENGINE
local ESPHolders = {}

local function ClearESP(p)
    if ESPHolders[p] then
        for _, v in pairs(ESPHolders[p]) do
            pcall(function()
                v.Visible = false
                v:Remove()
            end)
        end
        ESPHolders[p] = nil
    end
end

Players.PlayerRemoving:Connect(ClearESP)

RunService.RenderStepped:Connect(function()
    for p in pairs(ESPHolders) do
        if not p or not p.Parent or not p.Character or not p.Character:FindFirstChild("Humanoid") or p.Character.Humanoid.Health <= 0 then
            ClearESP(p)
        end
    end

    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
            local isTeam = IsTeammate(p)
            local shouldDraw = false

            if isTeam and ConfigData.ESPTeam then
                shouldDraw = true
            elseif not isTeam and ConfigData.ESPEnabled then
                shouldDraw = true
            end

            local hrp = p.Character.HumanoidRootPart
            local myHrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            local dist = myHrp and (myHrp.Position - hrp.Position).Magnitude or 0

            if shouldDraw and dist <= ConfigData.ESPMaxDistance then
                if not ESPHolders[p] then
                    ESPHolders[p] = {
                        Tracer = Drawing.new("Line"),
                        Name = Drawing.new("Text"),
                        Box = Drawing.new("Square")
                    }
                end

                local draw = ESPHolders[p]
                local screenPos, onScreen = Camera:WorldToViewportPoint(hrp.Position)

                if onScreen then
                    local color = isTeam and Color3.fromRGB(50, 255, 50) or ConfigData.ESPColorVal

                    local boxWidth = 2000 / screenPos.Z
                    local boxHeight = 3000 / screenPos.Z
                    local boxPosX = screenPos.X - (boxWidth / 2)
                    local boxPosY = screenPos.Y - (boxHeight / 2)

                    -- Tracer
                    draw.Tracer.Visible = ConfigData.ESPTracer
                    draw.Tracer.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                    draw.Tracer.To = Vector2.new(screenPos.X, screenPos.Y)
                    draw.Tracer.Color = color
                    draw.Tracer.Thickness = 1.2

                    -- Box
                    draw.Box.Visible = ConfigData.ESPBox
                    draw.Box.Size = Vector2.new(boxWidth, boxHeight)
                    draw.Box.Position = Vector2.new(boxPosX, boxPosY)
                    draw.Box.Color = color
                    draw.Box.Thickness = 1.5

                    -- Name & Distance
                    draw.Name.Visible = ConfigData.ESPName or ConfigData.ESPDistance
                    local textStr = ""
                    if ConfigData.ESPName then textStr = textStr .. p.Name .. " " end
                    if ConfigData.ESPDistance then textStr = textStr .. "[" .. math.floor(dist) .. "m]" end
                    draw.Name.Text = textStr
                    draw.Name.Position = Vector2.new(screenPos.X, boxPosY - 18)
                    draw.Name.Color = Color3.fromRGB(255, 255, 255)
                    draw.Name.Size = 16
                    draw.Name.Center = true
                    draw.Name.Outline = true
                else
                    draw.Tracer.Visible = false
                    draw.Name.Visible = false
                    draw.Box.Visible = false
                end
            else
                ClearESP(p)
            end
        else
            ClearESP(p)
        end
    end
end)

-- 10. BLUE BELLY TRAIL ENGINE
local TrailFolder = workspace:FindFirstChild("SavasTrailFolder") or Instance.new("Folder")
TrailFolder.Name = "SavasTrailFolder"
TrailFolder.Parent = workspace

local blueColor = Color3.fromRGB(0, 150, 255)
local blueSeq = ColorSequence.new(blueColor)

local function CreateBellyTrail(char)
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local a0 = hrp:FindFirstChild("BellyTrailA0") or Instance.new("Attachment")
    a0.Name = "BellyTrailA0"
    a0.Position = Vector3.new(0, 0.3, 0)
    a0.Parent = hrp

    local a1 = hrp:FindFirstChild("BellyTrailA1") or Instance.new("Attachment")
    a1.Name = "BellyTrailA1"
    a1.Position = Vector3.new(0, -0.3, 0)
    a1.Parent = hrp

    local trail = hrp:FindFirstChild("BellyTrail") or Instance.new("Trail")
    trail.Name = "BellyTrail"
    trail.Attachment0 = a0
    trail.Attachment1 = a1
    trail.Lifetime = 3.5
    trail.MinLength = 0.05
    trail.FaceCamera = true
    trail.LightInfluence = 0
    trail.Color = blueSeq
    trail.WidthScale = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(1, 0)
    })
    trail.Parent = hrp
    return trail
end

local lastNodeTime = {}

RunService.Heartbeat:Connect(function()
    local now = tick()
    for _, p in pairs(Players:GetPlayers()) do
        if p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
            local hrp = p.Character.HumanoidRootPart
            local active = ConfigData.ESPFootstep and (p == LocalPlayer or not (ConfigData.TeamCheck and IsTeammate(p)))

            if active then
                local trail = hrp:FindFirstChild("BellyTrail") or CreateBellyTrail(p.Character)
                if trail then
                    trail.Enabled = true
                    trail.Color = blueSeq
                end

                if not lastNodeTime[p] or (now - lastNodeTime[p]) >= 0.05 then
                    lastNodeTime[p] = now
                    
                    local bellyPos = hrp.Position
                    local node = Instance.new("SphereHandleAdornment")
                    node.Name = "TrailNode"
                    node.Color3 = blueColor
                    node.Radius = 0.35
                    node.AlwaysOnTop = true
                    node.ZIndex = 10
                    node.Transparency = 0.2
                    node.Adornee = workspace.Terrain
                    node.CFrame = CFrame.new(bellyPos)
                    node.Parent = TrailFolder

                    TweenService:Create(node, TweenInfo.new(3.5, Enum.EasingStyle.Linear), {
                        Transparency = 1,
                        Radius = 0.05
                    }):Play()

                    task.delay(3.5, function()
                        pcall(function() node:Destroy() end)
                    end)
                end
            else
                local trail = hrp:FindFirstChild("BellyTrail")
                if trail then
                    trail.Enabled = false
                end
            end
        end
    end
end)

-- 11. KILL ALL & TROLL LOOPS
task.spawn(function()
    while true do
        task.wait(0.05)
        if KillAllActive and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local myHrp = LocalPlayer.Character.HumanoidRootPart
            for _, p in pairs(Players:GetPlayers()) do
                if not KillAllActive then break end
                if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
                    if not (ConfigData.KillAllTeamCheck and IsTeammate(p)) then
                        local targetHrp = p.Character.HumanoidRootPart
                        local dist = (targetHrp.Position - myHrp.Position).Magnitude
                        if dist <= ConfigData.KillAllMaxDistance then
                            myHrp.CFrame = targetHrp.CFrame * CFrame.new(0, 0, 2)
                            task.wait(0.05)
                        end
                    end
                end
            end
        end
    end
end)

RunService.Heartbeat:Connect(function()
    local myHrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not myHrp then return end

    local maxDist = ConfigData.BringMaxDistance

    if BringPlayersLoop then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local targetHrp = p.Character.HumanoidRootPart
                if (targetHrp.Position - myHrp.Position).Magnitude <= maxDist then
                    targetHrp.CFrame = myHrp.CFrame * CFrame.new(0, 0, -4)
                end
            end
        end
    end

    if HolePlayersLoop then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local targetHrp = p.Character.HumanoidRootPart
                if (targetHrp.Position - myHrp.Position).Magnitude <= maxDist then
                    targetHrp.CFrame = myHrp.CFrame * CFrame.new(0, -6, -4)
                end
            end
        end
    end

    if BringVehiclesLoop then
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("VehicleSeat") and obj.Parent then
                local vehModel = obj.Parent
                local primary = vehModel.PrimaryPart or obj
                if primary and (primary.Position - myHrp.Position).Magnitude <= maxDist then
                    primary.CFrame = myHrp.CFrame * CFrame.new(0, 0, -8)
                end
            end
        end
    end

    if BringEverythingLoop then
        for _, part in pairs(workspace:GetDescendants()) do
            if part:IsA("BasePart") and not part.Anchored and not part:IsDescendantOf(LocalPlayer.Character) then
                if (part.Position - myHrp.Position).Magnitude <= maxDist then
                    part.CFrame = myHrp.CFrame * CFrame.new(0, 0, -5)
                end
            end
        end
    end

    if BlackholeLoop then
        local angle = tick() * 3
        local radius = 10
        local idx = 0
        for _, part in pairs(workspace:GetDescendants()) do
            if part:IsA("BasePart") and not part.Anchored and not part:IsDescendantOf(LocalPlayer.Character) then
                if (part.Position - myHrp.Position).Magnitude <= maxDist then
                    idx = idx + 1
                    local offset = Vector3.new(math.cos(angle + idx) * radius, math.sin(angle + idx) * 5, math.sin(angle + idx) * radius)
                    part.CFrame = myHrp.CFrame * CFrame.new(0, 5, -15) + offset
                end
            end
        end
    end

    if FlingAllActive then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local targetHrp = p.Character.HumanoidRootPart
                if (targetHrp.Position - myHrp.Position).Magnitude <= maxDist then
                    myHrp.CFrame = targetHrp.CFrame * CFrame.new(0, 0, 0)
                    myHrp.AssemblyLinearVelocity = Vector3.new(99999, 99999, 99999)
                    myHrp.AssemblyAngularVelocity = Vector3.new(99999, 99999, 99999)
                end
            end
        end
    end

    if SpinbotActive or ConfigData.Spinbot then
        myHrp.CFrame = myHrp.CFrame * CFrame.Angles(0, math.rad(ConfigData.SpinSpeed), 0)
    end

    if TrollOrbitActive and SelectedPlayerObj and SelectedPlayerObj.Character and SelectedPlayerObj.Character:FindFirstChild("HumanoidRootPart") then
        local tHrp = SelectedPlayerObj.Character.HumanoidRootPart
        local angle = tick() * 5
        myHrp.CFrame = tHrp.CFrame * CFrame.new(math.cos(angle) * 6, 2, math.sin(angle) * 6)
    end

    if TrollAttachActive and SelectedPlayerObj and SelectedPlayerObj.Character and SelectedPlayerObj.Character:FindFirstChild("HumanoidRootPart") then
        local tHrp = SelectedPlayerObj.Character.HumanoidRootPart
        myHrp.CFrame = tHrp.CFrame * CFrame.new(0, 0, 1.5)
    end

    if TrollHeadSpinActive and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head") then
        LocalPlayer.Character.Head.CFrame = LocalPlayer.Character.Head.CFrame * CFrame.Angles(0, math.rad(45), 0)
    end
end)

-- 12. PLAYER MOVEMENT HOOKS
RunService.Stepped:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        local hum = LocalPlayer.Character.Humanoid
        if ConfigData.SpeedHack then hum.WalkSpeed = ConfigData.SpeedVal end
        if ConfigData.JumpHack then hum.JumpPower = ConfigData.JumpVal end
    end
end)

UserInputService.JumpRequest:Connect(function()
    if ConfigData.InfJump and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

print("[SAVAS CHEAT v7.0] Başarıyla yüklendi ve tüm motorlar aktifleştirildi!")

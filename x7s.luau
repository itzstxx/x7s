local MaintenanceEnabled = false

if MaintenanceEnabled then
    local _pl=game:GetService("Players").LocalPlayer
    local _pg=_pl:WaitForChild("PlayerGui")
    local _li=game:GetService("Lighting")
    local _ts=game:GetService("TweenService")
    local _blur=Instance.new("BlurEffect"); _blur.Size=14; _blur.Parent=_li
    local _sg=Instance.new("ScreenGui"); _sg.Name="x7sMain"
    _sg.IgnoreGuiInset=true; _sg.ResetOnSpawn=false; _sg.Parent=_pg
    local _m=Instance.new("Frame"); _m.AnchorPoint=Vector2.new(0.5,0.5)
    _m.Position=UDim2.new(0.5,0,0.5,0); _m.Size=UDim2.new(0,520,0,300)
    _m.BackgroundColor3=Color3.fromRGB(8,6,12); _m.BackgroundTransparency=0.1
    _m.BorderSizePixel=0; _m.Parent=_sg
    Instance.new("UICorner",_m).CornerRadius=UDim.new(0,16)
    local _ms=Instance.new("UIStroke",_m)
    _ms.Color=Color3.fromRGB(141,122,174); _ms.Transparency=0.65; _ms.Thickness=1
    local _mg=Instance.new("UIGradient",_m)
    _mg.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(13,9,20)),ColorSequenceKeypoint.new(1,Color3.fromRGB(5,4,8))})
    _mg.Rotation=30
    local function _lbl(txt,sz,col,y,h)
        local l=Instance.new("TextLabel",_m); l.BackgroundTransparency=1
        l.Size=UDim2.new(1,-60,0,h or 36); l.Position=UDim2.new(0,30,0,y)
        l.Text=txt; l.TextColor3=col; l.Font=Enum.Font.GothamBold
        l.TextSize=sz; l.TextWrapped=true; l.TextXAlignment=Enum.TextXAlignment.Center
        return l
    end
    _lbl("✝  Sistema en Mantenimiento  ✝",22,Color3.fromRGB(141,122,174),40)
    local _div=Instance.new("Frame",_m); _div.Size=UDim2.new(1,-60,0,1)
    _div.Position=UDim2.new(0,30,0,90); _div.BackgroundColor3=Color3.fromRGB(141,122,174)
    _div.BackgroundTransparency=0.6; _div.BorderSizePixel=0
    _lbl("El sistema fue deshabilitado temporalmente.\nVolveremos cuando sea seguro utilizarlo.",15,Color3.fromRGB(180,165,205),104,60)
    local _sc=Instance.new("Frame",_m); _sc.Size=UDim2.new(1,-60,0,56)
    _sc.Position=UDim2.new(0,30,0,188); _sc.BackgroundColor3=Color3.fromRGB(18,14,26)
    _sc.BackgroundTransparency=0.1; _sc.BorderSizePixel=0
    Instance.new("UICorner",_sc).CornerRadius=UDim.new(0,12)
    local _dot=Instance.new("Frame",_sc); _dot.Size=UDim2.fromOffset(14,14)
    _dot.Position=UDim2.new(0,18,0.5,-7); _dot.BackgroundColor3=Color3.fromRGB(200,80,80)
    _dot.BorderSizePixel=0; Instance.new("UICorner",_dot).CornerRadius=UDim.new(1,0)
    local _sl=Instance.new("TextLabel",_sc); _sl.BackgroundTransparency=1
    _sl.Size=UDim2.new(1,-50,0,18); _sl.Position=UDim2.new(0,46,0,9)
    _sl.Text="ESTADO DEL SISTEMA"; _sl.TextColor3=Color3.fromRGB(90,80,110)
    _sl.Font=Enum.Font.GothamMedium; _sl.TextSize=11; _sl.TextXAlignment=Enum.TextXAlignment.Left
    local _sm=Instance.new("TextLabel",_sc); _sm.BackgroundTransparency=1
    _sm.Size=UDim2.new(1,-50,0,24); _sm.Position=UDim2.new(0,46,0,28)
    _sm.Text="OFFLINE"; _sm.TextColor3=Color3.fromRGB(200,80,80)
    _sm.Font=Enum.Font.GothamBold; _sm.TextSize=20; _sm.TextXAlignment=Enum.TextXAlignment.Left
    local _cb=Instance.new("TextButton",_m); _cb.Size=UDim2.fromOffset(30,30)
    _cb.Position=UDim2.new(1,-40,0,10); _cb.BackgroundColor3=Color3.fromRGB(30,22,42)
    _cb.BorderSizePixel=0; _cb.Text="✕"; _cb.TextColor3=Color3.fromRGB(200,170,220)
    _cb.Font=Enum.Font.GothamBold; _cb.TextSize=13
    Instance.new("UICorner",_cb).CornerRadius=UDim.new(1,0)
    _cb.MouseButton1Click:Connect(function()
        _ts:Create(_m,TweenInfo.new(0.18,Enum.EasingStyle.Quad),{BackgroundTransparency=1,Size=UDim2.new(0,490,0,280)}):Play()
        for _,v in ipairs(_m:GetDescendants()) do
            if v:IsA("TextLabel") or v:IsA("TextButton") then _ts:Create(v,TweenInfo.new(0.15),{TextTransparency=1}):Play() end
        end
        task.wait(0.2); if _blur then _blur:Destroy() end; _sg:Destroy()
    end)
    return
end

local Players          = game:GetService("Players")
local TweenService     = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService       = game:GetService("RunService")
local Workspace        = game:GetService("Workspace")
local HttpService      = game:GetService("HttpService")

local player    = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local camera    = Workspace.CurrentCamera

local CONFIG_FILE = "x7s_v1.json"

local function mkDefault()
    return {
        esp_on=false, esp_names=false, esp_lines=false, esp_key="T",
        hbx_on=false, hbx_size=5, hbx_show=false, hbx_key="G",
        trg_on=false, trg_key="R",
        summer_on=false,
        kill_on=false, kill_keep=false, kill_bubble=false,
        panel_bg=true, notifs=true, lang="English", gui_key="RightShift",
    }
end
local S = mkDefault()
pcall(function()
    local d = HttpService:JSONDecode(readfile(CONFIG_FILE))
    for k,v in pairs(S) do if d[k]~=nil then S[k]=d[k] end end
end)
local function save() pcall(function() writefile(CONFIG_FILE,HttpService:JSONEncode(S)) end) end

local Locale = {
    English = {
        tab_esp="ESP", tab_hbx="HBX", tab_trg="TRG", tab_evt="EVT", tab_kll="KILL", tab_cfg="CFG",
        
        esp_on="Enable ESP",        esp_on_d="Show enemies through walls.",
        esp_names="Show Enemy Name",
        esp_lines="ESP Lines",      esp_lines_d="Draw lines from your character to enemy positions.",
        esp_key="ESP Keybind",
        
        hbx_on="Enable Hitbox",     hbx_on_d="Show and expand enemy hitboxes.",
        hbx_size="Hitbox Size",
        hbx_show="Show Hitbox",
        hbx_key="Hitbox Keybind",
        
        trg_on="Triggerbot",        trg_on_d="Shoots when your cursor is directly over a visible enemy.",
        trg_key="Triggerbot Keybind",
        
        ev_sum="Summer 2026",       ev_sum_d="Collects Summer 2026 drops automatically. Only in matches.",
        
        kl_on="Kill All Enemies",   kl_on_d="Instantly eliminates enemies when enabled.",
        kl_keep="Keep Enabled",     kl_keep_d="Keeps Kill All enabled and prevents it from turning off.",
        kl_bbl="Kill All Bubble",   kl_bbl_d="Show a small Kill All button on screen.",
        
        st_bg="Toggle Panel Background",
        st_notif="Enable Notifications",
        st_lang="Language",
        st_key="Toggle UI",
        st_r1="Reset Toggle UI Keybind",  st_r1_d="Reset this keybind to its default value.",
        st_r2="Reset All Keybinds",       st_r2_d="Reset all keybinds to their default values.",
        
        n_on="Enabled", n_off="Disabled", n_reset="Keybind reset",
    },
    ["Español"] = {
        tab_esp="ESP", tab_hbx="HBX", tab_trg="TRG", tab_evt="EVT", tab_kll="MATAR", tab_cfg="CFG",
        esp_on="Activar ESP",        esp_on_d="Muestra enemigos a través de paredes.",
        esp_names="Nombre del Enemigo",
        esp_lines="Líneas ESP",      esp_lines_d="Dibuja líneas desde tu personaje hasta los enemigos.",
        esp_key="Tecla ESP",
        hbx_on="Activar Hitbox",    hbx_on_d="Muestra y expande las hitboxes enemigas.",
        hbx_size="Tamaño Hitbox",
        hbx_show="Mostrar Hitbox",
        hbx_key="Tecla Hitbox",
        trg_on="Triggerbot",         trg_on_d="Dispara cuando el cursor está sobre un enemigo visible.",
        trg_key="Tecla Triggerbot",
        ev_sum="Verano 2026",        ev_sum_d="Recoge drops de Verano 2026 automáticamente. Solo en partidas.",
        kl_on="Matar a Todos",       kl_on_d="Elimina instantáneamente a los enemigos cuando está activado.",
        kl_keep="Mantener Activo",   kl_keep_d="Mantiene Matar Todos activo e impide que se desactive.",
        kl_bbl="Burbuja Matar",      kl_bbl_d="Muestra un pequeño botón en pantalla.",
        st_bg="Fondo del Panel",
        st_notif="Activar Notificaciones",
        st_lang="Idioma",
        st_key="Alternar UI",
        st_r1="Restablecer Tecla UI",     st_r1_d="Restablece esta tecla a su valor predeterminado.",
        st_r2="Restablecer Todas",        st_r2_d="Restablece todas las teclas a sus valores predeterminados.",
        n_on="Activado", n_off="Desactivado", n_reset="Tecla restablecida",
    }
}
local function L(k)
    local tbl = Locale[S.lang] or Locale.English
    return tbl[k] or (Locale.English[k] or k)
end

local C = {
    BG      = Color3.fromRGB(5,   5,   7),
    CARD    = Color3.fromRGB(14,  12,  20),
    HEADER  = Color3.fromRGB(8,   6,   13),
    TABBAR  = Color3.fromRGB(6,   5,   9),
    TEXT    = Color3.fromRGB(212, 202, 228),
    DIM     = Color3.fromRGB(102, 92,  120),
    ACCENT  = Color3.fromRGB(141, 122, 174),
    ACCENT2 = Color3.fromRGB(170, 148, 210),
    DIV     = Color3.fromRGB(28,  24,  40),
    TOG_ON  = Color3.fromRGB(141, 122, 174),
    TOG_OFF = Color3.fromRGB(38,  32,  54),
    THUMB   = Color3.fromRGB(228, 220, 240),
    KEY_BG  = Color3.fromRGB(22,  18,  32),
    KEY_TXT = Color3.fromRGB(141, 122, 174),
    BORDER  = Color3.fromRGB(58,  50,  80),
    RED     = Color3.fromRGB(180, 60,  70),
    GREEN   = Color3.fromRGB(90,  180, 100),
}
local TI  = TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local TIF = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

local oldGui = playerGui:FindFirstChild("x7sV1")
if oldGui then oldGui:Destroy() end
pcall(function()
    local cg = game:GetService("CoreGui"):FindFirstChild("x7sV1")
    if cg then cg:Destroy() end
end)

local gui = Instance.new("ScreenGui")
gui.Name = "x7sV1"; gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true; gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.DisplayOrder = 99
local _protected = false
pcall(function() if syn and syn.protect_gui then syn.protect_gui(gui) end end)
pcall(function() gui.Parent = game:GetService("CoreGui"); _protected = true end)
if not _protected then pcall(function() gui.Parent = gethui(); _protected = true end) end
if not _protected then gui.Parent = playerGui end

local _notifQueue = {}
local _notifActive = false

local function showNotif(title, body, isGood)
    if not S.notifs then return end
    table.insert(_notifQueue, {title=title, body=body, good=isGood})
    if _notifActive then return end
    _notifActive = true
    task.spawn(function()
        while #_notifQueue > 0 do
            local n = table.remove(_notifQueue, 1)
            local col = n.good and C.ACCENT or C.DIM
            local toast = Instance.new("Frame", gui)
            toast.Size = UDim2.fromOffset(240, 58)
            toast.Position = UDim2.new(1, 260, 1, -80)
            toast.BackgroundColor3 = Color3.fromRGB(12, 10, 18)
            toast.BorderSizePixel = 0; toast.ZIndex = 200
            Instance.new("UICorner", toast).CornerRadius = UDim.new(0, 10)
            local ts = Instance.new("UIStroke", toast); ts.Color = col; ts.Transparency = 0.5; ts.Thickness = 1
            
            local bar = Instance.new("Frame", toast); bar.Size = UDim2.new(0, 3, 1, -16)
            bar.Position = UDim2.new(0, 0, 0, 8); bar.BackgroundColor3 = col
            bar.BorderSizePixel = 0; Instance.new("UICorner", bar).CornerRadius = UDim.new(1, 0)
            local tl = Instance.new("TextLabel", toast); tl.BackgroundTransparency = 1
            tl.Size = UDim2.new(1, -20, 0, 20); tl.Position = UDim2.fromOffset(14, 8)
            tl.Text = n.title; tl.TextColor3 = col; tl.Font = Enum.Font.GothamBold
            tl.TextSize = 12; tl.TextXAlignment = Enum.TextXAlignment.Left
            local bl = Instance.new("TextLabel", toast); bl.BackgroundTransparency = 1
            bl.Size = UDim2.new(1, -20, 0, 18); bl.Position = UDim2.fromOffset(14, 28)
            bl.Text = n.body; bl.TextColor3 = C.DIM; bl.Font = Enum.Font.Gotham
            bl.TextSize = 11; bl.TextXAlignment = Enum.TextXAlignment.Left
            TweenService:Create(toast, TIF, {Position = UDim2.new(1, -250, 1, -80)}):Play()
            task.wait(2.5)
            TweenService:Create(toast, TIF, {Position = UDim2.new(1, 260, 1, -80)}):Play()
            task.wait(0.3); toast:Destroy()
            task.wait(0.1)
        end
        _notifActive = false
    end)
end

local PW, PH = 300, 502

local glow = Instance.new("Frame", gui)
glow.Size = UDim2.fromOffset(PW + 24, PH + 24)
glow.Position = UDim2.new(0.5, -(PW/2 + 12), 0.5, -(PH/2 + 12))
glow.BackgroundColor3 = C.ACCENT; glow.BackgroundTransparency = 0.93
glow.BorderSizePixel = 0; glow.ZIndex = 1
Instance.new("UICorner", glow).CornerRadius = UDim.new(0, 22)

local panel = Instance.new("Frame", gui)
panel.Name = "x7sPanel"
panel.Size = UDim2.fromOffset(PW, PH)
panel.Position = UDim2.new(0.5, -PW/2, 0.5, -PH/2)
panel.BackgroundColor3 = C.BG; panel.BackgroundTransparency = 0
panel.BorderSizePixel = 0; panel.ClipsDescendants = true; panel.ZIndex = 2
Instance.new("UICorner", panel).CornerRadius = UDim.new(0, 16)
local panelStroke = Instance.new("UIStroke", panel)
panelStroke.Color = C.BORDER; panelStroke.Transparency = 0.4; panelStroke.Thickness = 1

local panelGrad = Instance.new("UIGradient", panel)
panelGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(9, 6, 16)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(5, 5, 7)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(8, 5, 14)),
})
panelGrad.Rotation = 135

local topGlow = Instance.new("Frame", panel)
topGlow.Size = UDim2.new(1, 0, 0, 1); topGlow.Position = UDim2.new(0, 0, 0, 0)
topGlow.BackgroundColor3 = C.ACCENT; topGlow.BackgroundTransparency = 0.5
topGlow.BorderSizePixel = 0; topGlow.ZIndex = 3
local topGlowGrad = Instance.new("UIGradient", topGlow)
topGlowGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
    ColorSequenceKeypoint.new(0.2, Color3.fromRGB(141, 122, 174)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(200, 180, 240)),
    ColorSequenceKeypoint.new(0.8, Color3.fromRGB(141, 122, 174)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)),
})

local HEADER_H = 62

local header = Instance.new("Frame", panel)
header.Size = UDim2.new(1, 0, 0, HEADER_H)
header.BackgroundColor3 = C.HEADER; header.BackgroundTransparency = 0
header.BorderSizePixel = 0; header.ZIndex = 3

local headerLine = Instance.new("Frame", header)
headerLine.Size = UDim2.new(1, 0, 0, 1)
headerLine.Position = UDim2.new(0, 0, 1, -1)
headerLine.BackgroundColor3 = C.ACCENT; headerLine.BackgroundTransparency = 0.6
headerLine.BorderSizePixel = 0
local hlGrad = Instance.new("UIGradient", headerLine)
hlGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0,0,0)),
    ColorSequenceKeypoint.new(0.3, Color3.fromRGB(141,122,174)),
    ColorSequenceKeypoint.new(0.7, Color3.fromRGB(141,122,174)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0,0,0)),
})

local logoImg = Instance.new("ImageLabel", header)
logoImg.Size = UDim2.fromOffset(36, 36)
logoImg.Position = UDim2.new(0, 10, 0.5, -18)
logoImg.BackgroundTransparency = 1
logoImg.Image = "rbxassetid://77130965021335"
logoImg.ScaleType = Enum.ScaleType.Fit
task.delay(2, function()
    if logoImg and not logoImg.IsLoaded then
        logoImg.Image = ""
        local fl = Instance.new("TextLabel", header)
        fl.Size = UDim2.fromOffset(36, 36); fl.Position = logoImg.Position
        fl.BackgroundTransparency = 1; fl.Text = "✝"
        fl.TextColor3 = C.ACCENT; fl.Font = Enum.Font.Fantasy
        fl.TextSize = 28; fl.TextXAlignment = Enum.TextXAlignment.Center
    end
end)

local titleLbl = Instance.new("TextLabel", header)
titleLbl.Size = UDim2.new(1, -130, 0, 24)
titleLbl.Position = UDim2.fromOffset(54, 8)
titleLbl.BackgroundTransparency = 1
titleLbl.Text = "✝  x7s  ✝"
titleLbl.TextColor3 = C.ACCENT; titleLbl.Font = Enum.Font.GothamBlack
titleLbl.TextSize = 16; titleLbl.TextXAlignment = Enum.TextXAlignment.Left

local subLbl = Instance.new("TextLabel", header)
subLbl.Size = UDim2.new(1, -130, 0, 14)
subLbl.Position = UDim2.fromOffset(54, 32)
subLbl.BackgroundTransparency = 1
subLbl.Text = "v1.0  ·  by stx  ·  "..player.Name
subLbl.TextColor3 = C.DIM; subLbl.Font = Enum.Font.Gotham
subLbl.TextSize = 10; subLbl.TextXAlignment = Enum.TextXAlignment.Left

local igBtn = Instance.new("TextButton", header)
igBtn.Size = UDim2.fromOffset(88, 12)
igBtn.Position = UDim2.fromOffset(54, 47)
igBtn.BackgroundTransparency = 1; igBtn.BorderSizePixel = 0
igBtn.Text = "📷 @itzstxx"; igBtn.TextColor3 = Color3.fromRGB(100, 85, 130)
igBtn.Font = Enum.Font.GothamBold; igBtn.TextSize = 9
igBtn.TextXAlignment = Enum.TextXAlignment.Left; igBtn.AutoButtonColor = false
local _igc = false
igBtn.MouseButton1Click:Connect(function()
    if _igc then return end; _igc = true
    pcall(function() setclipboard("@itzstxx") end)
    igBtn.Text = "✓ Copiado"; igBtn.TextColor3 = C.ACCENT
    task.delay(1.8, function() igBtn.Text = "📷 @itzstxx"; igBtn.TextColor3 = Color3.fromRGB(100,85,130); _igc = false end)
end)
igBtn.MouseEnter:Connect(function() if not _igc then igBtn.TextColor3 = C.ACCENT2 end end)
igBtn.MouseLeave:Connect(function() if not _igc then igBtn.TextColor3 = Color3.fromRGB(100,85,130) end end)

local closeBtn = Instance.new("TextButton", header)
closeBtn.Size = UDim2.fromOffset(30, 30)
closeBtn.Position = UDim2.new(1, -40, 0.5, -15)
closeBtn.BackgroundColor3 = Color3.fromRGB(28, 16, 22); closeBtn.BorderSizePixel = 0
closeBtn.Text = "✕"; closeBtn.TextColor3 = C.RED
closeBtn.Font = Enum.Font.GothamBold; closeBtn.TextSize = 12
closeBtn.AutoButtonColor = false
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(1, 0)
local closeStroke = Instance.new("UIStroke", closeBtn)
closeStroke.Color = C.RED; closeStroke.Transparency = 0.7; closeStroke.Thickness = 1
closeBtn.MouseButton1Click:Connect(function()
    TweenService:Create(panel, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {BackgroundTransparency = 1, Size = UDim2.fromOffset(PW-20, PH-20)}):Play()
    TweenService:Create(glow, TweenInfo.new(0.15), {BackgroundTransparency = 1}):Play()
    task.delay(0.15, function() panel.Visible = false; glow.Visible = false; panel.BackgroundTransparency = 0; panel.Size = UDim2.fromOffset(PW, PH) end)
end)

local TABBAR_H = 38

local tabBar = Instance.new("Frame", panel)
tabBar.Size = UDim2.new(1, 0, 0, TABBAR_H)
tabBar.Position = UDim2.fromOffset(0, HEADER_H)
tabBar.BackgroundColor3 = C.TABBAR; tabBar.BorderSizePixel = 0

local tabBarLine = Instance.new("Frame", tabBar)
tabBarLine.Size = UDim2.new(1, 0, 0, 1); tabBarLine.Position = UDim2.new(0, 0, 1, -1)
tabBarLine.BackgroundColor3 = C.BORDER; tabBarLine.BackgroundTransparency = 0.3
tabBarLine.BorderSizePixel = 0

local TAB_COUNT = 6
local tabW = PW / TAB_COUNT  

local tabIndicator = Instance.new("Frame", tabBar)
tabIndicator.Size = UDim2.fromOffset(tabW - 8, 2)
tabIndicator.Position = UDim2.fromOffset(4, TABBAR_H - 2)
tabIndicator.BackgroundColor3 = C.ACCENT; tabIndicator.BorderSizePixel = 0
Instance.new("UICorner", tabIndicator).CornerRadius = UDim.new(1, 0)

local tabNames = {"ESP", "HBX", "TRG", "EVT", "KILL", "CFG"}
local tabBtns = {}
local tabPages = {}
local activeTab = 1

local CONTENT_Y = HEADER_H + TABBAR_H
local CONTENT_H = PH - CONTENT_Y

local function makeTabPage()
    local page = Instance.new("ScrollingFrame", panel)
    page.Size = UDim2.new(1, 0, 0, CONTENT_H)
    page.Position = UDim2.fromOffset(0, CONTENT_Y)
    page.BackgroundTransparency = 1; page.BorderSizePixel = 0
    page.ScrollBarThickness = 2; page.ScrollBarImageColor3 = C.ACCENT
    page.CanvasSize = UDim2.new(0, 0, 0, 0)
    page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    page.Visible = false
    local pad = Instance.new("UIPadding", page)
    pad.PaddingTop = UDim.new(0, 12); pad.PaddingLeft = UDim.new(0, 12)
    pad.PaddingRight = UDim.new(0, 12); pad.PaddingBottom = UDim.new(0, 14)
    local lay = Instance.new("UIListLayout", page)
    lay.SortOrder = Enum.SortOrder.LayoutOrder
    lay.Padding = UDim.new(0, 8)
    return page
end

for i = 1, TAB_COUNT do
    
    local btn = Instance.new("TextButton", tabBar)
    btn.Size = UDim2.fromOffset(tabW, TABBAR_H)
    btn.Position = UDim2.fromOffset((i - 1) * tabW, 0)
    btn.BackgroundTransparency = 1; btn.BorderSizePixel = 0
    btn.Text = tabNames[i]; btn.Font = Enum.Font.GothamBold; btn.TextSize = 10
    btn.TextColor3 = i == 1 and C.ACCENT or C.DIM
    btn.AutoButtonColor = false
    tabBtns[i] = btn
    tabPages[i] = makeTabPage()
    btn.MouseButton1Click:Connect(function()
        if activeTab == i then return end
        tabPages[activeTab].Visible = false
        tabBtns[activeTab].TextColor3 = C.DIM
        activeTab = i
        tabPages[i].Visible = true
        tabBtns[i].TextColor3 = C.ACCENT
        TweenService:Create(tabIndicator, TI, {
            Position = UDim2.fromOffset((i-1)*tabW + 4, TABBAR_H - 2)
        }):Play()
    end)
end
tabPages[1].Visible = true

local refreshers = {}

local function secLabel(parent, text)
    local f = Instance.new("Frame", parent)
    f.Size = UDim2.new(1, 0, 0, 22); f.BackgroundTransparency = 1
    local l = Instance.new("TextLabel", f)
    l.Size = UDim2.new(1, 0, 1, 0); l.BackgroundTransparency = 1
    l.Text = text:upper(); l.TextColor3 = C.DIM
    l.Font = Enum.Font.GothamBold; l.TextSize = 10
    l.TextXAlignment = Enum.TextXAlignment.Left
    local ls = Instance.new("UIStroke", l); ls.Color = C.DIM; ls.Transparency = 1  
    return f
end

local function makeCard(parent)
    local card = Instance.new("Frame", parent)
    card.Size = UDim2.new(1, 0, 0, 0)
    card.AutomaticSize = Enum.AutomaticSize.Y
    card.BackgroundColor3 = C.CARD; card.BorderSizePixel = 0
    Instance.new("UICorner", card).CornerRadius = UDim.new(0, 12)
    local cs = Instance.new("UIStroke", card)
    cs.Color = C.BORDER; cs.Transparency = 0.6; cs.Thickness = 1
    local lay = Instance.new("UIListLayout", card)
    lay.SortOrder = Enum.SortOrder.LayoutOrder; lay.Padding = UDim.new(0, 0)
    
    card.ClipsDescendants = true
    return card
end

local function makeDivider(parent)
    local d = Instance.new("Frame", parent)
    d.Size = UDim2.new(1, 0, 0, 1)
    d.BackgroundColor3 = C.DIV; d.BorderSizePixel = 0
    return d
end

local function makeToggle(parent, titleKey, descKey, stateKey, cb)
    local title = L(titleKey) or titleKey
    local desc = descKey and (L(descKey) or descKey) or nil
    local hasDesc = desc and desc ~= ""
    local rowH = hasDesc and 64 or 50

    local row = Instance.new("Frame", parent)
    row.Size = UDim2.new(1, 0, 0, rowH)
    row.BackgroundTransparency = 1

    local tl = Instance.new("TextLabel", row)
    tl.BackgroundTransparency = 1
    tl.Size = UDim2.new(1, -78, 0, 18)
    tl.Position = UDim2.fromOffset(16, hasDesc and 13 or 16)
    tl.Text = title; tl.TextColor3 = C.TEXT
    tl.Font = Enum.Font.GothamMedium; tl.TextSize = 13
    tl.TextXAlignment = Enum.TextXAlignment.Left; tl.TextTruncate = Enum.TextTruncate.AtEnd

    if hasDesc then
        local dl = Instance.new("TextLabel", row)
        dl.BackgroundTransparency = 1
        dl.Size = UDim2.new(1, -78, 0, 28)
        dl.Position = UDim2.fromOffset(16, 30)
        dl.Text = desc; dl.TextColor3 = C.DIM
        dl.Font = Enum.Font.Gotham; dl.TextSize = 11
        dl.TextXAlignment = Enum.TextXAlignment.Left; dl.TextWrapped = true
    end

    local TW, TH = 46, 26
    local TS = 20  
    local track = Instance.new("Frame", row)
    track.Size = UDim2.fromOffset(TW, TH)
    track.Position = UDim2.new(1, -(TW + 14), 0.5, -(TH/2))
    track.BorderSizePixel = 0
    Instance.new("UICorner", track).CornerRadius = UDim.new(1, 0)

    local thumb = Instance.new("Frame", track)
    thumb.Size = UDim2.fromOffset(TS, TS)
    thumb.BorderSizePixel = 0; thumb.BackgroundColor3 = C.THUMB
    Instance.new("UICorner", thumb).CornerRadius = UDim.new(1, 0)

    local function refresh()
        local on = S[stateKey]
        TweenService:Create(track, TI, {BackgroundColor3 = on and C.TOG_ON or C.TOG_OFF}):Play()
        TweenService:Create(thumb, TI, {
            Position = on and UDim2.fromOffset(TW - TS - 3, 3) or UDim2.fromOffset(3, 3),
            BackgroundColor3 = on and C.THUMB or Color3.fromRGB(180, 170, 200),
        }):Play()
    end
    refresh()
    refreshers[stateKey] = refresh

    local hit = Instance.new("TextButton", row)
    hit.Size = UDim2.new(1, 0, 1, 0); hit.BackgroundTransparency = 1; hit.Text = ""
    hit.MouseButton1Click:Connect(function()
        S[stateKey] = not S[stateKey]; refresh(); save()
        local state = S[stateKey]
        showNotif("✝  "..title, state and L("n_on") or L("n_off"), state)
        if cb then cb(state) end
    end)
    
    hit.MouseEnter:Connect(function()
        TweenService:Create(row, TI, {BackgroundColor3 = Color3.fromRGB(20,16,30)}):Play()
        row.BackgroundTransparency = 0
        Instance.new("UICorner", row).CornerRadius = UDim.new(0, 12)
    end)
    hit.MouseLeave:Connect(function()
        TweenService:Create(row, TI, {BackgroundTransparency = 1}):Play()
    end)
    return row
end

local function makeSlider(parent, titleKey, stateKey, mn, mx)
    local title = L(titleKey) or titleKey
    local row = Instance.new("Frame", parent)
    row.Size = UDim2.new(1, 0, 0, 60)
    row.BackgroundTransparency = 1

    local valLabel = Instance.new("TextLabel", row)
    valLabel.BackgroundTransparency = 1
    valLabel.Size = UDim2.new(0, 30, 0, 18); valLabel.Position = UDim2.new(1, -44, 0, 14)
    valLabel.Text = tostring(S[stateKey]); valLabel.TextColor3 = C.ACCENT
    valLabel.Font = Enum.Font.GothamBold; valLabel.TextSize = 13
    valLabel.TextXAlignment = Enum.TextXAlignment.Right

    local tl = Instance.new("TextLabel", row)
    tl.BackgroundTransparency = 1; tl.Size = UDim2.new(1, -80, 0, 18)
    tl.Position = UDim2.fromOffset(16, 14)
    tl.Text = title; tl.TextColor3 = C.TEXT
    tl.Font = Enum.Font.GothamMedium; tl.TextSize = 13
    tl.TextXAlignment = Enum.TextXAlignment.Left

    local track = Instance.new("Frame", row)
    track.Size = UDim2.new(1, -32, 0, 4); track.Position = UDim2.fromOffset(16, 38)
    track.BackgroundColor3 = Color3.fromRGB(30, 24, 44); track.BorderSizePixel = 0
    Instance.new("UICorner", track).CornerRadius = UDim.new(1, 0)

    local fill = Instance.new("Frame", track)
    fill.BackgroundColor3 = C.ACCENT; fill.BorderSizePixel = 0
    Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)

    local thumb = Instance.new("Frame", track)
    thumb.Size = UDim2.fromOffset(14, 14); thumb.BackgroundColor3 = C.ACCENT
    thumb.BorderSizePixel = 0; Instance.new("UICorner", thumb).CornerRadius = UDim.new(1, 0)

    local function setVal(v)
        v = math.clamp(math.floor(v + 0.5), mn, mx)
        S[stateKey] = v; valLabel.Text = tostring(v)
        local pct = (v - mn) / (mx - mn)
        TweenService:Create(fill, TweenInfo.new(0.12), {Size = UDim2.new(pct, 0, 1, 0)}):Play()
        TweenService:Create(thumb, TweenInfo.new(0.12), {Position = UDim2.new(pct, -7, 0.5, -7)}):Play()
    end
    setVal(S[stateKey])

    local sliding = false
    local function slide(inp)
        local abs = track.AbsolutePosition; local sz = track.AbsoluteSize
        if sz.X <= 0 then return end
        setVal(mn + math.clamp((inp.Position.X - abs.X) / sz.X, 0, 1) * (mx - mn))
    end
    track.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 then sliding = true; slide(inp) end
    end)
    UserInputService.InputChanged:Connect(function(inp)
        if sliding and inp.UserInputType == Enum.UserInputType.MouseMovement then slide(inp) end
    end)
    UserInputService.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 and sliding then sliding = false; save() end
    end)
    return row
end

local function makeKeybind(parent, titleKey, stateKey)
    local title = L(titleKey) or titleKey
    local row = Instance.new("Frame", parent)
    row.Size = UDim2.new(1, 0, 0, 50)
    row.BackgroundTransparency = 1

    local tl = Instance.new("TextLabel", row)
    tl.BackgroundTransparency = 1; tl.Size = UDim2.new(1, -80, 0, 18)
    tl.Position = UDim2.fromOffset(16, 16); tl.Text = title
    tl.TextColor3 = C.TEXT; tl.Font = Enum.Font.GothamMedium; tl.TextSize = 13
    tl.TextXAlignment = Enum.TextXAlignment.Left

    local keyBtn = Instance.new("TextButton", row)
    keyBtn.Size = UDim2.fromOffset(40, 28); keyBtn.Position = UDim2.new(1, -54, 0.5, -14)
    keyBtn.BackgroundColor3 = C.KEY_BG; keyBtn.BorderSizePixel = 0
    keyBtn.Text = S[stateKey]; keyBtn.TextColor3 = C.KEY_TXT
    keyBtn.Font = Enum.Font.GothamBold; keyBtn.TextSize = 11
    keyBtn.AutoButtonColor = false
    Instance.new("UICorner", keyBtn).CornerRadius = UDim.new(0, 6)
    local ks = Instance.new("UIStroke", keyBtn); ks.Color = C.BORDER; ks.Transparency = 0.4; ks.Thickness = 1

    local listening = false
    keyBtn.MouseButton1Click:Connect(function()
        if listening then return end
        listening = true
        keyBtn.Text = "..."; keyBtn.TextColor3 = C.ACCENT2
        local conn; conn = UserInputService.InputBegan:Connect(function(inp, proc)
            if proc then return end
            if inp.UserInputType == Enum.UserInputType.Keyboard then
                local kn = inp.KeyCode.Name
                S[stateKey] = kn; keyBtn.Text = kn; keyBtn.TextColor3 = C.KEY_TXT
                listening = false; conn:Disconnect()
                save(); showNotif("✝  "..title, kn, true)
            end
        end)
    end)
    refreshers[stateKey] = function()
        keyBtn.Text = S[stateKey]
    end
    return row
end

local function makeDropdown(parent, titleKey, stateKey, options, cb)
    local title = L(titleKey) or titleKey
    local container = Instance.new("Frame", parent)
    container.Size = UDim2.new(1, 0, 0, 50)
    container.BackgroundTransparency = 1
    container.ClipsDescendants = false

    local row = Instance.new("Frame", container)
    row.Size = UDim2.new(1, 0, 0, 50); row.BackgroundTransparency = 1

    local tl = Instance.new("TextLabel", row)
    tl.BackgroundTransparency = 1; tl.Size = UDim2.new(1, -120, 0, 18)
    tl.Position = UDim2.fromOffset(16, 16); tl.Text = title
    tl.TextColor3 = C.TEXT; tl.Font = Enum.Font.GothamMedium; tl.TextSize = 13
    tl.TextXAlignment = Enum.TextXAlignment.Left

    local valLbl = Instance.new("TextLabel", row)
    valLbl.BackgroundTransparency = 1; valLbl.Size = UDim2.fromOffset(90, 18)
    valLbl.Position = UDim2.new(1, -106, 0, 16)
    valLbl.Text = S[stateKey]; valLbl.TextColor3 = C.DIM
    valLbl.Font = Enum.Font.Gotham; valLbl.TextSize = 12
    valLbl.TextXAlignment = Enum.TextXAlignment.Right

    local arrow = Instance.new("TextLabel", row)
    arrow.BackgroundTransparency = 1; arrow.Size = UDim2.fromOffset(14, 18)
    arrow.Position = UDim2.new(1, -18, 0, 16)
    arrow.Text = "▾"; arrow.TextColor3 = C.DIM
    arrow.Font = Enum.Font.GothamBold; arrow.TextSize = 11

    local optH = 36
    local dropFrame = Instance.new("Frame", container)
    dropFrame.Size = UDim2.new(1, 0, 0, 0)
    dropFrame.Position = UDim2.fromOffset(0, 50)
    dropFrame.BackgroundColor3 = Color3.fromRGB(18, 14, 26)
    dropFrame.BorderSizePixel = 0; dropFrame.ClipsDescendants = true
    dropFrame.ZIndex = 50; dropFrame.Visible = false
    Instance.new("UICorner", dropFrame).CornerRadius = UDim.new(0, 10)
    local ds = Instance.new("UIStroke", dropFrame); ds.Color = C.BORDER; ds.Transparency = 0.3; ds.Thickness = 1

    for idx, opt in ipairs(options) do
        local ob = Instance.new("TextButton", dropFrame)
        ob.Size = UDim2.new(1, 0, 0, optH)
        ob.Position = UDim2.fromOffset(0, (idx-1)*optH)
        ob.BackgroundTransparency = 1; ob.BorderSizePixel = 0
        ob.Text = opt; ob.Font = Enum.Font.GothamMedium; ob.TextSize = 12
        ob.TextColor3 = S[stateKey] == opt and C.ACCENT or C.TEXT
        ob.ZIndex = 51; ob.AutoButtonColor = false
        ob.MouseButton1Click:Connect(function()
            S[stateKey] = opt; valLbl.Text = opt
            for _, b in ipairs(dropFrame:GetChildren()) do
                if b:IsA("TextButton") then b.TextColor3 = (b.Text == opt) and C.ACCENT or C.TEXT end
            end
            TweenService:Create(dropFrame, TIF, {Size = UDim2.new(1, 0, 0, 0)}):Play()
            task.delay(0.25, function() dropFrame.Visible = false end)
            container.Size = UDim2.new(1, 0, 0, 50); arrow.Text = "▾"
            save(); if cb then cb(opt) end
        end)
    end

    local open = false
    local hitArea = Instance.new("TextButton", row)
    hitArea.Size = UDim2.new(1, 0, 1, 0); hitArea.BackgroundTransparency = 1; hitArea.Text = ""; hitArea.ZIndex = 5
    hitArea.MouseButton1Click:Connect(function()
        open = not open
        if open then
            dropFrame.Visible = true; dropFrame.Size = UDim2.new(1, 0, 0, 0)
            TweenService:Create(dropFrame, TIF, {Size = UDim2.new(1, 0, 0, #options * optH)}):Play()
            container.Size = UDim2.new(1, 0, 0, 50 + #options * optH)
            arrow.Text = "▴"
        else
            TweenService:Create(dropFrame, TIF, {Size = UDim2.new(1, 0, 0, 0)}):Play()
            task.delay(0.25, function() dropFrame.Visible = false end)
            container.Size = UDim2.new(1, 0, 0, 50); arrow.Text = "▾"
        end
    end)
    return container
end

local function makeResetBtn(parent, titleKey, descKey, cb)
    local title = L(titleKey) or titleKey
    local desc = descKey and (L(descKey) or descKey) or nil
    local hasDesc = desc and desc ~= ""
    local rowH = hasDesc and 62 or 48

    local row = Instance.new("Frame", parent)
    row.Size = UDim2.new(1, 0, 0, rowH); row.BackgroundTransparency = 1

    local tl = Instance.new("TextLabel", row)
    tl.BackgroundTransparency = 1; tl.Size = UDim2.new(1, -56, 0, 18)
    tl.Position = UDim2.fromOffset(16, hasDesc and 10 or 15)
    tl.Text = title; tl.TextColor3 = C.TEXT
    tl.Font = Enum.Font.GothamMedium; tl.TextSize = 13
    tl.TextXAlignment = Enum.TextXAlignment.Left

    if hasDesc then
        local dl = Instance.new("TextLabel", row)
        dl.BackgroundTransparency = 1; dl.Size = UDim2.new(1, -56, 0, 26)
        dl.Position = UDim2.fromOffset(16, 28)
        dl.Text = desc; dl.TextColor3 = C.DIM
        dl.Font = Enum.Font.Gotham; dl.TextSize = 11
        dl.TextXAlignment = Enum.TextXAlignment.Left; dl.TextWrapped = true
    end

    local btn = Instance.new("TextButton", row)
    btn.Size = UDim2.fromOffset(30, 30); btn.Position = UDim2.new(1, -44, 0.5, -15)
    btn.BackgroundColor3 = C.KEY_BG; btn.BorderSizePixel = 0
    btn.Text = "↺"; btn.TextColor3 = C.ACCENT
    btn.Font = Enum.Font.GothamBold; btn.TextSize = 16; btn.AutoButtonColor = false
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    local rs = Instance.new("UIStroke", btn); rs.Color = C.BORDER; rs.Transparency = 0.4; rs.Thickness = 1

    btn.MouseButton1Click:Connect(function()
        TweenService:Create(btn, TI, {Rotation = 360}):Play()
        task.delay(0.2, function() btn.Rotation = 0 end)
        if cb then cb() end
        showNotif("✝  "..title, L("n_reset"), true)
    end)
    return row
end

local pg_esp = tabPages[1]
secLabel(pg_esp, "· · · ESP · · ·")
local espCard = makeCard(pg_esp)
makeToggle(espCard, "esp_on",    "esp_on_d",    "esp_on")
makeDivider(espCard)
makeToggle(espCard, "esp_names", nil,           "esp_names")
makeDivider(espCard)
makeToggle(espCard, "esp_lines", "esp_lines_d", "esp_lines")
makeDivider(espCard)
makeKeybind(espCard, "esp_key", "esp_key")

local pg_hbx = tabPages[2]
secLabel(pg_hbx, "· · · HITBOX · · ·")
local hbxCard = makeCard(pg_hbx)
makeToggle(hbxCard, "hbx_on",   "hbx_on_d", "hbx_on", function(on)
    if not on then
        
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= player and p.Character then
                local root = p.Character:FindFirstChild("HumanoidRootPart")
                if root then root.Size = Vector3.new(2, 2, 1) end
            end
        end
    end
end)
makeDivider(hbxCard)
makeSlider(hbxCard, "hbx_size", "hbx_size", 1, 20)
makeDivider(hbxCard)
makeToggle(hbxCard, "hbx_show", nil, "hbx_show")
makeDivider(hbxCard)
makeKeybind(hbxCard, "hbx_key", "hbx_key")

local pg_trg = tabPages[3]
secLabel(pg_trg, "· · · TRIGGERBOT · · ·")
local trgCard = makeCard(pg_trg)
makeToggle(trgCard, "trg_on", "trg_on_d", "trg_on")
makeDivider(trgCard)
makeKeybind(trgCard, "trg_key", "trg_key")

local pg_evt = tabPages[4]
secLabel(pg_evt, "· · · EVENT · · ·")
local evtCard = makeCard(pg_evt)
makeToggle(evtCard, "ev_sum", "ev_sum_d", "summer_on", function(on)
    showNotif("Summer 2026", on and "Auto-collect ON" or "Auto-collect OFF", on)
end)

local pg_kll = tabPages[5]
secLabel(pg_kll, "· · · KILL ALL · · ·")
local kllCard = makeCard(pg_kll)
makeToggle(kllCard, "kl_on",   "kl_on_d",   "kill_on")
makeDivider(kllCard)
makeToggle(kllCard, "kl_keep", "kl_keep_d", "kill_keep")
makeDivider(kllCard)
makeToggle(kllCard, "kl_bbl",  "kl_bbl_d",  "kill_bubble", function(on)
    
end)

local pg_cfg = tabPages[6]

secLabel(pg_cfg, "· · · DISPLAY · · ·")
local dispCard = makeCard(pg_cfg)
makeToggle(dispCard, "st_bg", nil, "panel_bg", function(on)
    panel.BackgroundTransparency = on and 0 or 0.15
end)
makeDivider(dispCard)
makeToggle(dispCard, "st_notif", nil, "notifs")

secLabel(pg_cfg, "· · · LANGUAGE · · ·")
local langCard = makeCard(pg_cfg)
makeDropdown(langCard, "st_lang", "lang", {"English", "Español"}, function(opt)
    
    showNotif("Language", opt, true)
end)

secLabel(pg_cfg, "· · · KEYBINDS · · ·")
local keyCard = makeCard(pg_cfg)
makeKeybind(keyCard, "st_key", "gui_key")
makeDivider(keyCard)
makeResetBtn(keyCard, "st_r1", "st_r1_d", function()
    S.gui_key = "RightShift"
    if refreshers["gui_key"] then refreshers["gui_key"]() end
    save()
end)
makeDivider(keyCard)
makeResetBtn(keyCard, "st_r2", "st_r2_d", function()
    S.esp_key = "T"; S.hbx_key = "G"; S.trg_key = "R"; S.gui_key = "RightShift"
    for k, fn in pairs(refreshers) do
        if k:find("_key") then fn() end
    end
    save()
end)

do
    local drag, dragStart, startPos = false, nil, nil
    local dh = Instance.new("TextButton", header)
    dh.Size = UDim2.new(1, 0, 1, 0); dh.BackgroundTransparency = 1; dh.Text = ""
    dh.ZIndex = 2
    dh.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 then
            drag = true; dragStart = inp.Position; startPos = panel.Position
        end
    end)
    UserInputService.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 then drag = false end
    end)
    UserInputService.InputChanged:Connect(function(inp)
        if drag and inp.UserInputType == Enum.UserInputType.MouseMovement then
            local d = inp.Position - dragStart
            local sc = gui.AbsoluteSize
            panel.Position = UDim2.new(
                startPos.X.Scale, math.clamp(startPos.X.Offset + d.X, 0, sc.X - PW),
                startPos.Y.Scale, math.clamp(startPos.Y.Offset + d.Y, 0, sc.Y - PH)
            )
            glow.Position = UDim2.new(
                panel.Position.X.Scale, panel.Position.X.Offset - 12,
                panel.Position.Y.Scale, panel.Position.Y.Offset - 12
            )
        end
    end)
end

local bubbleBtn = Instance.new("TextButton", gui)
bubbleBtn.Size = UDim2.fromOffset(56, 56)
bubbleBtn.Position = UDim2.new(0, 20, 0.5, 40)
bubbleBtn.BackgroundColor3 = Color3.fromRGB(14, 10, 22)
bubbleBtn.BorderSizePixel = 0; bubbleBtn.AutoButtonColor = false
bubbleBtn.Text = "💀"; bubbleBtn.TextSize = 24
bubbleBtn.ZIndex = 10; bubbleBtn.Visible = false
Instance.new("UICorner", bubbleBtn).CornerRadius = UDim.new(1, 0)
local bubStroke = Instance.new("UIStroke", bubbleBtn)
bubStroke.Color = C.RED; bubStroke.Transparency = 0.5; bubStroke.Thickness = 2

do
    local bDrag, bStart, bPos = false, nil, nil
    local bMoved = false
    bubbleBtn.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            bDrag = true; bMoved = false; bStart = inp.Position; bPos = bubbleBtn.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(inp)
        if bDrag and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then
            local d = inp.Position - bStart
            if d.Magnitude > 6 then bMoved = true end
            if bMoved then
                local sc = gui.AbsoluteSize
                bubbleBtn.Position = UDim2.new(0, math.clamp(bPos.X.Offset + d.X, 4, sc.X - 60), 0, math.clamp(bPos.Y.Offset + d.Y, 4, sc.Y - 60))
            end
        end
    end)
    UserInputService.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            if bDrag and not bMoved then
                S.kill_on = not S.kill_on
                TweenService:Create(bubStroke, TI, {Color = S.kill_on and C.ACCENT or C.RED}):Play()
                showNotif("💀 Kill All", S.kill_on and L("n_on") or L("n_off"), S.kill_on)
                save()
            end
            bDrag = false; bMoved = false
        end
    end)
end

local function updateBubble()
    bubbleBtn.Visible = S.kill_bubble
end
updateBubble()
if refreshers["kill_bubble"] then
    local old = refreshers["kill_bubble"]
    refreshers["kill_bubble"] = function() if old then old() end; updateBubble() end
else
    refreshers["kill_bubble"] = updateBubble
end

local espObjects = {}
local hitboxDrawings = {}

local function newLine()
    local l = Drawing.new("Line"); l.Visible = false; l.Thickness = 1.5
    l.Color = Color3.fromRGB(141, 122, 174); return l
end
local function newText()
    local t = Drawing.new("Text"); t.Visible = false; t.Size = 13
    t.Color = Color3.fromRGB(200, 190, 220); t.Outline = true
    t.OutlineColor = Color3.fromRGB(0, 0, 0); return t
end
local function newBox()
    local b = Drawing.new("Square"); b.Visible = false; b.Filled = false
    b.Thickness = 1.5; b.Color = Color3.fromRGB(141, 122, 174); return b
end

local function createEspObj(p)
    if p == player then return end
    espObjects[p] = {
        box  = newBox(),
        name = newText(),
        line = newLine(),
        hbx  = newBox(),
    }
end
local function removeEspObj(p)
    local obj = espObjects[p]; if not obj then return end
    obj.box:Remove(); obj.name:Remove(); obj.line:Remove(); obj.hbx:Remove()
    espObjects[p] = nil
end
for _, p in ipairs(Players:GetPlayers()) do createEspObj(p) end
Players.PlayerAdded:Connect(createEspObj)
Players.PlayerRemoving:Connect(removeEspObj)

local _hbxOriginals = {}  

local function applyHitbox(p, on)
    if not p.Character then return end
    local root = p.Character:FindFirstChild("HumanoidRootPart"); if not root then return end
    if on then
        if not _hbxOriginals[p] then _hbxOriginals[p] = root.Size end
        local s = S.hbx_size
        pcall(function() root.Size = Vector3.new(s * 2, s * 2, s * 2) end)
    else
        if _hbxOriginals[p] then
            pcall(function() root.Size = _hbxOriginals[p] end)
            _hbxOriginals[p] = nil
        end
    end
end

task.spawn(function()
    local summerKeys = {"summer","drop","collect","item2026","event","prize","gift"}
    local function isSummerObj(obj)
        if not obj or typeof(obj) ~= "Instance" then return false end
        local n = obj.Name:lower()
        for _, k in ipairs(summerKeys) do
            if n:find(k, 1, true) then return true end
        end
        return false
    end
    local _lastCollect = 0
    while true do
        task.wait(0.5)
        if not S.summer_on then continue end
        local now = tick()
        if now - _lastCollect < 0.3 then continue end
        local myChar = player.Character
        if not myChar then continue end
        local myRoot = myChar:FindFirstChild("HumanoidRootPart")
        if not myRoot then continue end
        
        for _, obj in ipairs(Workspace:GetDescendants()) do
            if isSummerObj(obj) then
                
                local prox = obj:FindFirstChildOfClass("ProximityPrompt") or obj.Parent and obj.Parent:FindFirstChildOfClass("ProximityPrompt")
                if prox then
                    pcall(function() fireproximityprompt(prox) end)
                    _lastCollect = tick()
                    break
                end
                
                if obj:IsA("BasePart") then
                    local dist = (obj.Position - myRoot.Position).Magnitude
                    if dist < 20 then
                        pcall(function() obj.Touched:Fire(myRoot) end)
                        _lastCollect = tick(); break
                    end
                end
            end
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(0.08)
        if not S.kill_on then continue end
        for _, p in ipairs(Players:GetPlayers()) do
            if p == player then continue end
            local char = p.Character; if not char then continue end
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health > 0 then
                pcall(function()
                    
                    hum.Health = 0
                end)
                
                pcall(function()
                    local remote = game:GetService("ReplicatedStorage"):FindFirstChild("Kill") or
                                   game:GetService("ReplicatedStorage"):FindFirstChild("Damage") or
                                   game:GetService("ReplicatedStorage"):FindFirstChild("KillPlayer")
                    if remote and remote:IsA("RemoteEvent") then
                        remote:FireServer(p)
                    end
                end)
            end
        end
        
        if S.kill_keep and not S.kill_on then
            S.kill_on = true
            if refreshers["kill_on"] then refreshers["kill_on"]() end
        end
    end
end)

local _plrList = Players:GetPlayers()
Players.PlayerAdded:Connect(function()    _plrList = Players:GetPlayers() end)
Players.PlayerRemoving:Connect(function() task.defer(function() _plrList = Players:GetPlayers() end) end)

local _tbCooldown = 0
local _tbRate = 0.12  

local _frame = 0
RunService.RenderStepped:Connect(function()
    _frame = _frame + 1
    local myChar = player.Character
    local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
    local vpSize = camera.ViewportSize
    local mousePos = UserInputService:GetMouseLocation()
    local now = tick()

    if _frame % 60 == 0 then
        for _, p in ipairs(_plrList) do
            if p ~= player then applyHitbox(p, S.hbx_on) end
        end
    end

    if S.trg_on and myChar and now - _tbCooldown > _tbRate then
        local unitRay = camera:ScreenPointToRay(mousePos.X, mousePos.Y)
        local rcParams = RaycastParams.new()
        rcParams.FilterType = Enum.RaycastFilterType.Exclude
        rcParams.FilterDescendantsInstances = {myChar}
        local result = Workspace:Raycast(unitRay.Origin, unitRay.Direction * 1500, rcParams)
        if result and result.Instance then
            local hitChar = result.Instance:FindFirstAncestorOfClass("Model")
            if hitChar then
                local hum = hitChar:FindFirstChildOfClass("Humanoid")
                if hum and hum.Health > 0 then
                    local isEnemy = false
                    for _, p in ipairs(_plrList) do
                        if p.Character == hitChar and p ~= player then isEnemy = true; break end
                    end
                    if isEnemy then
                        _tbCooldown = now
                        pcall(function()
                            game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, true, game, 0)
                        end)
                        task.delay(0.05, function()
                            pcall(function()
                                game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, false, game, 0)
                            end)
                        end)
                    end
                end
            end
        end
    end

    if _frame % 2 ~= 0 then return end

    for p, obj in pairs(espObjects) do
        local char = p.Character
        local function allOff()
            obj.box.Visible = false; obj.name.Visible = false
            obj.line.Visible = false; obj.hbx.Visible = false
        end
        if not char or not S.esp_on then allOff(); continue end
        local root = char:FindFirstChild("HumanoidRootPart")
        local hum  = char:FindFirstChildOfClass("Humanoid")
        if not root or not hum or hum.Health <= 0 then allOff(); continue end

        local sp, onS = camera:WorldToViewportPoint(root.Position)
        if not onS then allOff(); continue end
        local sp2 = Vector2.new(sp.X, sp.Y)

        local headPart = char:FindFirstChild("Head")
        local topY = headPart and camera:WorldToViewportPoint(headPart.Position + Vector3.new(0, 0.7, 0)).Y or sp.Y - 40
        local height = math.abs(sp2.Y - topY) * 2.2
        local width  = height * 0.5

        if S.esp_on then
            obj.box.Visible = true
            obj.box.Color = C.ACCENT
            obj.box.Size = Vector2.new(width, height)
            obj.box.Position = Vector2.new(sp2.X - width/2, sp2.Y - height/2)
        else obj.box.Visible = false end

        if S.esp_names then
            obj.name.Visible = true
            obj.name.Text = p.Name
            obj.name.Color = C.TEXT
            obj.name.Position = Vector2.new(sp2.X, sp2.Y - height/2 - 18)
        else obj.name.Visible = false end

        if S.esp_lines then
            obj.line.Visible = true
            obj.line.Color = C.ACCENT
            obj.line.From = Vector2.new(vpSize.X/2, vpSize.Y)
            obj.line.To = sp2
        else obj.line.Visible = false end

        if S.hbx_on and S.hbx_show then
            local hbxSp = camera:WorldToViewportPoint(root.Position)
            local hbxH = height * (S.hbx_size / 2)
            local hbxW = hbxH * 0.8
            obj.hbx.Visible = true
            obj.hbx.Color = Color3.fromRGB(255, 100, 100)
            obj.hbx.Size = Vector2.new(hbxW, hbxH)
            obj.hbx.Position = Vector2.new(hbxSp.X - hbxW/2, hbxSp.Y - hbxH/2)
        else obj.hbx.Visible = false end
    end
end)

UserInputService.InputBegan:Connect(function(inp, proc)
    if proc then return end
    if inp.UserInputType ~= Enum.UserInputType.Keyboard then return end
    local kn = inp.KeyCode.Name

    if kn == S.gui_key then
        if panel.Visible then
            TweenService:Create(panel, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {BackgroundTransparency = 1}):Play()
            TweenService:Create(glow, TweenInfo.new(0.15), {BackgroundTransparency = 1}):Play()
            task.delay(0.15, function()
                panel.Visible = false; glow.Visible = false
                panel.BackgroundTransparency = 0; glow.BackgroundTransparency = 0.93
            end)
        else
            panel.Visible = true; glow.Visible = true
            panel.Size = UDim2.fromOffset(PW - 10, PH - 10); panel.BackgroundTransparency = 1
            TweenService:Create(panel, TweenInfo.new(0.2, Enum.EasingStyle.Back), {
                Size = UDim2.fromOffset(PW, PH), BackgroundTransparency = 0
            }):Play()
            TweenService:Create(glow, TweenInfo.new(0.2), {BackgroundTransparency = 0.93}):Play()
        end
    end

    if kn == S.esp_key then
        S.esp_on = not S.esp_on; save()
        if refreshers["esp_on"] then refreshers["esp_on"]() end
        showNotif("✝  ESP", S.esp_on and L("n_on") or L("n_off"), S.esp_on)
    end
    
    if kn == S.hbx_key then
        S.hbx_on = not S.hbx_on; save()
        if refreshers["hbx_on"] then refreshers["hbx_on"]() end
        showNotif("✝  Hitbox", S.hbx_on and L("n_on") or L("n_off"), S.hbx_on)
    end
    
    if kn == S.trg_key then
        S.trg_on = not S.trg_on; save()
        if refreshers["trg_on"] then refreshers["trg_on"]() end
        showNotif("✝  Triggerbot", S.trg_on and L("n_on") or L("n_off"), S.trg_on)
    end
end)

player.CharacterAdded:Connect(function(char)
    task.wait(0.5)
    _hbxOriginals = {}  
end)

task.defer(function()
    panel.BackgroundTransparency = S.panel_bg and 0 or 0.15
    updateBubble()
end)

print("✝  x7s V1.0 Loaded — "..player.Name.."  ✝")
print("   "..S.gui_key.." = Toggle GUI  ·  "..S.esp_key.." = ESP  ·  "..S.hbx_key.." = Hitbox  ·  "..S.trg_key.." = Trigger")

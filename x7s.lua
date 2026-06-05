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
        esp_char_r=100, esp_char_g=220, esp_char_b=100,  -- Color del Character ESP (verde por defecto)
        esp_avatar=true,   -- Mostrar thumbnail del avatar en el ESP
        hbx_on=false, hbx_size=5, hbx_show=false, hbx_key="G",
        hbx_vis_check=true,   -- Visible Check: no matar si está detrás de pared
        trg_on=false, trg_key="R",
        summer_on=false,
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
        tab_esp="ESP", tab_hbx="HBX", tab_trg="TRG", tab_cfg="CFG",

        esp_on="Enable ESP",        esp_on_d="Show enemies through walls.",
        esp_names="Show Enemy Name",
        esp_lines="ESP Lines",      esp_lines_d="Draw lines from your character to enemy positions.",
        esp_key="ESP Keybind",
        esp_color="ESP Color",      esp_color_d="Customize the character highlight color.",
        esp_avatar="Show Avatar",   esp_avatar_d="Show player avatar thumbnail above ESP.",

        hbx_on="Enable Hitbox",     hbx_on_d="Show and expand enemy hitboxes.",
        hbx_size="Hitbox Size",
        hbx_show="Show Hitbox",
        hbx_key="Hitbox Keybind",
        hbx_vis="Visible Check",    hbx_vis_d="Only register hits when the enemy is actually visible. Prevents kills through walls.",

        trg_on="Triggerbot",        trg_on_d="Shoots when your cursor is directly over a visible enemy.",
        trg_key="Triggerbot Keybind",

        ev_sum="Summer 2026",       ev_sum_d="Collects Summer 2026 drops automatically. Only in matches.",

        st_bg="Toggle Panel Background",
        st_notif="Enable Notifications",
        st_lang="Language",
        st_key="Toggle UI",
        st_r1="Reset Toggle UI Keybind",  st_r1_d="Reset this keybind to its default value.",
        st_r2="Reset All Keybinds",       st_r2_d="Reset all keybinds to their default values.",

        n_on="Enabled", n_off="Disabled", n_reset="Keybind reset",
    },
    ["Español"] = {
        tab_esp="ESP", tab_hbx="HBX", tab_trg="TRG", tab_cfg="CFG",
        esp_on="Activar ESP",        esp_on_d="Muestra enemigos a través de paredes.",
        esp_names="Nombre del Enemigo",
        esp_lines="Líneas ESP",      esp_lines_d="Dibuja líneas desde tu personaje hasta los enemigos.",
        esp_key="Tecla ESP",
        esp_color="Color ESP",       esp_color_d="Personaliza el color del resaltado del personaje.",
        esp_avatar="Mostrar Avatar", esp_avatar_d="Muestra el avatar del jugador sobre el ESP.",
        hbx_on="Activar Hitbox",    hbx_on_d="Muestra y expande las hitboxes enemigas.",
        hbx_size="Tamaño Hitbox",
        hbx_show="Mostrar Hitbox",
        hbx_key="Tecla Hitbox",
        hbx_vis="Visible Check",    hbx_vis_d="Solo registra el hit si el enemigo está a la vista. Evita matar a través de paredes.",
        trg_on="Triggerbot",         trg_on_d="Dispara cuando el cursor está sobre un enemigo visible.",
        trg_key="Tecla Triggerbot",
        ev_sum="Verano 2026",        ev_sum_d="Recoge drops de Verano 2026 automáticamente. Solo en partidas.",
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

-- ══════════════════════════════════════════════
--  GOTHIC SIDEBAR GUI  (diseño HTML reference)
-- ══════════════════════════════════════════════
local GW, GH = 660, 520          -- ancho total, alto total
local SB_W   = 160                -- ancho sidebar
local HDR_H  = 34                 -- altura header
local FOOTER_H = 32

-- Accent color global (aplicado por toda la GUI)
local accentColor = C.ACCENT

-- Panel principal
local glow = Instance.new("Frame", gui)
glow.Size = UDim2.fromOffset(GW + 20, GH + 20)
glow.Position = UDim2.new(0.5, -(GW/2 + 10), 0.5, -(GH/2 + 10))
glow.BackgroundColor3 = accentColor; glow.BackgroundTransparency = 0.93
glow.BorderSizePixel = 0; glow.ZIndex = 1
Instance.new("UICorner", glow).CornerRadius = UDim.new(0, 4)

local panel = Instance.new("Frame", gui)
panel.Name = "x7sPanel"
panel.Size = UDim2.fromOffset(GW, GH)
panel.Position = UDim2.new(0.5, -GW/2, 0.5, -GH/2)
panel.BackgroundColor3 = Color3.fromRGB(8, 6, 8)
panel.BorderSizePixel = 0; panel.ClipsDescendants = true; panel.ZIndex = 2
local panelStroke = Instance.new("UIStroke", panel)
panelStroke.Color = Color3.fromRGB(58, 58, 58); panelStroke.Transparency = 0; panelStroke.Thickness = 1

local scanlines = Instance.new("Frame", panel)
scanlines.Name = "Scanlines"
scanlines.Size = UDim2.new(1, 0, 1, 0)
scanlines.BackgroundTransparency = 1
scanlines.BorderSizePixel = 0
scanlines.ZIndex = 80
scanlines.Active = false
for i = 0, math.floor(GH / 4) do
    local line = Instance.new("Frame", scanlines)
    line.Size = UDim2.new(1, 0, 0, 1)
    line.Position = UDim2.fromOffset(0, i * 4)
    line.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    line.BackgroundTransparency = 0.88
    line.BorderSizePixel = 0
end

local particleLayer = Instance.new("Frame", panel)
particleLayer.Name = "AmbientParticles"
particleLayer.Size = UDim2.new(1, 0, 1, 0)
particleLayer.BackgroundTransparency = 1
particleLayer.BorderSizePixel = 0
particleLayer.Active = false
particleLayer.ZIndex = 3
for i = 1, 14 do
    local dot = Instance.new("Frame", particleLayer)
    local sz = math.random(1, 3)
    dot.Size = UDim2.fromOffset(sz, sz)
    dot.Position = UDim2.fromOffset(math.random(18, GW - 18), math.random(42, GH - 24))
    dot.BackgroundColor3 = accentColor
    dot.BackgroundTransparency = 1
    dot.BorderSizePixel = 0
    dot.ZIndex = 3
    Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)
    task.spawn(function()
        task.wait(math.random() * 2)
        while dot.Parent do
            local startX = math.random(18, GW - 18)
            local startY = math.random(52, GH - 24)
            dot.Position = UDim2.fromOffset(startX, startY)
            dot.BackgroundTransparency = 1
            TweenService:Create(dot, TweenInfo.new(1.1, Enum.EasingStyle.Sine), {
                BackgroundTransparency = 0.42,
            }):Play()
            TweenService:Create(dot, TweenInfo.new(3.2 + math.random(), Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                Position = UDim2.fromOffset(startX + math.random(-16, 16), math.max(40, startY - math.random(24, 58))),
            }):Play()
            task.wait(1.4)
            TweenService:Create(dot, TweenInfo.new(1.1, Enum.EasingStyle.Sine), {
                BackgroundTransparency = 1,
            }):Play()
            task.wait(2.2 + math.random())
        end
    end)
end

TweenService:Create(glow, TweenInfo.new(6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
    BackgroundTransparency = 0.88,
}):Play()
panel.Size = UDim2.fromOffset(GW - 34, GH - 34)
panel.BackgroundTransparency = 1
TweenService:Create(panel, TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = UDim2.fromOffset(GW, GH),
    BackgroundTransparency = 0,
}):Play()

-- ── HEADER ─────────────────────────────────────
local header = Instance.new("Frame", panel)
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0, HDR_H)
header.BackgroundColor3 = Color3.fromRGB(4, 3, 4)
header.BorderSizePixel = 0; header.ZIndex = 10
local headerGrad = Instance.new("UIGradient", header)
headerGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(4,3,4)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(13,10,13)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(4,3,4)),
})
local headerBorder = Instance.new("Frame", header)
headerBorder.Size = UDim2.new(1, 0, 0, 1); headerBorder.Position = UDim2.new(0,0,1,-1)
headerBorder.BackgroundColor3 = Color3.fromRGB(42,42,42); headerBorder.BorderSizePixel = 0

-- Título header
local titleLbl = Instance.new("TextLabel", header)
titleLbl.Size = UDim2.new(0.5, 0, 1, 0); titleLbl.Position = UDim2.fromOffset(16, 0)
titleLbl.BackgroundTransparency = 1; titleLbl.Text = "† interfaz oscura v.XIII †"
titleLbl.TextColor3 = Color3.fromRGB(58, 58, 58); titleLbl.Font = Enum.Font.Gotham
titleLbl.TextSize = 9; titleLbl.TextXAlignment = Enum.TextXAlignment.Left
titleLbl.TextScaled = false

-- Deco: fecha + símbolos
local dateDeco = Instance.new("TextLabel", header)
dateDeco.Size = UDim2.new(0, 180, 1, 0); dateDeco.Position = UDim2.new(1, -220, 0, 0)
dateDeco.BackgroundTransparency = 1
dateDeco.Text = "♥ ★ ✦  "..os.date("%d/%m/%Y")
dateDeco.TextColor3 = Color3.fromRGB(42, 42, 42); dateDeco.Font = Enum.Font.GothamBold
dateDeco.TextSize = 8; dateDeco.TextXAlignment = Enum.TextXAlignment.Right

-- Close button
local closeBtn = Instance.new("TextButton", header)
closeBtn.Size = UDim2.fromOffset(22, 22); closeBtn.Position = UDim2.new(1, -30, 0.5, -11)
closeBtn.BackgroundColor3 = Color3.fromRGB(26, 10, 26)
closeBtn.BorderSizePixel = 0; closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(102, 102, 102)
closeBtn.Font = Enum.Font.GothamBold; closeBtn.TextSize = 11; closeBtn.AutoButtonColor = false
local closeStroke = Instance.new("UIStroke", closeBtn)
closeStroke.Color = Color3.fromRGB(58,58,58); closeStroke.Thickness = 1
closeBtn.MouseEnter:Connect(function() closeBtn.TextColor3 = accentColor; closeStroke.Color = accentColor end)
closeBtn.MouseLeave:Connect(function() closeBtn.TextColor3 = Color3.fromRGB(102,102,102); closeStroke.Color = Color3.fromRGB(58,58,58) end)
closeBtn.MouseButton1Click:Connect(function()
    TweenService:Create(panel, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {BackgroundTransparency=1, Size=UDim2.fromOffset(GW-20,GH-20)}):Play()
    TweenService:Create(glow, TweenInfo.new(0.15), {BackgroundTransparency=1}):Play()
    task.delay(0.16, function() panel.Visible=false; glow.Visible=false; panel.BackgroundTransparency=0; panel.Size=UDim2.fromOffset(GW,GH) end)
end)

-- ── BODY (sidebar + content) ───────────────────
local body = Instance.new("Frame", panel)
body.Size = UDim2.new(1, 0, 1, -(HDR_H + FOOTER_H))
body.Position = UDim2.fromOffset(0, HDR_H)
body.BackgroundTransparency = 1; body.BorderSizePixel = 0

-- ── SIDEBAR ────────────────────────────────────
local sidebar = Instance.new("Frame", body)
sidebar.Size = UDim2.new(0, SB_W, 1, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(4, 3, 4)
sidebar.BorderSizePixel = 0; sidebar.ClipsDescendants = true
local sbGrad = Instance.new("UIGradient", sidebar)
sbGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(4,3,4)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(8,5,8)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(4,3,4)),
})
sbGrad.Rotation = 90
local sbBorder = Instance.new("Frame", sidebar)
sbBorder.Size = UDim2.new(0, 1, 1, 0); sbBorder.Position = UDim2.new(1,-1,0,0)
sbBorder.BackgroundColor3 = Color3.fromRGB(42,42,42); sbBorder.BorderSizePixel = 0

-- Logo x7s
local logoLbl = Instance.new("TextLabel", sidebar)
logoLbl.Size = UDim2.new(1, 0, 0, 56); logoLbl.Position = UDim2.fromOffset(0, 14)
logoLbl.BackgroundTransparency = 1; logoLbl.Text = "x7s"
logoLbl.TextColor3 = Color3.fromRGB(239, 239, 239); logoLbl.Font = Enum.Font.Fantasy
logoLbl.TextSize = 38; logoLbl.TextXAlignment = Enum.TextXAlignment.Center
-- shadow/glow del logo
local logoGlow = Instance.new("UIStroke", logoLbl)
logoGlow.Color = accentColor; logoGlow.Transparency = 0.6; logoGlow.Thickness = 1
TweenService:Create(logoGlow, TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
    Transparency = 0.25,
    Thickness = 2,
}):Play()

local dotsDeco = Instance.new("TextLabel", sidebar)
dotsDeco.Size = UDim2.new(1, 0, 0, 14); dotsDeco.Position = UDim2.fromOffset(0, 70)
dotsDeco.BackgroundTransparency = 1; dotsDeco.Text = "· · · · · · · · ·"
dotsDeco.TextColor3 = Color3.fromRGB(68,68,68); dotsDeco.Font = Enum.Font.GothamBold
dotsDeco.TextSize = 9; dotsDeco.TextXAlignment = Enum.TextXAlignment.Center
TweenService:Create(dotsDeco, TweenInfo.new(2.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
    TextTransparency = 0.35,
}):Play()

-- Chain divider
local function makeSBChain(parent, y)
    local c = Instance.new("Frame", parent)
    c.Size = UDim2.new(1, -20, 0, 1); c.Position = UDim2.new(0, 10, 0, y)
    c.BackgroundTransparency = 1; c.BorderSizePixel = 0
    local cg = Instance.new("UIGradient", c)
    cg.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0,0,0)),
        ColorSequenceKeypoint.new(0.2, Color3.fromRGB(58,58,58)),
        ColorSequenceKeypoint.new(0.5, accentColor),
        ColorSequenceKeypoint.new(0.8, Color3.fromRGB(58,58,58)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0,0,0)),
    })
    c.BackgroundColor3 = Color3.fromRGB(255,255,255)
    c.BackgroundTransparency = 0
    return c
end
makeSBChain(sidebar, 88)

-- Nav buttons (paginas)
local navArea = Instance.new("Frame", sidebar)
navArea.Size = UDim2.new(1, -16, 0, 200); navArea.Position = UDim2.fromOffset(8, 100)
navArea.BackgroundTransparency = 1; navArea.BorderSizePixel = 0
local navLayout = Instance.new("UIListLayout", navArea)
navLayout.SortOrder = Enum.SortOrder.LayoutOrder; navLayout.Padding = UDim.new(0, 3)

-- Páginas de contenido
local CONTENT_X = SB_W
local CONTENT_W = GW - SB_W
local CONTENT_H2 = GH - HDR_H - FOOTER_H

local pages = {}
local navBtns = {}
local activePage = 1

local function makeContentPage()
    local p = Instance.new("ScrollingFrame", body)
    p.Size = UDim2.fromOffset(CONTENT_W, CONTENT_H2)
    p.Position = UDim2.fromOffset(CONTENT_X, 0)
    p.BackgroundTransparency = 1; p.BorderSizePixel = 0
    p.ScrollBarThickness = 2; p.ScrollBarImageColor3 = accentColor
    p.CanvasSize = UDim2.new(0,0,0,0); p.AutomaticCanvasSize = Enum.AutomaticSize.Y
    p.Visible = false
    local pad = Instance.new("UIPadding", p)
    pad.PaddingTop = UDim.new(0,14); pad.PaddingLeft = UDim.new(0,14)
    pad.PaddingRight = UDim.new(0,14); pad.PaddingBottom = UDim.new(0,16)
    local lay = Instance.new("UIListLayout", p)
    lay.SortOrder = Enum.SortOrder.LayoutOrder; lay.Padding = UDim.new(0, 10)
    return p
end

-- SVG-like icon labels (usando Unicode para los iconos de nav)
local NAV_DATA = {
    { icon = "⌂", label = "Inicio" },
    { icon = "⚙", label = "Ajustes" },
}

local function setPage(idx)
    if activePage == idx then return end
    if pages[activePage] then pages[activePage].Visible = false end
    local old = navBtns[activePage]
    if old then
        old.BackgroundTransparency = 1
        old.BorderSizePixel = 0
        old:FindFirstChild("__lbl") and true
        for _, ch in ipairs(old:GetChildren()) do
            if ch:IsA("TextLabel") then ch.TextColor3 = Color3.fromRGB(119,119,119) end
            if ch:IsA("Frame") then ch.BackgroundColor3 = Color3.fromRGB(0,0,0); ch.BackgroundTransparency = 1 end
        end
    end
    activePage = idx
    pages[idx].Visible = true
    local nb = navBtns[idx]
    if nb then
        local nbg = Instance.new("UIGradient")
        nbg.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(0,0,0)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(36,30,46)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(0,0,0)),
        })
        -- active BG
        for _, ch in ipairs(nb:GetChildren()) do
            if ch:IsA("TextLabel") then ch.TextColor3 = Color3.fromRGB(239,239,239) end
        end
        nb.BackgroundColor3 = Color3.fromRGB(36,30,46)
        nb.BackgroundTransparency = 0.5
        local ns = nb:FindFirstChildOfClass("UIStroke")
        if ns then ns.Color = accentColor; ns.Transparency = 0.72 end
    end
end

for i, nd in ipairs(NAV_DATA) do
    local nb = Instance.new("TextButton", navArea)
    nb.Size = UDim2.new(1, 0, 0, 30)
    nb.BackgroundTransparency = 1; nb.BorderSizePixel = 0
    nb.Text = ""; nb.AutoButtonColor = false
    local nbs = Instance.new("UIStroke", nb)
    nbs.Color = Color3.fromRGB(0,0,0); nbs.Transparency = 1; nbs.Thickness = 1

    local iconLbl = Instance.new("TextLabel", nb)
    iconLbl.Size = UDim2.fromOffset(18, 30); iconLbl.Position = UDim2.fromOffset(10, 0)
    iconLbl.BackgroundTransparency = 1; iconLbl.Text = nd.icon
    iconLbl.TextColor3 = Color3.fromRGB(119,119,119); iconLbl.Font = Enum.Font.GothamBold
    iconLbl.TextSize = 14; iconLbl.TextXAlignment = Enum.TextXAlignment.Center

    local textLbl = Instance.new("TextLabel", nb)
    textLbl.Size = UDim2.new(1, -36, 1, 0); textLbl.Position = UDim2.fromOffset(34, 0)
    textLbl.BackgroundTransparency = 1; textLbl.Text = nd.label:upper()
    textLbl.TextColor3 = Color3.fromRGB(119,119,119); textLbl.Font = Enum.Font.GothamBold
    textLbl.TextSize = 11; textLbl.TextXAlignment = Enum.TextXAlignment.Left

    nb.MouseEnter:Connect(function()
        if activePage ~= i then
            iconLbl.TextColor3 = Color3.fromRGB(170,170,170)
            textLbl.TextColor3 = Color3.fromRGB(170,170,170)
        end
    end)
    nb.MouseLeave:Connect(function()
        if activePage ~= i then
            iconLbl.TextColor3 = Color3.fromRGB(119,119,119)
            textLbl.TextColor3 = Color3.fromRGB(119,119,119)
        end
    end)
    nb.MouseButton1Click:Connect(function() setPage(i) end)

    navBtns[i] = nb
    pages[i] = makeContentPage()
end

-- Sidebar bottom decorations
local sbChainBot = makeSBChain(sidebar, GH - HDR_H - FOOTER_H - 60)
local sbBottomDeco = Instance.new("TextLabel", sidebar)
sbBottomDeco.Size = UDim2.new(1, 0, 0, 30)
sbBottomDeco.Position = UDim2.new(0, 0, 1, -50)
sbBottomDeco.BackgroundTransparency = 1; sbBottomDeco.Text = "♥ ✝ ♥"
sbBottomDeco.TextColor3 = Color3.fromRGB(46,36,62); sbBottomDeco.Font = Enum.Font.GothamBold
sbBottomDeco.TextSize = 10; sbBottomDeco.TextXAlignment = Enum.TextXAlignment.Center

-- IG button en sidebar bottom
local igBtn = Instance.new("TextButton", sidebar)
igBtn.Size = UDim2.new(1, -16, 0, 16); igBtn.Position = UDim2.new(0, 8, 1, -26)
igBtn.BackgroundTransparency = 1; igBtn.BorderSizePixel = 0
igBtn.Text = "📷 @itzstxx"; igBtn.TextColor3 = Color3.fromRGB(72, 58, 90)
igBtn.Font = Enum.Font.GothamBold; igBtn.TextSize = 9
igBtn.TextXAlignment = Enum.TextXAlignment.Center; igBtn.AutoButtonColor = false
local _igc = false
igBtn.MouseButton1Click:Connect(function()
    if _igc then return end; _igc = true
    pcall(function() setclipboard("@itzstxx") end)
    igBtn.Text = "✓ Copiado"; igBtn.TextColor3 = accentColor
    task.delay(1.8, function() igBtn.Text = "📷 @itzstxx"; igBtn.TextColor3 = Color3.fromRGB(72,58,90); _igc = false end)
end)
igBtn.MouseEnter:Connect(function() if not _igc then igBtn.TextColor3 = accentColor end end)
igBtn.MouseLeave:Connect(function() if not _igc then igBtn.TextColor3 = Color3.fromRGB(72,58,90) end end)

-- ── FOOTER ─────────────────────────────────────
local footer = Instance.new("Frame", panel)
footer.Size = UDim2.new(1, 0, 0, FOOTER_H); footer.Position = UDim2.new(0, 0, 1, -FOOTER_H)
footer.BackgroundColor3 = Color3.fromRGB(5,4,5); footer.BorderSizePixel = 0
local fBorder = Instance.new("Frame", footer)
fBorder.Size = UDim2.new(1, 0, 0, 1); fBorder.Position = UDim2.new(0,0,0,0)
fBorder.BackgroundColor3 = Color3.fromRGB(26,26,26); fBorder.BorderSizePixel = 0
local footerLayout = Instance.new("UIListLayout", footer)
footerLayout.FillDirection = Enum.FillDirection.Horizontal
footerLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
footerLayout.VerticalAlignment = Enum.VerticalAlignment.Center
footerLayout.Padding = UDim.new(0, 10)

local fc1 = Instance.new("TextLabel", footer); fc1.BackgroundTransparency=1
fc1.Text="✝"; fc1.TextColor3=Color3.fromRGB(42,42,42); fc1.Font=Enum.Font.Fantasy
fc1.TextSize=18; fc1.Size=UDim2.fromOffset(20,FOOTER_H)

local fLine1 = Instance.new("Frame", footer)
fLine1.Size=UDim2.fromOffset(140,1); fLine1.BackgroundColor3=Color3.fromRGB(42,42,42)
fLine1.BorderSizePixel=0; fLine1.LayoutOrder=2
local fLG = Instance.new("UIGradient",fLine1)
fLG.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(0,0,0)),ColorSequenceKeypoint.new(1,Color3.fromRGB(42,42,42))})

local fTextLbl = Instance.new("TextLabel", footer); fTextLbl.BackgroundTransparency=1
fTextLbl.Text="in darkness we trust"; fTextLbl.TextColor3=Color3.fromRGB(34,34,34)
fTextLbl.Font=Enum.Font.GothamBold; fTextLbl.TextSize=9
fTextLbl.Size=UDim2.fromOffset(130,FOOTER_H); fTextLbl.LayoutOrder=3

local fLine2 = Instance.new("Frame", footer)
fLine2.Size=UDim2.fromOffset(140,1); fLine2.BackgroundColor3=Color3.fromRGB(42,42,42)
fLine2.BorderSizePixel=0; fLine2.LayoutOrder=4
local fLG2 = Instance.new("UIGradient",fLine2)
fLG2.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(42,42,42)),ColorSequenceKeypoint.new(1,Color3.fromRGB(0,0,0))})

local fc2 = Instance.new("TextLabel", footer); fc2.BackgroundTransparency=1
fc2.Text="✝"; fc2.TextColor3=Color3.fromRGB(42,42,42); fc2.Font=Enum.Font.Fantasy
fc2.TextSize=18; fc2.Size=UDim2.fromOffset(20,FOOTER_H); fc2.LayoutOrder=5

-- ── GUI BUILDER HELPERS ─────────────────────────
local refreshers = {}

-- Función para actualizar el color de acento globalmente
local accentDeps = {}   -- {frame/stroke/label, prop}
local function registerAccent(obj, prop)
    table.insert(accentDeps, {obj=obj, prop=prop})
    obj[prop] = accentColor
end
local function applyAccent(newCol)
    accentColor = newCol
    logoGlow.Color = newCol
    glow.BackgroundColor3 = newCol
    panelStroke.Color = Color3.fromRGB(58,58,58)  -- no cambia
    for _, dot in ipairs(particleLayer:GetChildren()) do
        if dot:IsA("Frame") then dot.BackgroundColor3 = newCol end
    end
    for _, a in ipairs(accentDeps) do
        pcall(function() a.obj[a.prop] = newCol end)
    end
    -- nav active state
    local nb2 = navBtns[activePage]
    if nb2 then
        local ns = nb2:FindFirstChildOfClass("UIStroke")
        if ns then ns.Color = newCol end
    end
    -- Sidebar chain
    for _, ch in ipairs(sidebar:GetChildren()) do
        if ch:IsA("Frame") and ch:FindFirstChildOfClass("UIGradient") then
            local g = ch:FindFirstChildOfClass("UIGradient")
            if g and #g.Color.Keypoints >= 3 then
                g.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(0,0,0)),
                    ColorSequenceKeypoint.new(0.2, Color3.fromRGB(58,58,58)),
                    ColorSequenceKeypoint.new(0.5, newCol),
                    ColorSequenceKeypoint.new(0.8, Color3.fromRGB(58,58,58)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(0,0,0)),
                })
            end
        end
    end
end

-- Crear card (panel-box en HTML)
local function makeCard(parent)
    local card = Instance.new("Frame", parent)
    card.Size = UDim2.new(1, 0, 0, 0); card.AutomaticSize = Enum.AutomaticSize.Y
    card.BackgroundColor3 = Color3.fromRGB(13,13,13); card.BorderSizePixel = 0
    local cs = Instance.new("UIStroke", card)
    cs.Color = Color3.fromRGB(58,58,58); cs.Transparency = 0; cs.Thickness = 1
    local lay = Instance.new("UIListLayout", card)
    lay.SortOrder = Enum.SortOrder.LayoutOrder; lay.Padding = UDim.new(0,0)
    card.ClipsDescendants = true
    return card
end

-- Section header dentro de una card
local function makeSecHeader(parent, iconChar, titleText)
    local sh = Instance.new("Frame", parent)
    sh.Size = UDim2.new(1, 0, 0, 32); sh.BackgroundTransparency = 1
    local shBG = Instance.new("UIGradient", sh)
    shBG.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(8,6,8)), ColorSequenceKeypoint.new(1, Color3.fromRGB(13,10,13))})

    local dagLbl = Instance.new("TextLabel", sh)
    dagLbl.Size = UDim2.fromOffset(16, 32); dagLbl.Position = UDim2.fromOffset(14, 0)
    dagLbl.BackgroundTransparency = 1; dagLbl.Text = iconChar or "†"
    dagLbl.TextColor3 = accentColor; dagLbl.Font = Enum.Font.GothamBold; dagLbl.TextSize = 10
    registerAccent(dagLbl, "TextColor3")

    local titLbl = Instance.new("TextLabel", sh)
    titLbl.Size = UDim2.new(0, 120, 1, 0); titLbl.Position = UDim2.fromOffset(32, 0)
    titLbl.BackgroundTransparency = 1; titLbl.Text = titleText
    titLbl.TextColor3 = Color3.fromRGB(239,239,239); titLbl.Font = Enum.Font.GothamBlack
    titLbl.TextSize = 14; titLbl.TextXAlignment = Enum.TextXAlignment.Left

    -- Línea decorativa
    local secLine = Instance.new("Frame", sh)
    secLine.Size = UDim2.new(0, 80, 0, 1); secLine.Position = UDim2.new(0, 165, 0.5, 0)
    secLine.BackgroundColor3 = Color3.fromRGB(58,58,58); secLine.BorderSizePixel = 0
    local slG = Instance.new("UIGradient", secLine)
    slG.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(58,58,58)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0,0,0))})

    local shBottom = Instance.new("Frame", sh)
    shBottom.Size = UDim2.new(1, 0, 0, 1); shBottom.Position = UDim2.new(0, 0, 1, -1)
    shBottom.BackgroundColor3 = Color3.fromRGB(26,26,26); shBottom.BorderSizePixel = 0

    return sh
end

-- Divider
local function makeDivider(parent)
    local d = Instance.new("Frame", parent)
    d.Size = UDim2.new(1, 0, 0, 1); d.BackgroundColor3 = Color3.fromRGB(17,17,17); d.BorderSizePixel = 0
    return d
end

-- Section label simple (texto · · · SECCIÓN · · ·)
local function secLabel(parent, text)
    local f = Instance.new("Frame", parent)
    f.Size = UDim2.new(1, 0, 0, 26); f.BackgroundColor3 = Color3.fromRGB(8,6,8); f.BorderSizePixel = 0
    local topLine = Instance.new("Frame", f); topLine.Size = UDim2.new(1,0,0,1)
    topLine.BackgroundColor3 = Color3.fromRGB(26,26,26); topLine.BorderSizePixel = 0
    local botLine = Instance.new("Frame", f); botLine.Size = UDim2.new(1,0,0,1); botLine.Position = UDim2.new(0,0,1,-1)
    botLine.BackgroundColor3 = Color3.fromRGB(17,17,17); botLine.BorderSizePixel = 0
    local l = Instance.new("TextLabel", f)
    l.Size = UDim2.new(1, -28, 1, 0); l.Position = UDim2.fromOffset(14, 0)
    l.BackgroundTransparency = 1; l.Text = text:upper()
    l.TextColor3 = Color3.fromRGB(58,58,58); l.Font = Enum.Font.GothamBold; l.TextSize = 9
    l.TextXAlignment = Enum.TextXAlignment.Left; l.LetterSpacing = 3
    return f
end

-- Panel Row (contenedor de un ítem de configuración)
local function makeRow(parent, titleTxt, descTxt)
    local hasDesc = descTxt and descTxt ~= ""
    local rowH = hasDesc and 56 or 42
    local row = Instance.new("Frame", parent)
    row.Size = UDim2.new(1, 0, 0, rowH); row.BackgroundTransparency = 1

    local tl = Instance.new("TextLabel", row)
    tl.Size = UDim2.new(1, -70, 0, 16)
    tl.Position = UDim2.fromOffset(14, hasDesc and 10 or 13)
    tl.BackgroundTransparency = 1; tl.Text = titleTxt
    tl.TextColor3 = Color3.fromRGB(215, 215, 215); tl.Font = Enum.Font.GothamMedium
    tl.TextSize = 12; tl.TextXAlignment = Enum.TextXAlignment.Left
    tl.TextTruncate = Enum.TextTruncate.AtEnd

    if hasDesc then
        local dl = Instance.new("TextLabel", row)
        dl.Size = UDim2.new(1, -70, 0, 20); dl.Position = UDim2.fromOffset(14, 28)
        dl.BackgroundTransparency = 1; dl.Text = descTxt
        dl.TextColor3 = Color3.fromRGB(85,85,85); dl.Font = Enum.Font.Gotham
        dl.TextSize = 9; dl.TextXAlignment = Enum.TextXAlignment.Left; dl.TextWrapped = true
    end
    return row, rowH
end

-- Toggle
local function makeToggle(parent, titleKey, descKey, stateKey, cb)
    local title = L(titleKey) or titleKey
    local desc = descKey and (L(descKey) or descKey) or nil
    local row, rowH = makeRow(parent, title, desc)

    local TW, TH = 44, 24
    local track = Instance.new("Frame", row)
    track.Size = UDim2.fromOffset(TW, TH)
    track.Position = UDim2.new(1, -(TW+14), 0.5, -TH/2)
    track.BorderSizePixel = 0
    Instance.new("UICorner", track).CornerRadius = UDim.new(1, 0)
    local trkStroke = Instance.new("UIStroke", track)
    trkStroke.Color = Color3.fromRGB(58,58,58); trkStroke.Thickness = 1

    local thumb = Instance.new("Frame", track)
    thumb.Size = UDim2.fromOffset(18,18); thumb.BorderSizePixel = 0
    Instance.new("UICorner", thumb).CornerRadius = UDim.new(1, 0)

    local function refresh()
        local on = S[stateKey]
        if on then
            TweenService:Create(track, TI, {BackgroundColor3 = accentColor}):Play()
            trkStroke.Color = accentColor
        else
            TweenService:Create(track, TI, {BackgroundColor3 = Color3.fromRGB(26,26,26)}):Play()
            trkStroke.Color = Color3.fromRGB(58,58,58)
        end
        TweenService:Create(thumb, TI, {
            Position = on and UDim2.fromOffset(TW-20, 3) or UDim2.fromOffset(2, 3),
            BackgroundColor3 = on and Color3.fromRGB(239,239,239) or Color3.fromRGB(58,58,58),
        }):Play()
    end
    refresh(); refreshers[stateKey] = refresh

    local hit = Instance.new("TextButton", row)
    hit.Size = UDim2.new(1, 0, 1, 0); hit.BackgroundTransparency = 1; hit.Text = ""
    hit.MouseButton1Click:Connect(function()
        S[stateKey] = not S[stateKey]; refresh(); save()
        if cb then cb(S[stateKey]) end
        showNotif("✝  "..title, S[stateKey] and L("n_on") or L("n_off"), S[stateKey])
    end)
    hit.MouseEnter:Connect(function() TweenService:Create(row, TI, {BackgroundColor3=Color3.fromRGB(16,12,20)}):Play(); row.BackgroundTransparency=0; Instance.new("UICorner",row).CornerRadius=UDim.new(0,0) end)
    hit.MouseLeave:Connect(function() TweenService:Create(row, TI, {BackgroundTransparency=1}):Play() end)
    return row
end

-- Slider
local function makeSlider(parent, titleKey, stateKey, mn, mx)
    local title = L(titleKey) or titleKey
    local row = Instance.new("Frame", parent)
    row.Size = UDim2.new(1, 0, 0, 52); row.BackgroundTransparency = 1

    local valLbl = Instance.new("TextLabel", row)
    valLbl.Size = UDim2.fromOffset(22, 16); valLbl.Position = UDim2.new(1, -36, 0, 12)
    valLbl.BackgroundTransparency = 1; valLbl.Text = tostring(S[stateKey])
    valLbl.TextColor3 = accentColor; valLbl.Font = Enum.Font.GothamBold; valLbl.TextSize = 11
    valLbl.TextXAlignment = Enum.TextXAlignment.Right
    registerAccent(valLbl, "TextColor3")

    local tl = Instance.new("TextLabel", row)
    tl.Size = UDim2.new(1, -70, 0, 16); tl.Position = UDim2.fromOffset(14, 12)
    tl.BackgroundTransparency = 1; tl.Text = title
    tl.TextColor3 = Color3.fromRGB(215,215,215); tl.Font = Enum.Font.GothamMedium; tl.TextSize = 12
    tl.TextXAlignment = Enum.TextXAlignment.Left

    local trk = Instance.new("Frame", row)
    trk.Size = UDim2.new(1, -28, 0, 4); trk.Position = UDim2.fromOffset(14, 34)
    trk.BackgroundColor3 = Color3.fromRGB(42,42,42); trk.BorderSizePixel = 0
    Instance.new("UICorner", trk).CornerRadius = UDim.new(1,0)

    local fill = Instance.new("Frame", trk)
    fill.BackgroundColor3 = accentColor; fill.BorderSizePixel = 0
    Instance.new("UICorner", fill).CornerRadius = UDim.new(1,0)
    registerAccent(fill, "BackgroundColor3")

    local sThumb = Instance.new("Frame", trk)
    sThumb.Size = UDim2.fromOffset(13,13); sThumb.BackgroundColor3 = accentColor
    sThumb.BorderSizePixel = 0; Instance.new("UICorner", sThumb).CornerRadius = UDim.new(1,0)
    registerAccent(sThumb, "BackgroundColor3")

    local function setVal(v)
        v = math.clamp(math.floor(v+0.5), mn, mx)
        S[stateKey] = v; valLbl.Text = tostring(v); save()
        local pct = (v-mn)/(mx-mn)
        TweenService:Create(fill, TweenInfo.new(0.1), {Size=UDim2.new(pct,0,1,0)}):Play()
        TweenService:Create(sThumb, TweenInfo.new(0.1), {Position=UDim2.new(pct,-6,0.5,-6)}):Play()
    end
    setVal(S[stateKey])

    local sliding = false
    trk.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 then
            sliding = true
            local abs = trk.AbsolutePosition; local sz = trk.AbsoluteSize
            if sz.X > 0 then setVal(mn + math.clamp((inp.Position.X-abs.X)/sz.X,0,1)*(mx-mn)) end
        end
    end)
    UserInputService.InputChanged:Connect(function(inp)
        if sliding and inp.UserInputType == Enum.UserInputType.MouseMovement then
            local abs = trk.AbsolutePosition; local sz = trk.AbsoluteSize
            if sz.X > 0 then setVal(mn + math.clamp((inp.Position.X-abs.X)/sz.X,0,1)*(mx-mn)) end
        end
    end)
    UserInputService.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 then sliding = false end
    end)
    return row
end

-- Keybind
local function makeKeybind(parent, titleKey, stateKey)
    local title = L(titleKey) or titleKey
    local row, _ = makeRow(parent, title, nil)
    row.Size = UDim2.new(1, 0, 0, 42)

    local kbBtn = Instance.new("TextButton", row)
    kbBtn.Size = UDim2.fromOffset(28, 28)
    kbBtn.Position = UDim2.new(1, -42, 0.5, -14)
    kbBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
    kbBtn.BorderSizePixel = 0; kbBtn.AutoButtonColor = false
    local kbs = Instance.new("UIStroke", kbBtn); kbs.Color = Color3.fromRGB(58,58,58); kbs.Thickness = 1

    local function getKeyLabel(k)
        if k == "RightShift" then return "RS"
        elseif k == "LeftShift" then return "LS"
        elseif #k == 1 then return k
        else return k:sub(1,3) end
    end
    local kbLbl = Instance.new("TextLabel", kbBtn)
    kbLbl.Size = UDim2.new(1,0,1,0); kbLbl.BackgroundTransparency = 1
    kbLbl.Text = getKeyLabel(S[stateKey]); kbLbl.TextColor3 = accentColor
    kbLbl.Font = Enum.Font.GothamBold; kbLbl.TextSize = 11
    registerAccent(kbLbl, "TextColor3")

    local listening = false
    kbBtn.MouseButton1Click:Connect(function()
        if listening then return end
        listening = true
        kbLbl.Text = "…"; kbLbl.TextColor3 = accentColor; kbs.Color = accentColor
        local conn; conn = UserInputService.InputBegan:Connect(function(inp, proc)
            if proc then return end
            if inp.UserInputType == Enum.UserInputType.Keyboard then
                local kn = inp.KeyCode.Name
                if kn == "Escape" then
                    kbLbl.Text = getKeyLabel(S[stateKey])
                else
                    S[stateKey] = kn; save()
                    kbLbl.Text = getKeyLabel(kn)
                end
                kbLbl.TextColor3 = accentColor; kbs.Color = Color3.fromRGB(58,58,58)
                listening = false; conn:Disconnect()
            end
        end)
    end)
    kbBtn.MouseEnter:Connect(function() kbs.Color = accentColor end)
    kbBtn.MouseLeave:Connect(function() if not listening then kbs.Color = Color3.fromRGB(58,58,58) end end)

    local function refreshKb()
        kbLbl.Text = getKeyLabel(S[stateKey])
    end
    refreshers[stateKey] = refreshKb
    return row
end

-- Reset Button
local function makeResetBtn(parent, titleKey, descKey, cb)
    local title = L(titleKey) or titleKey
    local desc = descKey and (L(descKey) or descKey) or nil
    local row, _ = makeRow(parent, title, desc)
    row.Size = UDim2.new(1, 0, 0, desc and 52 or 42)

    local rBtn = Instance.new("TextButton", row)
    rBtn.Size = UDim2.fromOffset(28, 28)
    rBtn.Position = UDim2.new(1, -42, 0.5, -14)
    rBtn.BackgroundColor3 = Color3.fromRGB(30,30,30); rBtn.BorderSizePixel = 0
    rBtn.Text = "↺"; rBtn.TextColor3 = accentColor
    rBtn.Font = Enum.Font.GothamBold; rBtn.TextSize = 16; rBtn.AutoButtonColor = false
    local rbs = Instance.new("UIStroke", rBtn); rbs.Color = Color3.fromRGB(58,58,58); rbs.Thickness = 1
    rBtn.MouseEnter:Connect(function() rbs.Color = accentColor end)
    rBtn.MouseLeave:Connect(function() rbs.Color = Color3.fromRGB(58,58,58) end)
    rBtn.MouseButton1Click:Connect(function()
        TweenService:Create(rBtn, TI, {Rotation=360}):Play()
        task.delay(0.2, function() rBtn.Rotation=0 end)
        if cb then cb() end
        showNotif("✝  "..title, L("n_reset"), true)
    end)
    return row
end

-- Dropdown
local function makeDropdown(parent, titleKey, stateKey, options, cb)
    local title = L(titleKey) or titleKey
    local container = Instance.new("Frame", parent)
    container.Size = UDim2.new(1, 0, 0, 42); container.BackgroundTransparency = 1

    local row = Instance.new("Frame", container)
    row.Size = UDim2.new(1, 0, 0, 42); row.BackgroundTransparency = 1

    local tl = Instance.new("TextLabel", row)
    tl.Size = UDim2.new(1, -120, 0, 16); tl.Position = UDim2.fromOffset(14, 13)
    tl.BackgroundTransparency = 1; tl.Text = title
    tl.TextColor3 = Color3.fromRGB(215,215,215); tl.Font = Enum.Font.GothamMedium; tl.TextSize = 12
    tl.TextXAlignment = Enum.TextXAlignment.Left

    local valLbl = Instance.new("TextLabel", row)
    valLbl.Size = UDim2.fromOffset(90, 16); valLbl.Position = UDim2.new(1, -110, 0, 13)
    valLbl.BackgroundTransparency = 1; valLbl.Text = S[stateKey]
    valLbl.TextColor3 = Color3.fromRGB(85,85,85); valLbl.Font = Enum.Font.Gotham; valLbl.TextSize = 11
    valLbl.TextXAlignment = Enum.TextXAlignment.Right

    local arrowLbl = Instance.new("TextLabel", row)
    arrowLbl.Size = UDim2.fromOffset(14, 16); arrowLbl.Position = UDim2.new(1, -18, 0, 13)
    arrowLbl.BackgroundTransparency = 1; arrowLbl.Text = "▾"
    arrowLbl.TextColor3 = Color3.fromRGB(85,85,85); arrowLbl.Font = Enum.Font.GothamBold; arrowLbl.TextSize = 10

    local optH = 32
    local dropFrame = Instance.new("Frame", container)
    dropFrame.Size = UDim2.new(1, 0, 0, 0); dropFrame.Position = UDim2.fromOffset(0, 42)
    dropFrame.BackgroundColor3 = Color3.fromRGB(18,14,22); dropFrame.BorderSizePixel = 0
    dropFrame.ClipsDescendants = true; dropFrame.ZIndex = 50; dropFrame.Visible = false
    local dfs = Instance.new("UIStroke", dropFrame); dfs.Color = Color3.fromRGB(58,58,58); dfs.Thickness = 1

    for idx, opt in ipairs(options) do
        local ob = Instance.new("TextButton", dropFrame)
        ob.Size = UDim2.new(1,0,0,optH); ob.Position = UDim2.fromOffset(0,(idx-1)*optH)
        ob.BackgroundTransparency = 1; ob.BorderSizePixel = 0
        ob.Text = opt; ob.Font = Enum.Font.GothamMedium; ob.TextSize = 11
        ob.TextColor3 = S[stateKey] == opt and accentColor or Color3.fromRGB(215,215,215)
        ob.ZIndex = 51; ob.AutoButtonColor = false
        ob.MouseButton1Click:Connect(function()
            S[stateKey] = opt; valLbl.Text = opt
            for _, b in ipairs(dropFrame:GetChildren()) do
                if b:IsA("TextButton") then b.TextColor3 = b.Text==opt and accentColor or Color3.fromRGB(215,215,215) end
            end
            TweenService:Create(dropFrame, TIF, {Size=UDim2.new(1,0,0,0)}):Play()
            task.delay(0.25, function() dropFrame.Visible=false end)
            container.Size = UDim2.new(1,0,0,42); arrowLbl.Text = "▾"
            save(); if cb then cb(opt) end
        end)
    end

    local open = false
    local hitArea = Instance.new("TextButton", row)
    hitArea.Size = UDim2.new(1,0,1,0); hitArea.BackgroundTransparency=1; hitArea.Text=""; hitArea.ZIndex=5
    hitArea.MouseButton1Click:Connect(function()
        open = not open
        if open then
            dropFrame.Visible=true; dropFrame.Size=UDim2.new(1,0,0,0)
            TweenService:Create(dropFrame, TIF, {Size=UDim2.new(1,0,0,#options*optH)}):Play()
            container.Size=UDim2.new(1,0,0,42+#options*optH); arrowLbl.Text="▴"
        else
            TweenService:Create(dropFrame, TIF, {Size=UDim2.new(1,0,0,0)}):Play()
            task.delay(0.25, function() dropFrame.Visible=false end)
            container.Size=UDim2.new(1,0,0,42); arrowLbl.Text="▾"
        end
    end)
    return container
end

-- Color Picker (hex input + swatch click)
local function makeColorPicker(parent, label, getR, getG, getB, setRGB)
    local row = Instance.new("Frame", parent)
    row.Size = UDim2.new(1, 0, 0, 42); row.BackgroundTransparency = 1

    local tl = Instance.new("TextLabel", row)
    tl.Size = UDim2.new(1, -60, 0, 16); tl.Position = UDim2.fromOffset(14, 13)
    tl.BackgroundTransparency = 1; tl.Text = label
    tl.TextColor3 = Color3.fromRGB(215,215,215); tl.Font = Enum.Font.GothamMedium; tl.TextSize = 12
    tl.TextXAlignment = Enum.TextXAlignment.Left

    -- Swatch + R/G/B sliders en popup
    local swatch = Instance.new("Frame", row)
    swatch.Size = UDim2.fromOffset(28, 28); swatch.Position = UDim2.new(1, -42, 0.5, -14)
    swatch.BackgroundColor3 = Color3.fromRGB(getR(), getG(), getB()); swatch.BorderSizePixel = 0
    local swStroke = Instance.new("UIStroke", swatch); swStroke.Color = Color3.fromRGB(58,58,58); swStroke.Thickness = 1

    -- Sub-panel con los 3 sliders R/G/B
    local popup = Instance.new("Frame", parent)
    popup.Size = UDim2.new(1, 0, 0, 130); popup.BackgroundColor3 = Color3.fromRGB(16,12,22)
    popup.BorderSizePixel = 0; popup.Visible = false
    local pps = Instance.new("UIStroke", popup); pps.Color = Color3.fromRGB(58,58,58); pps.Thickness = 1
    local ppLayout = Instance.new("UIListLayout", popup)
    ppLayout.SortOrder = Enum.SortOrder.LayoutOrder; ppLayout.Padding = UDim.new(0,4)
    local ppPad = Instance.new("UIPadding", popup)
    ppPad.PaddingTop=UDim.new(0,8); ppPad.PaddingLeft=UDim.new(0,12)
    ppPad.PaddingRight=UDim.new(0,12); ppPad.PaddingBottom=UDim.new(0,8)

    local rgbVals = {getR(), getG(), getB()}
    local function updateSwatch()
        swatch.BackgroundColor3 = Color3.fromRGB(rgbVals[1], rgbVals[2], rgbVals[3])
        setRGB(rgbVals[1], rgbVals[2], rgbVals[3])
    end

    local LABELS = {"R","G","B"}
    local COLS = {Color3.fromRGB(220,80,80), Color3.fromRGB(80,200,80), Color3.fromRGB(80,120,220)}

    for ci = 1, 3 do
        local sRow = Instance.new("Frame", popup)
        sRow.Size = UDim2.new(1, 0, 0, 28); sRow.BackgroundTransparency = 1

        local lLbl = Instance.new("TextLabel", sRow)
        lLbl.Size = UDim2.fromOffset(16, 28); lLbl.Position = UDim2.fromOffset(0, 0)
        lLbl.BackgroundTransparency=1; lLbl.Text=LABELS[ci]
        lLbl.TextColor3=COLS[ci]; lLbl.Font=Enum.Font.GothamBold; lLbl.TextSize=11

        local vLbl = Instance.new("TextLabel", sRow)
        vLbl.Size = UDim2.fromOffset(28, 28); vLbl.Position = UDim2.new(1,-30,0,0)
        vLbl.BackgroundTransparency=1; vLbl.Text=tostring(rgbVals[ci])
        vLbl.TextColor3=COLS[ci]; vLbl.Font=Enum.Font.GothamBold; vLbl.TextSize=10
        vLbl.TextXAlignment=Enum.TextXAlignment.Right

        local trk2 = Instance.new("Frame", sRow)
        trk2.Size = UDim2.new(1,-52,0,4); trk2.Position=UDim2.fromOffset(22,12)
        trk2.BackgroundColor3=Color3.fromRGB(42,42,42); trk2.BorderSizePixel=0
        Instance.new("UICorner",trk2).CornerRadius=UDim.new(1,0)

        local fill2 = Instance.new("Frame", trk2)
        fill2.BackgroundColor3=COLS[ci]; fill2.BorderSizePixel=0
        Instance.new("UICorner",fill2).CornerRadius=UDim.new(1,0)

        local function setV(v)
            v = math.clamp(math.floor(v+0.5),0,255)
            rgbVals[ci] = v; vLbl.Text=tostring(v)
            fill2.Size = UDim2.new(v/255,0,1,0)
            updateSwatch(); save()
        end
        setV(rgbVals[ci])

        local sl2 = false
        trk2.InputBegan:Connect(function(inp)
            if inp.UserInputType==Enum.UserInputType.MouseButton1 then
                sl2=true
                local a=trk2.AbsolutePosition; local sz=trk2.AbsoluteSize
                if sz.X>0 then setV((inp.Position.X-a.X)/sz.X*255) end
            end
        end)
        UserInputService.InputChanged:Connect(function(inp)
            if sl2 and inp.UserInputType==Enum.UserInputType.MouseMovement then
                local a=trk2.AbsolutePosition; local sz=trk2.AbsoluteSize
                if sz.X>0 then setV((inp.Position.X-a.X)/sz.X*255) end
            end
        end)
        UserInputService.InputEnded:Connect(function(inp)
            if inp.UserInputType==Enum.UserInputType.MouseButton1 then sl2=false end
        end)
    end

    local popOpen = false
    local swBtn = Instance.new("TextButton", swatch)
    swBtn.Size=UDim2.new(1,0,1,0); swBtn.BackgroundTransparency=1; swBtn.Text=""
    swBtn.MouseButton1Click:Connect(function()
        popOpen = not popOpen; popup.Visible = popOpen
    end)
    return row, popup
end

-- Páginas: 1 = Inicio, 2 = Ajustes
local pg_inicio   = pages[1]
local pg_ajustes  = pages[2]

-- ══ INICIO PAGE ══════════════════════════════════

-- User Card (avatar + nombre + skin)
local userCard = Instance.new("Frame", pg_inicio)
userCard.Size = UDim2.new(1, 0, 0, 72)
userCard.BackgroundColor3 = Color3.fromRGB(13, 10, 18)
userCard.BorderSizePixel = 0
local ucStroke = Instance.new("UIStroke", userCard); ucStroke.Color=Color3.fromRGB(42,42,42); ucStroke.Thickness=1

-- Avatar circle
local avatarCircle = Instance.new("Frame", userCard)
avatarCircle.Size = UDim2.fromOffset(52, 52); avatarCircle.Position = UDim2.fromOffset(14, 10)
avatarCircle.BackgroundColor3 = Color3.fromRGB(26,16,42); avatarCircle.BorderSizePixel = 0
Instance.new("UICorner", avatarCircle).CornerRadius = UDim.new(1,0)
local avStroke = Instance.new("UIStroke", avatarCircle); avStroke.Color = accentColor; avStroke.Thickness = 2
registerAccent(avStroke, "Color")

local avatarImg = Instance.new("ImageLabel", avatarCircle)
avatarImg.Size = UDim2.new(1,0,1,0); avatarImg.BackgroundTransparency = 1
avatarImg.Image = "https://www.roblox.com/headshot-thumbnail/image?userId="..player.UserId.."&width=150&height=150&format=png"
avatarImg.ScaleType = Enum.ScaleType.Fit
Instance.new("UICorner", avatarImg).CornerRadius = UDim.new(1,0)

-- Info
local uNameLbl = Instance.new("TextLabel", userCard)
uNameLbl.Size = UDim2.new(1,-120,0,22); uNameLbl.Position = UDim2.fromOffset(76, 10)
uNameLbl.BackgroundTransparency=1; uNameLbl.Text=player.Name
uNameLbl.TextColor3=Color3.fromRGB(239,239,239); uNameLbl.Font=Enum.Font.GothamBlack
uNameLbl.TextSize=16; uNameLbl.TextXAlignment=Enum.TextXAlignment.Left

local uSkinLbl = Instance.new("TextLabel", userCard)
uSkinLbl.Size = UDim2.new(1,-120,0,14); uSkinLbl.Position = UDim2.fromOffset(76, 34)
uSkinLbl.BackgroundTransparency=1
-- Skin = nombre del avatar o outfit si existe
local skinText = "Default"
pcall(function()
    local desc = Players:GetHumanoidDescriptionFromUserId(player.UserId)
    if desc and desc.Shirt ~= 0 then skinText = "Custom Outfit" end
end)
uSkinLbl.Text="Skin: "..skinText
uSkinLbl.TextColor3=Color3.fromRGB(85,85,85); uSkinLbl.Font=Enum.Font.Gotham
uSkinLbl.TextSize=10; uSkinLbl.TextXAlignment=Enum.TextXAlignment.Left

local uIdLbl = Instance.new("TextLabel", userCard)
uIdLbl.Size = UDim2.new(1,-120,0,12); uIdLbl.Position = UDim2.fromOffset(76, 50)
uIdLbl.BackgroundTransparency=1; uIdLbl.Text="ID: "..tostring(player.UserId)
uIdLbl.TextColor3=Color3.fromRGB(42,42,42); uIdLbl.Font=Enum.Font.Gotham
uIdLbl.TextSize=9; uIdLbl.TextXAlignment=Enum.TextXAlignment.Left

-- Status dot
local statusDot = Instance.new("Frame", userCard)
statusDot.Size=UDim2.fromOffset(8,8); statusDot.Position=UDim2.new(1,-16,0,10)
statusDot.BackgroundColor3=accentColor; statusDot.BorderSizePixel=0
Instance.new("UICorner",statusDot).CornerRadius=UDim.new(1,0)
registerAccent(statusDot, "BackgroundColor3")
local statusLbl = Instance.new("TextLabel", userCard)
statusLbl.Size=UDim2.fromOffset(40,10); statusLbl.Position=UDim2.new(1,-50,0,0)
statusLbl.BackgroundTransparency=1; statusLbl.Text="ONLINE"
statusLbl.TextColor3=Color3.fromRGB(42,42,42); statusLbl.Font=Enum.Font.GothamBold
statusLbl.TextSize=7; statusLbl.TextXAlignment=Enum.TextXAlignment.Right

-- ── ESP + HBX en dos columnas ─────────────────
-- Roblox no soporta Flexbox, usaremos dos frames side by side
local rowESP_HBX = Instance.new("Frame", pg_inicio)
rowESP_HBX.Size = UDim2.new(1, 0, 0, 0); rowESP_HBX.AutomaticSize = Enum.AutomaticSize.Y
rowESP_HBX.BackgroundTransparency = 1; rowESP_HBX.BorderSizePixel = 0

local COL_W = (CONTENT_W - 28 - 8) / 2   -- 8 = gap, 28 = padding total

local espCol = Instance.new("Frame", rowESP_HBX)
espCol.Size = UDim2.fromOffset(COL_W, 0); espCol.AutomaticSize = Enum.AutomaticSize.Y
espCol.Position = UDim2.fromOffset(0, 0); espCol.BackgroundTransparency = 1
local espColLayout = Instance.new("UIListLayout", espCol)
espColLayout.SortOrder = Enum.SortOrder.LayoutOrder; espColLayout.Padding = UDim.new(0,0)

local hbxCol = Instance.new("Frame", rowESP_HBX)
hbxCol.Size = UDim2.fromOffset(COL_W, 0); hbxCol.AutomaticSize = Enum.AutomaticSize.Y
hbxCol.Position = UDim2.fromOffset(COL_W + 8, 0); hbxCol.BackgroundTransparency = 1
local hbxColLayout = Instance.new("UIListLayout", hbxCol)
hbxColLayout.SortOrder = Enum.SortOrder.LayoutOrder; hbxColLayout.Padding = UDim.new(0,0)

-- Altura del rowESP_HBX se ajusta al hijo más alto
local function updateRowHeight()
    local eH = espCol.AbsoluteSize.Y
    local hH = hbxCol.AbsoluteSize.Y
    rowESP_HBX.Size = UDim2.new(1, 0, 0, math.max(eH, hH))
end
espColLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateRowHeight)
hbxColLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateRowHeight)

-- ── ESP Column ─────────────────────────────────
local espCard = makeCard(espCol)
espCard.Size = UDim2.fromOffset(COL_W, 0)
makeSecHeader(espCard, "†", "ESP")
makeToggle(espCard, "esp_on",    "esp_on_d",    "esp_on")
makeDivider(espCard)
makeToggle(espCard, "esp_names", nil,           "esp_names")
makeDivider(espCard)
makeToggle(espCard, "esp_avatar","esp_avatar_d","esp_avatar")
makeDivider(espCard)
makeToggle(espCard, "esp_lines", "esp_lines_d", "esp_lines")
makeDivider(espCard)
-- Color ESP picker (swatch)
local espColorRow, espColorPop = makeColorPicker(espCard, "ESP Color",
    function() return S.esp_char_r end,
    function() return S.esp_char_g end,
    function() return S.esp_char_b end,
    function(r,g,b) S.esp_char_r=r; S.esp_char_g=g; S.esp_char_b=b end
)
makeDivider(espCard)
makeKeybind(espCard, "esp_key", "esp_key")

-- ── HBX Column ─────────────────────────────────
local hbxCard = makeCard(hbxCol)
hbxCard.Size = UDim2.fromOffset(COL_W, 0)
makeSecHeader(hbxCard, "†", "GUI")

-- Triggerbot row separado debajo de las columnas
local trgCard = makeCard(pg_inicio)
makeSecHeader(trgCard, "·", "Triggerbot")

-- ── INICIO content ──────────────────────────────
makeToggle(hbxCard, "hbx_on",   "hbx_on_d",   "hbx_on", function(on)
    if not on then
        for _, p2 in ipairs(Players:GetPlayers()) do
            if p2 ~= player and p2.Character then
                local root2 = p2.Character:FindFirstChild("HumanoidRootPart")
                if root2 then pcall(function() root2.Size = Vector3.new(2,2,1) end) end
            end
        end
    end
end)
makeDivider(hbxCard)
makeToggle(hbxCard, "hbx_vis",  "hbx_vis_d",  "hbx_vis_check")
makeDivider(hbxCard)
makeSlider(hbxCard, "hbx_size", "hbx_size", 1, 20)
makeDivider(hbxCard)
makeToggle(hbxCard, "hbx_show", nil,           "hbx_show")
makeDivider(hbxCard)
makeKeybind(hbxCard, "hbx_key", "hbx_key")

-- Triggerbot card (full width)
makeToggle(trgCard, "trg_on",   "trg_on_d",   "trg_on")
makeDivider(trgCard)
makeKeybind(trgCard, "trg_key", "trg_key")

-- ══ AJUSTES PAGE ══════════════════════════════════
local cfgCard = makeCard(pg_ajustes)
makeSecHeader(cfgCard, "†", "Settings")

secLabel(cfgCard, "· · · DISPLAY · · ·")
makeToggle(cfgCard, "st_bg",    nil, "panel_bg")
makeDivider(cfgCard)
makeToggle(cfgCard, "st_notif", nil, "notifs")

secLabel(cfgCard, "· · · LANGUAGE · · ·")
makeDropdown(cfgCard, "st_lang", "lang", {"English","Español"}, nil)

secLabel(cfgCard, "· · · KEYBINDS · · ·")
local keyCard2 = makeCard(pg_ajustes)
makeKeybind(keyCard2, "st_key", "gui_key")
makeDivider(keyCard2)
makeResetBtn(keyCard2, "st_r1", "st_r1_d", function()
    S.gui_key = "RightShift"; if refreshers["gui_key"] then refreshers["gui_key"]() end; save()
end)
makeDivider(keyCard2)
makeResetBtn(keyCard2, "st_r2", "st_r2_d", function()
    S.esp_key="T"; S.hbx_key="G"; S.trg_key="R"; S.gui_key="RightShift"
    for k, fn in pairs(refreshers) do if k:find("_key") then fn() end end; save()
end)

secLabel(cfgCard, "· · · COLORES · · ·")
-- Color Global (accent de la GUI)
local guiColorRow, guiColorPop = makeColorPicker(cfgCard, "GUI Accent Color",
    function() return math.floor(accentColor.R*255) end,
    function() return math.floor(accentColor.G*255) end,
    function() return math.floor(accentColor.B*255) end,
    function(r,g,b) applyAccent(Color3.fromRGB(r,g,b)) end
)

secLabel(pg_ajustes, "· · · EVENT · · ·")
local evtCard2 = makeCard(pg_ajustes)
makeToggle(evtCard2, "ev_sum", "ev_sum_d", "summer_on", function(on)
    showNotif("Summer 2026", on and "Auto-collect ON" or "Auto-collect OFF", on)
end)

-- Activar página 1 por defecto
setPage = setPage  -- referencia correcta (definida arriba con forward)
pages[1].Visible = true
navBtns[1].BackgroundColor3 = Color3.fromRGB(36,30,46)
navBtns[1].BackgroundTransparency = 0.5
local ns1 = navBtns[1]:FindFirstChildOfClass("UIStroke")
if ns1 then ns1.Color = accentColor end
for _, ch in ipairs(navBtns[1]:GetChildren()) do
    if ch:IsA("TextLabel") then ch.TextColor3 = Color3.fromRGB(239,239,239) end
end

-- Expose tabPages alias para compatibilidad con keybinds toggle
local tabPages = {pages[1], pages[1], pages[1], pages[2]}  -- dummy, no se usa con tabs

-- ══════════════════════════════════════════════
--  DRAG — mover panel (por el header)
-- ══════════════════════════════════════════════
do
    local drag, dragStart, startPos = false, nil, nil
    local dh = Instance.new("TextButton", header)
    dh.Size = UDim2.new(1, -30, 1, 0); dh.BackgroundTransparency = 1; dh.Text = ""
    dh.ZIndex = 5
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
                startPos.X.Scale, math.clamp(startPos.X.Offset + d.X, 0, sc.X - GW),
                startPos.Y.Scale, math.clamp(startPos.Y.Offset + d.Y, 0, sc.Y - GH)
            )
            glow.Position = UDim2.new(
                panel.Position.X.Scale, panel.Position.X.Offset - 10,
                panel.Position.Y.Scale, panel.Position.Y.Offset - 10
            )
        end
    end)
end

-- Legacy tabbed UI from the previous build. The Figma sidebar GUI above is the
-- active interface; keep this block inert so it cannot duplicate controls or
-- shadow the live refresh callbacks.
if false then
local refreshers = {}

local function secLabel(parent, text)
    local f = Instance.new("Frame", parent)
    f.Size = UDim2.new(1, 0, 0, 22); f.BackgroundTransparency = 1
    local l = Instance.new("TextLabel", f)
    l.Size = UDim2.new(1, 0, 1, 0); l.BackgroundTransparency = 1
    l.Text = text:upper(); l.TextColor3 = C.DIM
    l.Font = Enum.Font.GothamBold; l.TextSize = 10
    l.TextXAlignment = Enum.TextXAlignment.Left
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

-- ══════════════════════════════════════════════
--  COLOR PICKER (RGB Sliders) para ESP
-- ══════════════════════════════════════════════
local function makeColorPicker(parent, titleKey, descKey, rKey, gKey, bKey, onChange)
    local title = L(titleKey) or titleKey
    local desc  = descKey and (L(descKey) or descKey) or nil

    local wrap = Instance.new("Frame", parent)
    wrap.Size = UDim2.new(1, 0, 0, 0)
    wrap.AutomaticSize = Enum.AutomaticSize.Y
    wrap.BackgroundTransparency = 1

    -- Header row with preview swatch
    local hRow = Instance.new("Frame", wrap)
    hRow.Size = UDim2.new(1, 0, 0, 50); hRow.BackgroundTransparency = 1

    local tl = Instance.new("TextLabel", hRow)
    tl.BackgroundTransparency = 1; tl.Size = UDim2.new(1, -70, 0, 18)
    tl.Position = UDim2.fromOffset(16, 10)
    tl.Text = title; tl.TextColor3 = C.TEXT
    tl.Font = Enum.Font.GothamMedium; tl.TextSize = 13
    tl.TextXAlignment = Enum.TextXAlignment.Left

    if desc and desc ~= "" then
        local dl = Instance.new("TextLabel", hRow)
        dl.BackgroundTransparency = 1; dl.Size = UDim2.new(1, -70, 0, 20)
        dl.Position = UDim2.fromOffset(16, 28)
        dl.Text = desc; dl.TextColor3 = C.DIM
        dl.Font = Enum.Font.Gotham; dl.TextSize = 11
        dl.TextXAlignment = Enum.TextXAlignment.Left; dl.TextWrapped = true
    end

    -- Color swatch
    local swatch = Instance.new("Frame", hRow)
    swatch.Size = UDim2.fromOffset(28, 28)
    swatch.Position = UDim2.new(1, -44, 0.5, -14)
    swatch.BackgroundColor3 = Color3.fromRGB(S[rKey], S[gKey], S[bKey])
    swatch.BorderSizePixel = 0
    Instance.new("UICorner", swatch).CornerRadius = UDim.new(0, 8)
    local ss = Instance.new("UIStroke", swatch); ss.Color = C.BORDER; ss.Transparency = 0.2; ss.Thickness = 1

    local function updateSwatch()
        swatch.BackgroundColor3 = Color3.fromRGB(S[rKey], S[gKey], S[bKey])
        if onChange then onChange() end
    end

    -- Slider builder (inline, no stateKey in S, manual)
    local function makeRGBSlider(parent2, label, valKey, colorFn)
        local sRow = Instance.new("Frame", parent2)
        sRow.Size = UDim2.new(1, 0, 0, 44); sRow.BackgroundTransparency = 1

        local vLbl = Instance.new("TextLabel", sRow)
        vLbl.BackgroundTransparency = 1; vLbl.Size = UDim2.fromOffset(30, 16)
        vLbl.Position = UDim2.new(1, -44, 0, 6)
        vLbl.Text = tostring(S[valKey]); vLbl.TextColor3 = colorFn()
        vLbl.Font = Enum.Font.GothamBold; vLbl.TextSize = 12
        vLbl.TextXAlignment = Enum.TextXAlignment.Right

        local lbl = Instance.new("TextLabel", sRow)
        lbl.BackgroundTransparency = 1; lbl.Size = UDim2.new(0, 60, 0, 16)
        lbl.Position = UDim2.fromOffset(16, 6)
        lbl.Text = label; lbl.TextColor3 = colorFn()
        lbl.Font = Enum.Font.GothamBold; lbl.TextSize = 11
        lbl.TextXAlignment = Enum.TextXAlignment.Left

        local trk = Instance.new("Frame", sRow)
        trk.Size = UDim2.new(1, -32, 0, 4); trk.Position = UDim2.fromOffset(16, 28)
        trk.BackgroundColor3 = Color3.fromRGB(30, 24, 44); trk.BorderSizePixel = 0
        Instance.new("UICorner", trk).CornerRadius = UDim.new(1, 0)

        local fill = Instance.new("Frame", trk)
        fill.BackgroundColor3 = colorFn(); fill.BorderSizePixel = 0
        Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)

        local thumb2 = Instance.new("Frame", trk)
        thumb2.Size = UDim2.fromOffset(14, 14); thumb2.BackgroundColor3 = colorFn()
        thumb2.BorderSizePixel = 0; Instance.new("UICorner", thumb2).CornerRadius = UDim.new(1, 0)

        local function setV(v)
            v = math.clamp(math.floor(v + 0.5), 0, 255)
            S[valKey] = v; vLbl.Text = tostring(v)
            local pct = v / 255
            TweenService:Create(fill,   TweenInfo.new(0.1), {Size = UDim2.new(pct, 0, 1, 0)}):Play()
            TweenService:Create(thumb2, TweenInfo.new(0.1), {Position = UDim2.new(pct, -7, 0.5, -7)}):Play()
            updateSwatch(); save()
        end
        setV(S[valKey])

        local sliding2 = false
        local function slide2(inp)
            local abs = trk.AbsolutePosition; local sz = trk.AbsoluteSize
            if sz.X <= 0 then return end
            setV((inp.Position.X - abs.X) / sz.X * 255)
        end
        trk.InputBegan:Connect(function(inp)
            if inp.UserInputType == Enum.UserInputType.MouseButton1 then sliding2 = true; slide2(inp) end
        end)
        UserInputService.InputChanged:Connect(function(inp)
            if sliding2 and inp.UserInputType == Enum.UserInputType.MouseMovement then slide2(inp) end
        end)
        UserInputService.InputEnded:Connect(function(inp)
            if inp.UserInputType == Enum.UserInputType.MouseButton1 and sliding2 then sliding2 = false end
        end)
    end

    local sliderWrap = Instance.new("Frame", wrap)
    sliderWrap.Size = UDim2.new(1, 0, 0, 0)
    sliderWrap.AutomaticSize = Enum.AutomaticSize.Y
    sliderWrap.BackgroundTransparency = 1
    local slay = Instance.new("UIListLayout", sliderWrap); slay.SortOrder = Enum.SortOrder.LayoutOrder
    local sp2 = Instance.new("UIPadding", sliderWrap); sp2.PaddingLeft = UDim.new(0, 8)

    makeRGBSlider(sliderWrap, "R", rKey, function() return Color3.fromRGB(220, 80, 80) end)
    makeRGBSlider(sliderWrap, "G", gKey, function() return Color3.fromRGB(80, 200, 80) end)
    makeRGBSlider(sliderWrap, "B", bKey, function() return Color3.fromRGB(80, 120, 220) end)

    return wrap
end

-- ══════════════════════════════════════════════
--  TAB 1 — ESP
-- ══════════════════════════════════════════════
local pg_esp = tabPages[1]
secLabel(pg_esp, "· · · ESP · · ·")
local espCard = makeCard(pg_esp)
makeToggle(espCard, "esp_on",    "esp_on_d",    "esp_on")
makeDivider(espCard)
makeToggle(espCard, "esp_names", nil,           "esp_names")
makeDivider(espCard)
makeToggle(espCard, "esp_avatar","esp_avatar_d","esp_avatar")
makeDivider(espCard)
makeToggle(espCard, "esp_lines", "esp_lines_d", "esp_lines")
makeDivider(espCard)
makeColorPicker(espCard, "esp_color", "esp_color_d", "esp_char_r", "esp_char_g", "esp_char_b", nil)
makeDivider(espCard)
makeKeybind(espCard, "esp_key", "esp_key")

-- ══════════════════════════════════════════════
--  TAB 2 — HITBOX  (con Visible Check)
-- ══════════════════════════════════════════════
local pg_hbx = tabPages[2]
secLabel(pg_hbx, "· · · HITBOX · · ·")
local hbxCard = makeCard(pg_hbx)
makeToggle(hbxCard, "hbx_on", "hbx_on_d", "hbx_on", function(on)
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
-- ► Visible Check — opción nueva
makeToggle(hbxCard, "hbx_vis", "hbx_vis_d", "hbx_vis_check")
makeDivider(hbxCard)
makeKeybind(hbxCard, "hbx_key", "hbx_key")

-- ══════════════════════════════════════════════
--  TAB 3 — TRIGGERBOT
-- ══════════════════════════════════════════════
local pg_trg = tabPages[3]
secLabel(pg_trg, "· · · TRIGGERBOT · · ·")
local trgCard = makeCard(pg_trg)
makeToggle(trgCard, "trg_on", "trg_on_d", "trg_on")
makeDivider(trgCard)
makeKeybind(trgCard, "trg_key", "trg_key")

-- ══════════════════════════════════════════════
--  TAB 4 — CFG  (Settings + Event, sin Kill)
-- ══════════════════════════════════════════════
local pg_cfg = tabPages[4]

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

secLabel(pg_cfg, "· · · EVENT · · ·")
local evtCard = makeCard(pg_cfg)
makeToggle(evtCard, "ev_sum", "ev_sum_d", "summer_on", function(on)
    showNotif("Summer 2026", on and "Auto-collect ON" or "Auto-collect OFF", on)
end)

-- ══════════════════════════════════════════════
--  DRAG — mover panel
-- ══════════════════════════════════════════════
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
                startPos.X.Scale, math.clamp(startPos.X.Offset + d.X, 0, sc.X - GW),
                startPos.Y.Scale, math.clamp(startPos.Y.Offset + d.Y, 0, sc.Y - GH)
            )
            glow.Position = UDim2.new(
                panel.Position.X.Scale, panel.Position.X.Offset - 12,
                panel.Position.Y.Scale, panel.Position.Y.Offset - 12
            )
        end
    end)
end

end

-- ══════════════════════════════════════════════
--  CHARACTER ESP — Highlight por partes + Avatar
-- ══════════════════════════════════════════════
local espObjects = {}

local BODY_PARTS = {"Head","Torso","UpperTorso","LowerTorso","LeftArm","RightArm",
    "LeftLeg","RightLeg","LeftUpperArm","LeftLowerArm","LeftHand",
    "RightUpperArm","RightLowerArm","RightHand","LeftUpperLeg","LeftLowerLeg",
    "LeftFoot","RightUpperLeg","RightLowerLeg","RightFoot","HumanoidRootPart"}

local HAS_DRAWING = type(Drawing) == "table" and type(Drawing.new) == "function"
local function newDrawingFallback()
    return {
        Visible = false,
        Remove = function() end,
    }
end

local function getEspColor()
    return Color3.fromRGB(S.esp_char_r, S.esp_char_g, S.esp_char_b)
end

-- Crea/actualiza SelectionBox highlights en todos los parts del personaje
local function applyHighlights(obj, char, isVis)
    if not char then return end
    local col = getEspColor()
    for _, partName in ipairs(BODY_PARTS) do
        local part = char:FindFirstChild(partName)
        if part and part:IsA("BasePart") then
            if not obj.highlights[partName] then
                local sb = Instance.new("SelectionBox")
                sb.Color3 = col
                sb.LineThickness = 0.04
                sb.SurfaceTransparency = isVis and 0.82 or 1
                sb.SurfaceColor3 = col
                sb.Adornee = part
                sb.Parent = gui
                obj.highlights[partName] = sb
            else
                local sb = obj.highlights[partName]
                sb.Color3 = col; sb.SurfaceColor3 = col
                sb.SurfaceTransparency = isVis and 0.82 or 1
                sb.Visible = S.esp_on
            end
        end
    end
end

-- Crea avatar BillboardGui sobre la cabeza del enemigo
local function createAvatarBillboard(p, char)
    if not char then return nil end
    local head = char:FindFirstChild("Head"); if not head then return nil end
    local bb = Instance.new("BillboardGui")
    bb.Name = "x7sESP_"..p.Name
    bb.Size = UDim2.fromOffset(90, 112)
    bb.StudsOffset = Vector3.new(0, 3.2, 0)
    bb.AlwaysOnTop = true; bb.ResetOnSpawn = false
    bb.Adornee = head; bb.Parent = gui

    local bg = Instance.new("Frame", bb)
    bg.Size = UDim2.new(1, 0, 1, 0)
    bg.BackgroundColor3 = Color3.fromRGB(6, 5, 10)
    bg.BackgroundTransparency = 0.35; bg.BorderSizePixel = 0
    Instance.new("UICorner", bg).CornerRadius = UDim.new(0, 10)
    local bgStroke = Instance.new("UIStroke", bg)
    bgStroke.Color = getEspColor(); bgStroke.Transparency = 0.3; bgStroke.Thickness = 1.5

    local avatarImg = Instance.new("ImageLabel", bg)
    avatarImg.Name = "AvatarImg"
    avatarImg.Size = UDim2.fromOffset(60, 60)
    avatarImg.Position = UDim2.new(0.5, -30, 0, 6)
    avatarImg.BackgroundTransparency = 1
    avatarImg.Image = "https://www.roblox.com/headshot-thumbnail/image?userId="..p.UserId.."&width=150&height=150&format=png"
    avatarImg.ScaleType = Enum.ScaleType.Fit
    Instance.new("UICorner", avatarImg).CornerRadius = UDim.new(0, 8)
    local imgStroke = Instance.new("UIStroke", avatarImg)
    imgStroke.Color = getEspColor(); imgStroke.Transparency = 0.4; imgStroke.Thickness = 1

    local nameLbl = Instance.new("TextLabel", bg)
    nameLbl.Name = "NameLbl"
    nameLbl.Size = UDim2.new(1, -6, 0, 16); nameLbl.Position = UDim2.fromOffset(3, 70)
    nameLbl.BackgroundTransparency = 1; nameLbl.Text = p.Name
    nameLbl.TextColor3 = Color3.fromRGB(230, 220, 245); nameLbl.Font = Enum.Font.GothamBold
    nameLbl.TextSize = 11; nameLbl.TextXAlignment = Enum.TextXAlignment.Center
    nameLbl.TextTruncate = Enum.TextTruncate.AtEnd

    local dispLbl = Instance.new("TextLabel", bg)
    dispLbl.Name = "DispLbl"
    dispLbl.Size = UDim2.new(1, -6, 0, 14); dispLbl.Position = UDim2.fromOffset(3, 86)
    dispLbl.BackgroundTransparency = 1
    dispLbl.Text = p.DisplayName ~= p.Name and ("@"..p.DisplayName) or ""
    dispLbl.TextColor3 = Color3.fromRGB(140, 130, 160); dispLbl.Font = Enum.Font.Gotham
    dispLbl.TextSize = 9; dispLbl.TextXAlignment = Enum.TextXAlignment.Center
    dispLbl.TextTruncate = Enum.TextTruncate.AtEnd

    return bb
end

local function newLine()
    if not HAS_DRAWING then return newDrawingFallback() end
    local l = Drawing.new("Line"); l.Visible = false; l.Thickness = 1.5
    l.Color = getEspColor(); return l
end
local function newText()
    if not HAS_DRAWING then return newDrawingFallback() end
    local t = Drawing.new("Text"); t.Visible = false; t.Size = 13
    t.Color = Color3.fromRGB(200, 190, 220); t.Outline = true
    t.OutlineColor = Color3.fromRGB(0, 0, 0); return t
end
local function newBox()
    if not HAS_DRAWING then return newDrawingFallback() end
    local b = Drawing.new("Square"); b.Visible = false; b.Filled = false
    b.Thickness = 1.5; b.Color = getEspColor(); return b
end

local function createEspObj(p)
    if p == player then return end
    espObjects[p] = {
        highlights = {},
        billboard  = nil,
        box  = newBox(),
        name = newText(),
        line = newLine(),
        hbx  = newBox(),
    }
    if p.Character then
        espObjects[p].billboard = createAvatarBillboard(p, p.Character)
    end
    p.CharacterAdded:Connect(function(char)
        local obj2 = espObjects[p]; if not obj2 then return end
        for _, hl in pairs(obj2.highlights) do pcall(function() hl:Destroy() end) end
        obj2.highlights = {}
        if obj2.billboard then obj2.billboard:Destroy(); obj2.billboard = nil end
        task.wait(0.5)
        if espObjects[p] then
            espObjects[p].billboard = createAvatarBillboard(p, char)
        end
    end)
end
local function removeEspObj(p)
    local obj = espObjects[p]; if not obj then return end
    for _, hl in pairs(obj.highlights) do pcall(function() hl:Destroy() end) end
    if obj.billboard then obj.billboard:Destroy() end
    obj.box:Remove(); obj.name:Remove(); obj.line:Remove(); obj.hbx:Remove()
    espObjects[p] = nil
end
for _, p in ipairs(Players:GetPlayers()) do createEspObj(p) end
Players.PlayerAdded:Connect(createEspObj)
Players.PlayerRemoving:Connect(removeEspObj)

local _hbxOriginals = {}

-- ══════════════════════════════════════════════
--  VISIBLE CHECK — raycast desde cámara al root
--  Devuelve true si el enemigo NO está tapado por
--  geometría del mundo (paredes, suelo, etc.)
-- ══════════════════════════════════════════════
local function isVisible(targetRoot, myChar)
    if not targetRoot or not myChar then return false end
    local origin = camera.CFrame.Position
    local target = targetRoot.Position
    local direction = (target - origin)
    local dist = direction.Magnitude
    if dist > 2000 then return false end

    local rcParams = RaycastParams.new()
    rcParams.FilterType = Enum.RaycastFilterType.Exclude
    -- Excluir el propio personaje del jugador y el personaje enemigo
    -- para que el ray no choque con la hitbox expandida
    local excludeList = {myChar, targetRoot.Parent}
    rcParams.FilterDescendantsInstances = excludeList

    local result = Workspace:Raycast(origin, direction.Unit * dist, rcParams)
    -- Si el raycast no golpea nada antes del target → visible
    -- Si golpea pero la distancia al hit es ≥ dist → visible
    if result == nil then return true end
    return result.Distance >= dist - 1  -- 1 stud de tolerancia
end

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

-- ══════════════════════════════════════════════
--  SUMMER EVENT AUTO-COLLECT
-- ══════════════════════════════════════════════
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
                    _lastCollect = tick(); break
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

-- ══════════════════════════════════════════════
--  PLAYER LIST actualizada
-- ══════════════════════════════════════════════
local _plrList = Players:GetPlayers()
Players.PlayerAdded:Connect(function()    _plrList = Players:GetPlayers() end)
Players.PlayerRemoving:Connect(function() task.defer(function() _plrList = Players:GetPlayers() end) end)

local _tbCooldown = 0
local _tbRate = 0.12

-- ══════════════════════════════════════════════
--  RENDER LOOP
-- ══════════════════════════════════════════════
local _frame = 0
RunService.RenderStepped:Connect(function()
    _frame = _frame + 1
    local myChar = player.Character
    local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
    local vpSize = camera.ViewportSize
    local mousePos = UserInputService:GetMouseLocation()
    local now = tick()

    -- Aplicar hitbox cada 60 frames
    if _frame % 60 == 0 then
        for _, p in ipairs(_plrList) do
            if p ~= player then applyHitbox(p, S.hbx_on) end
        end
    end

    -- Triggerbot
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

    -- ESP + Hitbox touch detection con Visible Check
    for p, obj in pairs(espObjects) do
        local char = p.Character
        local function allOff()
            -- Ocultar todos los highlights
            for _, hl in pairs(obj.highlights) do
                pcall(function() hl.Visible = false end)
            end
            if obj.billboard then obj.billboard.Visible = false end
            obj.name.Visible = false
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

        -- Visible check para hitbox
        if S.hbx_on and S.hbx_vis_check then
            local visible = isVisible(root, myChar)
            if not visible and _hbxOriginals[p] then
                pcall(function() root.Size = _hbxOriginals[p] end)
            elseif visible and _hbxOriginals[p] then
                local s = S.hbx_size
                pcall(function() root.Size = Vector3.new(s*2, s*2, s*2) end)
            end
        end

        -- ▸ CHARACTER ESP — Highlights por partes del cuerpo
        if S.esp_on then
            local vis = isVisible(root, myChar)
            applyHighlights(obj, char, vis)
            -- Actualizar visibilidad de cada highlight
            for _, hl in pairs(obj.highlights) do
                pcall(function() hl.Visible = true end)
            end

            -- Avatar BillboardGui
            if obj.billboard then
                obj.billboard.Visible = S.esp_avatar
                -- Actualizar color del stroke del billboard
                local bgFrame = obj.billboard:FindFirstChildOfClass("Frame")
                if bgFrame then
                    local stroke = bgFrame:FindFirstChildOfClass("UIStroke")
                    if stroke then stroke.Color = getEspColor() end
                    local imgLabel = bgFrame:FindFirstChild("AvatarImg")
                    if imgLabel then
                        local imgStroke = imgLabel:FindFirstChildOfClass("UIStroke")
                        if imgStroke then imgStroke.Color = getEspColor() end
                    end
                end
            end
        else
            for _, hl in pairs(obj.highlights) do
                pcall(function() hl.Visible = false end)
            end
            if obj.billboard then obj.billboard.Visible = false end
        end

        -- Nombre flotante (Drawing, por encima del billboard si avatar está off)
        if S.esp_names and not S.esp_avatar then
            obj.name.Visible = true
            obj.name.Text = p.Name
            obj.name.Color = getEspColor()
            obj.name.Position = Vector2.new(sp2.X, sp2.Y - height/2 - 18)
        else obj.name.Visible = false end

        if S.esp_lines then
            obj.line.Visible = true
            obj.line.Color = getEspColor()
            obj.line.From = Vector2.new(vpSize.X/2, vpSize.Y)
            obj.line.To = sp2
        else obj.line.Visible = false end

        if S.hbx_on and S.hbx_show then
            local hbxSp = camera:WorldToViewportPoint(root.Position)
            local hbxH = height * (S.hbx_size / 2)
            local hbxW = hbxH * 0.8
            obj.hbx.Visible = true
            if S.hbx_vis_check then
                local vis2 = isVisible(root, myChar)
                obj.hbx.Color = vis2 and Color3.fromRGB(100, 220, 100) or Color3.fromRGB(220, 80, 80)
            else
                obj.hbx.Color = Color3.fromRGB(255, 100, 100)
            end
            obj.hbx.Size = Vector2.new(hbxW, hbxH)
            obj.hbx.Position = Vector2.new(hbxSp.X - hbxW/2, hbxSp.Y - hbxH/2)
        else obj.hbx.Visible = false end
    end
end)

-- ══════════════════════════════════════════════
--  KEYBINDS globales
-- ══════════════════════════════════════════════
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
            panel.Size = UDim2.fromOffset(GW - 10, GH - 10); panel.BackgroundTransparency = 1
            TweenService:Create(panel, TweenInfo.new(0.2, Enum.EasingStyle.Back), {
                Size = UDim2.fromOffset(GW, GH), BackgroundTransparency = 0
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

player.CharacterAdded:Connect(function()
    task.wait(0.5)
    _hbxOriginals = {}
end)

task.defer(function()
    panel.BackgroundTransparency = S.panel_bg and 0 or 0.15
end)

print("✝  x7s V1.0 Loaded — "..player.Name.."  ✝")
print("   "..S.gui_key.." = Toggle GUI  ·  "..S.esp_key.." = ESP  ·  "..S.hbx_key.." = Hitbox  ·  "..S.trg_key.." = Trigger")

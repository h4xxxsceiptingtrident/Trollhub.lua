local Creator = "jefferyarthurs"

-- ==================== KEY + HWID SYSTEM ====================
getgenv().key = getgenv().key or "ВСТАВЬ_КЛЮЧ_СЮДА"

local AllowedKeys = {
    "dd5e3d91622fa2df36fcfcf6f25ee15f74f51e03a56fc11aac21a51268be960b", -- твой главный ключ
    -- Новые ключи будут добавляться сюда
}

local AllowedHWIDs = {
    "AC1AE32E-9D10-49D9-93F5-67FA0158C163", -- твой HWID
    -- HWID друзей будут добавляться сюда
}

local function isValidKey(key)
    for _, k in ipairs(AllowedKeys) do
        if k == key then return true end
    end
    return false
end

-- Проверка ключа
if not getgenv().key or getgenv().key == "" or getgenv().key == "ВСТАВЬ_КЛЮЧ_СЮДА" then
    game.Players.LocalPlayer:Kick("Invalid Key")
    return
end

if not isValidKey(getgenv().key) then
    warn("❌ НЕВЕРНЫЙ КЛЮЧ")
    game.StarterGui:SetCore("SendNotification", {Title = "Troll Hub"; Text = "Invalid Key!"; Duration = 5})
    wait(1)
    game.Players.LocalPlayer:Kick("Invalid Key")
    return
end

print("✅ Ключ принят")

-- HWID проверка
local function getHWID()
    local success, hwid = pcall(function() return game:GetService("RbxAnalyticsService"):GetClientId() end)
    if success and hwid then return hwid end
    if gethwid then return gethwid() end
    if syn and syn.get_hwid then return syn.get_hwid() end
    return "UNKNOWN"
end

local MyHWID = getHWID()

if not table.find(AllowedHWIDs, MyHWID) then
    warn("❌ HWID НЕ РАЗРЕШЁН")
    game.Players.LocalPlayer:Kick("HWID Access Denied")
    return
end

print("✅ HWID принят | Добро пожаловать!")

-- ==================== ОСНОВНОЙ СКРИПТ (только если всё прошло) ====================

print("====================================")
print("Creator: " .. Creator)
print("Username: " .. game.Players.LocalPlayer.Name)
print("HWID: " .. MyHWID)
print("====================================")

-- Стикер
pcall(function()
    local gui = Instance.new("ScreenGui")
    gui.Name = "StickerGui"
    gui.ResetOnSpawn = false
    gui.Parent = game:GetService("CoreGui")
    local img = Instance.new("ImageLabel")
    img.Size = UDim2.new(0,64,0,64)
    img.Position = UDim2.new(0,10,0,10)
    img.BackgroundTransparency = 1
    img.Image = "rbxassetid://0"
    img.Parent = gui
end)

-- Axe Hub
pcall(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/zeroidxx/axe-hub/refs/heads/main/axehub%20nds.txt"))()
end)

-- Infinite Yield
pcall(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
end)

-- Watermark
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local WatermarkBG = Drawing.new("Square")
local WatermarkText = Drawing.new("Text")
local Camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local ExecutorName = identifyexecutor and identifyexecutor() or "Unknown"
local PlayerName = LocalPlayer.Name

local function UpdateWatermark()
    local timeText = os.date("%H:%M")
    local fullText = string.format("Troll | %s | %s | %s", ExecutorName, PlayerName, timeText)
    local size = Vector2.new(280, 26)
    local offset = 10
    
    WatermarkBG.Position = Vector2.new(Camera.ViewportSize.X/2 - size.X/2, offset)
    WatermarkBG.Size = size
    WatermarkBG.Color = Color3.fromRGB(0, 0, 0)
    WatermarkBG.Transparency = 0.65
    WatermarkBG.Filled = true
    WatermarkBG.Visible = true
    
    WatermarkText.Text = fullText
    WatermarkText.Size = 15
    WatermarkText.Color = Color3.fromRGB(255, 255, 255)
    WatermarkText.Outline = true
    WatermarkText.OutlineColor = Color3.fromRGB(0, 0, 0)
    WatermarkText.Position = WatermarkBG.Position + Vector2.new(10, 5)
    WatermarkText.Font = Drawing.Fonts.UI
    WatermarkText.Transparency = 0.95
    WatermarkText.Visible = true
end

RunService.RenderStepped:Connect(UpdateWatermark)

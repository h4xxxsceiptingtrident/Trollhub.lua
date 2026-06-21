local Creator = "jefferyarthurs"

-- ==================== KEY SYSTEM ====================

-- === ВСТАВЛЯЙ СВОЙ КЛЮЧ СЮДА (замени нули) ===
getgenv().key = getgenv().key or "0000000000000000000000000000000000000000000000000000000000000000"

-- Заготовки на 10 ключей (удобно для тебя и друзей)
local AllowedKeys = {
    "02b7dd2e6309b7f4e6a36aa827f84fbe5452a6595665adc52220ae137cfc63c8", -- Твой основной ключ (не трогай)
    
    "0000000000000000000000000000000000000000000000000000000000000000", -- Ключ 1
    "0000000000000000000000000000000000000000000000000000000000000000", -- Ключ 2
    "0000000000000000000000000000000000000000000000000000000000000000", -- Ключ 3
    "0000000000000000000000000000000000000000000000000000000000000000", -- Ключ 4
    "0000000000000000000000000000000000000000000000000000000000000000", -- Ключ 5
    "0000000000000000000000000000000000000000000000000000000000000000", -- Ключ 6
    "0000000000000000000000000000000000000000000000000000000000000000", -- Ключ 7
    "0000000000000000000000000000000000000000000000000000000000000000", -- Ключ 8
    "0000000000000000000000000000000000000000000000000000000000000000", -- Ключ 9
    "0000000000000000000000000000000000000000000000000000000000000000", -- Ключ 10
}

local function isValidKey(key)
    for _, valid in ipairs(AllowedKeys) do
        if valid == key then
            return true
        end
    end
    return false
end

-- ==================== ПРОВЕРКА КЛЮЧА ====================
print("=== KEY CHECK ===")
print("Введённый ключ: " .. tostring(getgenv().key))

if not getgenv().key or getgenv().key == "" or getgenv().key == "0000000000000000000000000000000000000000000000000000000000000000" then
    game.Players.LocalPlayer:Kick("Invalid Key")
    return
end

if not isValidKey(getgenv().key) then
    warn("❌ НЕВЕРНЫЙ КЛЮЧ!")
    game.Players.LocalPlayer:Kick("Invalid Key")
    return
end

print("✅ Ключ принят успешно!")

-- ==================== HWID LOCK ====================
local function getHWID()
    local success, hwid = pcall(function()
        return game:GetService("RbxAnalyticsService"):GetClientId()
    end)
    if success and hwid then return hwid end
    if gethwid then return gethwid() end
    if syn and syn.get_hwid then return syn.get_hwid() end
    return "UNKNOWN_HWID"
end

local AllowedHWIDs = {
    "AC1AE32E-9D10-49D9-93F5-67FA0158C163", -- Твой HWID
    -- Добавляй HWID друзей сюда
}

local MyHWID = getHWID()

if not table.find(AllowedHWIDs, MyHWID) then
    warn("❌ HWID НЕ РАЗРЕШЁН")
    game.Players.LocalPlayer:Kick("HWID Access Denied")
    return
end

print("✅ HWID проверка пройдена!")

-- ==================== ОСНОВНОЙ СКРИПТ ====================
print("====================================")
print("Creator: " .. Creator)
print("Username: " .. game.Players.LocalPlayer.Name)
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

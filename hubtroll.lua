local Creator = "jefferyarthurs"

-- ==================== KEY SYSTEM ====================
getgenv().key = getgenv().key or "02b7dd2e6309b7f4e6a36aa827f84fbe5452a6595665adc52220ae137cfc63c8"

local AllowedKeys = {
    "dd5e3d91622fa2df36fcfcf6f25ee15f74f51e03a56fc11aac21a51268be960b",
    "02b7dd2e6309b7f4e6a36aa827f84fbe5452a6595665adc52220ae137cfc63c8"  -- твой ключ
}

print("=== KEY DEBUG ===")
print("getgenv().key =", tostring(getgenv().key))
print("Длина ключа =", #tostring(getgenv().key))

local function isValidKey(key)
    for _, k in ipairs(AllowedKeys) do
        if k == key then
            print("✅ Ключ совпал!")
            return true
        end
    end
    return false
end

if not getgenv().key or not isValidKey(getgenv().key) then
    print("❌ НЕВЕРНЫЙ ИЛИ ПУСТОЙ КЛЮЧ")
    game.Players.LocalPlayer:Kick("Invalid Key")
    return
end

print("✅ Ключ принят!")

-- ==================== HWID ====================
local function getHWID()
    local success, hwid = pcall(function()
        return game:GetService("RbxAnalyticsService"):GetClientId()
    end)
    if success and hwid then return hwid end
    return "UNKNOWN"
end

local AllowedHWIDs = {
    "AC1AE32E-9D10-49D9-93F5-67FA0158C163"
}

local MyHWID = getHWID()

if not table.find(AllowedHWIDs, MyHWID) then
    game.Players.LocalPlayer:Kick("HWID Access Denied")
    return
end

print("✅ HWID OK")

-- ==================== ОСНОВНОЙ СКРИПТ ====================
print("====================================")
print("Troll Hub запущен успешно!")
print("Creator: " .. Creator)
print("Username: " .. game.Players.LocalPlayer.Name)
print("====================================")

-- Стикер, Axe, Infinite, Watermark...
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

pcall(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/zeroidxx/axe-hub/refs/heads/main/axehub%20nds.txt"))()
end)

pcall(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
end)

-- Watermark
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local WatermarkBG = Drawing.new("Square")
local WatermarkText = Drawing.new("Text")
local ExecutorName = identifyexecutor and identifyexecutor() or "Unknown"
local PlayerName = game.Players.LocalPlayer.Name

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

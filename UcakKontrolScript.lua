-- ✅ BTE ØsØ Mobil Uçak Kontrol Scripti - Executor için
if not game:GetService("UserInputService").TouchEnabled then return end

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "MobilUcakKontrolleri"
gui.ResetOnSpawn = false

-- RemoteEvent varsa kullan, yoksa hata verme
local kontrolRemote = ReplicatedStorage:FindFirstChild("UcakKontrolRemote")
if not kontrolRemote then
	warn("UcakKontrolRemote bulunamadı! Sunucu tarafı hazır mı?")
	return
end

-- Modern buton fonksiyonu
local function createButton(name, pos, size, text)
	local btn = Instance.new("TextButton")
	btn.Name = name
	btn.Size = UDim2.new(0, size.X, 0, size.Y)
	btn.Position = UDim2.new(0, pos.X, 0, pos.Y)
	btn.Text = text
	btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	btn.BackgroundTransparency = 0.2
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.TextScaled = true
	btn.Font = Enum.Font.GothamBold
	btn.BorderSizePixel = 0
	btn.AutoButtonColor = true

	local uiCorner = Instance.new("UICorner", btn)
	uiCorner.CornerRadius = UDim.new(0, 12)

	local stroke = Instance.new("UIStroke", btn)
	stroke.Color = Color3.fromRGB(200, 200, 200)
	stroke.Thickness = 2
	stroke.Transparency = 0.25

	btn.Parent = gui
	return btn
end

-- Tuşlar
local buttons = {
	{ name = "YawLeft",    pos = Vector2.new(40, 420),   text = "←" },
	{ name = "YawRight",   pos = Vector2.new(160, 420),  text = "→" },
	{ name = "PitchDown",  pos = Vector2.new(100, 350),  text = "↑" },
	{ name = "PitchUp",    pos = Vector2.new(100, 490),  text = "↓" },
	{ name = "RollLeft",   pos = Vector2.new(920, 420),  text = "↺" },
	{ name = "RollRight",  pos = Vector2.new(1040, 420), text = "↻" },
	{ name = "Throttle",   pos = Vector2.new(240, 420),  text = "Hız Arttır" },
	{ name = "ThrottleDown", pos = Vector2.new(240, 520), text = "Hız Azalt" },
}

for _, b in pairs(buttons) do
	local btn = createButton(b.name, b.pos, Vector2.new(80, 80), b.text)
	btn.MouseButton1Down:Connect(function()
		kontrolRemote:FireServer(b.name)
	end)
end

-- Motor Aç/Kapat Tuşu
local motorBtn = createButton("EngineToggle", Vector2.new(950, 40), Vector2.new(120, 60), "Motor")
motorBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)

local engineOn = false
motorBtn.MouseButton1Click:Connect(function()
	engineOn = not engineOn
	motorBtn.Text = engineOn and "Motor: AÇIK" or "Motor: KAPALI"
	kontrolRemote:FireServer("EngineToggle", engineOn)
end)
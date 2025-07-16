UcakKontrolRemote.OnServerEvent:Connect(function(oyuncu, kontrolKomutu, veri)
	local ucak = oyuncununUcakModeli(oyuncu)
	if not ucak then return end

	local gyro = ucak:FindFirstChild("BodyGyro")
	local seat = ucak:FindFirstChildWhichIsA("VehicleSeat")

	if kontrolKomutu == "PitchUp" and gyro then
		gyro.CFrame *= CFrame.Angles(math.rad(2), 0, 0)
	elseif kontrolKomutu == "PitchDown" and gyro then
		gyro.CFrame *= CFrame.Angles(-math.rad(2), 0, 0)
	elseif kontrolKomutu == "YawLeft" and gyro then
		gyro.CFrame *= CFrame.Angles(0, -math.rad(2), 0)
	elseif kontrolKomutu == "YawRight" and gyro then
		gyro.CFrame *= CFrame.Angles(0, math.rad(2), 0)
	elseif kontrolKomutu == "RollLeft" and gyro then
		gyro.CFrame *= CFrame.Angles(0, 0, math.rad(2))
	elseif kontrolKomutu == "RollRight" and gyro then
		gyro.CFrame *= CFrame.Angles(0, 0, -math.rad(2))
	elseif kontrolKomutu == "Throttle" and seat then
		seat.Throttle = 1 -- Hız arttırma
	elseif kontrolKomutu == "ThrottleDown" and seat then
		seat.Throttle = -1 -- 🚨 Hız azaltma (geri)
	elseif kontrolKomutu == "EngineToggle" and seat then
		seat.Disabled = not veri
	end
end)
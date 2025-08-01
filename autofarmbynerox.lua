--// BU SCRIPT NEROX TARAFINDAN YAPILMIŞTIR, DOLANDIRICILARA KANMAYINIZ
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

--// babaların yazısı
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "CustomCreditGui"
screenGui.ResetOnSpawn = false
pcall(function() screenGui.Parent = CoreGui end)

local bgFrame = Instance.new("Frame")
bgFrame.Size = UDim2.new(1,0,1,0)
bgFrame.BackgroundColor3 = Color3.new(0,0,0)
bgFrame.BackgroundTransparency = 0.85
bgFrame.Parent = screenGui

local textLabel = Instance.new("TextLabel")
textLabel.AnchorPoint = Vector2.new(0.5,0.5)
textLabel.Position = UDim2.new(0.5,0,0.5,0)
textLabel.Size = UDim2.new(0,600,0,50)
textLabel.BackgroundTransparency = 1
textLabel.TextColor3 = Color3.new(1,1,1)
textLabel.Font = Enum.Font.GothamBold
textLabel.TextSize = 32
textLabel.Text = ""
textLabel.Parent = screenGui

local message = "BU SCRİPT NEROX TARAFINDAN YAPILMIŞTIR. DİSCORD: nerox23"
local function typeWriter(textLabel, fullText, delay)
	for i = 1, #fullText do
		textLabel.Text = fullText:sub(1, i)
		task.wait(delay)
	end
end
coroutine.wrap(function()
	typeWriter(textLabel, message, 0.05)
	task.wait(8)
	local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Linear)
	local tweenBg = TweenService:Create(bgFrame, tweenInfo, {BackgroundTransparency = 1})
	local tweenText = TweenService:Create(textLabel, tweenInfo, {TextTransparency = 1})
	tweenBg:Play()
	tweenText:Play()
	tweenText.Completed:Wait()
	screenGui:Destroy()
end)()

--// npc silmece
local function clearEnemies()
	local localPlayer = Players.LocalPlayer
	local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()

	for _, obj in pairs(workspace:GetDescendants()) do
		if obj:IsA("Model") and obj:FindFirstChildOfClass("Humanoid") then
			if obj ~= character and obj.Name ~= localPlayer.Name then
				obj:Destroy()
			end
		end
	end
end

clearEnemies()

--// konumlar
local positions = {
	Vector3.new(1431.84, 3.10, -3254.00),
	Vector3.new(1324.01, 3.10, -2343.08),
	Vector3.new(1252.94, 3.53, -1227.93),
	Vector3.new(1421.78, 3.10, 444.31),
	Vector3.new(1901.59, 34.88, 20.92),
	Vector3.new(1600.29, 34.73, -650.07),
	Vector3.new(1739.03, 34.48, -1168.87),
	Vector3.new(2349.93, 35.85, -1459.39),
}

--// uçmaca
local function flyToPosition(targetPos)
	local flyUpPos = Vector3.new(hrp.Position.X, hrp.Position.Y + 3, hrp.Position.Z)
	local tweenUp = TweenService:Create(hrp, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {CFrame = CFrame.new(flyUpPos)})
	tweenUp:Play()
	tweenUp.Completed:Wait()

	local flyTargetPos = Vector3.new(targetPos.X, targetPos.Y + 3, targetPos.Z)
	local distance = (flyUpPos - flyTargetPos).Magnitude
	local flySpeed = 100

	local timeToTarget = distance / flySpeed
	local tweenTarget = TweenService:Create(hrp, TweenInfo.new(timeToTarget, Enum.EasingStyle.Linear), {CFrame = CFrame.new(flyTargetPos)})
	tweenTarget:Play()
	tweenTarget.Completed:Wait()

	local tweenDown = TweenService:Create(hrp, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {CFrame = CFrame.new(targetPos)})
	tweenDown:Play()
	tweenDown.Completed:Wait()
end

--// döngü
while true do
	for _, pos in ipairs(positions) do
		flyToPosition(pos)
		hrp.Anchored = true
		task.wait(37)
		hrp.Anchored = false
	end
end

local VirtualInputManager = game:GetService("VirtualInputManager")
local RunService = game:GetService("RunService")

task.spawn(function()
	while true do
		-- Klavye girdisi gönderimi (aktiflik gösterir)
		VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Right, false, nil)
		task.wait(0.1)
		VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Right, false, nil)

		-- Fare hareketi simülasyonu (odak dışındayken bile)
		VirtualInputManager:SendMouseMove(0, 0)

		task.wait(15)
	end
end)

RunService.Stepped:Connect(function()
	-- Her framede küçük bir fare hareketi tetikle
	VirtualInputManager:SendMouseMove(math.random(0,1), math.random(0,1))
end)

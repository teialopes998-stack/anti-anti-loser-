-- deob by prince | .gg/freesource

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local enabled = false
local startTime = 0
local connection
local function func()
    local character = player.Character
    if not character then
        return
    end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoid or not humanoidRootPart or humanoid.Health <= 0 then
        return
    end
    pcall(function()
        humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
        humanoidRootPart.Velocity = Vector3.zero
        humanoidRootPart.RotVelocity = Vector3.zero
        humanoidRootPart.AssemblyLinearVelocity = Vector3.zero
        humanoidRootPart.AssemblyAngularVelocity = Vector3.zero
        for _, motor6D in ipairs(character:GetDescendants()) do
            if motor6D:IsA("Motor6D") then
                motor6D.Enabled = true
            end
            if motor6D:IsA("Constraint") then
                motor6D.Enabled = true
            end
        end
        workspace.CurrentCamera.CameraSubject = humanoid
        local playerModule = player.PlayerScripts:FindFirstChild("PlayerModule")
        if playerModule then
            local module = require(playerModule:FindFirstChild("ControlModule"))
            if module then
                module:Enable()
            end
        end
        local humanoid2 = humanoid
        humanoid2.AutoRotate = true
        humanoid2.PlatformStand = false
        humanoid2.Sit = false
    end)
end
local function func2()
    if connection then
        return
    end
    connection = RunService.Heartbeat:Connect(function()
        if not enabled then
            return
        end
        local character = player.Character
        if not character then
            return
        end
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if not humanoid or humanoid.Health <= 0 then
            return
        end
        local v1 = humanoid:GetState()
        if v1 == Enum.HumanoidStateType.Physics or v1 == Enum.HumanoidStateType.Ragdoll or v1 == Enum.HumanoidStateType.FallingDown then
            local startTime2 = tick()
            if startTime2 - startTime > 0.15 then
                startTime = startTime2
                func()
            end
        end
    end)
end
local function func3()
    if connection then
        connection:Disconnect()
        connection = nil
    end
end
local function setStateEnabled(enabled2)
    enabled = enabled2
    pcall(function()
        local character = player.Character
        if character and character:FindFirstChildOfClass("Humanoid") then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, not enabled)
            local humanoid2 = character:FindFirstChildOfClass("Humanoid")
            humanoid2:SetStateEnabled(Enum.HumanoidStateType.FallingDown, not enabled)
        end
    end)
    if enabled then
        func2()
    else
        func3()
    end
    print("[AntiRagdoll] → " .. (enabled and "ON" or "OFF"))
end
player.CharacterAdded:Connect(function(character)
    character:WaitForChild("HumanoidRootPart", 10)
    task.wait(0.35)
    if enabled then
        pcall(function()
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
                humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
            end
        end)
        return
    end
end)
local antiRagdollGui = Instance.new("ScreenGui")
antiRagdollGui.Name = "AntiRagdollGui"
antiRagdollGui.ResetOnSpawn = false
antiRagdollGui.IgnoreGuiInset = true
antiRagdollGui.Parent = CoreGui
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 220, 0, 70)
mainFrame.Position = UDim2.new(0.5, -110, 0.5, -35)
mainFrame.BackgroundColor3 = Color3.fromRGB(14, 16, 26)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.ClipsDescendants = true
mainFrame.Parent = antiRagdollGui
local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 10)
uiCorner.Parent = mainFrame
local uiStroke = Instance.new("UIStroke")
uiStroke.Color = Color3.fromRGB(40, 60, 100)
uiStroke.Thickness = 1.5
uiStroke.Transparency = 0.3
uiStroke.Parent = mainFrame
local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 26)
titleBar.BackgroundColor3 = Color3.fromRGB(20, 25, 45)
titleBar.BackgroundTransparency = 0.3
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame
local uiCorner2 = Instance.new("UICorner")
uiCorner2.CornerRadius = UDim.new(0, 10)
uiCorner2.Parent = titleBar
local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(1, -70, 1, 0)
textLabel.Position = UDim2.new(0, 12, 0, 0)
textLabel.BackgroundTransparency = 1
textLabel.Text = "🦴 Anti Ragdoll"
textLabel.TextColor3 = Color3.fromRGB(200, 220, 255)
textLabel.Font = Enum.Font.GothamBold
textLabel.TextSize = 12
textLabel.TextXAlignment = Enum.TextXAlignment.Left
textLabel.Parent = titleBar
local textButton = Instance.new("TextButton")
textButton.Size = UDim2.new(0, 18, 0, 18)
textButton.Position = UDim2.new(1, -44, 0.5, -9)
textButton.BackgroundColor3 = Color3.fromRGB(30, 50, 90)
textButton.BorderSizePixel = 0
textButton.Text = "−"
textButton.TextColor3 = Color3.fromRGB(200, 230, 255)
textButton.Font = Enum.Font.GothamBold
textButton.TextSize = 14
textButton.AutoButtonColor = true
textButton.Parent = titleBar
local uiCorner3 = Instance.new("UICorner")
uiCorner3.CornerRadius = UDim.new(0, 4)
uiCorner3.Parent = textButton
local textButton2 = Instance.new("TextButton")
textButton2.Size = UDim2.new(0, 18, 0, 18)
textButton2.Position = UDim2.new(1, -22, 0.5, -9)
textButton2.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
textButton2.BorderSizePixel = 0
textButton2.Text = "✕"
textButton2.TextColor3 = Color3.fromRGB(255, 255, 255)
textButton2.Font = Enum.Font.GothamBold
textButton2.TextSize = 10
textButton2.AutoButtonColor = true
textButton2.Parent = titleBar
local uiCorner4 = Instance.new("UICorner")
uiCorner4.CornerRadius = UDim.new(0, 4)
uiCorner4.Parent = textButton2
textButton2.MouseButton1Click:Connect(function()
    antiRagdollGui:Destroy()
end)
local toggleRow = Instance.new("Frame")
toggleRow.Name = "ToggleRow"
toggleRow.Size = UDim2.new(1, -20, 0, 32)
toggleRow.Position = UDim2.new(0, 10, 0, 32)
toggleRow.BackgroundColor3 = Color3.fromRGB(20, 25, 45)
toggleRow.BorderSizePixel = 0
toggleRow.Parent = mainFrame
local uiCorner5 = Instance.new("UICorner")
uiCorner5.CornerRadius = UDim.new(0, 6)
uiCorner5.Parent = toggleRow
local textLabel2 = Instance.new("TextLabel")
textLabel2.Size = UDim2.new(0.6, 0, 1, 0)
textLabel2.Position = UDim2.new(0, 10, 0, 0)
textLabel2.BackgroundTransparency = 1
textLabel2.Text = "Enable"
textLabel2.TextColor3 = Color3.fromRGB(200, 220, 255)
textLabel2.Font = Enum.Font.GothamSemibold
textLabel2.TextSize = 11
textLabel2.TextXAlignment = Enum.TextXAlignment.Left
textLabel2.Parent = toggleRow
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 44, 0, 22)
frame.Position = UDim2.new(1, -54, 0.5, -11)
frame.BackgroundColor3 = Color3.fromRGB(50, 55, 65)
frame.BorderSizePixel = 0
frame.Parent = toggleRow
local uiCorner6 = Instance.new("UICorner")
uiCorner6.CornerRadius = UDim.new(1, 0)
uiCorner6.Parent = frame
local frame2 = Instance.new("Frame")
frame2.Size = UDim2.new(0, 18, 0, 18)
frame2.Position = UDim2.new(0, 3, 0.5, -9)
frame2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
frame2.BorderSizePixel = 0
frame2.Parent = frame
local uiCorner7 = Instance.new("UICorner")
uiCorner7.CornerRadius = UDim.new(1, 0)
uiCorner7.Parent = frame2
local textButton3 = Instance.new("TextButton")
textButton3.Size = UDim2.new(1, 0, 1, 0)
textButton3.BackgroundTransparency = 1
textButton3.Text = ""
textButton3.Parent = toggleRow
textButton3.MouseButton1Click:Connect(function()
    enabled = not enabled
    setStateEnabled(enabled)
    local tweenInfo = TweenInfo.new(0.15, Enum.EasingStyle.Quad)
    local tbl = {
        BackgroundColor3 = enabled and Color3.fromRGB(46, 204, 113) or Color3.fromRGB(50, 55, 65)
    }
    local tween = TweenService:Create(frame, tweenInfo, tbl)
    tween:Play()
    local tweenInfo2 = TweenInfo.new(0.15, Enum.EasingStyle.Quad)
    local tbl2 = {Position = enabled and UDim2.new(1, -21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9)}
    local tween2 = TweenService:Create(frame2, tweenInfo2, tbl2)
    tween2:Play()
end)
local flag = false
textButton.MouseButton1Click:Connect(function()
    flag = not flag
    if flag then
        local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
        local tbl = {Size = UDim2.new(0, 220, 0, 26)}
        local tween = TweenService:Create(mainFrame, tweenInfo, tbl)
        tween:Play()
        textButton.Text = "+"
    else
        local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
        local tbl = {Size = UDim2.new(0, 220, 0, 70)}
        local tween = TweenService:Create(mainFrame, tweenInfo, tbl)
        tween:Play()
        textButton.Text = "−"
    end
end)
local flag2 = false
local position
local position2
titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        flag2 = true
        position = input.Position
        position2 = mainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                flag2 = false
            end
        end)
        return
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if not flag2 then
        return
    end
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        local delta = input.Position - position
        mainFrame.Position = UDim2.new(position2.X.Scale, position2.X.Offset + delta.X, position2.Y.Scale, position2.Y.Offset + delta.Y)
    end
end)
print("[AntiRagdoll] Script loaded! Toggle the button to enable.")

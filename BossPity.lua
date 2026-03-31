a = Instance.new("ScreenGui")
b = Instance.new("Frame")

a.Name = "ScreenGui"
a.ResetOnSpawn = false
a.Enabled = true
a.Parent = game:GetService("CoreGui")

b.Size = UDim2.fromScale(0.12, 0.12)
b.AnchorPoint = Vector2.new(1, 1)
b.Position = UDim2.fromScale(0.98, 0.875)
b.BackgroundTransparency = 1
b.Parent = a

c = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("BossUI"):WaitForChild("MainFrame"):WaitForChild("BossHPBar"):WaitForChild("Pity")

d = c:Clone()
d.Name = "TextLabel"
d.Text = "Boss " .. c.Text
d.Parent = b

c:GetPropertyChangedSignal("Text"):Connect(function()
    d.Text = "Boss " .. c.Text
end)

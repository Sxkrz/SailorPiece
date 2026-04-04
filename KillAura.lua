if getgenv().killaura_running then return end
getgenv().killaura_running = true

local players = game:GetService("Players")
local rs = game:GetService("ReplicatedStorage")
local plr = players.LocalPlayer

local remotes = {
    M1 = rs:WaitForChild("CombatSystem"):WaitForChild("Remotes"):WaitForChild("RequestHit")
}

local config = {
    range = 200,
    cooldown = 0.12,
    auto_equip = true
}

local function char() 
    local c = plr.Character 
    return c and c:FindFirstChild("HumanoidRootPart") and c or nil 
end

local function equip()
    local char = char()
    if not char then return end
    if char:FindFirstChildOfClass("Tool") then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    local tool = plr.Backpack:FindFirstChildOfClass("Tool")
    if hum and tool then hum:EquipTool(tool) end
end

local function target()
    local char = char()
    if not char then return nil end
    local root = char.HumanoidRootPart
    local best, dist = nil, config.range
    
    local npcs = workspace:FindFirstChild("NPCs")
    if npcs then
        for _, v in ipairs(npcs:GetChildren()) do
            if v:IsA("Model") then
                local hum = v:FindFirstChildOfClass("Humanoid")
                local hrp = v:FindFirstChild("HumanoidRootPart")
                if hum and hrp and hum.Health > 0 then
                    local d = (root.Position - hrp.Position).Magnitude
                    if d < dist then
                        dist = d
                        best = v
                    end
                end
            end
        end
    end
    
    return best
end

while getgenv().killaura_running do
    local char = char()
    if char and not char:FindFirstChildOfClass("ForceField") then
        local target = target()
        if target then
            if config.auto_equip then equip() end
            remotes.M1:FireServer(target:GetPivot().Position)
        end
    end
    task.wait(config.cooldown)
end

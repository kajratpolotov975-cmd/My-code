local P = game:GetService("Players")
local TW = game:GetService("TweenService")
local L = game:GetService("Lighting")
local Camera = workspace.CurrentCamera
local p1, p2, lp, coold, PL = nil, nil, 2, false, P.LocalPlayer
local C1, C2, C3 = Color3.fromRGB(245,230,60), Color3.fromRGB(150,130,45), Color3.fromRGB(230,220,120)

local function snd(p, id, pt)
    local s = Instance.new("Sound") s.SoundId = "rbxassetid://"..id s.Volume = pt and 3 or 2.5 if pt then s.Pitch = 0.6 end s.Parent = p s:Play() game:GetService("Debris"):AddItem(s, 2)
end

local function fx()
    task.spawn(function()
        local cc, bl = Instance.new("ColorCorrectionEffect"), Instance.new("BlurEffect")
        cc.TintColor, cc.Brightness, cc.Saturation, cc.Parent, bl.Size, bl.Parent = Color3.fromRGB(255,110,0), 0.4, 3, L, 40, L
        local i = TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
        TW:Create(cc, i, {TintColor = Color3.fromRGB(255,255,255), Brightness = 0, Saturation = 0}):Play() TW:Create(bl, i, {Size = 0}):Play()
        task.wait(1.2) cc:Destroy() bl:Destroy()
    end)
end

local function vis(p)
    local s, sb, pt, l = Instance.new("Decal"), Instance.new("Decal"), Instance.new("ParticleEmitter"), Instance.new("PointLight")
    s.Texture, s.Face, s.Parent = "rbxassetid://13214736630", 0, p sb.Texture, sb.Face, sb.Parent = "rbxassetid://13214736630", 5, p
    pt.Texture, pt.Rate, pt.Parent = "rbxassetid://241583020", 45, p l.Color, l.Brightness, l.Range, l.Parent = C1, 3, 12, p
    local m = Instance.new("SpecialMesh") m.MeshType, m.Scale, m.Parent = 3, Vector3.new(1, 1, 0.1), p
    task.spawn(function() while p and p.Parent do p.CFrame = p.CFrame * CFrame.Angles(0, 0, 0.07) task.wait(0.03) end end)
end

local function spawnP(pos, n)
    local p = Instance.new("Part") p.Size, p.Color, p.Material, p.Anchored, p.CanCollide, p.Transparency = Vector3.new(4, 5, 0.2), C1, Enum.Material.Neon, true, false, 0.2
    if math.abs(n.Y) > 0.65 then p.CFrame = CFrame.new(pos + Vector3.new(0, 0.05, 0)) * CFrame.Angles(1.57, 0, 0) p:SetAttribute("Floor", true)
    else p.CFrame = CFrame.new(pos, pos + n) p:SetAttribute("Floor", false) end p.Parent = workspace vis(p) snd(p, 4590657391) return p
end

local function laser(s, e)
    local l = Instance.new("Part") l.Anchored, l.CanCollide, l.Color, l.Material, l.Transparency = true, false, C1, Enum.Material.Neon, 0.1
    local d = (e - s).Magnitude l.Size = Vector3.new(0.18, 0.18, d) l.CFrame = CFrame.new(s:Lerp(e, 0.5), e) l.Parent = workspace
    TW:Create(l, TweenInfo.new(0.25), {Size = Vector3.new(0,  0, d), Transparency = 1}):Play() game:GetService("Debris"):AddItem(l, 0.25)
end

local function gun()
    local bp = PL:FindFirstChildOfClass("Backpack") or PL:WaitForChild("Backpack")
    local old = bp:FindFirstChild("PortalGun") or (PL.Character and PL.Character:FindFirstChild("PortalGun")) if old then old:Destroy() end
    local Tool, H, B, Br = Instance.new("Tool"), Instance.new("Part"), Instance.new("Part"), Instance.new("Part")
    Tool.Name, Tool.RequiresHandle = "PortalGun", true H.Name, H.Size, H.Color, H.Parent = "Handle", Vector3.new(0.4, 1.2, 0.4), Color3.fromRGB(80, 80, 80), Tool
    B.Size, B.Color, B.Material, B.Parent = Vector3.new(0.6, 0.6, 2.5), C2, Enum.Material.DiamondPlate, Tool
    local w1 = Instance.new("Weld") w1.Part0, w1.Part1, w1.C0, w1.Parent = H, B, CFrame.new(0, 0.5, -0.5) * CFrame.Angles(-0.35, 0, 0), B
    Br.Name, Br.Size, Br.Color, Br.Material, Br.Parent = "Barrel", Vector3.new(1.1, 1.1, 1.1), C2, Enum.Material.Metal, Tool
    local w2 = Instance.new("Weld") w2.Part0, w2.Part1, w2.C0, w2.Parent = B, Br, CFrame.new(0, 0, -1.5), Br
    local Ls, O, F, Cr = Instance.new("Part"), Instance.new("Part"), Instance.new("Part"), Instance.new("Part")
    Ls.Size, Ls.Color, Ls.Material, Ls.Shape, Ls.Parent = Vector3.new(0.5, 0.5, 0.1), C1, Enum.Material.Neon, 0, Tool
    local w3 = Instance.new("Weld") w3.Part0, w3.Part1, w3.C0, w3.Parent = Br, Ls, CFrame.new(0, 0, -0.55), Ls
    O.Size, O.Color, O.Material, O.Shape, O.Parent = Vector3.new(0.4, 0.4, 0.4), Color3.fromRGB(255, 255, 100), Enum.Material.Neon, 0, Tool
    local wo = Instance.new("Weld") wo.Part0, wo.Part1, wo.C0, wo.Parent = Br, O, CFrame.new(0.55, 0, 0), O
    F.Size, F.Color, F.Material, F.Transparency, F.Parent = Vector3.new(0.5, 1, 0.5), C3, Enum.Material.Glass, 0.3, Tool
    local w4 = Instance.new("Weld") w4.Part0, w4.Part1, w4.C0, w4.Parent = B, F, CFrame.new(0, 0.7, -0.2) * CFrame.Angles(1.57, 0, 0), F
    Cr.Size, Cr.Color, Cr.Material, Cr.Parent = Vector3.new(0.3, 0.7, 0.3), C1, Enum.Material.Neon, Tool
    local w5 = Instance.new("Weld") w5.Part0, w5.Part1, w5.Parent = F, Cr, Cr
    Tool.Activated:Connect(function()
        local m = PL:GetMouse() if not m or not m.Target then return end
        laser(Br.Position, m.Hit.Position)
        if lp == 2 then if p1 then p1:Destroy() end p1 = spawnP(m.Hit.Position, m.Target.CFrame:VectorToWorldSpace(Vector3.FromNormalId(m.TargetSurface))) lp = 1
        else if p2 then p2:Destroy() end p2 = spawnP(m.Hit.Position, m.Target.CFrame:VectorToWorldSpace(Vector3.FromNormalId(m.TargetSurface))) lp = 2 end
    end)
    Tool.Unequipped:Connect(function() if p1 then p1:Destroy() p1 = nil end if p2 then p2:Destroy() p2 = nil end lp = 2 end)
    Tool.Parent = bp
end
task.spawn(gun) PL.CharacterAdded:Connect(function() task.wait(0.5) gun() end)

local function tp(to)
    local c = PL.Character local r = c and c:FindFirstChild("HumanoidRootPart") local h = c and c:FindFirstChildOfClass("Humanoid")
    if r and h and h.Health > 0 then coold = true r.AssemblyLinearVelocity = Vector3.new(0, 0, 0) snd(r, 4590657391, true) fx()
        if to:GetAttribute("Floor") then r.CFrame = (r.CFrame - r.CFrame.Position) + (to.Position + Vector3.new(0, 3.5, 0))
        else r.CFrame = CFrame.new((to.CFrame * CFrame.new(0, 0, -4)).Position, (to.CFrame * CFrame.new(0, 0, -4)).Position + to.CFrame.LookVector) end
        task.wait(1.5) coold = false
    end
end
task.spawn(function() while task.wait(0.05) do local c = PL.Character local r = c and c:FindFirstChild("HumanoidRootPart")
if r and p1 and p2 and not coold then if (r.Position - p1.Position).Magnitude < 3.5 then tp(p2) elseif (r.Position - p2.Position).Magnitude < 3.5 then tp(p1) end end end end)


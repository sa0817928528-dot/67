-- โหลดRayfield Gen2
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/gen2"))()
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
local StarterGui = game:GetService("StarterGui")
local LP = Players.LocalPlayer

-- สร้างหน้าต่างหลัก
local Window = Rayfield:CreateWindow({
    Name = "100 ฟังก์ชันระดับตำนาน",
    Icon = 0,
    LoadingTitle = "กำลังโหลด 100 ฟังก์ชัน...",
    LoadingSubtitle = "ขับเคลื่อนโดย Rayfield Gen2",
    Theme = "Default",
    ToggleUIKeybind = "K",
    ConfigurationSaving = { Enabled = true, FolderName = "My100Func", FileName = "Config" },
    Discord = { Enabled = false },
    KeySystem = false
})

-- Helper
local function getHum()
    local c = LP.Character
    if c then return c:FindFirstChildOfClass("Humanoid") end
end
local function notify(t, c)
    Rayfield:Notify({ Title = t, Content = c, Duration = 4, Image = 4483362458 })
end

-- สร้าง Tabs
local Tab1 = Window:CreateTab("ตัวละคร", nil)
local Tab2 = Window:CreateTab("กล้อง", nil)
local Tab3 = Window:CreateTab("ผู้เล่นอื่น", nil)
local Tab4 = Window:CreateTab("โลก", nil)
local Tab5 = Window:CreateTab("ระบบ", nil)
local Tab6 = Window:CreateTab("ESP & Aimbot", nil)
local Tab7 = Window:CreateTab("เสียง & เอฟเฟกต์", nil)

-- =========================================================
-- TAB 1: ตัวละคร (1-20)
-- =========================================================
Tab1:CreateSection("การเคลื่อนไหว")

Tab1:CreateSlider({ Name = "1. ปรับความเร็วเดิน", Range = {16,500}, Increment = 1, Suffix = " สปีด", CurrentValue = 16, Flag = "WalkSpeed",
    Callback = function(v) local h = getHum(); if h then h.WalkSpeed = v end end })

Tab1:CreateSlider({ Name = "2. ปรับความสูงกระโดด", Range = {50,500}, Increment = 1, Suffix = " กำลัง", CurrentValue = 50, Flag = "JumpPower",
    Callback = function(v) local h = getHum(); if h then h.JumpPower = v; h.UseJumpPower = true end end })

Tab1:CreateToggle({ Name = "3. ไม่มีแรงโน้มถ่วง", CurrentValue = false, Flag = "LowGrav",
    Callback = function(v) local h = getHum(); if h then h.Gravity = v and 50 or 196.2 end end })

Tab1:CreateToggle({ Name = "4. ลอยได้ (Fly)", CurrentValue = false, Flag = "Fly",
    Callback = function(v)
        local c = LP.Character; if not c then return end
        local hrp = c:FindFirstChild("HumanoidRootPart"); if not hrp then return end
        if v then
            local bv = Instance.new("BodyVelocity", hrp)
            bv.MaxForce = Vector3.new(1e5,1e5,1e5); bv.Velocity = Vector3.zero; bv.Name = "FlyBV"
            task.spawn(function()
                while bv.Parent do
                    local cam = workspace.CurrentCamera
                    local mv = Vector3.zero
                    if UserInputService:IsKeyDown(Enum.KeyCode.W) then mv += cam.CFrame.LookVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.S) then mv -= cam.CFrame.LookVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.A) then mv -= cam.CFrame.RightVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.D) then mv += cam.CFrame.RightVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then mv += Vector3.new(0,1,0) end
                    bv.Velocity = mv * 80
                    RunService.Heartbeat:Wait()
                end
            end)
        else
            local bv = hrp:FindFirstChild("FlyBV"); if bv then bv:Destroy() end
        end
    end })

Tab1:CreateToggle({ Name = "5. ว่ายน้ำได้ทุกที่", CurrentValue = false, Flag = "Swim",
    Callback = function(v) local h = getHum(); if h then h:SetStateEnabled(Enum.HumanoidStateType.Swimming, v) end end })

Tab1:CreateToggle({ Name = "6. ไต่กำแพงได้", CurrentValue = false, Flag = "Climb",
    Callback = function(v) local h = getHum(); if h then h:SetStateEnabled(Enum.HumanoidStateType.Climbing, v) end end })

Tab1:CreateSlider({ Name = "7. ความเร็วขณะว่ายน้ำ", Range = {1,100}, Increment = 1, Suffix = "", CurrentValue = 10, Flag = "SwimSpd",
    Callback = function(v) local h = getHum(); if h then h.SwimSpeed = v end end })

Tab1:CreateSlider({ Name = "8. ความเร็วขณะไต่", Range = {1,100}, Increment = 1, Suffix = "", CurrentValue = 10, Flag = "ClimbSpd",
    Callback = function(v) local h = getHum(); if h then h.ClimbSpeed = v end end })

Tab1:CreateToggle({ Name = "9. กระโดดกลางอากาศได้", CurrentValue = false, Flag = "AirJump",
    Callback = function(v) local h = getHum(); if h then h:SetStateEnabled(Enum.HumanoidStateType.Jumping, v) end end })

Tab1:CreateButton({ Name = "10. รีเซ็ตตัวละคร", Callback = function() local h = getHum(); if h then h.Health = 0 end end })

Tab1:CreateSection("สุขภาพ")

Tab1:CreateToggle({ Name = "11. ไม่รับความเสียหาย (God)", CurrentValue = false, Flag = "God",

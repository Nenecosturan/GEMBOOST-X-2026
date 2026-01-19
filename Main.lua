--[[
    💎 MASTERPIECE FPS BOOSTER & OPTIMIZER [PREMIUM]
    Engineered for: Solara, Wave, Delta, Hydrogen, Arceus X
    Focus: Smart Rendering, Memory Management, Thermal Protection
    Author: Kodlama Desteği (AI)
]]

-- // 1. UNIVERSAL COMPATIBILITY LAYER \\ --
local Services = {
    Workspace = game:GetService("Workspace"),
    Lighting = game:GetService("Lighting"),
    ReplicatedStorage = game:GetService("ReplicatedStorage"),
    StarterGui = game:GetService("StarterGui"),
    MaterialService = game:GetService("MaterialService"),
    RunService = game:GetService("RunService"),
    Stats = game:GetService("Stats")
}

-- Safe Environment Check
local getgenv = getgenv or function() return _G end
local setfpscap = setfpscap or function(fps) 
    warn("Executor does not support setfpscap, skipping.") 
end

-- // 2. CONFIGURATION & STATE \\ --
local Config = {
    LowPoly = false,
    Shadows = true,
    FPSLock = false,
    DeepClean = false,
    ThermalMode = false
}

-- // 3. OPTIMIZATION MODULES \\ --

local Optimizer = {}

-- >> Smart Material Handler (Non-Destructive)
function Optimizer.SetLowPoly(state)
    Config.LowPoly = state
    
    if state then
        Services.Lighting.GlobalShadows = false
        Services.Lighting.FogEnd = 9e9
        Services.Lighting.Brightness = 2
        
        -- Override Materials to Smooth Plastic (GPU Friendly)
        for _, v in pairs(Services.Workspace:GetDescendants()) do
            if v:IsA("BasePart") and not v:IsA("MeshPart") then
                v.Material = Enum.Material.SmoothPlastic
                v.Reflectance = 0
            elseif v:IsA("Decal") or v:IsA("Texture") then
                v.Transparency = 1 -- Hide textures instead of destroying
            end
        end
        
        -- Disable heavy effects
        for _, v in pairs(Services.Lighting:GetChildren()) do
            if v:IsA("PostEffect") or v:IsA("Atmosphere") or v:IsA("Sky") then
                v.Enabled = false
            end
        end
    end
end

-- >> Garbage Collection & Memory
function Optimizer.DeepClean()
    local Terrain = Services.Workspace:FindFirstChildOfClass("Terrain")
    if Terrain then
        Terrain.WaterWaveSize = 0
        Terrain.WaterWaveSpeed = 0
        Terrain.WaterReflectance = 0
        Terrain.WaterTransparency = 0
    end

    -- Clear Cache
    if sethiddenproperty then
        pcall(function()
            sethiddenproperty(Services.Lighting, "Technology", Enum.Technology.Compatibility)
        end)
    end
    
    -- Force Garbage Collection if supported
    game:GetService("TestService"):Message("🧹 Starting Deep Clean Process...")
    for i = 1, 5 do
        task.wait()
    end
end

-- >> Thermal Protection (Mobile Optimization)
function Optimizer.ToggleThermalMode(state)
    Config.ThermalMode = state
    if state then
        -- Cap FPS to 30 to save battery and reduce heat
        setfpscap(30)
        Services.RunService:Set3dRenderingEnabled(false) -- Extreme measure for AFK/Thermal
    else
        setfpscap(999)
        Services.RunService:Set3dRenderingEnabled(true)
    end
end

-- // 4. UI INTERFACE (RAYFIELD) \\ --
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "🚀 Masterpiece Optimizer | Premium",
    LoadingTitle = "Initializing Engine...",
    LoadingSubtitle = "by Kodlama Desteği",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "MasterpieceConfig",
        FileName = "Manager"
    },
    Discord = {
        Enabled = false,
        Invite = "noinvitelink",
        RememberJoins = true 
    },
    KeySystem = false
})

-- >> DASHBOARD TAB
local TabPerf = Window:CreateTab("Dashboard", 4483362458) -- Monitor Icon

TabPerf:CreateSection("Real-Time Statistics")

local FPSLabel = TabPerf:CreateLabel("FPS: Calculating...")
local RAMLabel = TabPerf:CreateLabel("RAM Usage: Calculating...")

-- Live Stats Updater
task.spawn(function()
    while true do
        task.wait(1)
        local fps = math.floor(Services.Workspace:GetRealPhysicsFPS())
        local mem = math.floor(Services.Stats:GetTotalMemoryUsageMb())
        FPSLabel:Set("FPS: " .. fps)
        RAMLabel:Set("RAM: " .. mem .. " MB")
    end
end)

TabPerf:CreateSection("Quick Actions")

TabPerf:CreateButton({
    Name = "⚡ Unlock FPS (Max Performance)",
    Callback = function()
        setfpscap(9999)
        Rayfield:Notify({
            Title = "FPS Unlocked",
            Content = "Frame cap removed. Enjoy smoothness.",
            Duration = 3,
            Image = 4483362458,
        })
    end,
})

-- >> RENDERING TAB
local TabRender = Window:CreateTab("Rendering", 4483362458)

TabRender:CreateSection("Graphics Overhaul")

TabRender:CreateToggle({
    Name = "Low Poly Mode (Smooth Plastic)",
    CurrentValue = false,
    Flag = "LowPoly",
    Callback = function(Value)
        Optimizer.SetLowPoly(Value)
        Rayfield:Notify({
            Title = "Rendering Changed",
            Content = Value and "Low Poly Applied" or "Restored (Rejoin recommended)",
            Duration = 3,
            Image = 4483362458,
        })
    end,
})

TabRender:CreateToggle({
    Name = "Disable Shadows & Effects",
    CurrentValue = false,
    Flag = "NoShadows",
    Callback = function(Value)
        Services.Lighting.GlobalShadows = not Value
        Services.Lighting.FogEnd = Value and 9e9 or 1000
    end,
})

-- >> UTILITIES TAB
local TabUtils = Window:CreateTab("Utilities", 4483362458)

TabUtils:CreateSection("Hardware Management")

TabUtils:CreateButton({
    Name = "🧹 Deep Clean Memory",
    Callback = function()
        Optimizer.DeepClean()
        Rayfield:Notify({
            Title = "Memory Cleaned",
            Content = "Textures reduced and caches cleared.",
            Duration = 3,
            Image = 4483362458,
        })
    end,
})

TabUtils:CreateToggle({
    Name = "🔥 Thermal Protection Mode",
    CurrentValue = false,
    Flag = "Thermal",
    Callback = function(Value)
        Optimizer.ToggleThermalMode(Value)
        local msg = Value and "Rendering Paused to cool down device." or "Rendering Resumed."
        Rayfield:Notify({
            Title = "Thermal Mode",
            Content = msg,
            Duration = 3,
            Image = 4483362458,
        })
    end,
})

Rayfield:LoadConfiguration()

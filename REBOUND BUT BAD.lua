local Creator = loadstring(game:HttpGet("https://pastebin.com/raw/0fSnvfGt"))()

--------------------------------------------------
-- SETTINGS
--------------------------------------------------

local ARRIVAL_SOUND = "rbxassetid://9114397505"

--------------------------------------------------
-- SERVICES
--------------------------------------------------

local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")

--------------------------------------------------
-- ARRIVAL EFFECT
--------------------------------------------------

local function ReboundSpawnEffect()

    -- Prevent duplicate arrival effects
    if workspace:FindFirstChild("ReboundArrival") then
        return
    end

    --------------------------------------------------
    -- ARRIVAL SOUND
    --------------------------------------------------

    local arrival = Instance.new("Sound")
    arrival.Name = "ReboundArrival"
    arrival.SoundId = ARRIVAL_SOUND
    arrival.Volume = 5
    arrival.PlaybackSpeed = 1
    arrival.Parent = workspace

    arrival:Play()

    Debris:AddItem(arrival, 10)

    --------------------------------------------------
    -- CAMERA SHAKE
    --------------------------------------------------

    local success, CameraShaker = pcall(function()
        return require(game.ReplicatedStorage.CameraShaker)
    end)

    if success and CameraShaker then

        local camera = workspace.CurrentCamera

        local camShake = CameraShaker.new(
            Enum.RenderPriority.Camera.Value,
            function(cf)
                camera.CFrame = camera.CFrame * cf
            end
        )

        camShake:Start()
        camShake:ShakeOnce(10, 3, 0.1, 6, 2, 0.5)

    end

    --------------------------------------------------
    -- BLUE WARNING
    --------------------------------------------------

    local warnEffect = Instance.new("ColorCorrectionEffect")

    warnEffect.Name = "ReboundWarning"
    warnEffect.TintColor = Color3.fromRGB(65, 138, 255)
    warnEffect.Saturation = -0.7
    warnEffect.Contrast = 0.2
    warnEffect.Parent = Lighting

    TweenService:Create(
        warnEffect,
        TweenInfo.new(5),
        {
            TintColor = Color3.fromRGB(255, 255, 255),
            Saturation = 0,
            Contrast = 0
        }
    ):Play()

    Debris:AddItem(warnEffect, 5)

end

--------------------------------------------------
-- CREATE REBOUND
--------------------------------------------------

local entity = Creator.createEntity({

    CustomName = "ReboundMoving",

    Model = "https://raw.githubusercontent.com/Ilikerobloxdoors/Rebound-BUT-BAD/main/Rebound%20BUT%20BAD.rbxm",

    Speed = 150,

    DelayTime = 3.7,

    HeightOffset = 0,

    CanKill = true,

    KillRange = 67,

    BreakLights = false,

    BackwardsMovement = true,

    FlickerLights = {
        false,
        1,
    },

    --------------------------------------------------
    -- 4 CYCLES
    --------------------------------------------------

    Cycles = {
        Min = 4,
        Max = 4,
        WaitTime = 1,
    },

    --------------------------------------------------
    -- CAMERA SHAKE
    --------------------------------------------------

    CamShake = {
        true,
        {9, 60, 0.1, 1.4},
        150,
    },

    --------------------------------------------------
    -- JUMPSCARE
    --------------------------------------------------

    Jumpscare = {
        true,
        {

            Image1 = "rbxassetid://11934600309",

            Image2 = "rbxassetid://10675906834",

            Shake = true,

            Sound1 = {
                10483790459,
                {
                    Volume = 0.5
                }
            },

            Sound2 = {
                81041181328536,
                {
                    Volume = 0.5
                }
            },

            Flashing = {
                true,
                Color3.fromRGB(255, 255, 255)
            },

            Tease = {
                true,
                Min = 2,
                Max = 2
            }

        }
    },

    --------------------------------------------------
    -- DEATH MESSAGE
    --------------------------------------------------

    CustomDialog = {
        "You died to ReboundMoving..."
    }

})

--------------------------------------------------
-- DEBUG
--------------------------------------------------

entity.Debug.OnEntitySpawned = function(entityTable)
    print("[Rebound] Spawned")
end

entity.Debug.OnEntityDespawned = function(entityTable)
    print("[Rebound] Despawned")
end

entity.Debug.OnEntityStartMoving = function(entityTable)
    print("[Rebound] Started moving")
end

entity.Debug.OnEntityFinishedRebound = function(entityTable)
    print("[Rebound] Finished cycle")
end

entity.Debug.OnEntityEnteredRoom = function(entityTable, room)
    print("[Rebound] Entered room:", room)
end

entity.Debug.OnLookAtEntity = function(entityTable)
    print("[Rebound] Player looked at entity")
end

entity.Debug.OnDeath = function(entityTable)
    warn("[Rebound] Player died")
end

--------------------------------------------------
-- ARRIVAL EFFECT
--------------------------------------------------

ReboundSpawnEffect()

--------------------------------------------------
-- RUN ONE ENTITY WITH 4 CYCLES
--------------------------------------------------

Creator.runEntity(entity)

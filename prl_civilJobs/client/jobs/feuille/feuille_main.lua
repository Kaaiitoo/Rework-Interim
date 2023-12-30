

local sync = false
local WorkerChillPos = {}
local workzone = {}
local WorkerWorkingPos = {}
local Heading
local pedHash
AuTravaillemine = nil
local ArgentMin
local ArgentMax


local WorkerChillPos = {
    ped1 = {
        pos = vector3(-282.20, -2075.30, 26.75),
        Heading = 69.13,
    },
    ped2 = {
        pos = vector3(-290.74, -2066.38, 26.75),
        Heading = 43.67,
    },
    ped3 = {
        pos = vector3(-320.47, -2063.89, 26.75),
        Heading = 13.24,
    },
    ped4 = {
        pos = vector3(-348.06, -2057.46, 26.75),
        Heading = 127.64,
    },
    
}

Citizen.CreateThread(function()
    LoadModel("s_m_y_construct_01")
    local ped = CreatePed(2, GetHashKey("s_m_y_construct_01"), zone.feuille, 117.68974304199, 0, 0)
    DecorSetInt(ped, "Yay", 5431)
    FreezeEntityPosition(ped, 1)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_GARDENER_LEAF_BLOWER", 0, true)
    SetEntityInvincible(ped, true)
    SetEntityAsMissionEntity(ped, 1, 1)
    SetBlockingOfNonTemporaryEvents(ped, 1)

 
    for _,v in pairs(WorkerChillPos) do
        local ped = CreatePed(2, GetHashKey("s_m_y_construct_01"), v.pos, v.Heading, 0, 0)
        DecorSetInt(ped, "Yay", 5431)
        FreezeEntityPosition(ped, 1)
        TaskStartScenarioInPlace(ped, "WORLD_HUMAN_GARDENER_LEAF_BLOWER", 0, true)
        SetEntityInvincible(ped, true)
        SetEntityAsMissionEntity(ped, 1, 1)
        SetBlockingOfNonTemporaryEvents(ped, 1)
    end

end)




local object = {
    "prop_pot_plant_01c",
    "prop_pot_plant_01c",
    "prop_pot_plant_01c",
    "prop_pot_plant_01c",
    "prop_pot_plant_01c",
    "prop_pot_plant_01c",
    "prop_pot_plant_01c",
    "prop_pot_plant_01c",
    "prop_pot_plant_01c",
    "prop_pot_plant_01c",
}


local zoneZoche = vector3(-305.10, -2076.03, 28.65)


function StartTravaillemine()
    self = object
    RequestAnimDict("melee@large_wpn@streamed_core")
    AuTravaillemine = true
    Citizen.CreateThread(function()
        while AuTravaillemine do
            EnAction = false
            local zoneRandom = vector3(zoneZoche.x+math.random(-1.0, 1.0), zoneZoche.y+math.random(-1.0, 1.0), zoneZoche.z)
            local random = math.random(1, #object)
            local model = GetHashKey(object[random])
            RequestModel(model)
            while not HasModelLoaded(model) do print("Chargement model") Wait(100) end
            roche = CreateObject(model, zoneRandom, 1, 0, 0)
            blip = AddBlipForEntity(roche)
           
            SetNetworkIdCanMigrate(NetworkGetNetworkIdFromEntity(roche), true)
            SetBlipSprite(blip, 618)
            SetBlipColour(blip, 5)
            SetBlipScale(blip, 0.65)
            PlaceObjectOnGroundProperly(roche)
            local pos = GetEntityCoords(roche)
            SetEntityCoords(roche, pos.x, pos.y, pos.z-0.5, 0.0, 0.0, 0.0, 0)
            FreezeEntityPosition(roche, 1)
            while not EnAction and AuTravaillemine do
                Citizen.Wait(1)
                dstToMarker = GetDistanceBetweenCoords(zoneRandom, pCoords, true)
                DrawMarker(32, zoneRandom.x, zoneRandom.y, zoneRandom.z+1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 255, 0, 170, 0, 0, 2, 1, nil, nil, 0)
                local dst = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), GetEntityCoords(roche), true)
                if dst <= 3.0 and AuTravaillemine then
                    RageUI.Text({

                        message = "[~y~E~w~] Pour commencer à travailler",
            
                        time_display = 1
            
                    })
                    if IsControlJustPressed(1, 51) and dst <= 3.0 then
                        RemoveBlip(blip)
                        EnAction = true
                        TaskPlayAnim(GetPlayerPed(-1), 'melee@large_wpn@streamed_core', 'ground_attack_on_spot', 8.0, 8.0, -1, 1, 0, 0, 0, 0)
                        pickaxe = CreateObject(GetHashKey(""), 0, 0, 0, true, true, true) 
                        AttachEntityToEntity(pickaxe, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.18, -0.02, -0.02, 350.0, 100.00, 140.0, true, true, false, true, 1, true)
                        exports["rs_prog"]:AfficherProgressbar(20.0)
                        Wait(20000)
                        PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
                        exports["rs_prog"]:CacherProgressbar() 
                        DetachEntity(pickaxe, 1, true)
                        DeleteEntity(pickaxe)
                        DeleteObject(pickaxe)
                        RemoveObj(NetworkGetNetworkIdFromEntity(pickaxe))
                        RemoveObj(NetworkGetNetworkIdFromEntity(roche))
                        ClearPedTasksImmediately(GetPlayerPed(-1))
                        local money = math.random(30, 30)
                        TriggerServerEvent("ori_jobs:pay", money)
                        RageUI.Popup({
                            message = "Bien ! Tu as été payé ~g~"..money.."$ ~w~pour ton travaille, continue comme ça !",
                        })
                        break
                    end
                end
            end
            DetachEntity(pickaxe, 1, true)
            DeleteEntity(pickaxe)
            DeleteObject(pickaxe)
            RemoveObj(NetworkGetNetworkIdFromEntity(pickaxe))
            RemoveObj(NetworkGetNetworkIdFromEntity(roche)) 
            RemoveBlip(blip)
        end
        DetachEntity(pickaxe, 1, true)
        DeleteEntity(pickaxe)
        RemoveObj(NetworkGetNetworkIdFromEntity(pickaxe))
        RemoveObj(NetworkGetNetworkIdFromEntity(roche))
        RemoveBlip(blip) 
    end)
end

function endwork()
    DetachEntity(pickaxe, 1, true)
    DeleteEntity(pickaxe)
    RemoveObj(NetworkGetNetworkIdFromEntity(pickaxe))
    RemoveObj(NetworkGetNetworkIdFromEntity(roche))
    RemoveBlip(blip) 
end

function RemoveObj(id)
    Citizen.CreateThread(function()
        SetNetworkIdCanMigrate(id, true)
        local entity = NetworkGetEntityFromNetworkId(id)
        NetworkRequestControlOfEntity(entity)
        local test = 0
        while test > 100 and not NetworkHasControlOfEntity(entity) do
            NetworkRequestControlOfEntity(entity)
            DetachEntity(entity, 0, 0)
            Wait(1)
            test = test + 1
        end
        SetEntityAsNoLongerNeeded(entity)

        local test = 0
        while test < 100 and IsEntityAttached(entity) do 
            DetachEntity(entity, 0, 0)
            Wait(1)
            test = test + 1
        end

        local test = 0
        while test < 100 and DoesEntityExist(entity) do 
            DetachEntity(entity, 0, 0)
            SetEntityAsNoLongerNeeded(entity)
            DeleteEntity(entity)
            DeleteObject(entity)
            SetEntityCoords(entity, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0)
            Wait(1)
            test = test + 1
        end

    end)
end
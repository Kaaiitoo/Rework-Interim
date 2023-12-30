DecorRegister("Yay", 4)
Heading = 206.31968688965
pedHash = "a_f_y_business_02"


zone = {
    Lifeinveders = vector3(-266.1607, -961.8145, 30.22313),
    otacos = vector3(-1242.93, -1461.35, 3.23),
    aero = vector3(-901.22, -2983.35, 18.85),
    feuille = vector3(-266.51, -2070.78, 26.75),
    peche = vector3(-2187.77, -409.14, 12.14),
}

local travailleZone = {
    {
        zone = vector3(-1242.93, -1461.35, 4.23),
        nom = "O'Tacos",
        blip = 467,
        couleur = 44,
    },
    {
        zone = vector3(-901.22, -2983.35, 19.45),
        nom = "Aéroport",
        blip = 423,
        couleur = 23,
    },
    {
        zone = vector3(-266.51, -2070.78, 27.75),
        nom = "Jardinerie",
        blip = 253,
        couleur = 2,
    },
    {
        zone = vector3(-2187.77, -409.14, 13.14),
        nom = "Pêche",
        blip = 267,
        couleur = 3,
    },
    
}


Citizen.CreateThread(function()
    LoadModel(pedHash)
    local ped = CreatePed(2, GetHashKey(pedHash), zone.Lifeinveders, Heading, 0, 0)
    DecorSetInt(ped, "Yay", 5431)
    FreezeEntityPosition(ped, 1)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_CLIPBOARD", 0, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, 1)

    local blip = AddBlipForCoord(zone.Lifeinveders)
    SetBlipSprite(blip, 590)
    SetBlipScale(blip, 0.7)
    SetBlipShrink(blip, true)
    SetBlipColour(blip, 11)

    for k,v in pairs(travailleZone) do
        local blip = AddBlipForCoord(v.zone)
        SetBlipSprite(blip, v.blip)
        SetBlipScale(blip, 0.7)
        SetBlipShrink(blip, true)
        SetBlipColour(blip, v.couleur)
        SetBlipAsShortRange(blip, true)


        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString(v.nom)
        EndTextCommandSetBlipName(blip)
    end

    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString("Emploi intérimaire")
    EndTextCommandSetBlipName(blip)
end)


function LoadModel(model)
    while not HasModelLoaded(model) do
        RequestModel(model)
        Wait(100)
    end
end
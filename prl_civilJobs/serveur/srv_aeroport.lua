
local config = {
    Heading =145.51,
    pedHash = "s_m_y_construct_01",
    AuTravailleJardinier = false,
    ArgentMin = 2,
    ArgentMax = 35,
}

local workzone = {
    {
        pos = vector3(-911.52, -3014.46, 13.94),
        Heading = 238.63,
        scenario = "WORLD_HUMAN_MAID_CLEAN",
    },
    {
        pos = vector3(-927.02, -3038.26, 13.94),
        Heading = 130.56,
        scenario = "WORLD_HUMAN_MAID_CLEAN",
    },
    {
        pos = vector3(-954.65, -3053.97, 13.94),
        Heading = 146.05,
        scenario = "WORLD_HUMAN_MAID_CLEAN",
    },
    {
        pos = vector3(-929.54, -2958.15, 13.94),
        Heading = 318.81,
        scenario = "WORLD_HUMAN_MAID_CLEAN",
    },
    {
        pos = vector3(-928.92, -2937.24, 13.94),
        Heading = 144.39,
        scenario = "WORLD_HUMAN_MAID_CLEAN",
    },
}



local WorkerChillPos = {
    ped1 = {
        pos = vector3(-917.66, -2980.43, 19.84),
        Heading = 216.75,
    },
    ped3 = {
        pos = vector3(-923.45, -2974.73, 19.84),
        Heading = 121.28,
    },
    
}


local WorkerWorkingPos = {
    {
        pos = vector3(-1277.588, 139.2914, 57.24146),
        Heading = 67.615928649902,
        scenario = "WORLD_HUMAN_GARDENER_LEAF_BLOWER",
    },
    {
        pos = vector3(-1282.589, 133.2682, 56.79959),
        Heading = 43.779140472412,
        scenario = "WORLD_HUMAN_MAID_CLEAN",
    },
}



RegisterNetEvent("RED_JOBS:JardinierAntiDump")
AddEventHandler("RED_JOBS:JardinierAntiDump", function()
    TriggerClientEvent("RED_JOBS:JardinierAntiDump", source, config, workzone, WorkerChillPos, WorkerWorkingPos)
end)

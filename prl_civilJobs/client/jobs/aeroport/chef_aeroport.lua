RMenu.Add('aero', 'main', RageUI.CreateMenu("Aéroport", " "))
RMenu:Get('aero', 'main'):SetSubtitle("~b~Manageur de l'Aéroport")
RMenu:Get('aero', 'main').EnableMouse = false;
RMenu:Get('aero', 'main').Closed = function()
    RenderScriptCams(0, 1, 1500, 1, 1)
    DestroyCam(cam, 1)
    SetBlockingOfNonTemporaryEvents(Ped, 1)
end

local vehicle = nil
local ZoneDeSpawn = vector3(-900.45, -2987.85, 13.94)

RageUI.CreateWhile(1.0, function()
    local distance = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), zone.aero, true)
    if distance <= 3.0 then
        RageUI.Text({

            message = "[~r~E~w~] Parler avec Julo",

            time_display = 1

        })
        if IsControlJustPressed(1, 51) and distance <= 3.0 then
            RageUI.Visible(RMenu:Get('aero', 'main'), not RageUI.Visible(RMenu:Get('aero', 'main')))
            CreateCamera()
        end
    end

    if RageUI.Visible(RMenu:Get('aero', 'main')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()
            RageUI.Button("Faire le nettoyage du hangar", "", {}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    RageUI.Popup({
                        message = "Alors comme ça tu veux bosser à ~g~l'Aéroport~w~ hein ?",
                    })
                    RageUI.Visible(RMenu:Get('aero', 'main'), not RageUI.Visible(RMenu:Get('aero', 'main')))
                    RenderScriptCams(0, 1, 1500, 1, 1)
                    DestroyCam(cam, 1)
                    AuTravailleJardinier = true
                    TriggerEvent('skinchanger:getSkin', function(skin)
                        local clothesSkin = {
                        }
                        TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
                    end)
                    local spawnRandom = vector3(ZoneDeSpawn.x+math.random(1,1), ZoneDeSpawn.y+math.random(1,1   ), ZoneDeSpawn.z)
                    ESX.Game.SpawnVehicle(3757070668, spawnRandom, 274.95318603516, function(veh)
                        vehicle = NetworkGetNetworkIdFromEntity(veh)
                        local blip = AddBlipForEntity(veh)
                        SetBlipSprite(blip, 559)
                        SetBlipFlashes(blip, true)
                    end)
                    StartTravailleJardinier()
                end
            end)
            RageUI.Button("Arreter de travailler", "", {}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    RageUI.Popup({
                        message = "haha ! Tu stop déja ! Allez prends ta paye feignant ! Merci de ton aide, reviens quand tu veux.",
                    })
                    RageUI.Visible(RMenu:Get('aero', 'main'), not RageUI.Visible(RMenu:Get('aero', 'main')))
                    RenderScriptCams(0, 1, 1500, 1, 1)
                    DestroyCam(cam, 1)
                    AuTravailleJardinier = false
                    ESX.Game.DeleteVehicle(NetworkGetEntityFromNetworkId(vehicle))
                    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                        local isMale = skin.sex == 0
                        TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
                            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                                TriggerEvent('skinchanger:loadSkin', skin)
                                TriggerEvent('esx:restoreLoadout')
                            end)
                        end)
                    end)
                end
            end)
        end, function()
            ---Panels
        end)
    end
end, 1)
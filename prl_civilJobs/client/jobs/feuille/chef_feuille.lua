RMenu.Add('feuille', 'main', RageUI.CreateMenu("Jardinier", " "))
RMenu:Get('feuille', 'main'):SetSubtitle("~y~Manager Jardinerie")
RMenu:Get('feuille', 'main').EnableMouse = false;
RMenu:Get('feuille', 'main').Closed = function()
    RenderScriptCams(0, 1, 1500, 1, 1)
    DestroyCam(cam, 1)
    SetBlockingOfNonTemporaryEvents(Ped, 1)
end

local vehicle = nil
RageUI.CreateWhile(1.0, function()
    local distance = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), zone.feuille, true)
    if distance <= 3.0 then
        RageUI.Text({

            message = "[~r~E~w~] Parler avec Boby",

            time_display = 1

        })
        if IsControlJustPressed(1, 51) and distance <= 3.0 then
            RageUI.Visible(RMenu:Get('feuille', 'main'), not RageUI.Visible(RMenu:Get('feuille', 'main')))
            CreateCamera()
        end
    end

    if RageUI.Visible(RMenu:Get('feuille', 'main')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()
            if not AuTravaillemine then
                RageUI.Button("Demander à travailler pour la jardinerie", "", {}, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        RageUI.Popup({
                            message = "Alors comme ça tu veux bosser à la ~g~Jardinerie~w~ hein ? Très bien, met un casque et prends tes outils ! Je te préviens c'est pas pour les petite merdes !",
                        })
                        RageUI.Visible(RMenu:Get('feuille', 'main'), not RageUI.Visible(RMenu:Get('feuille', 'main')))
                        RenderScriptCams(0, 1, 1500, 1, 1)
                        DestroyCam(cam, 1)
                        AuTravaillemine = true
                        TriggerEvent('skinchanger:getSkin', function(skin)
                            local clothesSkin = {
                            }
                            TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
                        end)
                        if not ESX.Game.IsSpawnPointClear(vector3(-273.37, -2077.06, 27.75), 29.18) then
                            local veh = ESX.Game.GetClosestVehicle(vector3(-273.37, -2077.06, 27.75))
                            TriggerEvent("LS_LSPD:RemoveVeh", veh)
                        end
                        ESX.Game.SpawnVehicle(GetHashKey("caddy"), vector3(-273.37, -2077.06, 27.75), 29.18, function(veh)
                            SetVehicleOnGroundProperly(veh)
                            vehicle = NetworkGetNetworkIdFromEntity(veh)
                        end)
                        StartTravaillemine()
                    end
                end)
            else
                RageUI.Button("Arreter de travailler", "", {}, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        RageUI.Popup({
                            message = "haha ! Tu stop déja ! Allez prends ta paye feignant ! Merci de ton aide, reviens quand tu veux.",
                        })
                        RageUI.Visible(RMenu:Get('feuille', 'main'), not RageUI.Visible(RMenu:Get('feuille', 'main')))
                        RenderScriptCams(0, 1, 1500, 1, 1)
                        DestroyCam(cam, 1)
                        AuTravaillemine = false
                        endwork()
                        TriggerEvent("LS_LSPD:RemoveVeh", NetworkGetEntityFromNetworkId(vehicle))
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
            end
        end, function()
            ---Panels
        end)
    end
end, 1)
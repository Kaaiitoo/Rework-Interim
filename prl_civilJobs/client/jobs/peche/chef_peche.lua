RMenu.Add('bucheron', 'main', RageUI.CreateMenu("Pêche", " "))
RMenu:Get('bucheron', 'main'):SetSubtitle("~b~Maitre Pêcheurs")
RMenu:Get('bucheron', 'main').EnableMouse = false;
RMenu:Get('bucheron', 'main').Closed = function()
    RenderScriptCams(0, 1, 1500, 1, 1)
    DestroyCam(cam, 1)
    SetBlockingOfNonTemporaryEvents(Ped, 1)
end

--local vehicle = nil
RageUI.CreateWhile(1.0, function()
    local distance = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), zone.peche, true)
    if distance <= 3.0 then
        
        RageUI.Text({

            message = "[~r~E~w~] Parler avec André",

            time_display = 1

        })
        if IsControlJustPressed(1, 51) and distance <= 3.0 then
            RageUI.Visible(RMenu:Get('bucheron', 'main'), not RageUI.Visible(RMenu:Get('bucheron', 'main')))
            CreateCamera()
        end
    end

    if RageUI.Visible(RMenu:Get('bucheron', 'main')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()
            if not AuTravaillebucheron then
                RageUI.Button("Demander à travailler pour la poissonerie", "", {}, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        RageUI.Popup({
                            message = "Alors comme ça tu veux bosser pour la ~g~poissonerie~w~ hein ? Très bien, prends ta canne à pêche ! Je te préviens c'est pas pour les petites merdes !",
                        })
                        RageUI.Visible(RMenu:Get('bucheron', 'main'), not RageUI.Visible(RMenu:Get('bucheron', 'main')))
                        RenderScriptCams(0, 1, 1500, 1, 1)
                        DestroyCam(cam, 1)
                        AuTravaillebucheron = true
                        TriggerEvent('skinchanger:getSkin', function(skin)
                            local clothesSkin = {
                            }
                            TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
                        end)
                        StartTravaillebucheron()
                    end
                end)
            else
                RageUI.Button("Arreter de travailler", "", {}, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        RageUI.Popup({
                            message = "haha ! Tu stop déja ! Allez prends ta paye feignant ! Merci de ton aide, reviens quand tu veux.",
                        })
                        RageUI.Visible(RMenu:Get('bucheron', 'main'), not RageUI.Visible(RMenu:Get('bucheron', 'main')))
                        RenderScriptCams(0, 1, 1500, 1, 1)
                        DestroyCam(cam, 1)
                        AuTravaillebucheron = false
                        endwork()
                        --TriggerEvent("LS_LSPD:RemoveVeh", NetworkGetEntityFromNetworkId(vehicle))
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
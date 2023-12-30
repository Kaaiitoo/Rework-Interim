RMenu.Add('otacos', 'main', RageUI.CreateMenu("O'Tacos", " "))
RMenu:Get('otacos', 'main'):SetSubtitle("~b~Manager du O'Tacos")
RMenu:Get('otacos', 'main').EnableMouse = false;
RMenu:Get('otacos', 'main').Closed = function()
    RenderScriptCams(0, 1, 1500, 1, 1)
    DestroyCam(cam, 1)
    SetBlockingOfNonTemporaryEvents(Ped, 1)
end

RageUI.CreateWhile(1.0, function()
    local distance = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), zone.otacos, true)
    if distance <= 3.0 then
        RageUI.Text({

            message = "[~r~E~w~] Pour parler avec Mike",

            time_display = 1

        })
        if IsControlJustPressed(1, 51) and distance <= 3.0 then
            RageUI.Visible(RMenu:Get('otacos', 'main'), not RageUI.Visible(RMenu:Get('otacos', 'main')))
            CreateCamera()
        end
    end

    if RageUI.Visible(RMenu:Get('otacos', 'main')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()
            RageUI.Button("Demander à travailler pour O'Tacos", "", {}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    RageUI.Popup({
                        message = "Alors comme ça tu veux bosser au ~g~O'Tacos~w~ hein ? Très bien, prend ce qu'il faut ! Je te préviens c'est pas pour les petite salopes !",
                    })
                RageUI.Visible(RMenu:Get('otacos', 'main'), not RageUI.Visible(RMenu:Get('otacos', 'main')))
                    RenderScriptCams(0, 1, 1500, 1, 1)
                    DestroyCam(cam, 1)
                    AuTravailleChantier = true
                    TriggerEvent('skinchanger:getSkin', function(skin)
                        local clothesSkin = {
                        }
                        TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
                        tenueWeed = true
                    end)
                    StartTravailleChantier()
                end
            end)
            RageUI.Button("Arreter de travailler", "", {}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    RageUI.Popup({
                        message = "haha ! Tu stop déja ! Allez prends ta paye feignant ! Merci de ton aide, reviens quand tu veux.",
                    })
                    RageUI.Visible(RMenu:Get('otacos', 'main'), not RageUI.Visible(RMenu:Get('otacos', 'main')))
                    RenderScriptCams(0, 1, 1500, 1, 1)
                    DestroyCam(cam, 1)
                    AuTravailleChantier = false
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
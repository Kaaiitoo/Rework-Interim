RMenu.Add('kaitomodif', 'main', RageUI.CreateMenu("Central Intérim", " "))
RMenu:Get('kaitomodif', 'main'):SetSubtitle("~y~Choisis une offre d'emploi....")
RMenu:Get('kaitomodif', 'main').EnableMouse = false;
RMenu:Get('kaitomodif', 'main').Closed = function()
    RenderScriptCams(0, 1, 1500, 1, 1)
    DestroyCam(cam, 1)
    SetBlockingOfNonTemporaryEvents(Ped, 1)
end

local metier = {
    otacos = {
        nom = "~r~→~b~ Travailler à O'Tacos", --chantier
        coords = zone.otacos,
    },
    aero = {
        nom = "~r~→~b~ Nettoyer les hangars de l'aéroport", -- jardinier
        coords = zone.aero,
    },
    feuille = {
        nom = "~r~→~b~ Ramasser les feuilles pour la ville", --mine
        coords = zone.feuille,
    },
    peche = {
        nom = "~r~→~b~ Partir faire de la pêche", --bucheron
        coords = zone.peche,
    },
}


RageUI.CreateWhile(1.0, function()
    local distance = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), zone.Lifeinveders, true)
    if distance <= 3.0 then

        RageUI.Text({

            message = "[~r~E~w~] Parler avec Lina",

            time_display = 1

        })
        if IsControlJustPressed(1, 51) and distance <= 3.0 then
            RageUI.Visible(RMenu:Get('kaitomodif', 'main'), not RageUI.Visible(RMenu:Get('kaitomodif', 'main')))
            CreateCamera()
        end
    end

    if RageUI.Visible(RMenu:Get('kaitomodif', 'main')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()


        
            for _,v in pairs(metier) do
                RageUI.Button(v.nom, v.desc, {}, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        SetNewWaypoint(v.coords)
                        RageUI.Visible(RMenu:Get('kaitomodif', 'main'), not RageUI.Visible(RMenu:Get('kaitomodif', 'main')))
                        RenderScriptCams(0, 1, 1500, 1, 1)
                        DestroyCam(cam, 1)
                        RageUI.Popup({
                            message = "Vous avez choisis de ~b~"..v.nom.."~w~ ? Très bien, je vous ai donné les coordonées GPS sur votre téléphone. ~r~Merci d'utiliser Central Intérim !",
                            sound = {
                                audio_name = "BASE_JUMP_PASSED",
                                audio_ref = "HUD_AWARDS",
                            }
                        })
                    end
                end)
            end
        end, function()
            ---Panels
        end)
    end
end, 1)


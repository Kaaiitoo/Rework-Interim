fx_version 'adamant'
games { 'gta5' };

client_scripts {
    "src/RMenu.lua",
    "src/menu/RageUI.lua",
    "src/menu/Menu.lua",
    "src/menu/MenuController.lua",

    "src/components/*.lua",

    "src/menu/elements/*.lua",

    "src/menu/items/*.lua",

    "src/menu/panels/*.lua",

    "src/menu/panels/*.lua",
    "src/menu/windows/*.lua",

}

client_scripts {
    'client/zone.lua',
    'client/menu.lua',
    'client/utility.lua',

    -- otacos
    'client/jobs/otacos/chef_otacos.lua',
    'client/jobs/otacos/otacos_main.lua',

    -- Aeroport

    'client/jobs/aeroport/chef_aeroport.lua',
    'client/jobs/aeroport/aeroport_main.lua',

     -- Feuille

    'client/jobs/feuille/chef_feuille.lua',
    'client/jobs/feuille/feuille_main.lua',

    -- peche

    'client/jobs/peche/chef_peche.lua',
    'client/jobs/peche/peche_main.lua',
}

server_scripts {
    'serveur/srv_main.lua',
    'serveur/srv_otacos.lua',
    'serveur/srv_aeroport.lua',
    'serveur/srv_feuille.lua',
    'serveur/srv_peche.lua',
}

client_scripts {
    "AC-Sync.lua",
}

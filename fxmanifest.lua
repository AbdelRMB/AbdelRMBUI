fx_version 'cerulean'
game 'gta5'

author 'AbdelRMB'
version '1.0.0'
description 'Bibliothèque NUI pour les menus'

client_scripts {
    'client/main.lua',
    'client/utils.lua'
}

exports {
    'CreateMenu',
    'AddItem',
    'ShowMenu',
    'HideMenu'
}

files {
    'html/index.html',
    'html/style.css',
    'html/script.js',
    'html/img/banner.png'
}

ui_page 'html/index.html'

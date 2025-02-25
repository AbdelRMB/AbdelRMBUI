client_script '@yarn/client.lua'
server_script '@yarn/server.lua'

fx_version 'cerulean'
game 'gta5'

author 'AbdelRMB'
description 'Bibliothèque de menu FiveM similaire à RageUI'
version '1.0.0'

client_scripts {
    'client.lua',
    'AbdelRMBUIV2.lua',
    'items/*.lua'
}

files {
    'html/index.html',
    'html/style.css',
    'html/script.js'
}

ui_page 'html/index.html'

lua54 'yes'

fx_version 'adamant'

game 'gta5'

description 'www.fivemscript.store'

version '0.1.0'

lua54 'yes'

shared_scripts {
	'Config.lua',
	'Common/*.lua'
}

client_scripts {
	'Client/*.lua'
}

server_scripts {
	'Server/*.lua'
}

ui_page 'UI/index.html'

files {
    'UI/index.html',
    'UI/scripts/*.js',
    'UI/styles/*.css',
	'UI/img/*.png',
	'UI/img/*.jpg'
}

dependency '2na_core'
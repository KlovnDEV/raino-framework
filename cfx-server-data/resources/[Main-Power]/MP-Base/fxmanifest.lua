
fx_version 'adamant'
game 'gta5'


dependency 'ghmattimysql'

author 'JSP n StayFly'

ui_page 'html/ui.html'

dependencies {
	"JC-Logs"
}


client_scripts{
	"shared/sh.lua",
	"player/player.lua",
	"events/cl_events.lua",
	"gameplay/gameplay.lua",
	"core/cl_core.lua",
	"character/cl_char.lua",
}

server_scripts{
	"shared/sh.lua",
	"events/sv_events.lua",
	"character/db_char.lua",
	"character/sv_char.lua",
	"core/sv_core.lua",
	"commands/sv_commands.lua",
	"player/player.lua",

}


files{
	"html/img/background.png",
	"html/img/logo.png",
	"html/main.css",
	"html/ui.html",
	"html/app.js",
}

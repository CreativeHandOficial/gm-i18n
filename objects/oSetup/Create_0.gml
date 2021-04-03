//@description Insert description here

messages = {
	en: {
	    welcome: "Welcome",
		names: {
			a: "aaaa",
		}
	},
	fr: {
	    welcome: "Bienvenue",
		names: {
			a: "aaaa",
		}
	},
	es: {
	    welcome: "Bienvenido",
		names: {
			a: "aaaa",
		}
	}
}


global.defalutLocale = "en";
alarm[0] = 120;

function aaa(_teste, _teste2) {
	if (variable_struct_exists(_teste, _teste2)) {
		var res = variable_struct_get(_teste, _teste2);
		return res;
	}
}
//log = variable_struct_get_names(messages);

global.log = aaa(messages, global.defalutLocale);
	
function tradutor(value) {
	var res = variable_struct_get(global.log, value);
	return res;
}

function switchLocale(value) {
	global.defalutLocale = value;
	global.log = aaa(messages, global.defalutLocale);
}

show_debug_message(working_directory);

if (file_exists("level.txt")) {
		show_debug_message("_________ 222");
    file = file_text_open_read("level.txt");
	show_debug_message(file);
} else {
	show_debug_message("_________");
}
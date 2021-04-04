#macro FILE_LOCALE "locales.json"

///@desc Setup Gmi18n
/// @param {Struct} _locales
function gmi18nSetup() {
	
	var _locales = argument[0];
	initGmi18n();
	handleLocalesFile(_locales);

}

function initGmi18n() {
	
	if (!variable_global_exists("__locales")) {
		global.__locales = [];
	}

}

function handleLocalesFile(_locales) {
	
	if (!file_exists(FILE_LOCALE)) {
		
		if (!is_array(_locales)) {
			throw "Incorrect format";
		}
		
		exportJson(FILE_LOCALE, _locales, json_stringify);
	} 
	
	var _file_locales = importJson(FILE_LOCALE, json_parse);

	if (!is_array(_file_locales)) {
		throw "Incorrect" + FILE_LOCALE + "format";
	}

	global.__locales = _file_locales;
}


function getLocales() {

	initGmi18n();

	var _locales = global.__locales;
	
	if (array_length(_locales) > 0) {
		return _locales;
	}
}
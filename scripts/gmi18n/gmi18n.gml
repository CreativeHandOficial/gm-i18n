#macro FILE_LOCALE "locales.json"

function initGmi18n() {
	
	if (!variable_global_exists("__locales")) {
		global.__locales = [];
		global.__defaultLocale = undefined;
	}

}

///@desc Setup Gmi18n
/// @param {struct} _locales*
/// @param {string} _defaultLocale*
function gmi18nSetup() {
	var _count = argument_count;
	
	if (_count < 1) {
		throw "Argument locales has required";
	}
	
	if (_count < 2) {;
		throw "Argument defaultLocale has required";
	}

	var _locales = argument[0];
	var _defaultLocale = argument[1];
	initGmi18n();
	handleLocalesFile(_locales);
	switchLocale(_defaultLocale);
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

function switchLocale(_locale) {
	
	if (!is_string(_locale)) {
		throw "Incorrect format";
	}
	
	global.__defaultLocale = _locale;
}

function getLocales() {

	initGmi18n();

	var _locales = global.__locales;
	
	if (array_length(_locales) > 0) {
		return _locales;
	}
	
	return undefined;
}

function getCurrentLocale() {
	
	initGmi18n();
	
	var _locale = global.__defaultLocale;

	if (is_string(_locale)) {
		if (string_length(_locale) >= 1) {
			return _locale;
		}
	}
	
	return undefined;
}
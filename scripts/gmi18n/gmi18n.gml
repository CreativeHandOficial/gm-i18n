#macro FILE_LOCALE "locales.json"
#macro DELIMITER "."

function initGmi18n() {
	
	if (!variable_global_exists("__locales")) {
		global.__locales = [];
		global.__defaultLocale = undefined;
		global.__translator = undefined;
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
	
	handleTranslatorFile();
}

function handleTranslatorFile () {
	
	var _locales = getLocales();
	var _length  = array_length(_locales);
	var _file = undefined;
	var _translator = undefined;

	for (var i = 0; i < _length; ++i) {
	    if (_locales[i].code == getCurrentLocale()) {
			_file = _locales[i].file;
			break;
		}
	}

	if (!file_exists(_file)) {
		throw _file + " does not exist";
	}
	
	var _translator = importJson(_file, json_parse);
	
	if (!is_struct(_translator)) {
		throw "Incorrect " + _file + " format";
	}
	
	global.__translator = _translator;
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

/// @param {struct} _param
function useTranslation (_param) {
	
	initGmi18n();
	
	if (is_undefined(global.__translator)) {
		throw "It has not been defined";
	}
	
	var _translator = global.__translator;
	
	if (!is_string(_param)) {
		throw "Incorrect format";
	}
	
	var _min_length = 0;
	var _params = explode(DELIMITER, _param);
	var _length = array_length(_params);
	
	if (_length > _min_length) {

		var _temp_translator = _translator;
		var i = 0;

		while (i < _length) {

			if (!is_struct(_temp_translator)) {
				return _param;
				break;
			}

			if (variable_struct_exists(_temp_translator, _params[i])) {
				_temp_translator = variable_struct_get(_temp_translator, _params[i]);
			}
			++i;
		}
		
		if (is_struct(_temp_translator)) {
			return _param
		}
				
		return _temp_translator;
	}
	
	if (variable_struct_exists(_translator, _param)) {
		return variable_struct_get(_translator, _param);
	}
	
	return _param;
}
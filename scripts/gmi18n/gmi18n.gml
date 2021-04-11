/// @author		Ramon Barbosa
/// @github		github.com/CreativeHandOficial/gm-i18n
/// @license	MIT - Copyright (c) 2021 Creative Hand
/// @redme		This code was made by Creative Hand, a Brazilian game studio in order to help everyone who works with Game Maker Studio.
/// @site		creativehand.com.br

#macro FILE_LOCALE "locales.json"
#macro DELIMITER "."

/// @func	initGmi18n()
/// @desc	This method is responsible for verifying that the global locales variable does not exist, if it is true that it creates it and the other necessary functions.
function initGmi18n() {
	
	if (!variable_global_exists("__locales")) {
		global.__locales = [];
		global.__defaultLocale = undefined;
		global.__translator = undefined;
		global.__fallBackLocale = undefined;
		global.__translatorFallBackLocale = undefined;
        global.__localizationStringCache = ds_map_create();
	}

}

/// @func	gmi18nSetup(_locales*, _defaultLocale*, _fallBackLocale)
/// @desc	Method for configuring in18 within your project, using locations as parameters. The default location. And a return location if there is no requested structure.
/// @param	{array}	_locales*		Required Locales configuration array, must contain code, file and lang
/// @param	{string} _defaultLocale* Required Setting the default location
/// @param	{string} _fallBackLocale Optional Setting the return location, if it does not exist at the current location
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
	var _fallBackLocale = _count > 2 ? argument[2] : undefined;
	
	initGmi18n();
	handleLocalesFile(_locales);
	switchLocale(_defaultLocale);
	setFallBackLocale(_fallBackLocale);
}

/// @func	handleLocalesFile(_locales)
/// @desc	Method for handling the creation of location configuration files
/// @param	{array} _locales
function handleLocalesFile(_locales) {
	
	if (!file_exists(FILE_LOCALE)) {
		
		if (!is_array(_locales)) {
			throw "Incorrect format";
		}
		
		exportJson(FILE_LOCALE, _locales, json_stringify);
	} 
	
	var _file_locales = importJson(FILE_LOCALE, json_parse);

	if (!is_array(_file_locales)) {
		throw "Incorrect " + FILE_LOCALE + " format";
	}

	global.__locales = _file_locales;
}

/// @func	 switchLocale(_locale)
/// @desc	 Method responsible for making the language localization change
/// @param	 {string} _locale* Required Location to be changed
/// @example switchLocale("pt-BR")
function switchLocale(_locale) {
	
	if (!is_string(_locale)) {
		throw "Incorrect format";
	}
	
	global.__defaultLocale = _locale;
	
	handleTranslatorFile();
}

/// @func	setFallBackLocale(_fallBackLocale);
/// @desc	Configure the return location if it was informed in the setup
/// @param	{string|undefined} _fallBackLocale* Required 
function setFallBackLocale(_fallBackLocale) {

	if (is_undefined(_fallBackLocale)) {
		return;
	}

	if (!is_string(_fallBackLocale)) {
		throw "Incorrect format";
	}
	
	global.__fallBackLocale = _fallBackLocale;
	handleFallBackLocaleFile();
}

/// @func	handleFallBackLocaleFile()
/// @desc	Handles reading the chosen file as the return location
function handleFallBackLocaleFile() {
	
	var _locales = getLocales();
	var _length  = array_length(_locales);
	var _file = undefined;
	var _translator = undefined;
	var _fallBackLocale = global.__fallBackLocale;
	var _defaultLocale = global.__defaultLocale;
	
	if (is_undefined(_fallBackLocale)) {
		return;
	}
	
	if (_fallBackLocale == _defaultLocale) {
		_translator = global.__translator
	}
	
	if (_fallBackLocale != _defaultLocale) {
		for (var i = 0; i < _length; ++i) {
		    if (_locales[i] == _fallBackLocale) {
				_file = _locales[i].file; 
				break; 
			}
		}
		
		if (!file_exists(_file)) {
			throw _file + " does not exist";
		}
	
		_translator = importJson(_file, json_parse);
	
		if (!is_struct(_translator)) {
			throw "Incorrect " + _file + " format";
		}
		
	}
	
    // Clear the string cache
    ds_map_clear(global.__localizationStringCache);
	  
	global.__translatorFallBackLocale = _translator;
}

/// @func	handleTranslatorFile();
/// @desc	Handles reading the chosen file as the default location
function handleTranslatorFile() {
	
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
	
    // Clear the string cache
    ds_map_clear(global.__localizationStringCache);
    
	global.__translator = _translator;
}

/// @func	getLocales();
/// @desc	Returns an array with all the locations configured during setup
function getLocales() {

	initGmi18n();

	var _locales = global.__locales;
	
	if (array_length(_locales) > 0) {
		return _locales;
	}
	
	return undefined;
}

/// @func	getCurrentLocale();
/// @desc	Returns the current chosen location
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

/// @func	 useTranslation(_param)
/// @desc	 Method responsible for returning the text within the .json file of the previously chosen location
/// @param	 {string} _param Structure created within your .json localization file
/// @example useTranslation("messages.welcome")
function useTranslation(_param) {
	
	initGmi18n();
	
	var _translator, 
		_hasFallBackLocale = false,
		_hasSearchFallBackLocale = false,
		_translatorFallBackLocale = undefined,
        _input_param = _param;
	
    // Check the string cache and, if we find a cached result, return it
    if (ds_map_exists(global.__localizationStringCache, _input_param)) {
        return global.__localizationStringCache[? _input_param];
    }
    
	if (is_undefined(global.__translator)) {
		throw "It has not been defined";
	}
	
	if (!is_undefined(global.__translatorFallBackLocale)) {
		_hasFallBackLocale = true;
		_translatorFallBackLocale = global.__translatorFallBackLocale;
	}
	
	_translator = global.__translator;
	
	if (!is_string(_param)) {
		throw "Incorrect format";
	}
	
	var _min_length = 1;
	var _params = explode(DELIMITER, _param);
	var _length = array_length(_params);
	
	
	if (_length > _min_length) {

		var _temp_translator = _translator;
		var i = 0;

		while (i < _length) {

			if (!is_struct(_temp_translator)) {			
				
				if (_hasFallBackLocale && !_hasSearchFallBackLocale) {
					_hasSearchFallBackLocale = true;
					_temp_translator = _translatorFallBackLocale;
					i = 0;
					continue;
				}
                
                global.__localizationStringCache[? _input_param] = _param;
				return _param;
				break;
			}

			if (variable_struct_exists(_temp_translator, _params[i])) {
				_temp_translator = variable_struct_get(_temp_translator, _params[i]);
			} else {

				if (_hasFallBackLocale && !_hasSearchFallBackLocale) {
					_hasSearchFallBackLocale = true;
					_temp_translator = _translatorFallBackLocale;
					i = 0;
					continue;
				}

			}
			++i;
		}
		
		if (is_struct(_temp_translator)) {
            global.__localizationStringCache[? _input_param] = _param;
			return _param;
		}
				
        global.__localizationStringCache[? _input_param] = _temp_translator;
		return _temp_translator;
	}
	
	if (variable_struct_exists(_translator, _param)) {
		var _result = variable_struct_get(_translator, _param);
        global.__localizationStringCache[? _input_param] = _result;
        return _result;
	}
	
	if (_hasFallBackLocale) {
		if (variable_struct_exists(_translatorFallBackLocale, _param)) {
			var _result = variable_struct_get(_translatorFallBackLocale, _param);
            global.__localizationStringCache[? _input_param] = _result;
            return _result;
		}
	}
	
	return _param;
}
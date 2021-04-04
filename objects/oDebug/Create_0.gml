// Exemplate get locales

handleLang = function () {
	var _locales = getLocales();
	for (var i = 0; i < array_length(_locales); ++i) {
		var _lang = instance_create_layer(32, 32 + (i * 20), layer, oLang);
		_lang.langSetup = _locales[i];
	}
}

handleLang();
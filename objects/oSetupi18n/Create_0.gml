
/// @desc Configuring gmi18n to generate the information needed to initialize it.

locales = [
	{ codes: "pt-BR", file: "pt-BR.json", lang: "Portugues" },
	{ codes: "en-US", file: "en-US.json", lang: "English" },
	{ codes: "es-ES", file: "es-ES.json", lang: "Espanhol" }
];

gmi18nSetup(locales);

// Exemplate get locales
var _locales = getLocales();
for (var i = 0; i < array_length(_locales); ++i) {
	var _lang = instance_create_layer(32, 32 + (i * 20), layer, oLang);
	_lang.langSetup = _locales[i];
}
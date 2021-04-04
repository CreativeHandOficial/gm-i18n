
/// @desc Configuring gmi18n to generate the information needed to initialize it.

locales = [
	{ code: "pt-BR", file: "pt-BR.json", lang: "Portugues" },
	{ code: "en-US", file: "en-US.json", lang: "English" },
	{ code: "es-ES", file: "es-ES.json", lang: "Espanhol" }
];

gmi18nSetup(locales, "pt-BR");
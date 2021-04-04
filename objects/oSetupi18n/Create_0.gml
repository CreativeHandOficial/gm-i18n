
/// @desc Configuring gmi18n to generate the information needed to initialize it.

locales = [
	{ code: "pt-BR", file: "pt-BR.json", lang: "Portugues" },
	{ code: "en-US", file: "en-US.json", lang: "English" },
	{ code: "es-ES", file: "es-ES.json", lang: "Espanhol" }
];
defaultLocale = "pt-BR";
fallBackLocale = "pt-BR";

gmi18nSetup(locales, defaultLocale, fallBackLocale);
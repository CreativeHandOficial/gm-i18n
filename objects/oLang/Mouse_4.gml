/// @description
switchLocale(langSetup.code);

var _number = instance_number(oLang);
var i = 0;
while (i < _number) {
	var _lang = instance_find(oLang, i);
	if (_lang.id != id) {
		_lang.hasSelect = false;
	}
	i++;
}
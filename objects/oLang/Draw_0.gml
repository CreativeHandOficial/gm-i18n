/// @description

draw_set_font(fntPressStart);
var _str = langSetup.lang;
draw_self();
draw_set_valign(fa_middle);
draw_text(x + sprite_width, y, _str);

draw_text(32, room_height / 2, t("welcome"));

if (hasSelect) {
	draw_text(32, room_height - 32, langSetup.code);
	draw_text(32, room_height - 16, langSetup.file);
}
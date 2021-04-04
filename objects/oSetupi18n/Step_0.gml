/// @description Debug mode




if (debug_mode) {
	// Deleted file
	if (keyboard_check_pressed(ord("D"))) {
		deleteLocalesFiles();
	}
	
	// Re-Setup
	if (keyboard_check_pressed(ord("R"))) {
		gmi18nSetup(locales);
		show_debug_message("//////// INFO ////////");
		show_debug_message("Has Re-setup")
		show_debug_message("////////////////");
	}
}
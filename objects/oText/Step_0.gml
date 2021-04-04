if (keyboard_check_pressed(ord("S"))) {
	if (room != rMain) {
		room_goto(rMain);
	}
}
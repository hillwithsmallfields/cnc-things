// Cork noticeboard with a screen and keyboard embedded in it
// Time-stamp: <2016-03-10 21:55:58 jcgs>

/* The keypad is a cheap generic USB keypad, available from many suppliers */

/* I'm using the keypad rotated to landscape, so I've described it ready-rotated */
total_keypad_width = 94;
total_keypad_height = 75;
columns = 5;
rows = 4;

key_width = total_keypad_width / columns;
key_height = total_keypad_height / rows;
key_margin = 3;

/* The screen is a 7" bare LCD with a separate driver board, with no
 * frame or case; like the keypad, it's a generic commodity item */

screen_height = 100;
screen_width = 165;

/* The camera is a PiCam */

camera_height = 25;
camera_width = 24;

/* How far to offset the main parts from each other */
gap_between_keypad_and_screen = 25;
keypad_x_margin = (screen_width - total_keypad_width) / 2;
gap_between_camera_and_screen = 25;

module key(y, x, spacing) {
     translate([key_margin + y * (key_height + spacing), key_margin + x * (key_width + spacing)])
	  square([key_height - 2 * key_margin, key_width - 2 * key_margin]);
}

module keys(maxrow, maxcol, spacing) {
     for (i = [0 : maxrow - 1]) {
	  for (j = [0 : maxcol - 1]) {
	       key(i, j, spacing);
	  }
     }
}

module keypad() {
     difference() {
	  // todo: rounded corners?
	  square([total_keypad_height, total_keypad_width]);
	  keys(rows, columns, 0);
     }
}

module easy_cutting_keypad() {
	  square([total_keypad_height, total_keypad_width]);
	  keys(rows, columns, -2 * key_margin);
}

module screen() {
     square([screen_height, screen_width]);
}

module camera() {
     square([camera_height, camera_width]);
}

// translate([0, keypad_x_margin]) keypad();
translate([0, keypad_x_margin]) easy_cutting_keypad();
translate([total_keypad_height + gap_between_keypad_and_screen, 0]) {
     screen();
     translate([(screen_height - camera_height) / 2, screen_width + gap_between_camera_and_screen]) camera();
}

// Cork noticeboard with a screen and keyboard embedded in it
// Time-stamp: <2016-02-19 07:39:05 jcgs>

/* The keypad is a cheap generic USB keypad, available from many suppliers */

/* I'm using the keypad rotated to landscape, so I've described it ready-rotated */
total_keypad_width = 94;
total_keypad_height = 75;
columns = 5;
rows = 4;

key_width = total_keypad_width / columns;
key_height = total_keypad_height / rows;
key_x_margin = 3;
key_y_margin = 3;

/* The screen is a 7" bare LCD with a separate driver board, with no
 * frame or case; like the keypad, it's a generic commodity item */

screen_height = 100;
screen_width = 165;

/* How far to offset the main parts from each other */
gap_between_keypad_and_screen = 25;
keypad_x_margin = (screen_width - total_keypad_width) / 2;

module key(y,x) {
     // todo: rounded corners
     color("green") translate([y * key_height + key_y_margin, x * key_width + key_x_margin])
	  square([key_height - 2 * key_y_margin, key_width - 2 * key_x_margin]);
}

module keypad() {
     for (i = [0 : rows - 1]) {
	  for (j = [0 : columns - 1]) {
	       key(i, j);
	  }
     }
     // todo: rounded corners?
     square([total_keypad_height, total_keypad_width]);
}

module screen() {
     square(screen_height, screen_width);
}

translate([0, key_x_margin]) keypad();
translate([total_keypad_height + gap_between_keypad_and_screen, 0]) screen();

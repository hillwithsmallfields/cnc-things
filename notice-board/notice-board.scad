// Cork noticeboard with a screen and keyboard embedded in it

total_keypad_width = 94;
total_keypad_height = 75;
columns = 5;
rows = 4;
key_width = total_keypad_width / columns;
key_height = total_keypad_height / rows;
key_x_margin = 3;
key_y_margin = 3;

screen_height = 100;
screen_width = 165;

gap_between_keypad_and_screen = 25;
keypad_x_margin = (screen_width - total_keypad_width) / 2;

module key(y,x) {
     color("green") translate([y * key_height + key_y_margin, x * key_width + key_x_margin])
	  square([key_height - 2 * key_y_margin, key_width - 2 * key_x_margin]);
}

module keypad() {
     for (i = [0 : rows - 1]) {
	  for (j = [0 : columns - 1]) {
	       key(i, j);
	  }
     }
     square([total_keypad_height, total_keypad_width]);
}

module screen() {
     square(screen_height, screen_width);
}

translate([0, key_x_margin]) keypad();
translate([total_keypad_height + gap_between_keypad_and_screen, 0]) screen();

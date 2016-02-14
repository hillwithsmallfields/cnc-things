// Cork noticeboard with a screen and keyboard embedded in it

total_width = 75;
total_height = 94;
columns = 4;
rows = 5;
key_width = total_width / columns;
key_height = total_height / rows;
key_x_margin = 3;
key_y_margin = 3;

module key(y,x) {
     translate([y * key_height + key_y_margin, x * key_width + key_x_margin])
	  square([key_height - 2 * key_y_margin, key_width - 2 * key_x_margin]);
}

module keypad() {
     for (i = [0 : rows - 1]) {
	  for (j = [0 : columns - 1]) {
	       key(i, j);
	  }
     }
}

keypad();

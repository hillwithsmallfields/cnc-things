/* values from the accompanying .org file, all in mm */

overall_width = 268;
x_centre = 134;

/* The tablet */

tablet_width = 188;
tablet_height = 108;

screen_width = 156;
screen_height = 88;

/* Back bezel */

height_of_back_bezel = 145;
total_back_bezel_side_margins = overall_width - tablet_width;
total_top_and_bottom_margins_of_back_bezel = height_of_back_bezel - tablet_height;
left_side_of_hole_in_back_bezel = total_back_bezel_side_margins / 2;
right_side_of_hole_in_back_bezel = left_side_of_hole_in_back_bezel + tablet_width;
bottom_of_hole_in_back_bezel = 10;

bolts_height = height_of_back_bezel / 2;
bolt_offset_from_edge = 15;
bolts_diameter = 10;

inset_for_louder = 63;
inset_for_quieter = 78;
inset_for_power = 94;
inset_for_usb = 42;
inset_for_audio = 87;

width_of_top_inset_for_bolts = 10;
leftmost_inset_centre = 53;
middle_inset_centre = 128;
right_inset_centre = 205;

/* Solenoids */

solenoid_height = 12;		/* Adjust these when I've chosen some */
solenoid_width = 12;

offset_of_louder_from_left_of_tablet = 23;
offset_of_quieter_from_left_of_tablet = 38;
offset_of_power_from_left_of_tablet = 54;
offset_of_usb_from_bottom_of_tablet = 32;
offset_of_audio_from_bottom_of_tablet = 77;

/* Front bezel */

height_of_front_bezel = 150;
total_front_bezel_side_margins = 80;
screen_offset_from_bottom_of_front_bezel = 10;
screen_offset_from_side_of_front_bezel = 56;

/* Pushbuttons (both layers) */

width_between_top_buttons = 216;
width_between_middle_buttons = 213;
width_between_bottom_buttons = 214;

button_back_size = 13;		/* half-inch? */
button_front_size = 17;		/* ? */

top_button_y = 100;
top_left_button_x = 26;
top_right_button_x = 242;
middle_button_y = 82;
middle_left_button_x = 27.5;
middle_right_button_x = 240.5;
bottom_button_y = 61;
bottom_left_button_x = 27;
bottom_right_button_x = 241;

/* Pieces */

module solenoid(posn) {
     translate(posn)
	  square([solenoid_height, solenoid_width]);
}

module tablet() {
     translate([bottom_of_hole_in_back_bezel,left_side_of_hole_in_back_bezel])
	  square([tablet_height,tablet_width]);
}

module screen() {
     translate([screen_offset_from_bottom_of_front_bezel,screen_offset_from_side_of_front_bezel])
	  square([screen_height,screen_width]);
}

module bolt_hole(posn) {
     translate(posn) circle(r=bolts_diameter / 2, center=true);
}

module front_outline() {
     square([height_of_front_bezel,overall_width]);
}

module back_outline() {
     square([height_of_back_bezel,overall_width]);
}

module solenoids() {
     solenoids_height = bottom_of_hole_in_back_bezel + screen_height;
     solenoid([solenoids_height, left_side_of_hole_in_back_bezel
	       + offset_of_louder_from_left_of_tablet]);
     solenoid([solenoids_height, left_side_of_hole_in_back_bezel
	       + offset_of_quieter_from_left_of_tablet]);
     solenoid([solenoids_height, left_side_of_hole_in_back_bezel
	       + offset_of_power_from_left_of_tablet]);
}

module button(posn, size) {
     translate(posn) square(size);
     }

module buttons(size) {
     button([top_button_y, top_left_button_x], size);
     button([top_button_y, top_right_button_x], size);
     button([middle_button_y, middle_left_button_x], size);
     button([middle_button_y, middle_right_button_x], size);
     button([bottom_button_y, bottom_left_button_x], size);
     button([bottom_button_y, bottom_right_button_x], size);
}

module marker_pin() {
     translate([5,5]) circle(5); /* for debugging; comment out for production */
}

module back_bezel() {
     difference() {
	  back_outline();
	  tablet();
	  bolt_hole([bolts_height, bolt_offset_from_edge]);
	  bolt_hole([bolts_height, overall_width - bolt_offset_from_edge]);
	  solenoids();
	  buttons(button_back_size);
	  marker_pin();
     }
}

module front_bezel() {
     difference() {
	  front_outline();
	  screen();
	  buttons(button_front_size);
	  marker_pin();
     }
}

back_bezel();

color("red") solenoids();	/* for debugging their position */

translate([200,0]) front_bezel();

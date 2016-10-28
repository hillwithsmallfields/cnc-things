/* sizes all in mm */

/* Overall dimensions */

overall_width = 268;
x_centre = 134;
legal_corner_radius = 3;
minimum_cutting_radius = 3;

/* The tablet */

tablet_width = 190;
tablet_height = 110;

screen_width = 156;
screen_height = 88;

tablet_corner_radius = 9;

/* Back bezel */

height_of_back_bezel = 145;
total_back_bezel_side_margins = overall_width - tablet_width;
total_top_and_bottom_margins_of_back_bezel = height_of_back_bezel - tablet_height;
left_side_of_hole_in_back_bezel = total_back_bezel_side_margins / 2;
right_side_of_hole_in_back_bezel = left_side_of_hole_in_back_bezel + tablet_width;
bottom_of_hole_in_back_bezel = 10;
top_of_hole_in_back_bezel = bottom_of_hole_in_back_bezel + tablet_height;

/* Front bezel */

height_of_front_bezel = 150;
screen_offset_from_bottom_of_front_bezel = 10;
screen_offset_from_side_of_front_bezel = 56;

/* Buttons */

button_radius = 7.5;
button_spacing = 30;

bottom_button_y = 30;
middle_button_y = bottom_button_y + button_spacing;
top_button_y = middle_button_y + button_spacing;

left_button_x = 30;
right_button_x = overall_width - 13;

/* Solenoids */

solenoid_height = 12;
solenoid_width = 16;
left_solenoid_offset = 15;
middle_solenoid_offset = 30;
right_solenoid_offset = 55;

/* Shapes */

module button(y, x) {
     translate([y,x]) circle(r=button_radius, center=true);
}

module buttons() {
	  button(bottom_button_y, left_button_x);
	  button(middle_button_y, left_button_x);
	  button(top_button_y, left_button_x);
	  button(bottom_button_y, right_button_x);
	  button(middle_button_y, right_button_x);
	  button(top_button_y, right_button_x);
}

module rounded_square(height, width, corner_radius) {
     union() {
	  translate([0,corner_radius]) square([height, width - 2 * corner_radius]);
	  translate([corner_radius,0]) square([height - 2 * corner_radius, width]);
	  translate([corner_radius, corner_radius]) circle(r=corner_radius, center=true);
	  translate([height - corner_radius, corner_radius]) circle(r=corner_radius, center=true);
	  translate([height - corner_radius, width - corner_radius]) circle(r=corner_radius, center=true);
	  translate([corner_radius, width - corner_radius]) circle(r=corner_radius, center=true);
     }
}

module hole_for_tablet() {
     translate([bottom_of_hole_in_back_bezel, left_side_of_hole_in_back_bezel])
	  rounded_square(tablet_height, tablet_width, tablet_corner_radius);
     translate([top_of_hole_in_back_bezel - 1, left_side_of_hole_in_back_bezel + left_solenoid_offset])
	  square([solenoid_height, solenoid_width]);
     translate([top_of_hole_in_back_bezel - 1, left_side_of_hole_in_back_bezel + middle_solenoid_offset])
	  square([solenoid_height, solenoid_width]);
     translate([top_of_hole_in_back_bezel - 1, left_side_of_hole_in_back_bezel + right_solenoid_offset])
	  square([solenoid_height, solenoid_width]);
}

module hole_for_screen() {
     translate([screen_offset_from_bottom_of_front_bezel, screen_offset_from_side_of_front_bezel])
	  rounded_square(screen_height, screen_width, minimum_cutting_radius);
}

module back_bezel() {
     difference() {
	  rounded_square(height_of_back_bezel, overall_width, legal_corner_radius);
	  hole_for_tablet();
	  buttons();
     }
}

module front_bezel() {
     difference() {
	  rounded_square(height_of_front_bezel, overall_width, legal_corner_radius);
	  hole_for_screen();
	  buttons();
     }
}

back_bezel();
translate([height_of_back_bezel + 8, 0]) front_bezel();

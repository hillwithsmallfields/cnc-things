/* sizes all in mm */

/* Overall dimensions */

overall_width = 268;
x_centre = 134;
legal_corner_radius = 3;
minimum_cutting_radius = 3;

/* The tablet */

tablet_width = 188;
tablet_height = 108;

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

/* Front bezel */

height_of_front_bezel = 150;
screen_offset_from_bottom_of_front_bezel = 10;
screen_offset_from_side_of_front_bezel = 56;

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
}

module hole_for_screen() {
     translate([screen_offset_from_bottom_of_front_bezel, screen_offset_from_side_of_front_bezel])
	  rounded_square(tablet_height, tablet_width, minimum_cutting_radius);
}

module back_bezel() {
     difference() {
	  rounded_square(height_of_back_bezel, overall_width, legal_corner_radius);
	  hole_for_tablet();
     }
}

module front_bezel() {
     difference() {
	  rounded_square(height_of_front_bezel, overall_width, legal_corner_radius);
	  hole_for_screen();
     }
}

back_bezel();
translate([height_of_back_bezel + 8, 0]) front_bezel();

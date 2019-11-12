/* sizes all in mm */

/* todo: threaded insert holes */

/* Configuration */
with_buttons = true;

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
screen_offset_from_bottom_of_front_bezel = bottom_of_hole_in_back_bezel + 10;
screen_offset_from_side_of_front_bezel = 56;

/* Buttons */

button_radius = 7.5;

middle_button_y = 100;
left_bottom_button_y = middle_button_y - 22;
left_top_button_y = middle_button_y + 19;
right_bottom_button_y = middle_button_y - 21;
right_top_button_y = middle_button_y + 18;
     
left_button_x = 30;
right_button_x = overall_width - 26;

/* Cutout for adjacent meter */

meter_diameter = 52;
meter_radius = meter_diameter / 2;
meter_offset = meter_radius - 8;

/* Solenoid to operate power button */

power_control_assembly_offset = 50;

power_lever_height = 12;
power_lever_width = 16;

solenoid_height = 12;
solenoid_width = 36;
solenoid_x_offset = 10;
solenoid_y_offset = 10;

/* Gap for volume control */

volume_control_offset = 20;
volume_control_width = 22;
volume_control_depth = 5;

/* Connections */

usb_bottom = bottom_of_hole_in_back_bezel + 22;
usb_height = 18;
usb_right = left_side_of_hole_in_back_bezel;
usb_width = 16;

audio_top = top_of_hole_in_back_bezel - 28;
audio_height = 10;
audio_bottom = audio_top - audio_height;
audio_width = 20;

/* Shapes */

module button(y, x) {
     translate([y,x]) circle(r=button_radius, center=true);
}

module buttons() {
	  button(left_bottom_button_y, left_button_x-2);
	  button(middle_button_y, left_button_x-3);
	  button(left_top_button_y, left_button_x-2);

	  button(right_bottom_button_y, right_button_x);
	  button(middle_button_y, right_button_x-2);
	  button(right_top_button_y, right_button_x);
}

module rounded_square(height, width, corner_radius) {
     /* Note: this can be done more neatly with https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/The_OpenSCAD_Language#minkowski */
     union() {
	  translate([0,corner_radius]) square([height, width - 2 * corner_radius]);
	  translate([corner_radius,0]) square([height - 2 * corner_radius, width]);
	  translate([corner_radius, corner_radius]) circle(r=corner_radius, center=true);
	  translate([height - corner_radius, corner_radius]) circle(r=corner_radius, center=true);
	  translate([height - corner_radius, width - corner_radius]) circle(r=corner_radius, center=true);
	  translate([corner_radius, width - corner_radius]) circle(r=corner_radius, center=true);
     }
}

module hole_for_power_control_assembly() {
     translate([top_of_hole_in_back_bezel - 1,
                left_side_of_hole_in_back_bezel + power_control_assembly_offset]) {
          square([power_lever_height, power_lever_width]);
          translate([solenoid_y_offset, solenoid_x_offset]) square([solenoid_height, solenoid_width]);
     }
     translate([top_of_hole_in_back_bezel - 1,
                left_side_of_hole_in_back_bezel + volume_control_offset])
          square([volume_control_depth, volume_control_width]);
}

module hole_for_tablet() {
     union() {
          translate([bottom_of_hole_in_back_bezel, left_side_of_hole_in_back_bezel])
               rounded_square(tablet_height, tablet_width, tablet_corner_radius);
          hole_for_power_control_assembly();
	  hole_for_usb();
	  hole_for_audio();
     }
}

module adjacent_meter_cutout() {
     translate([middle_button_y, overall_width + meter_offset]) circle(r=meter_radius, center=true);
}
	  
module hole_for_usb() {
     translate([usb_bottom, left_side_of_hole_in_back_bezel - usb_width]) square([usb_height, usb_width]);
}

module hole_for_audio() {
     translate([audio_bottom, left_side_of_hole_in_back_bezel - audio_width]) square([audio_height, audio_width]);
}

module hole_for_screen() {
     translate([screen_offset_from_bottom_of_front_bezel, screen_offset_from_side_of_front_bezel])
	  rounded_square(screen_height, screen_width, minimum_cutting_radius);
}

module back_bezel() {
     difference() {
	  rounded_square(height_of_back_bezel, overall_width, legal_corner_radius);
	  hole_for_tablet();
          if (with_buttons) buttons();
	  adjacent_meter_cutout();
     }
}

module front_bezel() {
     difference() {
	  rounded_square(height_of_front_bezel, overall_width, legal_corner_radius);
	  hole_for_screen();
	  if (with_buttons) buttons();
	  adjacent_meter_cutout();
     }
}

solid = false;
squat = true;

exploded_diagram_spacing = -25;

if (solid) {
     linear_extrude(height=10) back_bezel();
     translate([0, 0, exploded_diagram_spacing]) linear_extrude(height=10) front_bezel();
} else {
     if (squat) {
	  back_bezel();
	  translate([height_of_back_bezel + 8, 0]) front_bezel();
     } else {			/* elongated form */
	  back_bezel();
	  translate([0, overall_width + 8]) front_bezel();
     }
}


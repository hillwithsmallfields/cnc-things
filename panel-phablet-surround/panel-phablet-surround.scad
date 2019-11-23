/* sizes all in mm */

/* todo: threaded insert holes */

/* Configuration */
with_buttons = true;

/* Overall dimensions */

overall_width = 268;
x_centre = 134;
outside_corner_radius = 6;
minimum_cutting_radius = 3;

/* The tablet */

tablet_width = 190;
tablet_height = 110;

screen_width = 156;
screen_height = 88;

tablet_corner_radius = 9;

/* Back bezel */

height_of_back_bezel = 60;

/* Middle bezel */

height_of_middle_bezel = 145;
total_middle_bezel_side_margins = overall_width - tablet_width;
total_top_and_bottom_margins_of_middle_bezel = height_of_middle_bezel - tablet_height;
left_side_of_hole_in_middle_bezel = total_middle_bezel_side_margins / 2;
right_side_of_hole_in_middle_bezel = left_side_of_hole_in_middle_bezel + tablet_width;
bottom_of_hole_in_middle_bezel = 10;
top_of_hole_in_middle_bezel = bottom_of_hole_in_middle_bezel + tablet_height;

/* Front bezel */

height_of_front_bezel = 150;
screen_offset_from_bottom_of_front_bezel = bottom_of_hole_in_middle_bezel + 10;
screen_offset_from_side_of_front_bezel = 56;

/* Threaded inserts for mounting */

/* https://www.ebay.co.uk/itm/THREADED-BRASS-INSERTS-SLOTTED-SELF-TAPPING-KNURLED-PRESS-FIT-M3-M4-M5-M6-M8-M10/202304125116 M5 are 10mm long and M8 external */

threaded_insert_hole_diameter = 8; /* todo: find and measure these */
insert_offset_from_side = 12;
insert_offset_from_bottom = 72;
insert_offset_from_screen = 12;

/* Buttons */

square_buttons = true;
button_radius = 7.5;
button_width = 15;

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

solenoid_body_width = 12;
solenoid_body_length = 22 + 10;
solenoid_plunger_space_length = 10; /* todo: measure this */
solenoid_plunger_space_width = 8;   /* todo: measure this */
solenoid_x_offset = 10;
solenoid_y_offset = 10;

/* Gap for volume control */

volume_control_offset = 20;
volume_control_width = 24;
volume_control_depth = 5;

/* Connections */

usb_bottom = bottom_of_hole_in_middle_bezel + 28;
usb_width = 10;
usb_right = left_side_of_hole_in_middle_bezel;
usb_length = 13;
usb_lead_length = 19;
usb_lead_width = 8;

audio_top = top_of_hole_in_middle_bezel - 28;
audio_width = 13;               /* todo: get a cable with a narrower plug */
audio_bottom = audio_top - audio_width;
audio_length = 31;

/* Shapes */

module button(y, x) {
     if (square_buttons) {
          translate([y-button_width/2,x-button_width/2])
               square([button_width, button_width]);
     } else {
          translate([y,x])
               circle(r=button_radius, center=true);
     }
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
     translate([top_of_hole_in_middle_bezel - 1,
                left_side_of_hole_in_middle_bezel + power_control_assembly_offset]) {
          square([power_lever_height, power_lever_width]);
          translate([solenoid_y_offset, solenoid_x_offset]) {
               square([solenoid_body_width, solenoid_body_length]);
               translate([solenoid_body_width/2 - solenoid_plunger_space_width/2, solenoid_body_length]) square([solenoid_plunger_space_width, solenoid_plunger_space_length]);
          }
     }
     translate([top_of_hole_in_middle_bezel - 1,
                left_side_of_hole_in_middle_bezel + volume_control_offset])
          square([volume_control_depth, volume_control_width]);
}

module hole_for_tablet() {
     union() {
          translate([bottom_of_hole_in_middle_bezel, left_side_of_hole_in_middle_bezel])
               rounded_square(tablet_height, tablet_width, tablet_corner_radius);
          hole_for_power_control_assembly();
	  hole_for_usb();
	  hole_for_audio();
     }
}

module adjacent_meter_cutout() {
     translate([middle_button_y, overall_width + meter_offset])
          circle(r=meter_radius, center=true);
}

module threaded_holes() {
     translate([insert_offset_from_bottom, insert_offset_from_side])
          circle(r=threaded_insert_hole_diameter/2, center=true);
     translate([insert_offset_from_bottom, overall_width - insert_offset_from_side])
          circle(r=threaded_insert_hole_diameter/2, center=true);
     translate([top_of_hole_in_middle_bezel + insert_offset_from_screen,
                left_side_of_hole_in_middle_bezel + insert_offset_from_screen])
          circle(r=threaded_insert_hole_diameter/2, center=true);
     translate([top_of_hole_in_middle_bezel + insert_offset_from_screen,
                right_side_of_hole_in_middle_bezel - insert_offset_from_screen])
          circle(r=threaded_insert_hole_diameter/2, center=true);
     if (false)                 /* upper central hole */
          translate([top_of_hole_in_middle_bezel + insert_offset_from_screen,
                     (left_side_of_hole_in_middle_bezel + right_side_of_hole_in_middle_bezel) / 2])
               circle(r=threaded_insert_hole_diameter/2, center=true);
}

module hole_for_usb() {
     /* todo: USB cable is right-angled, so needs a bit leading off it, but I don't know which way up that will be */
     translate([usb_bottom, left_side_of_hole_in_middle_bezel - usb_length]) {
          square([usb_width, usb_length]);
          translate([usb_width, 0])
               square([usb_lead_length, usb_lead_width]);
     }
}

module hole_for_audio() {
     translate([audio_bottom, left_side_of_hole_in_middle_bezel - audio_length]) square([audio_width, audio_length]);
}

module hole_for_screen() {
     translate([screen_offset_from_bottom_of_front_bezel, screen_offset_from_side_of_front_bezel])
	  rounded_square(screen_height, screen_width, minimum_cutting_radius);
}

module back_bezel() {
     intersection() {
          rounded_square(height_of_back_bezel * outside_corner_radius,
                         overall_width,
                         outside_corner_radius);
          square([height_of_back_bezel, overall_width]);
     }
}

module middle_bezel() {
     difference() {
	  rounded_square(height_of_middle_bezel, overall_width, outside_corner_radius);
	  hole_for_tablet();
          threaded_holes();
          if (with_buttons) buttons();
	  adjacent_meter_cutout();
    }
}

module front_bezel() {
     difference() {
	  rounded_square(height_of_front_bezel, overall_width, outside_corner_radius);
	  hole_for_screen();
	  if (with_buttons) buttons();
	  adjacent_meter_cutout(); /* might not be needed, but probably best left in */
     }
}

solid = false;

exploded_diagram_spacing = -25;

cutting_gap = 3;

if (solid) {
     linear_extrude(height=10) back_bezel();
     translate([0, 0, exploded_diagram_spacing]) linear_extrude(height=10) middle_bezel();
     translate([0, 0, exploded_diagram_spacing*2]) linear_extrude(height=10) front_bezel();
} else {
     back_bezel();
     translate([height_of_back_bezel + cutting_gap, 0]) middle_bezel();
     translate([height_of_back_bezel + height_of_middle_bezel + 2 * cutting_gap, 0]) front_bezel();
     echo("Overall height",
          height_of_back_bezel + height_of_middle_bezel + height_of_front_bezel + 2 * cutting_gap);
     echo("Overall width", overall_width);
}

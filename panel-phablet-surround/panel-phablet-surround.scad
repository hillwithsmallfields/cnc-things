/* values from the accompanying .org file, all in mm */

overall_width = 268;
x_centre = 134;
height_of_front_bezel = 150;
height_of_back_bezel = 145;
tablet_width = 188;
tablet_height = 108;
total_front_bezel_side_margins = 80;
left_side_of_hole_in_back_bezel = 50;
right_side_of_hole_in_back_bezel = 238;
total_top_and_bottom_margins_of_back_bezel = 42;
bottom_of_hole_in_back_bezel = 10;
screen_width = 156;
screen_height = 88;
screen_offset_from_bottom_of_front_bezel = 10;
screen_offset_from_side_of_front_bezel = 56;
offset_of_louder_from_left_of_tablet = 23;
offset_of_quieter_from_left_of_tablet = 38;
offset_of_power_from_left_of_tablet = 54;
offset_of_usb_from_bottom_of_tablet = 32;
offset_of_audio_from_bottom_of_tablet = 77;
inset_for_louder = 63;
inset_for_quieter = 78;
inset_for_power = 94;
inset_for_usb = 42;
inset_for_audio = 87;
width_of_top_inset_for_bolts = 10;
leftmost_inset_centre = 53;
middle_inset_centre = 128;
right_inset_centre = 205;
width_between_top_buttons = 216;
width_between_middle_buttons = 213;
width_between_bottom_buttons = 214;
top_button_y = 100;
top_left_button_x = 26;
top_right_button_x = 242;
middle_button = 82;
middle_left_button_x = 27.5;
middle_right_button_x = 240.5;
bottom_button_y = 61;
bottom_left_button_x = 27;
bottom_right_button_x = 241;

module button() {
     }

module tablet() {
     union () {
	  square([tablet_height,tablet_width], center=true);
     }
}

module screen() {
	  square([screen_height,screen_width], center=true);
}

module outline() {
     square([height_of_front_bezel,overall_width], center=true);
}

module back_bezel() {
     difference() {
	  outline();
	  tablet();
     }
}

module front_bezel() {
     difference() {
	  outline();
	  screen();
     }
}

back_bezel();

translate([200,0]) front_bezel();

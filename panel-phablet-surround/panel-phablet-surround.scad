/* values from the accompanying .org file */

Overall_width = 268;
X_centre = 134;
Height_of_front_bezel = 150;
Height_of_back_bezel = 145;
Tablet_width = 188;
Tablet_height = 108;
Total_front_bezel_side_margins = 80;
Left_side_of_hole_in_back_bezel = 50;
Right_side_of_hole_in_back_bezel = 238;
Total_top_and_bottom_margins_of_back_bezel = 42;
Bottom_of_hole_in_back_bezel = 10;
Screen_width = 156;
Screen_height = 88;
Screen_offset_from_bottom_of_front_bezel = 10;
Screen_offset_from_side_of_front_bezel = 56;
Offset_of_louder_from_left_of_tablet = 23;
Offset_of_quieter_from_left_of_tablet = 38;
Offset_of_power_from_left_of_tablet = 54;
Offset_of_USB_from_bottom_of_tablet = 32;
Offset_of_audio_from_bottom_of_tablet = 77;
Inset_for_louder = 63;
Inset_for_quieter = 78;
Inset_for_power = 94;
Inset_for_USB = 42;
nInset_for_audio = 87;
Width_of_top_inset_for_bolts = 10;
Leftmost_inset_centre = 53;
Middle_inset_centre = 128;
Right_inset_centre = 205;
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



difference() {
     square([Height_of_front_bezel,Overall_width], center=true);
     square([Tablet_height,Tablet_width], center=true);
}

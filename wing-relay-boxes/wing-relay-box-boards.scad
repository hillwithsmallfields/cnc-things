/* Tufnol base boards for wiring in wing relay boxes */

/* sizes all in mm */

width = 105;
height = 55;

corner_width = 11;
lower_corner_height = 4;
upper_corner_height = 9;

isolator_thickness = 6;
isolator_tab_length = 12;
isolator_tab_angle = 22.5;

terminal_width = 7.7;
terminal_depth = 3.1;

blade_width = 6.3;
blade_depth = 0.8;

relay_width = 26;
relay_half_width = relay_width / 2;
relay_depth = 28;
relay_gap = 4;

relay_margin = (height - relay_depth) / 2;

blade_outer = 17.5;
blade_spacing = blade_outer - blade_depth;
side_margin_to_centres = (relay_width - blade_spacing) / 2;

lug_width = 2.2;
lug_depth = 0.9;

back_blade_to_far_end_of_mid = 11.6;
back_blade_to_far_end_of_front = 21.3;
mid_blade_to_front_offset = back_blade_to_far_end_of_front - back_blade_to_far_end_of_mid;

power_bolt_diameter = 6;

led_diameter = 3.5;
led_spacing = 6;

module terminal() {
     translate([-terminal_depth/2, -terminal_width/2]) {
          union() {
               square([terminal_depth, terminal_width]);
               translate([terminal_depth, (terminal_width - lug_width)/2]) square([lug_depth, lug_width]);
          }
     }
}

module relay_base() {
     translate([relay_half_width, terminal_width/2]) terminal();
     translate([side_margin_to_centres, mid_blade_to_front_offset + blade_width/2]) terminal();
     translate([relay_width - side_margin_to_centres, mid_blade_to_front_offset + blade_width/2]) terminal();
     translate([relay_half_width, back_blade_to_far_end_of_front]) { rotate([0,0,90]) terminal(); }
}

module power_bolt_hole() {
     circle(d=power_bolt_diameter, center=true, $fn=36);
}

bolt_offset_from_edge = 15;

module insulator_cutout() {
     rotate([0,0,isolator_tab_angle]) translate([-isolator_thickness/2, -isolator_tab_length/2]) square([isolator_thickness, isolator_tab_length]);
}

module led_holes() {
     for (i = [0:1]) {
          for (j = [0:5]) {
               translate([j*led_spacing + i*led_spacing/2, i*led_spacing/2]) circle(d=led_diameter, center=true, $fn=36);
          }
     }
}

module base_board() {
     difference() {
          square([width, height]);
          translate([0, relay_margin]) {
               translate([0, 0]) relay_base();
               translate([relay_width+relay_gap, 0]) relay_base();
               translate([(relay_width)*3, 0]) relay_base();
          }
          translate([relay_width*2.4, bolt_offset_from_edge]) power_bolt_hole();
          translate([relay_width*2.7, height-bolt_offset_from_edge]) power_bolt_hole();
          translate([relay_width*2.55, (bolt_offset_from_edge + height-bolt_offset_from_edge) / 2]) insulator_cutout();
          square([corner_width, lower_corner_height]);
          translate([width-corner_width, 0]) square([corner_width, lower_corner_height]); 
          translate([0, height-upper_corner_height]) square([corner_width, upper_corner_height]); 
          translate([width-corner_width, height-upper_corner_height]) square([corner_width, upper_corner_height]);
          translate([corner_width+led_spacing, height-led_spacing*1.5]) led_holes();
     }
}

base_board();

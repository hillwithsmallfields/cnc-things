board_length = 85;
board_width = 57;

board_hole_offset = 4;
board_hole_spacing = 58;
board_hole_diameter = 3;
bolt_head_diameter = 12;

margin = 10;

layer_thickness = 3;
layer_length = board_length+margin;
layer_width = board_width+2*margin;

wood_screw_hole_offset = margin / 2;
wood_screw_hole_diameter = 3;

side_sockets_space = 30;

spacing = 3;

audio_amp_long = 22;
audio_amp_short = 18;

audio_amp_surround_long = audio_amp_long+2*margin;
audio_amp_surround_short = audio_amp_short+2*margin;

module board_holes(diameter) {
     translate([board_length-board_hole_offset, board_hole_offset]) circle(d=diameter);
     translate([board_length-board_hole_offset, board_width-board_hole_offset]) circle(d=diameter);
     translate([board_length-(board_hole_offset+board_hole_spacing), board_hole_offset]) circle(d=diameter);
     translate([board_length-(board_hole_offset+board_hole_spacing), board_width-board_hole_offset]) circle(d=diameter);
}

module wood_screw_holes() {
     translate([layer_length-wood_screw_hole_offset, wood_screw_hole_offset]) circle(d=wood_screw_hole_diameter);
     translate([layer_length-wood_screw_hole_offset, layer_width-wood_screw_hole_offset]) circle(d=wood_screw_hole_diameter);
     translate([layer_length/2, wood_screw_hole_offset]) circle(d=wood_screw_hole_diameter);
     translate([wood_screw_hole_offset, wood_screw_hole_offset]) circle(d=wood_screw_hole_diameter);
     translate([wood_screw_hole_offset, layer_width-wood_screw_hole_offset]) circle(d=wood_screw_hole_diameter);
}

module audio_amp_surround() {
     difference() {
          square([audio_amp_surround_long, audio_amp_surround_short]);
          translate([margin, margin]) square([audio_amp_long, audio_amp_short]);
          translate([audio_amp_surround_long/2, margin/2]) circle(d=wood_screw_hole_diameter);
          translate([audio_amp_surround_long/2, audio_amp_surround_short - margin/2]) circle(d=wood_screw_hole_diameter);
     }
}

module audio_amp_retainer() {
     difference() {
          square([margin, audio_amp_surround_short]);
          translate([margin/2, margin/2]) circle(d=wood_screw_hole_diameter);
          translate([margin/2, audio_amp_surround_short - margin/2]) circle(d=wood_screw_hole_diameter);
     }
}

module board() {
     square([board_length, board_width]);
}

module computer() {
     difference() {
          board();
          board_holes();
     }
}

module layer() {
     difference() {
          square([layer_length, layer_width]);
          wood_screw_holes();
     }
}

module surrounding_layer() {
     union() {
          difference() {
               layer();
               translate([0, margin]) board();
               translate([side_sockets_space, margin+board_width]) square([board_length-(side_sockets_space+board_hole_offset*2), margin]);
          }
          /* put the amp surround in the bit we cut out --- less waste that way */
          translate([0, margin+spacing]) audio_amp_surround();
          /* and the retainer */
          translate([audio_amp_surround_long+spacing, margin+spacing]) audio_amp_retainer();
     }
}

module base_layer() {
     difference() {
          layer();
          translate([0, margin]) board_holes(board_hole_diameter);
     }
}

module under_layer() {
     difference() {
          layer();
          translate([0, margin]) board_holes(bolt_head_diameter);
     }
}

/* board(); */

surrounded = false;
three_d = false;

if (three_d) {
     translate([0, 0, layer_thickness]) linear_extrude(height=layer_thickness) surrounding_layer();
     translate([0, 0, layer_thickness*2]) linear_extrude(height=layer_thickness) surrounding_layer();
     linear_extrude(height=layer_thickness) base_layer();
     translate([0, 0, -layer_thickness])linear_extrude(height=layer_thickness) under_layer();
     translate([0, 0, -layer_thickness*2])linear_extrude(height=layer_thickness) under_layer();
} else {
     if (surrounded) {
          surrounding_layer();
          translate([0, layer_width+spacing]) surrounding_layer();
          translate([0, (layer_width+spacing)*2]) surrounding_layer();
          translate([layer_length+spacing, 0]) under_layer();
          translate([layer_length+spacing, layer_width+spacing]) under_layer();
          translate([layer_length+spacing, (layer_width+spacing)*2]) base_layer();
     } else {
          translate([0, 0]) under_layer();
          translate([0, layer_width+spacing]) under_layer();
          translate([0, (layer_width+spacing)*2]) base_layer();
     }
}

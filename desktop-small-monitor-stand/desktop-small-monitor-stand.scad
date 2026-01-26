/* An upright stand for a small monitor, with a desk/work lamp at the
 * top, and a lid that holds a keyboard and folds down at the
 * front. */

/* dimensions in mm */

three_d = false;
gap = 5;

thickness = 8;

/* Eyoyo 8" monitor */
monitor_width = 200;
monitor_height = 164;
monitor_depth_with_stand = 75;
monitor_depth_without_stand = 33;
monitor_side_margins = 16;
monitor_top_margin = 16;

overall_width = monitor_width + monitor_side_margins * 2;

/* large keyboard */
keyboard_width = 150;
keyboard_length = 440;
keyboard_depth = 28;

keyboard_tray_width = overall_width;

face_plate_inset = keyboard_depth;

/* MR16 lamp */
lamp_diameter = 2 * 25.4;
lamp_plate_size = lamp_diameter + 20;
lamp_aperture_height = (sqrt((lamp_plate_size * lamp_plate_size) / 2) + thickness) * 2;

overall_height = keyboard_length + thickness * 2;
front_height = overall_height - lamp_aperture_height;

overall_depth = monitor_depth_with_stand + face_plate_inset + thickness * 2;
base_depth = overall_depth;

module thicken() {
     if (three_d) {
          linear_extrude(height=thickness) children();
     } else {
          children();
     }
}

module side_plate() {
     thicken() square([overall_depth, overall_height]);

module position_slant_plate(flat) {
     far_in = face_plate_inset;
     far_up = (overall_height - (lamp_aperture_height - thickness));
     translate([flat ? far_in : 0,
                flat ? far_up : far_in,
                flat ? 0 : far_up]) rotate([flat ? 0 : 45,
                                            0,
                                            flat ? 45 : 0]) children();
}

module position_lamp_plate(flat) {
     far_in = face_plate_inset;
     far_up = (overall_height - thickness);
     translate([flat ? far_in : 0,
                flat ? far_up : far_in,
                flat ? 0: far_up]) rotate([flat ? 0 : -45,
                                           0,
                                           flat ? -45 : 0]) children();
}

module side_plate() {
     linear_extrude(height=thickness) {
          difference() {
               square([overall_depth, overall_height]);
               /* translate([30, 30]) circle(r=10); */ /* debug to check which corner is which */
               position_slant_plate(flat=true) {
                    translate([lamp_plate_size/4, 0]) square([lamp_plate_size/2, thickness]);
               }
               position_lamp_plate(flat=true) {
                    translate([lamp_plate_size/4, 0]) square([lamp_plate_size/2, thickness]);
               }
          }
     }
}

module face_plate() {
     thicken() {
          difference() {
               square([overall_width, front_height]);
               translate([monitor_side_margins, front_height-(monitor_height + monitor_top_margin)]) {
                    square([monitor_width, monitor_height]);
               }
          }
     }
}

module slant_plate() {
     linear_extrude(height=thickness) union() {
          square([overall_width, lamp_plate_size]);
          translate([-thickness, lamp_plate_size/4]) square([thickness, lamp_plate_size/2]);
          translate([overall_width, lamp_plate_size/4]) square([thickness, lamp_plate_size/2]);
     }
}

module lamp_plate() {
     linear_extrude(height=thickness)  {
          union() {
               difference() {
                    square([overall_width, lamp_plate_size]);
                    translate([overall_width/2, lamp_plate_size/2]) circle(d=lamp_diameter);
               }
               translate([-thickness, lamp_plate_size/4]) square([thickness, lamp_plate_size/2]);
               translate([overall_width, lamp_plate_size/4]) square([thickness, lamp_plate_size/2]);
          }
     }
}

module top_plate() {
     thicken() square([overall_width, base_depth]);
}

module base_plate() {
     thicken() square([overall_width, base_depth]);
}

module back_plate() {
     thicken() square([overall_width, overall_height- 2 * thickness]);
}

module keyboard_tray_long_edge() {
     thicken() square([keyboard_length, keyboard_depth]);
}

module keyboard_tray_side() {
     thicken() square([keyboard_tray_width-thickness*2, keyboard_depth]);
}

module keyboard_tray_base() {
     thicken() square([keyboard_length-thickness*2, keyboard_tray_width-thickness*2]);
}

module tower_assembly () {
     if (three_d) {
          base_plate();
          color("red") translate([-thickness, 0, 0]) rotate([90, 0, 90]) side_plate();
          color("red") translate([overall_width, 0, 0]) rotate([90, 0, 90]) side_plate();
          color("purple") translate([0, face_plate_inset, thickness]) rotate([90, 0, 0]) face_plate();
          color("purple") translate([0, base_depth, thickness]) rotate([90, 0, 0]) back_plate();
          /* lamp in a 45 degree bay */
          color("green") position_slant_plate(flat=false) { slant_plate(); }
          color("lime") position_lamp_plate(flat=false) { lamp_plate(); }
          translate([0, 0, overall_height-thickness]) top_plate();
     } else {
          translate([0, overall_width]) rotate([0, 0, -90]) {
               base_plate();
               translate([0, base_depth+gap]) {
                    top_plate();
                    translate([0, base_depth+gap]) {
                         side_plate();
                         translate([base_depth+gap, 0]) side_plate();
                         translate([0, overall_height + gap]) face_plate();
                    }
               }
          translate([0, overall_width]) {
               color("red") slant_plate();
               color("red") translate([0, lamp_plate_size+gap]) lamp_plate();
          }
     }
}

module keyboard_tray_assembly() {
     if (three_d) {
          color("green") translate([thickness, 0, 0]) keyboard_tray_base();
          color("red") translate([0, keyboard_tray_width-thickness, 0]) rotate([90, 0]) keyboard_tray_long_edge();
          color("red") rotate([90, 0]) keyboard_tray_long_edge();
          color("blue") rotate([90, 0, 90]) keyboard_tray_side();
          color("blue") translate([keyboard_length-thickness, 0, 0]) rotate([90, 0, 90]) keyboard_tray_side();
     } else {
          keyboard_tray_base();
          translate([keyboard_length + gap, 0]) {
               keyboard_tray_long_edge();
               translate([0, keyboard_depth + gap]) keyboard_tray_long_edge();
               translate([0, keyboard_depth * 2 + gap * 2]) {
                    keyboard_tray_side();
                    translate([keyboard_tray_width + gap, 0]) keyboard_tray_side();
               }
          }
     }
}

module assembly() { 
     if (three_d) {
          tower_assembly();
          translate([thickness, -500, thickness]) rotate([0, -90, -90]) keyboard_tray_assembly();
     } else {
          tower_assembly();
          /* keyboard_tray_assembly(); */
     }
}

assembly();

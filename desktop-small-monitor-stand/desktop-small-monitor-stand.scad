/* An upright stand for a small monitor, with a desk/work lamp at the
 * top, and a lid that holds a keyboard and folds down at the
 * front. */

/* dimensions in mm */

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

keyboard_tray_width = overall_width - 2 * thickness;

face_plate_inset = keyboard_depth;

/* MR16 lamp */
lamp_diameter = 2 * 25.4;
lamp_plate_size = lamp_diameter + 20;
lamp_aperture_height = sqrt((lamp_plate_size * lamp_plate_size) / 2) * 2;

overall_height = keyboard_length + thickness * 2;
front_height = overall_height - lamp_aperture_height;

overall_depth = monitor_depth_with_stand + face_plate_inset + thickness * 2;
base_depth = overall_depth;

module side_plate() {
     square([overall_depth, overall_height]);
}

module face_plate() {
     difference() {
          square([overall_width, front_height]);
          translate([monitor_side_margins, front_height-(monitor_height + monitor_top_margin)]) {
               square([monitor_width, monitor_height]);
          }
     }
}

module slant_plate() {
     square([overall_width, lamp_plate_size]);
}

module lamp_plate() {
     difference() {
          square([overall_width, lamp_plate_size]);
          translate([overall_width/2, lamp_plate_size/2]) circle(d=lamp_diameter);
     }
}

module top_plate() {
     square([overall_width, base_depth]);
}

module base_plate() {
     square([overall_width, base_depth]);
}

module back_plate() {
     square([overall_width, overall_height]);
}

module keyboard_tray_long_edge() {
     square([keyboard_length, keyboard_depth]);
}

module keyboard_tray_side() {
     square([keyboard_tray_width, keyboard_depth]);
}

module keyboard_tray_base() {
     square([keyboard_length, keyboard_tray_width]);
}

three_d = true;
gap = 5;

module tower_assembly () {
     if (three_d) {
          base_plate();
          rotate([90, 0, 90]) side_plate();
          translate([overall_width, 0, 0]) rotate([90, 0, 90]) side_plate();
          translate([0, face_plate_inset, 0]) rotate([90, 0, 0]) face_plate();
          translate([0, base_depth, 0]) rotate([90, 0, 0]) back_plate();
          /* lamp in a 45 degree bay */
          translate([0, face_plate_inset, overall_height - lamp_aperture_height]) rotate([45, 0, 0]) slant_plate();
          translate([0, face_plate_inset, overall_height]) rotate([-45, 0, 0]) lamp_plate();
          translate([0, 0, overall_height]) top_plate();
     } else {
     }
}

module keyboard_tray_assembly() {
     if (three_d) {
          keyboard_tray_base();
          translate([0, keyboard_tray_width, 0]) rotate([90, 0]) keyboard_tray_long_edge();
          rotate([90, 0]) keyboard_tray_long_edge();
          rotate([90, 0, 90]) keyboard_tray_side();
          translate([keyboard_length, 0, 0]) rotate([90, 0, 90]) keyboard_tray_side();
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
          translate([0, -250, 0]) rotate([0, -90, -90]) keyboard_tray_assembly();
     } else {
          tower_assembly();
          keyboard_tray_assembly();
     }
}

assembly();

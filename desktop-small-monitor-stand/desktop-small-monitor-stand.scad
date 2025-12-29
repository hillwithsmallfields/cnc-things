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

/* MR16 lamp */
lamp_diameter = 2 * 25.4;
lamp_overhang = 60;

overall_height = keyboard_length + thickness * 2;
front_height = overall_height - lamp_overhang;

overall_depth = monitor_depth_with_stand + thickness * 2;
base_depth = overall_depth;

module side_plate() {
}

module face_plate() {
     difference() {
          square([overall_width, front_height]);
          translate([monitor_side_margins, front_height-(monitor_height + monitor_top_margin)]) square([monitor_width, monitor_height]);
     }
}

module lamp_plate() {
     difference() {
          square([overall_width, lamp_overhang*sqrt(2)]);
          translate([]) circle(d=lamp_diameter);
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

module keyboard_tray_top() {
}

module keyboard_tray_assembly() {
     keyboard_tray_base();
     translate([0, keyboard_tray_width, 0]) rotate([90, 0]) keyboard_tray_long_edge();
     rotate([90, 0]) keyboard_tray_long_edge();
     rotate([90, 0, 90]) keyboard_tray_side();
     translate([keyboard_length, 0, 0]) rotate([90, 0, 90]) keyboard_tray_side();
}

keyboard_tray_assembly();

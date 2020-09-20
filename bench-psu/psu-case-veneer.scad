include <psu-dimensions.scad>

module veneer_top_flat() {
     union() {
          difference() {
               square([total_width, total_depth + outer_thickness + veneer_thickness]);
               outer_top_cutouts(true);
               top_dividers();
          }
          color("red") translate([usb_panel_from_side, binding_post_row_spacing*6]) usb_x_4();
     }
}

module veneer_top() {
     color("brown", veneer_alpha) {
          linear_extrude(height=veneer_thickness) {
               veneer_top_flat();
          }
     }
}

module veneer_front_flat() {
     difference() {
          square([total_width, total_height]);
          outer_front_cutouts(true);
          front_dividers();
     }
}

module veneer_front() {
     color("brown", veneer_alpha) {
          linear_extrude(height=veneer_thickness) {
               veneer_front_flat();
          }
     }
}

module veneer_back_flat() {
     difference() {
          square([total_width, total_height]);
          back_cutouts();
     }
}

module veneer_back() {
     color("brown", veneer_alpha) {
          linear_extrude(height=veneer_thickness) {
               veneer_back_flat();
          }
     }
}

module veneer_left_flat() {
     difference() {
          square([total_depth, total_height]);
          left_cutouts();
     }
}

module veneer_left() {
     color("brown", veneer_alpha) {
          linear_extrude(height=veneer_thickness) {
               veneer_left_flat();
          }
     }
}

module veneer_right_flat() {
     difference() {
          square([total_depth, total_height]);
          right_cutouts();
     }
}

module veneer_right() {
     color("brown", veneer_alpha) {
          linear_extrude(height=veneer_thickness) {
               veneer_right_flat();
          }
     }
}

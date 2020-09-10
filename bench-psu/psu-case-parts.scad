include <psu-dimensions.scad>

corner_length = total_width / 4;
corner_depth = corner_length / 3;

module lower_base_corner_flat() {
     union() {
          square([corner_length,
                  corner_depth],
                 center=false);
          square([corner_depth,
                  corner_length],
                 center=false);
     }
}

module lower_base_corner() {
     linear_extrude(height=outer_thickness) {
          lower_base_corner_flat();
     }
}

module lower_base() {
     lower_base_corner();
     translate([total_width, 0]) rotate(90) lower_base_corner();
     translate([0, total_depth]) rotate(-90) lower_base_corner();
     translate([total_width, total_depth]) rotate(180) lower_base_corner();
}

module lower_base_parts() {
     lower_base_corner_flat();
     translate([corner_length + corner_depth + cutting_space, corner_length]) rotate(180) lower_base_corner_flat();
     translate([corner_length + corner_depth + cutting_space * 2, 0]) lower_base_corner_flat();
     translate([(corner_length + corner_depth) * 2 + cutting_space * 3, corner_length]) rotate(180) lower_base_corner_flat();
}

module upper_base_flat() {
     square([total_width-2*inner_thickness,
                total_depth-2*inner_thickness],
          center=false);
}

module upper_base() {
     translate([outer_thickness, outer_thickness]) {
          linear_extrude(height=inner_thickness) {
               upper_base_flat();
          }
     }
}

module base() {
     color("green", 2/3) translate([0, 0, outer_thickness]) upper_base();
     color("red", 1/3) lower_base();
}

module ventilation_hole_row(columns) {
     for (i=[0:columns]) {
          translate([i * ventilation_hole_spacing, 0]) circle(d=ventilation_hole_diameter);
     }
}

module ventilation_hole_grid(columns, rows) {
     for (i=[0:rows]) {
          offset = i % 2 == 0 ? 0 : ventilation_hole_spacing/2;
          translate([offset, i * ventilation_hole_spacing]) ventilation_hole_row(columns);
     }
}

module back_cutouts() {
     translate([margin*2, total_height - margin*2 - mains_inlet_height]) square([mains_inlet_width, mains_inlet_height]);
     difference() {
          translate([ventilation_panel_start, margin]) ventilation_hole_grid(rear_ventilation_holes_per_row, rear_ventilation_hole_rows);
     }
}

module left_cutouts() {
     translate([margin, margin]) ventilation_hole_grid(side_ventilation_holes_per_row, side_ventilation_hole_rows);
}

module right_cutouts() {
     translate([total_depth - (margin*2 + side_ventilation_area_length), margin]) ventilation_hole_grid(side_ventilation_holes_per_row, side_ventilation_hole_rows);
}

module binding_post_hole_pair(diameter, spacing, join) {
     translate([-spacing/2, 0]) circle(d=diameter);
     translate([spacing/2, 0]) circle(d=diameter);
     if (join) {
         translate([-spacing/2, -diameter/2]) square([spacing, diameter]);
     }
}

module meter_and_switch_cutout() {
    translate([-meter_and_switch_width/2, -meter_and_switch_height/2]) {
        square([switch_width, switch_height]);
        translate([switch_width + meter_switch_gap, (switch_height - meter_height)/2]) {
            square([meter_width, meter_height]);
        }
    }
}

module one_outer_front_cutout(with_text, volt_label) {
     translate([half_section_width, total_height-(meter_and_switch_height + margin)]) meter_and_switch_cutout();
     if (with_text) {
          translate([12, 12]) text(volt_label);
     }
}

module one_outer_top_cutout(with_text, volt_label) {
     translate([0, binding_post_offset]) {
          for (i=[1:binding_post_rows]) {
               translate([half_section_width, (i + 1) * binding_post_row_spacing]) {
                    if (i != binding_post_rows-2) {
                         binding_post_hole_pair(binding_post_hole_outer_diameter, binding_post_spacing, false);
                    }
               }
          }
          if (with_text) {
               translate([12,binding_post_row_spacing]) text(volt_label);
               translate([12,binding_post_row_spacing * (binding_post_rows + 1.5)]) text(volt_label);
          }
     }
}

module outer_top_cutouts(with_text) {
     translate([0, outer_thickness]) {
          for (i=[0:sections]) {
               translate([i * section_width, 0]) {
                    one_outer_top_cutout(with_text, voltages[i]);
               }
          }
     }
}

module top_dividers() {
     for (i=[1:sections-1]) {
          translate([i * section_width, margin]) {
               square([3,total_depth - margin*2]);
          }
     }
}

module outer_front_cutouts(with_text) {
     for (i=[0:sections]) {
          translate([i * section_width, 0]) {
               one_outer_front_cutout(with_text, voltages[i]);
          }
     }
}

module front_dividers() {
     for (i=[1:sections-1]) {
          translate([i * section_width, margin]) {
               square([3, total_height - margin*2]);
          }
     }
}

module outer_top_flat() {
     difference() {
          square([total_width, total_depth + outer_thickness]);
          outer_top_cutouts(false);
     }
}

module outer_top() {
     linear_extrude(height=outer_thickness) {
          outer_top_flat();
     }
}

module outer_front_flat() {
     difference() {
          square([total_width, total_height]);
          outer_front_cutouts(false);
     }
}

module outer_front() {
     linear_extrude(height=outer_thickness) {
          outer_front_flat();
     }
}

module veneer_top_flat() {
     difference() {
          square([total_width, total_depth + outer_thickness + veneer_thickness]);
          outer_top_cutouts(true);
          top_dividers();
     }
}

module veneer_top() {
     color("brown", 0.25) {
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
     color("brown", 0.25) {
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
     color("brown", 0.25) {
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
     color("brown", 0.25) {
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
     color("brown", 0.25) {
          linear_extrude(height=veneer_thickness) {
               veneer_right_flat();
          }
     }
}

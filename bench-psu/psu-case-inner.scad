include <psu-box.scad>
include <psu-dimensions.scad>

module one_front_inner_cutout() {
     translate([half_section_width, total_height-(meter_and_switch_height + margin)]) meter_and_switch();
}

module one_top_inner_cutout() {
     translate([0, binding_post_offset]) {
          for (i=[1:binding_post_rows]) {
               if (i != binding_post_rows-2) {          
                    translate([half_section_width, i * binding_post_row_spacing]) binding_post_hole_pair(binding_post_hole_inner_diameter, binding_post_spacing, true);
               }
          }
     }
}

module front_inner_cutouts() {
     for (i=[0:sections]) {
          translate([i * section_width, 0]) {
               one_front_inner_cutout();
          }
     }
     translate([(total_width - adjuster_width)/2, adjuster_y_offset]) square([adjuster_width, adjuster_height]);
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

module back_inner_cutouts() {
     translate([margin*2, margin*2]) square([mains_inlet_width, mains_inlet_height]);
     difference() {
          translate([ventilation_panel_start, margin]) ventilation_hole_grid(rear_ventilation_holes_per_row, rear_ventilation_hole_rows);
     }
}

module top_inner_cutouts() {
     for (i=[0:sections]) {
          translate([i * section_width, 0]) {
               one_top_inner_cutout();
          }
     }
}

module left_inner_cutouts() {
     translate([margin, margin]) ventilation_hole_grid(side_ventilation_holes_per_row, side_ventilation_hole_rows);
}

module right_inner_cutouts() {
     translate([total_depth - (margin*2 + side_ventilation_area_length), margin]) ventilation_hole_grid(side_ventilation_holes_per_row, side_ventilation_hole_rows);
}

module psu_case_inner() {
     box(total_width, total_height, total_depth, inner_thickness,
         assemble=true,
         labels=true,
         open_bottom=true) {
          front_inner_cutouts();
          top_inner_cutouts();
          back_inner_cutouts();
          left_inner_cutouts();
          right_inner_cutouts();
     };
}

psu_case_inner();

include <psu-dimensions.scad>

module one_front_outer_cutout() {
     translate([half_section_width - switch_width/2, switch_offset]) square([switch_width, switch_height]);
     translate([half_section_width - meter_width/2, meter_offset]) square([meter_width, meter_height]);
}

module one_top_outer_cutout() {
     for (i=[1:binding_post_rows]) {
          translate([half_section_width, i * binding_post_row_spacing]) binding_post_hole_pair(binding_post_hole_outer_diameter, binding_post_spacing);
     }
}

module top_outer_cutouts() {
     translate([0, outer_thickness]) {
          for (i=[0:sections]) {
               translate([i * section_width, 0]) {
                    one_top_outer_cutout();
               }
          }
     }
}

module front_outer_cutouts() {
     for (i=[0:sections]) {
          translate([i * section_width, 0]) {
               one_front_outer_cutout();
          }
     }
}

module front_top() {
     difference() {
          square([total_width, total_depth]);
          top_outer_cutouts();
     }
}

module front_outer() {
     difference() {
          square([total_width, total_height]);
          front_outer_cutouts();
     }
}

module psu_case_outer() {
     front_outer();
     translate([0, total_height + cutting_space]) front_top();
}

psu_case_outer();

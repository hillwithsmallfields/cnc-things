include <psu-dimensions.scad>

module one_front_outer_cutout(volt_label) {
     translate([half_section_width, total_height-(meter_and_switch_height + margin)]) meter_and_switch();
     translate([12, 12]) text(volt_label);
}

module one_top_outer_cutout(volt_label) {
     translate([0, binding_post_offset]) {
          for (i=[1:binding_post_rows]) {
               translate([half_section_width, (i + 1) * binding_post_row_spacing]) {
                    if (i != binding_post_rows-2) {
                         binding_post_hole_pair(binding_post_hole_outer_diameter, binding_post_spacing, false);
                    }
               }
          }
          translate([12,binding_post_row_spacing]) text(volt_label);
          translate([12,binding_post_row_spacing * (binding_post_rows + 1.5)]) text(volt_label);
     }
}

module top_outer_cutouts() {
     translate([0, outer_thickness]) {
          for (i=[0:sections]) {
               translate([i * section_width, 0]) {
                    one_top_outer_cutout(voltages[i]);
               }
          }
     }
}

module front_outer_cutouts() {
     for (i=[0:sections]) {
          translate([i * section_width, 0]) {
               one_front_outer_cutout(voltages[i]);
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

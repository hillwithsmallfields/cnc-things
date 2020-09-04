include <psu-box.scad>
include <psu-dimensions.scad>

module one_front_inner_cutout() {
     translate([half_section_width - switch_width/2, switch_offset]) square([switch_width, switch_height]);
     translate([half_section_width - meter_width/2, meter_offset]) square([meter_width, meter_height]);
}

module one_top_inner_cutout() {
     for (i=[1:binding_post_rows]) {
          translate([half_section_width, i * binding_post_row_spacing]) binding_post_hole_pair(binding_post_hole_inner_diameter, binding_post_spacing);
     }
}

module front_inner_cutouts() {
     for (i=[0:sections]) {
          translate([i * section_width, 0]) {
               one_front_inner_cutout();
          }
     }
}

module back_inner_cutouts() {
     translate([margin, total_height - (margin + mains_inlet_height)]) square([mains_inlet_width, mains_inlet_height]);
}

module top_inner_cutouts() {
     for (i=[0:sections]) {
          translate([i * section_width, 0]) {
               one_top_inner_cutout();
          }
     }
}

module psu_case_inner() {
     box(total_width, total_height, total_depth, inner_thickness,
         assemble=true,
         labels=true,
         open_bottom=true) {
          front_inner_cutouts();
          top_inner_cutouts();
          back_inner_cutouts();
     };
}

psu_case_inner();

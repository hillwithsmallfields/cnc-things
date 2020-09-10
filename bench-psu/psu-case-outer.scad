include <psu-dimensions.scad>
include <psu-case-parts.scad>

module psu_case_outer() {
     outer_front_flat();
     translate([0, total_height + cutting_space]) outer_top_flat();
     translate([0, 3 * (total_height + cutting_space)]) lower_base_parts();
}

psu_case_outer();

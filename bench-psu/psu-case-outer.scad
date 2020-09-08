include <psu-dimensions.scad>
include <psu-case-parts.scad>

module psu_case_outer() {
     outer_front();
     translate([0, total_height + cutting_space]) outer_top();
}

psu_case_outer();

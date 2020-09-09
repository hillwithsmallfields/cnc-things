include <psu-case-inner.scad>
include <psu-case-parts.scad>

module psu_case_all() {
     psu_case_inner_with_components(true);
     translate([0, 0, total_height]) outer_top();
}

psu_case_all();

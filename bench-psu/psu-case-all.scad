include <psu-case-inner.scad>
include <psu-case-parts.scad>

module psu_case_all() {
     psu_case_inner_with_components();
     translate([0, 0, total_height * 2 ]) outer_top();
}

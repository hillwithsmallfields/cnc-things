include <psu-case-parts.scad>
include <psu-case-inner.scad>

module psu_case_all() {
     psu_case_inner_with_components(true);
     translate([0, -outer_thickness, total_height + outer_thickness]) outer_top(); /* I don't understand the height calculation; have I got the wrong zero point for my extruded parts? */
     translate([0, 0, outer_thickness]) rotate([90, 0, 0]) outer_front();
     translate([0, -(outer_thickness + veneer_thickness), total_height + outer_thickness*2 + veneer_thickness]) veneer_top(); /* TODO: height calculation not right yet */
     translate([0, -(outer_thickness + veneer_thickness), outer_thickness]) rotate([90, 0, 0]) veneer_front();
     translate([0, total_depth+veneer_thickness, outer_thickness]) rotate([90, 0, 0]) veneer_back();
     translate([-veneer_thickness, total_depth, outer_thickness]) rotate([90, 0, -90]) veneer_left();
     translate([total_width+veneer_thickness, 0, outer_thickness]) rotate([90, 0, 90]) veneer_right();
}

psu_case_all();

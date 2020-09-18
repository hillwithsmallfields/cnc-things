include <psu-dimensions.scad>
include <psu-case-parts-front.scad>
include <psu-case-parts-top.scad>
include <psu-case-parts-base.scad>
include <psu-case-parts-back-sides.scad>
include <psu-case-veneer.scad>

veneer_alpha = 1/8;
outer_alpha = 1/4;

module assembly_bracket_slots(panel_width) {
     translate([assembly_bracket_tab_offset+inner_thickness, inner_thickness*2]) square([assembly_bracket_tab_length, inner_thickness]);
     translate([panel_width - (assembly_bracket_tab_offset+inner_thickness+assembly_bracket_tab_length), inner_thickness*2]) square([assembly_bracket_tab_length, inner_thickness]);
}

module psu_case_all(with_components) {
     psu_case_inner_with_components(with_components);
     translate([0, -outer_thickness, total_height + outer_thickness]) outer_top(); /* I don't understand the height calculation; have I got the wrong zero point for my extruded parts? */
     translate([0, 0, outer_thickness]) rotate([90, 0, 0]) outer_front();
     translate([0, -(outer_thickness + veneer_thickness), total_height + outer_thickness*2 + veneer_thickness]) veneer_top(); /* TODO: height calculation not right yet */
     translate([0, -(outer_thickness + veneer_thickness), outer_thickness]) rotate([90, 0, 0]) veneer_front();
     translate([0, total_depth+veneer_thickness, outer_thickness]) rotate([90, 0, 0]) veneer_back();
     translate([-veneer_thickness, total_depth, outer_thickness]) rotate([90, 0, -90]) veneer_left();
     translate([total_width+veneer_thickness, 0, outer_thickness]) rotate([90, 0, 90]) veneer_right();
}

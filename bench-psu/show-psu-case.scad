include <psu-case-inner.scad>

psu_case_inner_with_components(false);
translate([0, -outer_thickness, total_height + outer_thickness]) outer_top(); /* I don't understand the height calculation; have I got the wrong zero point for my extruded parts? */
translate([0, 0, outer_thickness]) rotate([90, 0, 0]) outer_front();

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

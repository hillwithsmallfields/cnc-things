include <psu-case-parts.scad>

module cut_assembly_brackets_parts_only() {
     assembly_brackets_parts(true);
     translate([assembly_bracket_size*5, 0]) assembly_brackets_parts(false);
}

cut_assembly_brackets_parts_only();

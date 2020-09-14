include <psu-dimensions.scad>

module lower_base_corner_flat() {
     difference() {
          union() {
               square([corner_length,
                       corner_depth],
                      center=false);
               square([corner_depth,
                       corner_length],
                      center=false);
          }
          translate([corner_fixing_hole_offset + outer_thickness,
                     corner_fixing_hole_offset + outer_thickness]) {
               circle(d=corner_fixing_bolt_hole_diameter);
          }
     }
}

module lower_base_corner() {
     linear_extrude(height=outer_thickness) {
          lower_base_corner_flat();
     }
}

module lower_base() {
     lower_base_corner();
     translate([total_width, 0]) rotate(90) lower_base_corner();
     translate([0, total_depth]) rotate(-90) lower_base_corner();
     translate([total_width, total_depth]) rotate(180) lower_base_corner();
}

module lower_base_parts() {
     lower_base_corner_flat();
     translate([corner_length + corner_depth + cutting_space, corner_length]) rotate(180) lower_base_corner_flat();
     translate([corner_length + corner_depth + cutting_space * 2, 0]) lower_base_corner_flat();
     translate([(corner_length + corner_depth) * 2 + cutting_space * 3, corner_length]) rotate(180) lower_base_corner_flat();
}

module upper_base_flat() {
     base_width = total_width-2*outer_thickness;
     base_depth = total_depth-2*outer_thickness;
     difference() {
          square([base_width, base_depth],
                 center=false);
          base_mounting_component_positioning() {
               psu12v_boltholes();
               psu5v_boltholes();
               psu36v_boltholes();
          }
          translate([corner_fixing_hole_offset, corner_fixing_hole_offset]) circle(d=corner_fixing_bolt_hole_diameter);
          translate([base_width - corner_fixing_hole_offset, corner_fixing_hole_offset]) circle(d=corner_fixing_bolt_hole_diameter);
          translate([corner_fixing_hole_offset, base_depth - corner_fixing_hole_offset]) circle(d=corner_fixing_bolt_hole_diameter);
          translate([base_width - corner_fixing_hole_offset, base_depth - corner_fixing_hole_offset]) circle(d=corner_fixing_bolt_hole_diameter);
     }
}

module upper_base() {
     translate([outer_thickness, outer_thickness]) {
          linear_extrude(height=inner_thickness) {
               upper_base_flat();
          }
     }
}

module base() {
     color("green", 2/3) translate([0, 0, outer_thickness]) upper_base();
     color("red", 1/3) lower_base();
}

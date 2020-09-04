include <psu-dimensions.scad>

module lower_base() {
     cube([total_width,
           total_depth,
           outer_thickness],
          center=false);
}

module upper_base() {
     translate([outer_thickness, outer_thickness]) {
          cube([total_width-2*inner_thickness,
                total_depth-2*inner_thickness,
                inner_thickness],
               center=false);
     }
}

module base() {
     color("red") lower_base();
     color("green") translate([0, 0, outer_thickness]) upper_base();
}

base();

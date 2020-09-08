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
     color("green", 2/3) translate([0, 0, outer_thickness]) upper_base();
     color("red", 1/3) lower_base();
}

module binding_post_hole_pair(diameter, spacing, join) {
     translate([-spacing/2, 0]) circle(d=diameter);
     translate([spacing/2, 0]) circle(d=diameter);
     if (join) {
         translate([-spacing/2, -diameter/2]) square([spacing, diameter]);
     }
}

module meter_and_switch_cutout() {
    translate([-meter_and_switch_width/2, -meter_and_switch_height/2]) {
        square([switch_width, switch_height]);
        translate([switch_width + meter_switch_gap, (switch_height - meter_height)/2]) {
            square([meter_width, meter_height]);
        }
    }
}

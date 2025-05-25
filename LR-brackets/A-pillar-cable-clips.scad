/* Clip to hold the cable trunking up each side of the windscreen */

length = 10;
thickness = 5;
cable_diameter = 19;
cross_section = cable_diameter + 2 * thickness;
screw_size=5;
screw_head_size=8;
screw_head_depth=3;

cable_tie_thickness = 2;
cable_tie_width = 4;
cable_tie_depth = 2;

module cable_clip() {
     difference() {
          linear_extrude(length) {
               difference() {
                    intersection() {
                         rotate([0, 0, 45]) {
                              difference() {
                                   square(cross_section, center=true);
                                   circle(d=cable_diameter);
                              }
                         }
                         square(cross_section, center=true);
                    }
                    square(cross_section);
               }
          }
          translate([0, 0, length/2]) rotate([135, 90, 0]) {
               cylinder(d=screw_size, h=cross_section);
               cylinder(d=screw_head_size, h=cable_diameter/2 + screw_head_depth);
          }
     
          translate([0, 0, (length-cable_tie_width)/2]) {
               linear_extrude(cable_tie_width) {
                    difference() {
                         circle(d=cable_diameter+cable_tie_depth+cable_tie_thickness);
                         circle(d=cable_diameter+cable_tie_depth);
                    }
               }
          }
     }
}

cable_clip();

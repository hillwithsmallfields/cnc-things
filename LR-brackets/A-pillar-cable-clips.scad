length = 10;
thickness = 5;
cable_diameter = 19;
cross_section = cable_diameter + 2 * thickness;
screw_size=5;
screw_head_size=8;
screw_head_depth=3;

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
     }
}

cable_clip();

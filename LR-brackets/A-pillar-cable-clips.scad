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

module screw_hole() {
     translate([0, 0, length/2]) rotate([135, 90, 0]) {
          cylinder(d=screw_size, h=cross_section);
          cylinder(d=screw_head_size, h=cable_diameter/2 + screw_head_depth);
     }
}

module cable_tie_channel() {
     translate([0, 0, (length-cable_tie_width)/2]) {
          linear_extrude(cable_tie_width) {
               difference() {
                    circle(d=cable_diameter+cable_tie_depth+cable_tie_thickness);
                    circle(d=cable_diameter+cable_tie_depth);
               }
          }
     }
}

module clip_body() {
     linear_extrude(length) {
          difference() {
               intersection() {
                    union() {
                         circle(d=cross_section);
                         /* the part that fits in the windscreen channel */
                         translate([-3*cross_section/4, -3*cross_section/4]) square(cross_section);
                    }
                    /* clip diagonally to fit in corner */
                    rotate([0, 0, 45]) {
                         difference() {
                              square(cross_section, center=true);
                              /* cut out the centre */
                              circle(d=cable_diameter);
                         }
                    }
                    /* clip off corners diagonally */
                    square(cross_section, center=true);
               }
               /* make it an open clip, rather than a closed circle */
               square(cross_section);
          }
     }
}

module cable_clip() {
     difference() {
          clip_body();

          screw_hole();

          cable_tie_channel();
     }
}

cable_clip();


cover_length = 9 * 25.4;
cover_height = 3 * 25.4;

nholes = 12;
hole_spacing = 10;

hole_size = 3;
screw_hole_size = 5;
screw_hole_offset = 10;

module in_corners(w, h) {
     children();
     translate([w, h]) rotate([0,0,180]) children();
     translate([0, h]) rotate([0,0,-90]) children();
     translate([w, 0]) rotate([0,0,90]) children();
}

module cover_plate() {
     difference() {
          square([cover_length, cover_height]);
          translate([(cover_length - hole_spacing * nholes - 1) / 2, cover_height / 2]) {
               for (i = [ 0 : nholes - 1 ]) {
                    translate([i * hole_spacing, 0]) {
                         circle(center=true, d=hole_size);
                    }
               }
          }
          in_corners(cover_length, cover_height) {
               translate([screw_hole_offset, screw_hole_offset]) {
                    circle(center=true, d=screw_hole_size);
               }
          }
     }
}

module hole_sampler() {
     difference() {
          square([cover_length, cover_height/4]);
          translate([(cover_length - hole_spacing * nholes - 1) / 2, cover_height / 8]) {
               for (i = [ 0 : nholes - 1 ]) {
                    translate([i * hole_spacing, 0]) {
                         circle(center=true, d=2+i*.25);
                    }
               }
          }
     }
}

cover_plate();
translate([0, cover_height*(1+1/16)]) hole_sampler();

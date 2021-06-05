
cover_length = 8.5 * 25.4;
cover_height = 3 * 25.4;

nholes = 12;
hole_spacing = 10;

hole_size = 5;
screw_hole_size = 4;
screw_hole_offset = 8;

module rounded_rect(w, h, r) {
     union() {
          translate([0, r]) square([w, h-r*2]);
          translate([r, 0]) square([w-r*2, h]);
          translate([r,r,]) circle(r=r);
          translate([r,h-r,]) circle(r=r);
          translate([w-r,r,]) circle(r=r);
          translate([w-r,h-r,]) circle(r=r);
     }
}

module in_corners(w, h) {
     children();
     translate([w, h]) rotate([0,0,180]) children();
     translate([0, h]) rotate([0,0,-90]) children();
     translate([w, 0]) rotate([0,0,90]) children();
}

usb_width = 18;
usb_height = 10;

module usb_hole() {
     translate([-usb_width/2, -usb_height/2]) rounded_rect(usb_width, usb_height, 1);
}

module cover_plate() {
     difference() {
          /* square([cover_length, cover_height]); */
          rounded_rect(cover_length, cover_height, screw_hole_offset);
          translate([0,0])
               translate([(cover_length - hole_spacing * (nholes - 1)) / 2, cover_height / 2]) {
               for (i = [ 0 : nholes - 1 ]) {
                    translate([i * hole_spacing, 0]) {
                         circle(center=true, d=hole_size);
                    }
               }
          }
          translate([27, cover_height / 2]) usb_hole();
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
                         circle(center=true, d=4+i*.25);
                    }
               }
          }
     }
}

cover_plate();
translate([0, cover_height*(1+1/16)]) hole_sampler();

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

module rounded_outline(w, h, r, t) {
     difference() {
          rounded_rect(w, h, r);
          translate([t, t]) rounded_rect(w-t*2, h-t*2, r);
     }
}

rounded_rect(60, 90, 10);
translate([100, 0]) rounded_outline(60, 90, 10, 5);

size = 24;
radius = 3;

spacing = size + 2;

thickness = 6;

straight_side = size - (2 * radius);

inner_side = size - (2 * thickness);

screw_hole_diameter = 3;

module radiused_foot() {
     union() {
          translate([0, radius]) square([size, straight_side]);
          translate([radius, 0]) square([straight_side, size]);
          translate([radius, radius]) circle(r=radius);
          translate([size-radius, radius]) circle(r=radius);
          translate([radius, size-radius]) circle(r=radius);
          translate([size-radius, size-radius]) circle(r=radius);
     }
}

module foot_with_hole() {
     difference() {
          radiused_foot();
          translate([size/2, size/2]) circle(d=screw_hole_diameter, $fn=18);
     }
}

module foot_with_gap() {
     difference() {
          radiused_foot();
          translate([thickness,thickness]) square([inner_side, inner_side]);
     }
}

foot_with_hole();
translate([spacing, 0]) foot_with_gap();
translate([0, spacing]) foot_with_gap();
translate([spacing, spacing]) foot_with_gap();


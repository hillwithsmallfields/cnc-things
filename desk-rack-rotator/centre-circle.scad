outer_diameter = 145;
outer_radius = outer_diameter / 2;

screw_hole_diameter = 3;

magnet_inset = 15;

module zero_circle() {
     difference() {
          circle(d=outer_diameter, $fn=360);
          circle(d=10, $fn=36);
          for (angle = [0:30:360]) {
               rotate(angle + 15)
                    translate([outer_diameter/2 - magnet_inset, 0])
                    circle(d=screw_hole_diameter, $fn=12);
          }
     }
}

module centred_circle() {
     translate([75, 75]) zero_circle();
}

/* centred_circle(); */

module segment(degrees) {
     intersection() {
          zero_circle();
          translate([0, -outer_radius]) square([outer_radius, outer_diameter]);
          rotate(degrees)translate([-outer_radius, -outer_radius]) square([outer_radius, outer_diameter]);
     }
}

segment(112);
rotate(120) segment(112);
rotate(240) segment(112);

outer_diameter = 145;
outer_radius = outer_diameter / 2;

module zero_circle() {
     difference() {
          circle(d=outer_diameter, $fn=360);
          circle(d=10, $fn=36);
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

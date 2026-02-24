/* along top edge of screen */
module upper() {
     square([164, 15]);
}

/* along bottom edge of screen */
module lower() {
     difference() {
          square([164, 35]);
          translate([110, 0]) square([20, 20]);
     }
}

module cutout(x, y, w, h) {
     translate([x, y]) square([w, h]);
}

module backplate() {
     difference() {
          square([164, 123]);
          cutout(109, 0, 27, 30); /* indent in lower edge for strut */
          cutout(0, 60, 22, 50); /* indent in left edge for connectors */
     }
}

/* behind screen */
module backing() {
     difference() {
          backplate();
          cutout(67, 22, 38, 40);  /* connector to actual screen */
          cutout(17, 55, 30, 22);  /* lower left chip cluster */
          cutout(18, 95, 28, 16);  /* upper left chip cluster */
          cutout(50, 75, 30, 30);  /* large chip */
          cutout(104, 50, 28, 35); /* right component cluster */
     }
}

/* standoff pieces; there will be four stacks of three */
module pillar() {
     square([20, 20]);
}

/* between the standoff pieces */
module strap() {
     square([20, 123]);
}

/* deeper bits for the screws to go into */
module extender() {
     square([30, 15]);
}

scale([-1, 1]) rotate(90) {
     lower();
     translate([0, 40]) upper();
     translate([0, 60]) for (i = [0: 3]) translate([i*35, 0]) extender();
     translate([0, 80]) backing();
     translate([0, 225]) rotate(-90) strap();
     translate([0, 250]) rotate(-90) strap();
     translate([0, 255]) backplate();
/* translate([475, 0]) for (i = [0: 5]) translate([i*25, 0]) pillar(); */
/* translate([475, 30]) for (i = [0: 5]) translate([i*25, 0]) pillar(); */
}

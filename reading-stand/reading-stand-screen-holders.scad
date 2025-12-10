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

/* behind screen */
module backing() {
     difference() {
          square([164, 123]);
          translate([110, 0]) square([25, 30]);
          translate([0, 60]) square([15, 50]);
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

lower();
translate([0, 40]) upper();
translate([0, 60]) for (i = [0: 5]) translate([i*25, 0]) pillar();
translate([0, 85]) for (i = [0: 5]) translate([i*25, 0]) pillar();
translate([0, 110]) for (i = [0: 3]) translate([i*35, 0]) extender();
translate([170, 0]) backing();
translate([340, 0]) strap();
translate([370, 0]) strap();

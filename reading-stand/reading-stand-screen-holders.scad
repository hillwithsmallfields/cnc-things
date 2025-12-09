module upper() {
     square([220, 15]);
}

module lower() {
     difference() {
          square([220, 35]);
          translate([140, 0]) square([20, 20]);
     }
}

upper();
translate([0, 30]) upper();
translate([0, 60]) lower();
translate([0, 100]) lower();

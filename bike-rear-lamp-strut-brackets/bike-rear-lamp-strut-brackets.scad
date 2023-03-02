seat_stay_diameter = 15;
tube_wall_thickness = 5;
outer_diameter = seat_stay_diameter+tube_wall_thickness;

tube_length = 30;

plate_diameter = 25;
slot_diameter = 15;
slot_thickness = 5;

halver = (outer_diameter + plate_diameter) * 2;

module bracket() {
     difference() {
          union() {
               cylinder(h=tube_length, d=outer_diameter, center=true);
               rotate([90, 0, 0]) {
                    translate([plate_diameter/2, 0, 0]) {
                         difference() {
                              cylinder(h=outer_diameter, d=plate_diameter, center=true);
                              cylinder(h=slot_thickness, d=slot_diameter, center=true);
                              translate([0, -plate_diameter/2, -slot_thickness/2]) {
                                   cube([plate_diameter/2, slot_diameter, slot_thickness]);
                              }
                         }
                    }
               }
          }
          cylinder(h=tube_length+2, d=seat_stay_diameter, center=true);
     }
}

difference() {
     bracket();
     translate([-halver/2, 0, -halver/2])
          cube([halver, halver, halver]);
}

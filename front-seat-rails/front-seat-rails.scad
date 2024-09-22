angle_width = 15;
angle_thickness = 3;

tube_outer_diameter = 15;
tube_inner_diameter = 11;

slot_width = 8;

lengthways_mounting_spacing = 330;
widthways_mounting_spacing = 290;

rail_length = lengthways_mounting_spacing + 80;

back_hinge_position = 50;
front_hinge_position = rail_length - 50;

module angle(length) {
     cube([length, angle_thickness, angle_width]);
     cube([length, angle_width, angle_thickness]);
}

module rail_stock(length) {
     rotate([180, 0, 0]) translate([0, -(angle_width + slot_width/2), 0]) {
          angle(length);
          translate([0, angle_width*2+slot_width, 0]) rotate([90, 0, 0]) angle(length);
     }
}

module tube_cutout(length) {
     translate([0, 0, -1]) cylinder(h=length+2, r=tube_outer_diameter/2);
}

module tube(length) {
     difference() {
          cylinder(h=length, r=tube_outer_diameter/2);
          translate([0, 0, -1]) cylinder(h=length+2, r=tube_inner_diameter/2);
     }
}

module rail(length, width) {
     union() {
          difference() {
               rail_stock(length);
               translate([back_hinge_position, -(angle_width+slot_width/2), -angle_width/2-angle_thickness]) rotate([-90, 0, 0]) tube_cutout(width);
               translate([front_hinge_position, -(angle_width+slot_width/2), -angle_width/2-angle_thickness]) rotate([-90, 0, 0]) tube_cutout(width);
          }
          translate([back_hinge_position, -(angle_width+slot_width/2), -angle_width/2-angle_thickness]) rotate([-90, 0, 0]) tube(width);
          translate([front_hinge_position, -(angle_width+slot_width/2), -angle_width/2-angle_thickness]) rotate([-90, 0, 0]) tube(width);
     }
}

module upper_frame() {
     translate([0, -widthways_mounting_spacing/2, 0]) rail(rail_length, angle_width*2 + slot_width);
     translate([0, widthways_mounting_spacing/2, 0]) rail(rail_length, angle_width*2 + slot_width);
     translate([0, -(widthways_mounting_spacing/2+angle_width+angle_thickness), 0]) rotate([180, 0, 90]) angle(widthways_mounting_spacing+angle_width*2+angle_thickness*2);
     translate([rail_length, -(widthways_mounting_spacing/2+angle_width+angle_thickness), 0]) rotate([-90, 0, 90]) angle(widthways_mounting_spacing+angle_width*2+angle_thickness*2);
}

upper_frame();


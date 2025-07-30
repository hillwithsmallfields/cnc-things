blank_length = 1000;
blank_width = 145;

width = blank_width;
height = (blank_length - blank_width) / 4;
thickness = 12;

side_tabs = 8;
side_tab_height = height / (2 * side_tabs);

base_tabs = 4;
base_tab_length = width / (2 * base_tabs);

vent_hole_base = 30;
vent_hole_rows = 12;
vent_hole_size = 12;
vent_hole_columns = 7;
vent_hole_column_spacing = ((width - (2 * thickness)) / ((vent_hole_columns / 2) - 1) / 2);
echo(vent_hole_column_spacing);
module side(angle) {
     rotate([0, 0, angle])
          translate([-width/2, width/2, 0])
          rotate([90, 0, 0])
          linear_extrude(thickness) {
          difference() {
               square([width, height]);
               for (i = [0: side_tabs - 1]) {
                    translate([0, i * side_tab_height * 2]) square([thickness, side_tab_height]);
                    translate([width - thickness, side_tab_height + i * side_tab_height * 2, ]) square([thickness, side_tab_height]);
               }
               for (i = [0: base_tabs - 1]) {
                    translate([base_tab_length + i * base_tab_length *2, 0]) square([base_tab_length, thickness]);
               }
               for (i = [0: vent_hole_rows - 1]) {
                    for (j = [0: vent_hole_columns/2]) {
                         for (k = [-1 : 1: 1]) {
                              /* echo(i, j, k); */
                              translate([
                                             width/2 + k * vent_hole_column_spacing
                                             ,
                                             vent_hole_base + 2 * i * vent_hole_size
                                             ])
                                   circle(d=vent_hole_size);
                         }
                    }
               }
          }
     }
}

module base() {
     linear_extrude(thickness) {
          difference() {
               translate([-width/2, -width/2]) square([width, width]);
               for (angle = [0: 90: 270]) {
                    rotate(angle) translate([-width/2, -width/2])
                         for (i = [0: base_tabs - 1]) {
                              translate([0, i * 2 * base_tab_length]) square([base_tab_length, thickness]);
                         }
               }
          }
     }
}

module ladle_holder() {
     color("purple") base();
     color("red") side(0);
     color("green") side(90);
     color("blue") side(180);
     color("yellow") side(270);
}

ladle_holder();

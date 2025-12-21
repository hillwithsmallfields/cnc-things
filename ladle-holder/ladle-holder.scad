/* The actual dimensions */
blank_real_length = 1000;
blank_real_width = 145;
/* leave a bit for inaccuracy of aligning it in the laser cutter */
blank_length = blank_real_length - 4*5;
blank_width = blank_real_width - 4;
thickness = 12;

edge = .1;                       /* to separate the sections, so they don't union together */
explode = thickness;

width = blank_width;
height = (blank_length - blank_width) / 4;

side_tab_height = thickness;
side_tabs = (height / side_tab_height) / 2;

base_tab_length = thickness;
base_tabs = (width / base_tab_length) / 2;

vent_hole_base = 30;
vent_hole_rows = 12;
vent_hole_size = thickness;
vent_hole_columns = 7;
vent_hole_column_spacing = ((width - (2 * thickness)) / ((vent_hole_columns / 2) - 1) / 2);

echo(vent_hole_column_spacing);

module side_2d() {
     difference() {
          square([width, height-edge]);
          for (i = [0: side_tabs]) {
               translate([0, i * side_tab_height * 2]) square([thickness, side_tab_height]);
          }
          for (i = [0: side_tabs]) {
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
     }}

module side_3d(angle) {
     rotate([0, 0, angle])
          translate([-width/2, width/2 + explode, 0])
          rotate([90, 0, 0])
          linear_extrude(thickness) {
          side_2d();
     }
}

module base_2d() {
     difference() {
          translate([-width/2, -width/2]) square([width, width]);
          for (angle = [0: 90: 270]) {
               rotate(angle) translate([-width/2, -width/2])
                    for (i = [1: base_tabs - 1]) {
                         translate([0, 1 + i * 2 * base_tab_length]) square([thickness, base_tab_length]);
                    }
          }
     }
}

module base_3d() {
     linear_extrude(thickness) {
          base_2d();
     }
}

module ladle_holder_2d() {
     translate([width/2, width/2]) {
          base_2d();
     }
     translate([0, width]) {
          for (i = [0: 3]) {
               translate([0, i * height]) side_2d();
          }
     }

}

module ladle_holder_3d() {
     translate([0, 0, -2 * explode]) color("purple") base_3d();
     color("red") side_3d(0);
     color("green") side_3d(90);
     color("blue") side_3d(180);
     color("yellow") side_3d(270);
}

/* ladle_holder_2d(); */

/* translate([width, width]) base_2d(); */
rotate(90) side_2d();
/* base_2d(); */
/* scale([0.25, 0.25]) side_2d(); */

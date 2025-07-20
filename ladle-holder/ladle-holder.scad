height = 400;
width = 100;
thickness = 10;

tabs = 8;
tab_height = height / tabs;

module side(angle) {
     rotate([0, 0, angle])
          translate([-width/2, width/2, 0])
          rotate([90, 0, 0])
          linear_extrude(thickness) {
          square([width, height]);
     }
}

module base() {
     linear_extrude(thickness) translate([-width/2, -width/2]) square([width, width]);
}

module ladle_holder() {
     base();
     color("red") side(0);
     color("green") side(90);
     color("blue") side(180);
     color("yellow") side(270);
}

ladle_holder();

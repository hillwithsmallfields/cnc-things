plate_length = 280;
gap_height = 28;
overlap = 18;
plate_height = gap_height + overlap;

half_height = gap_height / 2;

module motor_socket() {
     circle(d=15);
}

module ethernet_socket() {
     square([22, 20]);
}

module iec(width, height, corner_depth, hole_spacing) {
     union([]) {
          translate([-width/2, -height/2])
               polygon(points=[[0, 0],
                               [0, height - corner_depth],
                               [corner_depth, height],
                               [width - corner_depth, height],
                               [width, height - corner_depth],
                               [width, 0],
                               [0, 0]]);
          translate([-hole_spacing/2, 0]) circle(d=4);
          translate([hole_spacing/2, 0]) circle(d=4);
     }
}

module mains_inlet() {
     iec(26, 18, 5, 40);
}

module mains_outlet() {
     iec(32, 23, 8, 40);
}

module audio_socket() {
     circle(d=9.5);
}

module din_socket() {
     union() {
          circle(d=15);
          translate([-11.5, 0]) circle(d=3);
          translate([11.5, 0]) circle(d=3);
     }
}

module socket_plate() {
     difference() {
          square([plate_length, plate_height]);
          translate([18, 14]) motor_socket();
          translate([35, 0]) ethernet_socket();
          translate([90, 14]) mains_inlet();
          translate([150, 14]) mains_outlet();
          translate([200, 14]) audio_socket();
          translate([240, 14]) din_socket();
     }
}

socket_plate();

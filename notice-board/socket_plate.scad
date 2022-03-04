plate_length = 350;
gap_height = 28;
overlap = 18;
plate_height = gap_height + overlap;

half_height = gap_height / 2;

fixing_height = gap_height + overlap/2;

top_plate_length = 420;

module screw_hole() {
     circle(d=4);
}

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

module cooling_fan() {
     /* "Ultra-miniature Brushless Fan Electric DC 5V 6V 2507 Mini Micro Tiny Cooling NI" has 3mm holes in a 21mm square, and is 25mm overall */
     union() {
          circle(d=22);
          hole_place = 21/2;
          translate([hole_place, hole_place]) circle(d=3);
          translate([hole_place, -hole_place]) circle(d=3);
          translate([-hole_place, -hole_place]) circle(d=3);
          translate([-hole_place, hole_place]) circle(d=3);
     }
}

module socket_plate() {
     difference() {
          square([plate_length, plate_height]);
          translate([15, fixing_height]) screw_hole();
          translate([plate_length/2, fixing_height]) screw_hole();
          translate([plate_length-15, fixing_height]) screw_hole();
          translate([18, 14]) motor_socket();
          translate([35, 0]) ethernet_socket();
          translate([90, 14]) mains_inlet();
          translate([150, 14]) mains_outlet();
          translate([200, 14]) audio_socket();
          translate([240, 14]) din_socket();
     }
}

module top_plate() {
     difference() {
          square([top_plate_length, plate_height]);
          translate([15, fixing_height]) screw_hole();
          translate([top_plate_length/2, fixing_height]) screw_hole();
          translate([top_plate_length-15, fixing_height]) screw_hole();
          translate([20, 10]) circle(d=10);
          translate([top_plate_length/2, 10]) circle(d=10);
          translate([top_plate_length*.25, half_height]) cooling_fan();
          translate([top_plate_length*.75, half_height]) cooling_fan();
     }
}

socket_plate();

translate([0, plate_height + 3]) top_plate();

/* end triangles for the reading stand */

width = 270;
height = 178;
peak_offset = 205;

speaker_diameter = 50;
speaker_mounting_hole_offset = 25;
speaker_mounting_hole_diameter = 4;

speaker_centre_x = 162.5;
speaker_centre_y = 75;

mains_x = 105;
mains_y = 44;

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

module speaker_holes(diameter, hole_offset, bolt_hole_diameter) {
     circle(d=diameter);
     translate([-hole_offset, -hole_offset]) circle(d=bolt_hole_diameter);
     translate([hole_offset, -hole_offset]) circle(d=bolt_hole_diameter);
     translate([-hole_offset, hole_offset]) circle(d=bolt_hole_diameter);
     translate([hole_offset, hole_offset]) circle(d=bolt_hole_diameter);
}

module end_triangle() {
     polygon(points=[[0, 0],
                     [peak_offset, height],
                     [width, 0]]);
}

module endplate() {
     difference() {
          end_triangle();
          translate([speaker_centre_x, speaker_centre_y]) speaker_holes(speaker_diameter, speaker_mounting_hole_offset, speaker_mounting_hole_diameter);
          translate([mains_x, mains_y]) mains_inlet();
     }
}

wedge_size = 45;

module corner_wedge() {
     difference() {
          intersection() {
               translate([-(width-wedge_size), 0]) end_triangle();
               translate([wedge_size, 0]) circle(r=wedge_size);
          }
          translate([wedge_size/2, wedge_size/2]) circle(d=12);
     }
}

module corner_wedges(n) {
     for (i = [0:n]) {
          translate([wedge_size*i, 0]) corner_wedge();
     }
}

/* endplate(); */

corner_wedges(6);

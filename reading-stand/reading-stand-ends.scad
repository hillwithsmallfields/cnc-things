/* end triangles for the reading stand */

width = 250;
height = 200;
peak_offset = 200;

speaker_diameter = 50;
speaker_mounting_hole_offset = 25;
speaker_mounting_hole_diameter = 4;

speaker_centre_x = 162.5;
speaker_centre_y = 75;

mains_x = width - 50;
mains_y = 25;

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
          /* translate([-hole_spacing/2, 0]) circle(d=4); */
          /* translate([hole_spacing/2, 0]) circle(d=4); */
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

module endplate() {
     difference() {
          polygon(points=[[0, 0],
                          [peak_offset, height],
                          [width, 0]]);
          translate([speaker_centre_x, speaker_centre_y]) speaker_holes(speaker_diameter, speaker_mounting_hole_offset, speaker_mounting_hole_diameter);
          translate([mains_x, mains_y]) mains_inlet();
     }
}

endplate();

/* Standoffs and surrounds for speakers: standoffs as there isn't
 * enough depth to the nearby strut, and surrounds to protect them a
 * bit. */

circle_steps=120;

speaker_hole_diameter = 52;

screw_hole_spacing = 42;
screw_hole_diameter = 4;

enclosing_square_size = 55;

/* Large enough to cover the old mounting screw holes, but not large enough to interfere with edges or mains inlets, I hope. */
rim_diameter = 80;
speaker_tips_diameter = 74;

terminals_width = 32;
terminals_depth = 12;

module standoff_plate() {
     difference() {
          circle(d=rim_diameter, $fn=circle_steps);
          circle(d=speaker_hole_diameter, $fn=circle_steps);
          translate([-terminals_width/2, speaker_hole_diameter/2 - terminals_depth/2]) square([terminals_width, terminals_depth]);
          translate([-screw_hole_spacing/2, -screw_hole_spacing/2]) circle(d=screw_hole_diameter);
          translate([-screw_hole_spacing/2, screw_hole_spacing/2]) circle(d=screw_hole_diameter);
          translate([screw_hole_spacing/2, -screw_hole_spacing/2]) circle(d=screw_hole_diameter);
          translate([screw_hole_spacing/2, screw_hole_spacing/2]) circle(d=screw_hole_diameter);
     }
}

module spacer_plate() {
     union() {
          difference() {
               circle(d=rim_diameter, $fn=circle_steps);
               translate([-enclosing_square_size/2, -enclosing_square_size/2]) square([enclosing_square_size, enclosing_square_size]);
          }
          difference() {
               circle(d=rim_diameter, $fn=circle_steps);
               circle(d=speaker_tips_diameter, $fn=circle_steps);
          }
     }
}

module face_plate() {
     difference() {
          circle(d=rim_diameter, $fn=circle_steps);
          circle(d=speaker_hole_diameter, $fn=circle_steps);
     }
}

if (true) {
     /* cut these two from the same solid wood used for the main structure */
     standoff_plate();
     translate([rim_diameter*1+10, 0]) face_plate();
} else {
     /* cut this one from thin ply */
     spacer_plate();
}

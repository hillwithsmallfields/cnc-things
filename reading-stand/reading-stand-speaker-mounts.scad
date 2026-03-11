/* Standoffs and surrounds for speakers: standoffs as there isn't
 * enough depth to the nearby strut, and surrounds to protect them a
 * bit. */

speaker_hole_diameter = 50;

screw_hole_spacing = 42;
screw_hole_diameter = 4;

enclosing_square_size = 53;

/* Large enough to cover the old mounting screw holes, but not large enough to interfere with edges or mains inlets, I hope. */
rim_diameter = 80;

module standoff_plate() {
     difference() {
          circle(d=rim_diameter);
          circle(d=speaker_hole_diameter);
          translate([-screw_hole_spacing/2, -screw_hole_spacing/2]) circle(d=screw_hole_diameter);
          translate([-screw_hole_spacing/2, screw_hole_spacing/2]) circle(d=screw_hole_diameter);
          translate([screw_hole_spacing/2, -screw_hole_spacing/2]) circle(d=screw_hole_diameter);
          translate([screw_hole_spacing/2, screw_hole_spacing/2]) circle(d=screw_hole_diameter);
     }
}

module spacer_plate() {
     difference() {
          circle(d=rim_diameter);
          translate([-enclosing_square_size/2, -enclosing_square_size/2]) square([enclosing_square_size, enclosing_square_size]);
     }
}

module face_plate() {
     difference() {
          circle(d=rim_diameter);
          circle(d=speaker_hole_diameter);
     }
}

if (false) {
     /* cut these two from the same solid wood used for the main structure */
     standoff_plate();
     translate([rim_diameter*1+10, 0]) face_plate();
} else {
     /* cut this one from thin ply */
     spacer_plate();
}

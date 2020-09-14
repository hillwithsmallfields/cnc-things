include <psu-dimensions.scad>
include <psu-case-parts-front.scad>
include <psu-case-parts-base.scad>
include <psu-case-parts-back-sides.scad>
include <psu-case-veneer.scad>

veneer_alpha = 1/8;
outer_alpha = 1/4;

module binding_post_hole_pair(diameter, spacing, join) {
     translate([-spacing/2, 0]) circle(d=diameter);
     translate([spacing/2, 0]) circle(d=diameter);
     if (join) {
         translate([-spacing/2, -diameter/2]) square([spacing, diameter]);
     }
}

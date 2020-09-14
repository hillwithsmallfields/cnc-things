include <psu-box.scad>
include <psu-dimensions.scad>
include <psu-case-parts.scad>
include <psu-components.scad>

module inner_back_cutouts() {
     back_cutouts();
}

module inner_left_cutouts() {
     left_cutouts();
}

module inner_right_cutouts() {
     right_cutouts();
}

three_d = true;

module psu_case_inner() {
     translate([0, 0, outer_thickness]) {
          box(total_width, total_height, total_depth, inner_thickness,
              assemble=three_d,
              labels=true,
              open_bottom=true) {
               inner_front_cutouts();
               inner_top_cutouts();
               inner_back_cutouts();
               inner_left_cutouts();
               inner_right_cutouts();
          }
     }
}

module psu_case_inner_with_components(three_d) {
     if (three_d) {
          internal_components();
     }
     psu_case_inner();
     if (three_d) {
	  base();
     }	  
}

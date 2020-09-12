include <psu-box.scad>
include <psu-dimensions.scad>
include <psu-case-parts.scad>
include <psu-components.scad>

module one_inner_front_cutout() {
     translate([half_section_width, meter_and_switch_offset_from_base + meter_and_switch_height/2]) {
          meter_and_switch_cutout(false);
     }
}

module one_inner_top_cutout() {
     translate([0, binding_post_offset]) {
          for (i=[1:binding_post_rows]) {
               if (i != binding_post_rows-2) {          
                    translate([half_section_width, i * binding_post_row_spacing]) {
			 binding_post_hole_pair(binding_post_hole_inner_diameter, binding_post_spacing, true);
		    }
               }
          }
     }
}

module inner_front_cutouts() {
     for (i=[0:sections-1]) {
          translate([i * section_width, 0]) {
               one_inner_front_cutout();
          }
     }
     translate([(total_width - adjuster_width_inner)/2, adjuster_y_centre - adjuster_height_inner/2]) {
          square([adjuster_width_inner, adjuster_height_inner]);
     }
}

module inner_back_cutouts() {
     back_cutouts();
}

module inner_top_cutouts() {
     for (i=[0:sections-1]) {
          translate([i * section_width, 0]) {
               one_inner_top_cutout();
          }
     }
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

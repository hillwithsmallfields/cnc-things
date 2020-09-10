include <psu-dimensions.scad>
include <psu-case-parts.scad>

module cut_veneer() {
     veneer_top_flat();
     translate([total_width + cutting_space, 0]) veneer_front_flat();
     translate([total_width + cutting_space, total_height + cutting_space]) veneer_back_flat();
     translate([(total_width + cutting_space) * 2, 0]) veneer_left_flat();
     translate([(total_width + cutting_space) * 2, total_height + cutting_space]) veneer_right_flat();
}

cut_veneer();

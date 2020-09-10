include <psu-case-inner.scad>

module cut_top_base() {
     box(total_width, total_height, total_depth, inner_thickness,
         assemble=false,
         cut_parts="top",
         labels=true,
         open_bottom=true) {
          front_inner_cutouts();
          top_inner_cutouts();
          back_inner_cutouts();
          left_inner_cutouts();
          right_inner_cutouts();
     }

     translate([0, total_depth + cutting_space]) { upper_base_flat(); }
}

cut_top_base();

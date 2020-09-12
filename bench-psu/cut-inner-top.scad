include <psu-case-inner.scad>

module cut_inner_top_only() {
     box(total_width, total_height, total_depth, inner_thickness,
         assemble=false,
         cut_parts="top",
         labels=true,
         open_bottom=true) {
          inner_front_cutouts();
          inner_top_cutouts();
          inner_back_cutouts();
          inner_left_cutouts();
          inner_right_cutouts();
     }
}

cut_inner_top_only();

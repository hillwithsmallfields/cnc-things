include <psu-case-inner.scad>

module cut_inner_left_only() {
     box(total_width, total_height, total_depth, inner_thickness,
         assemble=false,
         cut_parts="left",
         labels=true,
         open_bottom=true) {
          front_inner_cutouts();
          top_inner_cutouts();
          back_inner_cutouts();
          left_inner_cutouts();
          right_inner_cutouts();
     }
}

cut_inner_left_only();

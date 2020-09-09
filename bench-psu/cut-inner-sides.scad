include <psu-case-inner.scad>

box(total_width, total_height, total_depth, inner_thickness,
    assemble=false,
    cut_parts="sides",
    labels=true,
    open_bottom=true) {
     front_inner_cutouts();
     top_inner_cutouts();
     back_inner_cutouts();
     left_inner_cutouts();
     right_inner_cutouts();
}

include <psu-dimensions.scad>

module ventilation_hole_row(columns) {
     for (i=[0:columns]) {
          translate([i * ventilation_hole_spacing, 0]) circle(d=ventilation_hole_diameter);
     }
}

module ventilation_hole_grid(columns, rows) {
     for (i=[0:rows]) {
          offset = i % 2 == 0 ? 0 : ventilation_hole_spacing/2;
          translate([offset, i * ventilation_hole_spacing]) ventilation_hole_row(columns);
     }
}

module back_cutouts() {
     translate([margin, psu36v_height]) square([mains_inlet_width, mains_inlet_height]);
     translate([margin, total_height - margin - MC4_width - inner_thickness]) square([MC4_length, MC4_width]);
     translate([rear_ventilation_panel_start, margin]) ventilation_hole_grid(rear_ventilation_holes_per_row, rear_ventilation_hole_rows);
     assembly_bracket_slots(total_width);
}

module left_cutouts() {
     translate([margin*3, margin]) ventilation_hole_grid(side_ventilation_holes_per_row, side_ventilation_hole_rows);
     assembly_bracket_slots(total_depth);
}

module right_cutouts() {
     translate([total_depth - (margin*3 + side_ventilation_area_length), margin]) ventilation_hole_grid(side_ventilation_holes_per_row, side_ventilation_hole_rows);
     assembly_bracket_slots(total_depth);
}

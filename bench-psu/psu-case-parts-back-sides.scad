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
     translate([margin*2, total_height - margin*2 - mains_inlet_height]) square([mains_inlet_width, mains_inlet_height]);
     difference() {
          translate([ventilation_panel_start, margin]) ventilation_hole_grid(rear_ventilation_holes_per_row, rear_ventilation_hole_rows);
     }
}

module left_cutouts() {
     translate([margin, margin]) ventilation_hole_grid(side_ventilation_holes_per_row, side_ventilation_hole_rows);
}

module right_cutouts() {
     translate([total_depth - (margin*2 + side_ventilation_area_length), margin]) ventilation_hole_grid(side_ventilation_holes_per_row, side_ventilation_hole_rows);
}

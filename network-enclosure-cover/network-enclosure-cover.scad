
cut_width = 25 * 25.4;
cut_height = 4 * 25.4;

shelf_width = 18 * 25.4;

tb_margin = .8 * 25.4;
lr_margin = 3 * 25.4;

ventilation_hole_diameter = 10;
ventilation_hole_spacing = ventilation_hole_diameter * 1.75;

panel_width = cut_width - lr_margin*2;
panel_height = cut_height - tb_margin*2;

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

module cover_panel_outline() {
     square([cut_width, cut_height]);
}

module shelf_panel_outline() {
     square([shelf_width, cut_height]);
}

module cover_panel() {
     difference() {
          cover_panel_outline();
          translate([lr_margin, tb_margin]) {
               ventilation_hole_grid(panel_width / ventilation_hole_spacing, panel_height / ventilation_hole_spacing);
          }
     }
}

module shelf() {
    difference() {
          shelf_panel_outline();
          translate([lr_margin, tb_margin]) {
               ventilation_hole_grid(7*25.4 / ventilation_hole_spacing, panel_height / ventilation_hole_spacing);
          }
          translate([13*25.4, tb_margin]) {
               ventilation_hole_grid(3*25.4 / ventilation_hole_spacing, panel_height / ventilation_hole_spacing);
          }
     }
}

/* rotate([0, 0, 90]) cover_panel(); */
rotate([0, 0, 90]) shelf();


cut_width = 25 * 25.4;
cut_height = 4 * 25.4;

tb_margin = 0.75 * 25.4;
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

module outline() {
     square([cut_width, cut_height]);
}

difference() {
     outline();
     translate([lr_margin, tb_margin]) {
          ventilation_hole_grid(panel_width / ventilation_hole_spacing, panel_height / ventilation_hole_spacing);
     }
}


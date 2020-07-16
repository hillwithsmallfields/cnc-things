meter_width = 45;
meter_height = 26;

bezel = 4;

spacing = bezel * 2;

columns = 2;
rows = 3;

one_width = meter_width + spacing;
one_height = meter_height + spacing;

whole_width = one_width * columns;
whole_height = one_height * rows;

module meter_holes() {
     for (row = [0:rows-1]) {
          for (column = [0:columns-1]) {
               translate([column * one_width + bezel, row * one_height + bezel]) {
                    square([meter_width, meter_height]);
               }
          }
     }
}

module panel_outline() {
     square([whole_width, whole_height]);
}

module meter_panel() {
     difference() {
          panel_outline();
          meter_holes();
     }
}

meter_panel();

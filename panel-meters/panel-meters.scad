meter_width = 45;
meter_height = 26;

bezel = 4;

spacing = bezel * 2;

columns = 2;
rows = 3;

whole_width = (meter_width + spacing) * columns;
whole_height = (meter_height + spacing) * rows;

module meter_holes() {
     for (row = [1:rows]) {
          for (column = [1:columns]) {
               translate() {
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

meter_width = 30;
meter_height = 20;

bezel = 4;

spacing = bezel * 2;

columns = 2;
rows = 3;

whole_width = (meter_width + spacing) * columns;
whole_height = (meter_height + spacing) * rows;

module meter_panel() {
     for (row = [1:rows]) {
          for (column = [1:columns]) {
          }
     }
}

/* modified version of box.scad */
include <box.scad>

meter_width = 45;
meter_height = 26;

bezel = 4;

spacing = bezel * 2;

edging = 8;
button_area_width = 18;
button_diameter = 12;

columns = 3;
rows = 2;

one_width = meter_width + spacing;
one_height = meter_height + spacing;

whole_width = one_width * columns + edging * 2 + button_area_width;
whole_height = one_height * rows + edging * 2;

module meter_holes() {
     translate([edging, edging]) {
          for (row = [0:rows-1]) {
               for (column = [0:columns-1]) {
                    translate([column * one_width + bezel, row * one_height + bezel]) {
                         square([meter_width, meter_height]);
                    }
               }
          }
     }
     translate([whole_width - edging - button_area_width/2, one_height/2]) { circle(d=button_diameter, center=true);}
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

// meter_panel();
box(width=whole_width, depth=whole_height, height=25, thickness=3, open_bottom=true, assemble=true, cutouts=meter_holes);


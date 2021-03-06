/* modified version of box.scad */
include <meterbox.scad>

meter_width = 45;
meter_height = 26;

clip_notch_depth = 0.25;
clip_notch_width = 11;
clip_notch_offset = 10;

bezel = 4;

spacing = bezel * 2;

h_edging = 6;
v_edging = 6;
button_area_width = 18;
small_button_diameter = 4;
large_button_diameter = 12;
mounting_bolt_diameter = 5;
mounting_area_width = 20;

columns = 3;
rows = 2;

one_width = meter_width + spacing;
one_height = meter_height + spacing;

whole_width = one_width * columns + h_edging * 2 + button_area_width + mounting_area_width;
whole_height = one_height * rows + v_edging * 2;

module meter_hole(w, h, d) {
     union() {
          square([w, h]);
          translate([clip_notch_offset, -d]) square([clip_notch_width, meter_height + d * 2]);
          translate([meter_width - (clip_notch_offset + clip_notch_width), -d]) square([clip_notch_width, meter_height + d * 2]);
     }
}

module meter_holes() {
     translate([h_edging + mounting_area_width, v_edging]) {
          for (row = [0:rows-1]) {
               for (column = [0:columns-1]) {
                    translate([column * one_width + bezel, row * one_height + bezel]) {
                         meter_hole(meter_width, meter_height, clip_notch_depth);
                    }
               }
          }
     }
     translate([whole_width - h_edging - button_area_width/2, one_height/2]) { circle(d=small_button_diameter, center=true);}
     translate([whole_width - h_edging - button_area_width/2, whole_height - one_height/2]) { circle(d=large_button_diameter, center=true);}
     translate([mounting_area_width / 2, whole_height / 2]) { circle(d=mounting_bolt_diameter, center=true); }
     translate([whole_width - mounting_area_width / 2, whole_height / 2]) { circle(d=mounting_bolt_diameter, center=true); }
}

module panel_outline() {
     square([whole_width, whole_height]);
}

module test_outline() {
     square([whole_width, whole_height]);
}

module test_meter_holes() {
     translate([h_edging + mounting_area_width, v_edging]) {
          for (row = [0:rows-1]) {
               for (column = [0:columns-1]) {
                    translate([column * one_width + bezel, row * one_height + bezel]) {
                         meter_hole(meter_width+row*0.1,
                                    meter_height+row*0.1,
                                    clip_notch_depth + column*0.25);
                    }
               }
          }
     }
}

module meter_panel() {
     difference() {
          panel_outline();
          meter_holes();
     }
}

// meter_panel();

if (true) {
     box(width=whole_width,
         depth=whole_height,
         height=30,
         thickness=3,
         open_bottom=true,
         // assemble=true,
         cutouts=meter_holes);
} else {
     difference() {
          test_outline();
          test_meter_holes();
     }
}


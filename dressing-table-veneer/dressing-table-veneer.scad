table_width = 1050;
table_depth = 484;

upper_width = 473;
upper_depth = 190;

back_offset = 250;
back_depth = 243;

inset_offset = 57;
inset_depth = 59;

quarter_offset = 14;
quarter_radius = 156 + quarter_offset;

module top() {
     difference() {
          square([table_width, table_depth]);
          translate([back_offset, table_depth-upper_depth]) {
               difference() {
                    square([upper_width, upper_depth]);
                    translate([inset_offset+inset_depth, 0]) {
                         square([table_width - (back_offset + inset_offset + inset_depth) * 2, 59]);
                    }
               }
          }
     }
}

top();

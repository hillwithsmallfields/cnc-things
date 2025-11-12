/* Carrier plate to glue MC8 connector shells and interlocking relay sockets into */

top_margin = 25;
bottom_margin = 25;
side_margin = 20;
bar_width = 12;

connector_hole_height = 38;
connector_hole_width = 17;
connector_x_spacing = 25;
connector_y_spacing = connector_hole_height + bar_width;

relay_height = 36;
relay_spacing = 31;
/* they interlock, so the width is larger than the spacing: */
relay_width = 33;

bolt_hole_diameter = 5;
bolt_hole_spacing = 25;

module socket_grid(x, y) {
     for (i=[0:y-1]) {
          for (j=[0:x-1]) {
               translate([j*connector_x_spacing, i*connector_y_spacing]) {
                    square([connector_hole_width, connector_hole_height]);
               }
          }
     }
}

module mounting_holes(plate_width, plate_height) {
     translate([0, bolt_hole_spacing/2])
          for (i=[0:plate_height/bolt_hole_spacing-1]) {
               translate([side_margin/2, i*bolt_hole_spacing]) circle(d=bolt_hole_diameter);
               translate([plate_width - (side_margin/2), i*bolt_hole_spacing]) circle(d=bolt_hole_diameter);
          }
}

module relay_row(n) {
     square([relay_spacing*n + (relay_width-relay_spacing),
             relay_height]);
}             

module socket_plate(x, y, n) {
     plate_width = x*connector_x_spacing + side_margin*2;
     plate_height = y*connector_y_spacing + top_margin + bottom_margin + ((n>0) ? relay_height : 0);
     difference() {
          square([plate_width, plate_height]);
          translate([side_margin, bottom_margin]) socket_grid(x, y);
          if (n > 0) {
               translate([side_margin+((plate_width-side_margin*2 - n*relay_spacing) / 2)-(relay_width-relay_spacing),
                          y*connector_y_spacing+2*bar_width]) relay_row(n);
          }
          mounting_holes(plate_width, plate_height);
     }
     color("red") mounting_holes(plate_width, plate_height);
}

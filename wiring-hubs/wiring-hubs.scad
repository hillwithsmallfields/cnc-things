/* Carrier plate to glue MC8 connector shells and interlocking relay sockets into */

/* large relay is 43mm wide and needs 70mm clearance from mounting hole */

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

power_connector_bolt_diameter = 8;

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

module power_connector_bolts(plate_width, n) {
     /* don't put the connector bolts in the side margins --- that's
      * where the mounting bolts go */
     bolt_spacing = (plate_width - (side_margin/2)) / (n+1);

     translate([side_margin + bolt_spacing/2, 0])
          for (i=[0:n-1])
               translate([i*bolt_spacing, 0]) circle(d=power_connector_bolt_diameter);
}

module socket_plate(x, y, n_relays, n_power_studs) {
     plate_width = x*connector_x_spacing + side_margin*2;
     plate_height = y*connector_y_spacing + top_margin + bottom_margin + ((n_relays>0) ? relay_height : 0);
     echo("plate is", plate_width, "mm wide and", plate_height, "mm high");
     echo("plate is", plate_width/25.4, "inches wide and", plate_height/25.4, "inches high");
     difference() {
          square([plate_width, plate_height]);
          translate([side_margin, bottom_margin]) socket_grid(x, y);
          if (n_relays > 0) {
               translate([side_margin+((plate_width-side_margin*2 - n_relays*relay_spacing) / 2)-(relay_width-relay_spacing),
                          y*connector_y_spacing+2*bar_width]) relay_row(n_relays);
          }
          mounting_holes(plate_width, plate_height);
          if (n_power_studs > 0) {
               translate([0, bottom_margin/2]) {
                    power_connector_bolts(plate_width, n_power_studs);
               }
          }
     }
}

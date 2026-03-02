/* Tray layout for 8 o'clock Eucharist at Great St Mary's */

tray_width = 476;
tray_height = 327;

large_jug_size = 56;
small_jug_size = 53;

large_pyx_diameter = 48;
small_pyx_diameter = 45;

hosts_box_size = 91;

lavabo_base_diameter = 66;
lavabo_clearance_diameter = 132;

small_chalice_diameter = 70;
large_chalice_side_length = 62.5;

keys_length = 95;
keys_width = 25;

finger_hole_upper_diameter = 20;
finger_hole_lower_diameter = 24;

sanitiser_dispenser_size = 65;

/* from https://www.reddit.com/r/openscad/comments/nmfsih/centred_multiline_text/ */
module multiline(text,
                 lineheight=1.2,
                 vcenter=true,
                 size=10,
                 halign="center",
                 valign="center",
                 spacing=undef,
                 font=undef,
                 direction=undef,
                 language=undef,
                 script=undef){
     translate((vcenter==true?1:0) * [0,-(len(text)-1)*size*lineheight/2,0])
          for(i = [ 0 : len(text)-1 ]){
               translate([0, (len(text)-1-i)*size*lineheight, 0])
                    color("brown")text(text=text[i],
                                       size=size,
                                       halign=halign,
                                       valign=valign,
                                       spacing=spacing,
                                       font=font,
                                       direction=direction,
                                       language=language,
                                       script=script);
          }
}

module tray() {
     square([tray_width, tray_height]);
}

module square_base(base_size) {
     translate([-base_size/2, -base_size/2]) square([base_size, base_size]);
}

module sanitiser(upper) {
     if (upper) {
          square_base(sanitiser_dispenser_size);
     } else {
          multiline(["Sanitiser",
                     "dispenser"]);
     }
}

module small_jug(upper) {
     if (upper) {
          square_base(small_jug_size);
     } else {
          multiline(["Jug for",
                     "ablution"], size=10);
     }
}

module large_jug(upper, contents, top_label, bottom_label) {
     if (upper) {
          square_base(large_jug_size);
     } else {
	  translate([0, large_jug_size/2 - 6])
	       color("brown")
	       text(text=top_label,
		    size=6,
		    valign="center",
		    halign="center");
          multiline(["Jug for",
                     contents], size=10);
	  translate([0, -large_jug_size/2 + 6])
	       color("brown")
	       text(text=bottom_label,
		    size=6,
		    valign="center",
		    halign="center");
     }
}

module hosts_box(upper) {
     if (upper) {
          square_base(hosts_box_size);
     } else {
          multiline(["Hosts",
                     "box"], size=12);
     }
}

module lift_holes(upper, size, angle) {
     rotate(angle) {
          difference() {
               union() {
                    translate([size/2, 0]) circle(d=upper ? finger_hole_upper_diameter : finger_hole_lower_diameter);
                    translate([-size/2, 0]) circle(d=upper ? finger_hole_upper_diameter : finger_hole_lower_diameter);
               }
               circle(d=size);
          }
     }
}

module circle_with_lift_holes(upper, size, angle) {
     union() {
	  circle(d=size);
	  lift_holes(upper, size, angle);
     }
}

module main_pyx(upper) {
     if (upper) {
          circle_with_lift_holes(true, large_pyx_diameter, 135);
     } else {
          multiline(["Main",
                     "pyx"], size=12);
     }
}

module gf_pyx(upper) {
     if (upper) {
          circle_with_lift_holes(true, small_pyx_diameter, 45);
     } else {
          multiline(["Gluten-",
                     "free",
                     "pyx"],
               size=8);
     }
}

module gf_chalice(upper) {
     if (upper) {
          circle(d=small_chalice_diameter);
     } else {
          multiline(["Gluten-",
                     "free",
                     "chalice"], size=12);
     }
}

module lavabo(upper) {
     if (upper) {
          circle(d=lavabo_base_diameter);
     } else {
          multiline(["Lavabo"], size=12);
     }
}

module chalice(upper) {
     if (upper) {
          circle(r=large_chalice_side_length, $fn=6);
     } else {
          multiline(["Chalice,",
                     "purificator,",
                     "paten,",
                     "priest's wafer,",
                     "pall,",
                     "corporal"],
               size=12);
     }
}

module sanitiser(upper) {
     if (upper) {
          square_base(66);
     } else {
          multiline(["Sanitiser"]);
     }
}

module keys(upper) {
     if (upper) {
          translate([-keys_length/2, -keys_width/2]) square([keys_length, keys_width]);
     } else {
          multiline(["Aumbry keys"]);
     }
}

module finger_holes(upper) {
     translate([0, tray_height/2]) circle(upper ? finger_hole_upper_diameter : finger_hole_lower_diameter);
     translate([tray_width, tray_height/2]) circle(upper ? finger_hole_upper_diameter : finger_hole_lower_diameter);
}

main_pyx_position = [70, 160];
gf_pyx_position = [130, 160];

module layout(upper) {
     translate([hosts_box_size/2 + 25,
                hosts_box_size/2 + 15]) hosts_box(upper);
     translate([230, 100]) chalice(upper);
     translate([395, 100]) lavabo(upper);
     translate(main_pyx_position) main_pyx(upper);
     translate(gf_pyx_position) gf_pyx(upper);
     translate([60, 250]) large_jug(upper, "wine", "Handle", "Spout");
     translate([150, 250]) large_jug(upper, "water", "Spout", "Handle");
     translate([240, 250]) gf_chalice(upper);
     translate([340, 250]) sanitiser(upper);
     translate([430, 250]) small_jug(upper);
     translate([330, 170]) keys(upper);
}

module layer(upper) {
     if (upper) {
          difference() {
               tray();
               layout(true);
               finger_holes(true);
          }
     } else {
          layout(false);
     }
}

module pyx_finger_holes(upper) {
     translate(main_pyx_position) lift_holes(upper, large_pyx_diameter, 135);
     translate(gf_pyx_position) lift_holes(upper, small_pyx_diameter, 45);
}

show_both = true;
top_layer = true;
cut = true;

if (show_both) {
     linear_extrude(6) layer(true);
     translate([0, 0, -2]) linear_extrude(2) difference() {
          tray();
          finger_holes(false);
          pyx_finger_holes(false);
     }
     layer(false);
} else {
     if (top_layer) {
          layer(true);
     } else {
          if (cut) {
               difference() {
                    tray();
		    finger_holes(false);
                    pyx_finger_holes(false);
               }
          } else {
               layout(false);
          }
     }
}

/* text for back of tray: */
/* https://github.com/hillwithsmallfields/cnc-things/blob/master/GSM/tray-layout-8am.scad */

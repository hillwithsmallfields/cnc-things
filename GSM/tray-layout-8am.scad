/* Tray layout for 8 o'clock Eucharist at Great St Mary's */

tray_width = 478;
tray_height = 325;

large_jug_size = 56;
small_jug_size = 53;

large_pyx_diameter = 48;
small_pyx_diameter = 45;

hosts_box_size = 90;

lavabo_base_diameter = 70;
lavabo_clearance_diameter = 132;

small_chalice_diameter = 70;
large_chalice_side_length = 65;;

keys_length = 75;
keys_width = 25;

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

module small_jug(upper) {
     if (upper) {
          square_base(small_jug_size);
     } else {
          multiline(["Jug",
                     "for",
                     "ablution"]);
     }
}

module large_jug(upper, contents) {
     if (upper) {
          square_base(large_jug_size);
     } else {
          multiline(["Jug",
                     "for",
                     contents]);
     }
}

module hosts_box(upper) {
     if (upper) {
          square_base(hosts_box_size);
     } else {
          multiline(["Hosts",
                     "box"]);
     }
}

module main_pyx(upper) {
     if (upper) {
          circle(d=large_pyx_diameter);
     } else {
          multiline(["Main",
                     "pyx"]);
     }
}

module gf_pyx(upper) {
     if (upper) {
     circle(d=small_pyx_diameter);
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
                     "chalice"]);
     }
}

module lavabo(upper) {
     if (upper) {
          circle(d=lavabo_base_diameter);
     } else {
          multiline(["Lavabo"]);
     }
}

module chalice(upper) {
     if (upper) {
          circle(r=large_chalice_side_length, $fn=6);
     } else {
          multiline(["Main",
                     "chalice"],
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
          multiline(["Aumbry",
                     "keys"]);
     }
}

module layout(upper) {
     translate([hosts_box_size/2 + 40,
                hosts_box_size/2 + 15]) hosts_box(upper);
     translate([230, 100]) chalice(upper);
     translate([380, 100]) lavabo(upper);
     translate([50, 150]) main_pyx(upper);
     translate([115, 150]) gf_pyx(upper);
     translate([80, 250]) large_jug(upper, "water");
     translate([180, 250]) large_jug(upper, "wine");
     translate([300, 250]) gf_chalice(upper);
     translate([400, 250]) small_jug(upper);
     translate([330, 180]) keys(upper);
}

module layer(upper) {
     if (upper) {
          difference() {
               tray();
               layout(upper);
          }
     } else {
          layout(upper);
     }
}

if (true) {
     linear_extrude(6) layer(true);
     translate([0, 0, -2]) linear_extrude(2) tray();
     layer(false);
} else {
     layer(true);
}


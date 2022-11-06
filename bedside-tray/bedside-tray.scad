width = 400;
height = 380;

spacing = 10;

cards_length = 110;
cards_width = 75;

charger_cable_width = 15;

coaster_edge = 115;

emergency_torch_length = 117;
emergency_torch_width = 40;

flood_torch_length = 150;
flood_torch_width = 15;

nail_file_length = 115;
nail_file_width = 12.5;

pen_holder_edge = 70;

pencil_torch_length = 150;
pencil_torch_width = 15;

penknife_length = 95;
penknife_width = 35;

phone_height = 165;
phone_width = 80;

inhaler_length = 70;
inhaler_width = 30;

sanitiser_bottle_width = 50;
sanitiser_bottle_height = 30;

vaseline_diameter = 50;

wallet_length = 135;
wallet_width = 80;

watch_strap_length = 265;
watch_strap_width = 25;
watch_body_diameter = 55;
watch_body_offset = 145;

module centred(w, h) {
     translate([-w/2, -h/2]) {
          children();
     }
}

module centred_rectangle(w, h) {
     centred(w, h) square([w, h]);
}

module down(dh) {
     translate([0, -dh]) {
          children();
     }
}

module up(dh) {
     translate([0, dh]) {
          children();
     }
}

module beside(w) {
     children(0);
     translate([w+spacing, 0]) {
          children(1);
     }
}

module below(h) {
     children(0);
     translate([0, -(h+spacing)]) {
          children(1);
     }
}

module cards() {
     centred_rectangle(cards_length, cards_width);
}

module coaster() {
     centred_rectangle(coaster_edge, coaster_edge);
}

module emergency_torch() {
     centred_rectangle(emergency_torch_length, emergency_torch_width);
}

module flood_torch() {
     centred_rectangle(flood_torch_width, flood_torch_length);
}

module inhaler() {
     centred_rectangle(inhaler_width, inhaler_length);
}

module nail_file() {
     centred_rectangle(nail_file_length, nail_file_width);
}

module pen_holder() {
     centred_rectangle(pen_holder_edge, pen_holder_edge);
}

module pencil_torch() {
     centred_rectangle(pencil_torch_width, pencil_torch_length);
}

module penknife() {
     centred_rectangle(penknife_width, penknife_length);
}

module sanitiser_bottle() {
     centred(sanitiser_bottle_width, sanitiser_bottle_height) {
          scale([sanitiser_bottle_width/sanitiser_bottle_height, 1])
               circle(d=sanitiser_bottle_height);
     }
}

module wallet() {
     centred_rectangle(wallet_length, wallet_width);
}

module watch() {
     centred(watch_body_diameter, watch_strap_length) {
          translate([-watch_strap_width/2, 0]) square([watch_strap_width, watch_strap_length]);
          up(watch_body_offset) circle(d=watch_body_diameter);
     }
}

module phone() {
     centred(phone_width, phone_height) {
          square([phone_width, phone_height]);
          translate([phone_width/2 - charger_cable_width/2, -40]) square([charger_cable_width, 40]);
     }
}

module vaseline() {
     circle(d=vaseline_diameter);
}

module layer() {
     square([width, height]);
}

module lower_layer() {
     layer();
}

module upper_layer() {
     difference() {
          layer();
          translate([spacing+pen_holder_edge/2, height-spacing-pen_holder_edge/2]) {
               beside(pen_holder_edge) {
                    below(pen_holder_edge) {
                         pen_holder();
                         beside(sanitiser_bottle_width) {
                              translate([spacing*2, 0]) sanitiser_bottle();
                              down(20) vaseline();
                         }
                    }
                    beside(60) {
                         down(10) penknife();
                         beside(watch_body_diameter) {
                              down(100) watch();
                              beside(wallet_width) {
                                   below(wallet_width+spacing) {
                                        down(spacing) wallet();
                                        below(cards_width) {
                                             cards();
                                             nail_file();
                                        }
                                   }
                                   beside(pencil_torch_width) {
                                        down(40) pencil_torch();
                                        down(40) flood_torch();
                                   }
                              }
                         }
                    }
               }
          }
          translate([spacing+phone_width/2, spacing+phone_height/2]) {
               beside(phone_width+20) {
                    up(20) phone();
                    beside(80) {
                         down(40) emergency_torch();
                         inhaler();
                    }
               }
          }
          translate([width-spacing-coaster_edge/2, spacing+coaster_edge/2]) {
               coaster();
          }
          /* beside(penknife_width) { */
          /*      penknife(); */
          /*      cards(); */
          /* } */
     }
}

upper_layer();

wedge_length = 60;
wedge_height = 20;

module fillet_jig() {
     polygon([[0, 0], [wedge_length, 0], [wedge_length, wedge_height]]);
}

for (i = [0:5]) {
     translate([0, i*(wedge_height + 10)]) {
          fillet_jig();
          translate([wedge_length, wedge_height+5]) rotate(180) fillet_jig();
     }
}

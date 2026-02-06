earring_size = 20;
hole_size = 3;
hole_offset = 3;

module round_earring() {
     difference() {
	  circle(d=earring_size, center=true);
	  translate([0, (earring_size/2)-hole_offset]) circle(d=hole_size, center=true);
	  text("a", 10, center, center);
     }
}

round_earring();

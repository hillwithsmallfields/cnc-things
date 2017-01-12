/* D-lock holders (will be at various angles) */

block_diameter = 35;
block_radius = block_diameter / 2;
block_length = 50;
endpiece = 10;

main_block_length = block_length - endpiece;

shackle_diameter = 22;

rack_diameter = 8;		/* TODO: measure this */

bolt_outer_diameter = 6;
bolt_inner_diameter = 5;
bolt_length = 20;

module bolt_holes(hole_diameter) {
     rotate([0,0,45]) {
	  translate([block_radius/2,0,0]) {
	       cylinder(h = bolt_length, r = hole_diameter / 2, $fn = 360);
	  }
     }
     rotate([0,0,45 + 180]) {
	  translate([block_radius/2,0,0]) {
	       cylinder(h = bolt_length, r = hole_diameter / 2, $fn = 360);
	  }
     }
}

module block() {
     /* main block */
     difference() {
	  cylinder(h = main_block_length, r = block_radius, center = true, $fn = 360);
	  /* the hole for the shackle */
	  translate([0, 0, (block_diameter - shackle_diameter) / 2]) {
	       rotate([90,0,0]) {
		    cylinder(h = block_diameter, r = shackle_diameter / 2, center = true, $fn = 360);
	       }
	  }
	  /* the hole for the rack */
	  translate([0, 0, (main_block_length) / -2]) {
	       rotate([90,0,45]) {
		    cylinder(h = block_diameter * 2, r = rack_diameter / 2, center = true, $fn = 360);
	       }
	  }
	  translate([0,0,(block_length)/-2]) bolt_holes(bolt_inner_diameter);
     }

     /* endpiece */
     translate([0, 0, -block_length]) {
	  difference() {
	       cylinder(h = endpiece, r = block_radius, center = true, $fn = 360);
	       /* the hole for the rack */
	       translate([0, 0, endpiece / 2]) {
		    rotate([90,0,45]) {
			 cylinder(h = block_diameter * 2, r = rack_diameter / 2, center = true, $fn = 360);
		    }
	       }
	       translate([0,0,-bolt_length/2]) {
		    bolt_holes(bolt_outer_diameter);
	       }
	  }
     }
}
     
block();

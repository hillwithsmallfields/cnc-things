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

module bolt_holes(twist, hole_diameter) {
     rotate([0,0,twist]) {
	  translate([block_radius/2,0,0]) {
	       cylinder(h = bolt_length, r = hole_diameter / 2, $fn = 360);
	  }
     }
     rotate([0,0,twist + 180]) {
	  translate([block_radius/2,0,0]) {
	       cylinder(h = bolt_length, r = hole_diameter / 2, $fn = 360);
	  }
     }
}

module block(twist) {
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
	       rotate([90,0,twist]) {
		    cylinder(h = block_diameter * 2, r = rack_diameter / 2, center = true, $fn = 360);
	       }
	  }
	  translate([0,0,(block_length)/-2]) bolt_holes(twist, bolt_inner_diameter);
     }

     /* endpiece */
     translate([0, 0, -block_length]) {
	  difference() {
	       cylinder(h = endpiece, r = block_radius, center = true, $fn = 360);
	       /* the hole for the rack */
	       translate([0, 0, endpiece / 2]) {
		    rotate([90,0,twist]) {
			 cylinder(h = block_diameter * 2, r = rack_diameter / 2, center = true, $fn = 360);
		    }
	       }
	       translate([0,0,-bolt_length/2]) {
		    bolt_holes(twist, bolt_outer_diameter);
	       }
	  }
     }
}

front_twist = 75;

block(front_twist);
rotate([0,0,front_twist]) translate([0,100,0]) rotate([0,0,-front_twist]) block(front_twist);
rotate([90,0,180+front_twist]) translate([0,-35,-50]) color("black") cylinder(h = 200, r = rack_diameter / 2, , $fn = 360);

back_twist = -75;

translate([0,120,0]) {
     block(back_twist);
     rotate([0,0,back_twist]) translate([0,-100,0]) rotate([0,0,75]) block(back_twist /* this last one works only for one angle, I think*/);
     rotate([90,0,back_twist]) translate([0,-35,-50]) color("black") cylinder(h = 200, r = rack_diameter / 2, $fn = 360);
}


